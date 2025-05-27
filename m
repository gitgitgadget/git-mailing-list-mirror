Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE11A0BD6
	for <git@vger.kernel.org>; Tue, 27 May 2025 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332271; cv=none; b=UiNCFPua6I2EguY8J+elon/uf/1shM0Q3cbMgt3kGxNP6Nf/5xjHW1qv8LIWhchFWRgmNx2isflRfxVxyLIZAVjcLtxUvlxMDCByxkD9GE1aJ7Z2JGfVrgrLpdP08z1w5Xn8Op0GJt+hFMOWqmoIYk4bTQQkHCDoNT1gvLWSE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332271; c=relaxed/simple;
	bh=mmXYhi7Kv2n2qKp4te1j+Iw6t5NUcFtGvzlnTuqTtZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJnPWqUsMbAlabiVvr6WhuGjIRLA4oSTPqMmtOE41ljG1jq+Vvx64YfZwCfR4aAp/hkoPGC8VGBanolikrcfFtRmTlV1XvLu7pVl8ngCVgsMQqCXVsBSzYhvdU5zx/3r+fAYIoBgJvV5yqb9YYGvQWfBY88ipQWWaKA1Zpk6GnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jIUTNp5q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JK9CU5BO; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jIUTNp5q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JK9CU5BO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EFFE011400E4;
	Tue, 27 May 2025 03:51:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 May 2025 03:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748332267; x=1748418667; bh=jWKmoyz2tr
	0oHfz5o97yezGZrHS34e1+jwmkixYW3/o=; b=jIUTNp5quZNBMez/F7Qk7nBUxy
	r8ICL5vDLcNNhHczu6/lXOr3WMGDlLk/xDExOWOkxedC3j2q+fbcYeMllk++aZ/I
	EfpEn5Xusjgl7rJBGKScIjek5va8o4coflF9HUgCGmzPeF1CMnFu8fql2d7vT89V
	Boc9WMm/EG09pDRa4GuyApXtaXnU1FWAIcdK6cAncHCOeHE5+Jf/qfTTNm/B5rlp
	Ge/eM9NQhlJhHD/Bkke5pr292hdJj7/jtyU/5qi2c05n1bGuPIzlcAxnLaoM7AxV
	wnSKgQhoSIGcg1S8ijYBJ+5xM0A9/noq3qF2mmrnUnoHtfT8F4aJeUZSlC+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748332267; x=1748418667; bh=jWKmoyz2tr0oHfz5o97yezGZrHS34e1+jwm
	kixYW3/o=; b=JK9CU5BOcoaaY5PXNV/5VDA8ADuES4orpoI/dpQ20SO23wgrb3W
	NEvtFTvLWfX2SE7rVLqznfPanGaiIoFkS9i7qF+JYWRQexodNeTbxTQRNwWH4SiH
	/TDDev0QE72SunsDluuFFJ+WGaYagUh1sCyfaooeyYu89Ufb+Y/6hLE36BmjIkuc
	ch/OqewQV0CDpJRmFFdFPzFc3MxTiPv2D9wE61ome7KfddPorJjSnwGctYjpcmUr
	aff0hak8sOt9DzobBQ6nFN9nGYiYq7LVezu1oyoPC9sngCSAO9gnxjNVjaoQXqV0
	mhrBMtxYb7gP9DDgCzx5PbS46IpVfmpVw+g==
X-ME-Sender: <xms:6241aFuFAy0FpQJ5s_KECSdtbqxRwwOg-d55g_S8k14hLQrLh_t4hQ>
    <xme:6241aOelKXbfHYOXKZtlVnD9Pq5YyD0thJAJ5qGsRAMwYDv36E8fNpvLwe9ZYMKgR
    d0Vj-eEYVpSdCwvOg>
X-ME-Received: <xmr:6241aIyFHfVlWLSRQMLzTaLmRraBTxHE2X4V3XrHONWNRCfhUFeNS_CViWWhKJXHi62cQ8tJaYs21htCcoyZClgbSd7BPGGKXEoZdOBt9GSy9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduleekfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhl
    sehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouh
    guvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6241aMMQga2xbAVEgw0vn_WjCqZi28ActRQuHZ4NTJygIc2-gFInkA>
    <xmx:6241aF8ZC5_4qHMjOIQTKX0FLemNFkQ4mycaQS--acVYj54Y16uQZQ>
    <xmx:6241aMXD__Ztzj4CDoXEyQLVqL-TpP82RxtJjrzlXYDuKqzy3Zy5iw>
    <xmx:6241aGfqArdZCQCDqOzYySRpLc0Uqz_s1N8v-sgK5H8qYKgqbYna8w>
    <xmx:6241aPgWQL1haYEB69N7WpZ0uilPamDXys2GrzEiIJpRlRSPvvSyi6Ar>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 03:51:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d92aa29d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 07:51:05 +0000 (UTC)
Date: Tue, 27 May 2025 09:51:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 2/5] promisor-remote: allow a server to advertise more
 fields
Message-ID: <aDVu6O9MUicmd8y4@pks.im>
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250519141259.3061550-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519141259.3061550-3-christian.couder@gmail.com>

On Mon, May 19, 2025 at 04:12:56PM +0200, Christian Couder wrote:
> diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> index 2638b01f83..71311b70c8 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -9,6 +9,24 @@ promisor.advertise::
>  	"false", which means the "promisor-remote" capability is not
>  	advertised.
>  
> +promisor.sendFields::
> +	A comma or space separated list of additional remote related
> +	fields that a server will send while advertising its promisor
> +	remotes using the "promisor-remote" capability, see
> +	linkgit:gitprotocol-v2[5]. Currently, only the
> +	"partialCloneFilter" and "token" fields are supported. The
> +	"partialCloneFilter" field contains the partial clone filter
> +	used for the remote, and the "token" field contains an
> +	authentication token for the remote.
> ++
> +When a field is part of this list and a corresponding
> +"remote.foo.<field>" config variable is set on the server to a
> +non-empty value, then the field and its value will be sent when
> +advertising the promisor remote "foo". This list has no effect unless
> +the "promisor.advertise" config variable is set to "true", and the
> +"name" and "url" fields are always advertised regardless of this
> +setting.

I think this documentation should be clarified to explicitly talk about
"field names". In v2 I misread these paragraphs to mean that the admin
is expected to configure name-value pairs because you say "fields" here,
and that term is specified elsewhere to be such a pair.

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 94e87f2f48..cde4079d8c 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -314,6 +314,73 @@ static int allow_unsanitized(char ch)
>  	return ch > 32 && ch < 127;
>  }
>  
> +static const char promisor_field_filter[] = "partialCloneFilter";
> +static const char promisor_field_token[] = "token";

Curious. Why aren't these declared as mere string constants (static
const char *)? It might be a bit more idiomatic to have these as
all-uppercase defines to make it obvious that those aren't a local
variable.

    #define PROMISOR_FIELD_FILTER "partialCloneFilter"
    #define PROMISOR_FIELD_TOKEN  "token"

> @@ -326,6 +393,8 @@ struct promisor_info {
>  	struct promisor_info *next;
>  	const char *name;
>  	const char *url;
> +	const char *filter;
> +	const char *token;
>  };
>  
>  static void promisor_info_list_free(struct promisor_info *p)

Yup, this now follows my suggestion.

> @@ -336,12 +405,45 @@ static void promisor_info_list_free(struct promisor_info *p)
>  		next = p->next;
>  		free((char *)p->name);
>  		free((char *)p->url);
> +		free((char *)p->filter);
> +		free((char *)p->token);
>  		free(p);
>  	}
>  }
>  
> -/* Prepare a 'struct promisor_info' linked list with config information. */
> -static struct promisor_info *promisor_config_info_list(struct repository *repo)
> +static void set_one_field(struct promisor_info *p,
> +			  const char *field, const char *value)
> +{
> +	if (!strcasecmp(field, promisor_field_filter))
> +		p->filter = xstrdup(value);
> +	else if (!strcasecmp(field, promisor_field_token))
> +		p->token = xstrdup(value);
> +	else
> +		BUG("Invalid field '%s'", field);

s/Invalid/invalid/

Patrick
