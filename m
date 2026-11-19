Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795128208;
	b=nUGLTZzukkISgBJ+uteb3q3SbUSODuZcImntUMuVZ+QJ908pZPxVPK9LO6ZbPlGCUXJU
	 BcUiQGxZFeQ+TXee4v687EPWbEa681dAhxM/oouPvuKuPWRKR8+sTXPkxiBrWHPd785VC
	 a0bz6JKNeiiUA0y24ykstkEYwquzwmmRKgeXI+qJrNiu+OOFvn13hu6ro75DhLxFg7bmQ
	 Aq2S49JgrJamHB6Nj6j55ulFTXguffh8jqDHrxJ+AWJVD2dp6zEuO1CZudYR++qctVL1U
	 Fuxzysl/y3y9K6Rc7eH02bzyjkCNZguS9Wv4Ed1ioxycoFb2YXi90LzPOu8cvqPHFWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795128208;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=6aRL7jJoLDTqaZ8gOUeYUlo0w1fM8yKtA1eURITqjEw=;
	b=kZoH4AJQgth84DtEWzTIdZ7+7pygP8akfxbwO2WjdI65Fk+INJBo8LWtB2PQCh/A5M/b
	 AUXV7JONlqzMx/ZZxR9SpGwx/pymH9X6epywNcJRM5XtCKGColl/A1wk6LaT1FB8eVdw4
	 GSkgCYfYLlpphFfD0yr/25iG53jfeCmifNI9bV8Jz69L2BauTurpPBATOtEiP1hRbU3Ge
	 7R+qfr5qJTjRKL6IQf5XFN+pz1IpohMd5+cEtsyKV2PDgyHOhwt0CspT1vYcpujZNKy2K
	 kwGakPL+e1KPdQiFByo3540X1uOIs9qUCQ9TMpBZ8sO72EOWO82vOJK7WOpNwlJL3tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=n3RacU45;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bcecORwy;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89C606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 22:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF89C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=n3RacU45;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bcecORwy
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 474E77A02A0
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 17:43:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 19 Nov 2026 17:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795128206; x=1795214606; bh=6aRL7jJoLD
	TqaZ8gOUeYUlo0w1fM8yKtA1eURITqjEw=; b=n3RacU45X8+XZVhRapg95cfXKz
	qH/XBh6gD3fjJ8oV2u51H6bz80la+sI1ga9Fsi5Uvoy9hzUyOgHNBzUvO3vKsIIw
	w8bAQrDP57lm6OpixMTEaPVmaYEKmDgO18UJF6OSCccEoKBhk8+drsmCSVVtLH0F
	JlxB2wIJbtVvdprsTnJjJjz6ohb8WLUTjR2VUpz/4/DrLUm3EfNRmXkQqF5zPLjO
	Q5/7ZOtgx0MYZf14I9i+VNCPRXUyDvNGv9b7ed1NABDY8ZDxEB4zEqR4TC4Epyt9
	XENv5wbQHFIrogOPmBsFSszsykVxQiFP/KZynsmVfrMRPo9ueK4ECFXHTKPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795128206; x=1795214606; bh=6aRL7jJoLDTqaZ8gOUeYUlo0w1fM8yKtA1e
	URITqjEw=; b=bcecORwy39+cWlScvv3zi74kSfut+dz+MUDyDjfYuCwSzU7dSAD
	jXFprl+NjWCfHhIzpsWFDSuJ0LUFy7MNVHMP37DD3Wat/x82sWNDDuwDKm8mdWIK
	oAzjyeRiRHo/lVMBx+h+9Cfj1bOV04pUNSfpG3SVBZn5iNU0KWnO5h/Q80FAq3pZ
	j/g6xl0/GtntgwurQgiMUmdxqn/miAjp7zJCijuH+ria0XHn9Zdw7wX5bOvkEYce
	MBPI7oRLtdnKXa8vVL/5zOl99PolUejVuKRxXQVe8NPclEOdn2l5vi+oKxzerku6
	2SFUMxmWrDZKdN5LA/36J6tuvK11AgwtVBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795128206; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fDdfSsvymmrU+KcQvFc3uWo+Wh7DZn/nthJyOM09G7DDeVt
	7EFirZztd6y7yUS4yf3CcOSf0we2QRvt3BWO365VNk/cQdIHJ0jXtkoeyquPKiTP
	vAaKYvE/sCiR+ys5nmtoSlsgxN4d+s/mT8Pzivq0/WZHokhE8nxkorzdemyECHlv
	iTf1TstFbTyuDakcYLqyyigP/PLeKGUO6J48Ee7DyiQJf8E9AY8KxIunDcH8/Nle
	EnQjtNa40LAxWOIo0GAMfP65vIowgNz/5QKqoz9z6osjV5v7ZsN7ow0Cr2riLlIk
	UABVYJ1qBHgnqLzELnHAX31ijG6mWBDIR5NzF9w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:1TkL82UPnUkScLntU/rEQsnIgmmIRv6F85RacHOVBOo=:ixmgZDlQKhPtb6Pg9QMsJpM+pbaRRdr+Y5GV1bEIfh4=;
X-ME-Sender: <xms:jnv_auurpCKVIosBblEl7LNrIT9_Ug215lc3o0C5mgMU-tbZf49F7w>
    <xme:jnv_aqU7YxTHBGKMfsMGhnksRHzi5tvw9kgVIE-ahR3Xh1ffjMloKaKYk9Jjfdtmr
    _uw6mmZngr08CMpw43C-fgXUoQUtUnLHrn2Z0o6IGu18Jiq9JB5rgI>
X-ME-Received: <xmr:jnv_aiE2BYtNNXxSSVBT-YVq-HUoBS5NEpc6qCLPaYShZjeTnvdwl-bfJMpNQKG0ZYYZetHzp0EqYysybRNfdMVS2--plwYgqOG2>
X-ME-Proxy-Cause: dmFkZTE+ePNfg3mWfLB7ntkB/p6GGOV2+oFK7XEP4US7fuZw7513WBiyPF15OU/ZCxQkzK
    r3bOfvF/pG5WP7Hf54pu7g8RcasX/+UW11XI+wszkIAjoszYJuWiOTsm8L20vsjdBmqYWz
    /+adN2Q3ZfOtSJ+eGKiFajqm+QFIZXMoQHa+spidMOhK8xVEiHDoppQ5UPa+/tSEIJxer9
    602kH1OfBl7v7vHrYPlPpXFBeGEItUtfje5n0NODw5nY6eWTleli5SYiEMUF/SG56u9e29
    wouAqGvxmzpShbK9W0sVZeM5GkpthHtkNYiXGlfz8G/FLeMWHucXrmBptKbPFxDHAEvxUe
    Xo7YGoEFUWb7zPc0pV53vY6fU3uP0WOhTWSLfKYWrKYz9YSnQTylZzenOpcSlzQO2uRF9z
    /MxJSVYfeGagW80N8fk7BqtMzs9q/9YGSJnnqbPiKt52E/7Zpz8sVvfDuhigYOJN7q0hUK
    7IHtgnOUjJrQbepWWoM3GkO18dEPuUQwKZyG1vsNDKdrG/SSZZU+2t5oxfFC61MZ4zr3Wd
    LWe+SBJ0CjcwZlZNV51cVXMfbDo44Ry2l1FHtNWTiRGBm71w9CmXabc/BcjCQGmOw97NOE
    4zb16zAtO1yN+ZMXYYiiZSew8dd6wHgWMee5DEq51QIUkUs1V67ed9mAZ4HA
X-ME-Proxy: <xmx:jnv_ak3c5un8DYV_W1bG5kefKLmq8TjiEfyPUH2HvSd8yxI5omVYGw>
    <xmx:jnv_asO3ShMGsyiSqy2iAMSZQ-WdSlZCIDbHP4KmFIbTg4PeWdgixQ>
    <xmx:jnv_ar7Jqd1nC_tMBzZCDc-0QMHo053wBNuAQS8Attvk5PLXCBbaHA>
    <xmx:jnv_au3h7AGDqLaUMcsZyExxxwPphwBIH3oCigHvKsaowkCoqS3vdw>
    <xmx:jnv_asHAKXEqV2JeJeQrujOw56h_CZelLng2tbU2W0PY6MJnT4FlJ6ff>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 17:43:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 11/13] builtin/rerere: use `OPT_SUBCOMMAND()`
In-Reply-To: <20261119-pks-rerere-subcommands-v5-11-0c1092b88958@pks.im>
	(Patrick Steinhardt's message of "Thu, 19 Nov 2026 12:47:12 +0100")
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
	<20261119-pks-rerere-subcommands-v5-11-0c1092b88958@pks.im>
Date: Thu, 19 Nov 2026 14:43:25 -0800
Message-ID: <xmqqwlq8tpbm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In git-rerere(1) we have our own custom logic to parse subcommands. In
> preceding commits we have refactored all of those subcommands so that
> they are ready to be used as `OPT_SUBCOMMAND()`s. Switch over to use
> these so that we get rid of our custom subcommand parsing.
>
> Unfortunately this means that we have a backwards-incompatible change
> because we no longer accept the "--[no-]rerere-autoupdate" flag for all
> subcommands. But this was arguably broken and misleading as we ignore
> this flag for any other subcommand aynway. So we cheat a bit and simply
> call it a bug that those flags were accepted in the first place.

Aynway.

> +static int cmd_rerere_perform(int argc,
> +			      const char **argv,
> +			      const char *prefix,
> +			      struct repository *repo)
> +{
> +	int autoupdate = -1;
> +	struct option options[] = {
> +		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
> +			N_("register clean resolutions in index"), 1),
> +		OPT_END(),
> +	};
> +	enum rerere_flags flags = 0;

The "register clean resolutions in index" text used to be given for "-h"

    $ rungit master rerere -h
    usage: git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]

        --[no-]rerere-autoupdate
                              register clean resolutions in index

but we moved it to this subcommand.

It was a bug that "git rerere diff --no-rerere-autoupdate" did not
complain.  Because this option only appears here, those subcommands
would now complain when they see the --no-rerere-autoupdate option.

Which is very good.

What is a bit sad is that it has become very hard to actually see
this help text.

    $ rungit seen rerere -h
    usage: git rerere [--[no-]rerere-autoupdate]
       or: git rerere clear
       or: git rerere diff
       or: git rerere forget <pathspec>...
       or: git rerere gc
       or: git rerere remaining
       or: git rerere status

Because the primary subcommand (i.e., record and replay after you
got a conflict in the working tree) does not have a subcommand verb,
"git rerere -h" would trigger the help for the top-level command,
and the help is shown from there without using the options[] array
in this subcommand.

I said "very hard", not impossible, because there is an awkward way
to see this.

    $ rungit seen rerere -- -h
    $ rungit seen rerere --rerere-autoupdate -h

Both of which would give you

    usage: git rerere [--[no-]rerere-autoupdate]

        --[no-]rerere-autoupdate
                              register clean resolutions in index

but it probably is not what users will ever use.

I think it is OK to stop here and leave the above as-is.  The only
people who use this option are those who already know and are used
to it.  Everybody else I would imagine would rather use

	git -c rerere.autoupdate=no rerere

instead.

It might have fallouts on --git-completion-helper, too.

    $ rungit master rerere --git-completion-helper
    --rerere-autoupdate --no-rerere-autoupdate
    $ rungit seen rerere --git-completion-helper
    clear diff forget gc remaining status

Arguably, the updated choices are better, but I do not know offhand
how the bash completion script uses this (specifically, the old output
was so bad that it may have workaround that we will no longer need with
your improvements).

Thanks.

