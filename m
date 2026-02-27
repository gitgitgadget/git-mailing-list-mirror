Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F65346AC3
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213344; cv=none; b=V5WPpdtPLDmM+SIyNYEfPxQur1lPzUJgtLyJF7E2QjuQEjtlhtGXrYkQ3Jj7lASgBiyBxlUqftBt54vDN3m5eX1CzYsWlLfzp3U0msCMTnyQlQpYCJTlC9LrBbFSJmhY+/jbuCoEUtKPb0C8BAPMmsxaW/VUV5ZT72GkVXRnY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213344; c=relaxed/simple;
	bh=9MPRSbK3NvWgkK6yy4c3Dc7K6xyjlW8WlBvhelwOHZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YEsrWj1cIaLD66guR4JjP4zq+XlUJ9lC/DLyLzfR/SphJCC7C5C6fCQ//Xt5pKnAm6pJtuqPonvvSs0uzXHmL3M0eOUTZcoU9QuOUipzxaZzrq+38oQIuQ++93HijKHlve56NBD6WhrqeMHDid5OBW/gGFDr6COr1Z3xH2+Z23A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BWqP2/dy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DYRt/j/n; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BWqP2/dy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DYRt/j/n"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D1B95140010F;
	Fri, 27 Feb 2026 12:29:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 27 Feb 2026 12:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772213342; x=1772299742; bh=Z6WaK7XCou
	dlpRh2R0/i6uVNIG5OUtEXqW/dZjntNx0=; b=BWqP2/dy7FCNTFFfDFvlpy7QgN
	nak6tz+gnLP3JQL++BTnJ5O3PZpzRECTLQ7ITLIlOtuvDSgJba8pcGuep0vgj5rf
	Usvjf0YkOog/jPwNCye2sUANsYd8w/7324Y/K5iBJdL0BXPOlcVoC4hqNhL0EQJ/
	e7ICDaiqPYs3EGl5/O/tAmZiMED2351nj+8JpK6QDDb9NouoFZekztDRdNN7EHJy
	baPvkFkKT1oDitbv5bvlNXgj1D9fMLX+TcEdx1yWIW/74ct9SCiEXuM/6DvV2oio
	/4FL5tQLM7lgN5bFvQEcviYSxI84o2M56eJwkkH5Tc+g1eGnBhuLlHZUNkRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772213342; x=1772299742; bh=Z6WaK7XCoudlpRh2R0/i6uVNIG5OUtEXqW/
	dZjntNx0=; b=DYRt/j/nbEKxZ5M+1yRQiU6+f0hGoVYCMYHdbIqdkmA7kf4/dD/
	Sm/2g75Moha45wl63TODVYsITlN6yaDfeTRPIrRnkYky1Rgf1O3ailnGn8iArmKb
	/qlD4hZycFT1WrzPTLHRy66vhMEALA9RU7kl35eBYnn3xGInHuuEI78WHBMn11Oz
	zRzynb84kLkEvIzBFXTHjwtrd7BDLInHrtnTWhqCqwPFNnvLMUP6tabFSiZaLtoT
	xUo0WoYDa0R15uAHyPpfMN0nIKvfc6aHtv1gX2YEHJlyUpnU089kjTAwpsuctD+2
	8Pwf1X5EobSxnnXlaoSzzV+If+hzD8MLbzQ==
X-ME-Sender: <xms:XtShaalCUN5gS4vzrMdx1Ldj4hCELKWnYud78-cC-3Z8tDCjh-CZqw>
    <xme:XtShaY34CiluMiJmmVIlcKmua3qpvF_2K_wKZJEwqm3AqqPGvXmAMm_lReZxCh4PE
    7VW7a_sdrFenutg4av-xBl9pwGzIkBiXja621SDeQpSh6ACoUIlasc>
X-ME-Received: <xmr:XtShadqP4Cqn_ONS2Noknx17UgQbgVRg4fjtynQPV6pSCpYvUBrrFC7Sv7XCyqwEjzuFaje1ZLPe6uNYFT3k9sn8Kli7q1diSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeliedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhsmhhilhgvhiesghhithhl
    rggsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XtShadcp84RvONqhz0aitDhmLm_--pC49DFlv7C9SJtvLk8jVpe0CQ>
    <xmx:XtShaUowlcQTCxpL7fxLvE-rh-eaeszmz3P67mnWUutIjNqP67ifNQ>
    <xmx:XtShaWFZtruS4_gkhavl0oXDEjJcS5FKIMiFAeT4qzhjr3kjIU4U7w>
    <xmx:XtShactHSMywEFy_RN0uMHQKwiUlTxlC_5U9dUUdBefzfEBH79F68Q>
    <xmx:XtShaZJKysFqpv_-Nnx3ed-lWf2XhJ9T5thrZdd2D5VTkBDt-W9mvHwQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 12:29:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Matt Smiley <msmiley@gitlab.com>
Subject: Re: [PATCH 2/2] upload-pack: reduce lock contention when writing
 packfile data
In-Reply-To: <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
	(Patrick Steinhardt's message of "Fri, 27 Feb 2026 12:23:01 +0100")
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
	<20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
Date: Fri, 27 Feb 2026 09:29:00 -0800
Message-ID: <xmqqpl5qrt7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> ...
> write(3p) call. Even worse, when the sideband is enabled we end up
> matching one read with _two_ writes: one for the pkt-line length, and
> one for the packfile data.
>
> Extend our use of the buffering infrastructure so that we soak up bytes
> until the buffer is filled up at least 2/3rds of its capacity. The
> change is relatively simple to implement as we already know to flush the
> buffer in `create_pack_file()` after git-pack-objects(1) has finished.
>
> This significantly reduces the number of write(3p) syscalls we need to
> do. Before this change, cloning the Linux repository resulted in around
> 400,000 write(3p) syscalls. With the buffering in place we only do
> around 130,000 syscalls.
>
> Now we could of course go even further and make sure that we always fill
> up the whole buffer. But this might cause an increase in read(3p)
> syscalls, and some tests show that this only reduces the number of
> write(3p) syscalls from 130,000 to 100,000. So overall this doesn't seem
> worth it.

Very well reasoned.  I love this size ratio between explanation and
code change ;-)

>
> Helped-by: Matt Smiley <msmiley@gitlab.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  upload-pack.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index c2643c0295..f8ba245616 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -270,6 +270,13 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
>  		}
>  	}
>  
> +	/*
> +	 * Make sure that we buffer some data before sending it to the client.
> +	 * This significantly reduces the number of write(3p) syscalls.
> +	 */
> +	if (readsz && os->used < (LARGE_PACKET_DATA_MAX * 2 / 3))
> +		return readsz;
> +
>  	if (os->used > 1) {
>  		send_client_data(1, os->buffer, os->used - 1, use_sideband);
>  		os->buffer[0] = os->buffer[os->used - 1];
