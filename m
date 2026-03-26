Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0153FADFF
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546156; cv=none; b=mIKtTMKawdAWen+SbGnNStARepZAIdl5NP/3tzaHLCzO6up1oGNE7+k9j13bkYUfpPeevBBusbKnHsfRpXKx2xCbCfSBProuEMSF25ncl9xFRl2Jo4hoIdICt3sMVXVqXQ92YNRfn+S5LxwA5MoanZtNj07W2W4GCRYcPpkrI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546156; c=relaxed/simple;
	bh=JoHErFQOe+h87HhjsgABdJIMX0wQlUboz94vI5ONx3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OOBLj2NrRyvTBLWH67N/Wm2sfWTTCyiGmQjQ3ASEInxrFuLo1iFrlUhEZNLrzp3FlsvASNdsUWI0ouZLNVV4XltDEfhZ5hMA7RDF1wG27ym8BKlgDsHCVxRfRW2BOnYKNdUKPboEa8h0+Qe+gbXHwm0IVxf+1xE4woGz1wq9NVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Prd8exuH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IUKg7sn2; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Prd8exuH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUKg7sn2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C6ADD1D0027C;
	Thu, 26 Mar 2026 13:29:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 26 Mar 2026 13:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774546153; x=1774632553; bh=L6qm1GEsL+
	OTvOfXBf/JgmTb6NHbOzqCpNGN/NMTxME=; b=Prd8exuH2RQtdmDxqXMHjzQFdn
	KuWmOdzrWFVMIFqVU38axUy4PW1sSF+FoFtzg0nFoPQfXoD/euhelKvHAz3euIq0
	Rw9wlcZXj5O1UJzTFrVuF3BuCSABCgMTYKADSg9bRH7zJ5wllDu+HQF+D/IL7sKx
	BfmHMxyhp62bRh5FKgnHAL1duj9wuzlWlGjvNFVRSPqHItbYAe3AdDMeVf4fwTKX
	2owS7eFKJ9CCHaKUsCbdt73yjHVAhfA01D2932/57FqgZxXSTbhzTCLsMq+0PDmq
	1uaIZG07kIFHfxRv5LVPcpAm30B+RCBgA0ZlWosaaWIIlFD58AlFHbfMBuJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774546153; x=1774632553; bh=L6qm1GEsL+OTvOfXBf/JgmTb6NHbOzqCpNG
	N/NMTxME=; b=IUKg7sn2N6QcmPf61W8EMSzF/XfrGN+VImg1EFrUpQ4Bez8kZ6V
	kjnuUkasgxD8qy0N75oGqWMqW2JKzPkVyOoOeUZDGqTdb0zWh5hb2jOpwRAB2HSa
	n1eru4sU6Ot1YdVM7OVFlcbYkybpa+UJCiDy4eoSCaUeO8dKmJma9DbDoQ9K1ku9
	sJwgiaCVa/BzHCRraSAe0p/mMusaW+u/poi6X8jHy5Y11Q85fx8bj8VjrKCJ6oDz
	biXyNeofvHwzFB12O3q3MWF1eWLYB9Zbv6P93AKrOsgb+0Jz3Tpfck/QCrO7VlMN
	UlaFxR1fKkF+1keNnAEiwcmkyOhqyLwlACw==
X-ME-Sender: <xms:6WzFaaRRZvRyQcB5KTHQiiSkGJ3HG2avbyCzdxBDRas94_XAa-AsLg>
    <xme:6WzFaTAjmKz3Q_75Iu5fuMCs2fO6ZuARGnqOwOBAwaxxxOxFw6NHax-3_Z7OPnBoW
    SM7N5IVZfyjMEiNnZvQxnAtsVzoJc-x6kvjlI0b5KL37d6TBy60qV0>
X-ME-Received: <xmr:6WzFaRSfbiX_GPdsg29ffJ5HArBZs4CgCKZ_-LTN8vYGn46F_otf5OEX3W7Tq_whP90QJMQ6DKZLCtY4nsOqWVdJP2SV7xXYKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhgffffkgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetieejgfeiudehfffhteeggeegtd
    dvfeeiieduvdduteekteegfeetjeejgffhjeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehg
    rhhusghigidrvghupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6WzFaRov17uTBVh6oL3KvaqbmmsFl3vZcrEGfnsZrYIuc680EcIG0w>
    <xmx:6WzFaTzreVEXm4cPf8K-BQ4DqphSuYKa8OQyvxw4AeOqOBupiYhh-Q>
    <xmx:6WzFaWIaZIuxkPEjNKDImn2HdCl_z8AzihPsB6AVLdiz59RPI5mDmg>
    <xmx:6WzFaVII2vo2foE7cqgaWJtIMDCdsEwOWkc-7zbQIV8hEgIFXlfD-Q>
    <xmx:6WzFaY7mwbZ0pdZmzH3KN8yTfYS7GPrNBKxP4anrGFLP2rejS0EIXIxB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 13:29:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@grubix.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] do not discard const: adjust to non-const data types
In-Reply-To: <8a65ada967b6b1308ea4cffca82102d4de8e9dd9.1774537954.git.git@grubix.eu>
	(Michael J. Gruber's message of "Thu, 26 Mar 2026 16:22:49 +0100")
References: <cover.1774537954.git.git@grubix.eu>
	<8a65ada967b6b1308ea4cffca82102d4de8e9dd9.1774537954.git.git@grubix.eu>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 26 Mar 2026 10:28:54 -0700
Message-ID: <xmqq5x6iqz3d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael J Gruber <git@grubix.eu> writes:

> We use data types (such as string_list's util member) which are not
> necessarily "non-const in practice" (such as the list of environment
> variables in run-command.c) but are not declared "const". Rather than
> duplicating data types (e.g. with a new constr_string_list), discard the
> const explicitly for now to quell ISOC23 warnings.
> ---
>  http-push.c   | 2 +-
>  run-command.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index 9ae6062198..acc7f1d8fa 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1772,7 +1772,7 @@ int cmd_main(int argc, const char **argv)
>  			str_end_url_with_slash(arg, &repo->url);
>  			repo->path_len = strlen(repo->url);
>  			if (path) {
> -				repo->path = strchr(path+2, '/');
> +				repo->path = (char *) strchr(path+2, '/');
>  				if (repo->path)
>  					repo->path_len = strlen(repo->path);
>  			}
> diff --git a/run-command.c b/run-command.c
> index 32c290ee6a..1db02ef030 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -604,7 +604,7 @@ static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
>  	/* Last one wins, see run-command.c:prep_childenv() for context */
>  	for (e = deltaenv; e && *e; e++) {
>  		struct strbuf key = STRBUF_INIT;
> -		char *equals = strchr(*e, '=');
> +		char *equals = (char *) strchr(*e, '=');
>  
>  		if (equals) {
>  			strbuf_add(&key, *e, equals - *e);

I didn't look at the other http-push.c one, but this part with a bit
wider context reads like this:

	for (e = deltaenv; e && *e; e++) {
		struct strbuf key = STRBUF_INIT;
		char *equals = strchr(*e, '=');

		if (equals) {
			strbuf_add(&key, *e, equals - *e);
			string_list_insert(&envs, key.buf)->util = equals + 1;
		} else {
			string_list_insert(&envs, *e)->util = NULL;
		}
		strbuf_release(&key);
	}

I wonder if the cast to strip away constness wants to go near the
assignment to ->util.


