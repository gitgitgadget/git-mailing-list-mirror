Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257137;
	b=w9oW0dpj4ZKRTZDjmxwbTmyH2FO1HRuC22q7XH8aGSnSGGKYWakDytqSvVRfoIsxhw/f
	 p7j8ycoL4hOagWtTaXpx2DRbDKR/lbih1/F+3/60EzBFSRjlLv2NpxgvMOzFP+78j1uQX
	 sDCN4HnPc8mw2y8sKiNbqeE89vz7ta0j3fWk4PfhcQfJFCimd9BOkk1UKKo51zNmaqI1J
	 kZqN/QZY9/PhR6zcDg2qZtHFqeLyFvUZqmqj1ppImHuW1ZGylD5PT0A/h4sKutawRUEHw
	 6zcLN/wF9oEDep/4nCuEGy2smju+Orx0GRtghrL46LvRyJM76kTD4JvnPG0TA6ty6gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257137;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=OJilo1SfF+t7rACo0goJwF4Jdsh9e9MRm/ZJ59EXFf8=;
	b=xgHtnK1n5e8Gy19M/Pjn+8P9R/R9x+Mw/1NQIMw8hve6Y6MytfO/ASvTFsdBGywd7h1w
	 HiFFzdodz6A+OAqG9j62LA9Bqq3WA3oHw/mW7WXOJjBkGah6Y7VXQN/+9O80kO3sUeC5a
	 Y4aOIM40Bw1r+FU0lSB/ieFO5HWDr8FhdC/dOMA8OlY83wNrRv1b74wUnGkueI1nXW4QP
	 yQ8M7hzkZPI0x76HGzV8t5azFV45UehHKIbJUdUmv2dNEv8gOAU42H1J1YCdqEtI/8tQz
	 ZvRVw5U7mLg1G/s16ohYLJbNizUzT/hqyM1lbyeKbSvwKs5na4pLDmRgOjlOrXB8+RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QsjerUF+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pW0yuGqE;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C09606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QsjerUF+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pW0yuGqE
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B57DAEC01DC
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:45:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 09 Nov 2026 15:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794257135; x=1794343535; bh=OJilo1SfF+
	t7rACo0goJwF4Jdsh9e9MRm/ZJ59EXFf8=; b=QsjerUF+XY1igndrea2QlzAc7B
	MHKbnFX6K6vO/TJAPuj3wrqR/Ceb7PFnyK4ydqBtzgOS60CkoCW/SnYgjinZLVtF
	AoqXXTOSV58mfdu881r6zDmxjphXH/Pi5hxBDsx1CNLhtpVYaY6mguAhi3z2ABjl
	kXhyH+XlwSiymUMJq8RbGRbMPpsGWpvc9mlyQG3PIlGT/Ckg2zyVsGuoW8Vscza7
	+3NC0kg3frJyYsvw8bwNOkwVUlmXa0QCgO2+Zmoq7MSxUHmyJRfxVa2HEWesgaVD
	m5FnpIULwSfNiBvqW3TS43TldOlRJCpSSfoUTy7mPZ31cPjxvmPHoQ/TXUWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794257135; x=1794343535; bh=OJilo1SfF+t7rACo0goJwF4Jdsh9e9MRm/Z
	J59EXFf8=; b=pW0yuGqEuSR0sXVKOH6HzN1OsxCCiVnD3QEUaJ+PjHVHqjStsrf
	2wAR3wcfYD6BtgD2uWOU6wu1zcd6ePNyrAg9UrzR9i5toU1OgH8i9B+8J2hvP4lI
	65yoTb/mRKf9pp9pwI/IjQW0U3ayJHkLyNWP4N2imjqx3Um2TihxrwYI0Sz5KECv
	emCsY68uz9Y/XdnB1oKC423HupoF3i5VSzLV60AWwczHEAyFJVRBNZGndoJ2LciX
	fFJ039u5NiwI75W9OAAxvdLJd6633VKN6hlFvv7qtyDLN2jHkWiL4Kb9WQ3brvGM
	tjOtPtsTkyFtZtsDa15DPUc+hS9Dps9pK3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794257135; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nkVncuUDi73jgXlcI5t2Dq7PqYbm/aMFYE6S8FZhtrZNBCn
	LPnTAvaWejbZCkGgRuq5Jdz0N9UD2+zslApm+VYmj7ppTsKONvgJuhh0IK8l7wuT
	YXWFMneiw+omP06oUwBK9rxYiZcryTXs2pnZ7B2SWrkZrDC+s6m0WjzDUykfCoT2
	aBtl87+9m3yZm1f1JCfMDUsmkSvm9tGPRKqwv5tm30Y32CR9Y20cxeACL5QnXoqg
	fUm5hDfa1SvjVbP9iZhjtlf+/Pznf/YhrgawxF8b4uL7r9DNM++ISeN1DwWKp9S+
	GGoaRRAF4Fb+xJwjcWb49iMiAYLFXrC6lq3wptQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:6Q8WOpjJ5Sga/qvfflEXrhMgcUVKbGXaxGvyDrp3hE8=:R86MKrDu4WeFikos1PXK/maXrwNEDllmFRE1L/0iuvM=;
X-ME-Sender: <xms:7zDyao09EchM6UK4CfGQ7kyDQfSMiwYs0VNpTP2UOWgMaQt2P_kocQ>
    <xme:7zDyaqGjzhOqUEwFoIuiZP9b_50iqq8LXKGgNwztYUJLmxfk_oh6JIJ0oRq19ymfK
    hQSRkkoHN6yhn6-PPHymlVeN6kDcGSpcChIsFXeK3RcKgO505xXrFY>
X-ME-Received: <xmr:7zDyal5fVPqzdultKweGiBSpSIYmnHEA5AmibfGiGJeUjyV81xPb457ia4EYpQXrN-ky78qCcL4b66iW8u5te_jV1K1mKHy6RA8Y>
X-ME-Proxy-Cause: dmFkZTEobjXo+a/CznTaVsiQKBpm0S/w+F5rH+1Xsa778oJ+Np8Ll+PoDDP1HREdlrll7R
    RXzJTp5WenfDW2I+oqTixwZoIsBxoN6svbrJCovjCXgYOCvhsWPJ2RreSsmK/JjOOrL1Qk
    3OZjJ3jg6bV4DkTx4YZBCRnQr3rlkVjPYJOKxmuM4a8kvReO1yBQINMTTLWgrYcJaACYVF
    5hqzvFbyiFvo7jZZagE0DJryE6dTY4fiBkwueKbx5qWH2eY9+BTd6lJil7d/SNDREoYewZ
    MQqhv2+uul3lipEFPWfX0JCWInVUDV+VKBiW6OH+1cJSoQDmgNMpYt5+cj0uuPOrAtbZc0
    NTILrf1IZP0O+UTmx2C9t7280g2hwBSNcoi4Ry8IRVv+rwwc2ufmKor/SbC/qutFuFihCL
    Lu020lMKb6wdshqWA4ugRCeEY72/U62bQXwZgaWWCa8N+sIwUeGcQ1GwmXcborIMVDJNNN
    g1rxftuh9iXMyK50UDgWu9oaHXjnuzI03YXzn0e+oD6nfDKabBzpBOcNRNAZQDt8Io27MM
    jftVjKGzMihoT1BBvxUoEYM+Xkdpbo9ZWvddfjdQ4l8WI/ukv1ycwD9i2S/ntcLdNMjVzk
    PonFsTzRWZK/13b5cHvVK/AN8p4R2ce+7AEPc42XeGmxB6mpzJDn68RiJBiA
X-ME-Proxy: <xmx:7zDyagsdY6t7MljlFhxDHOTR5EF0g4p1B9B6wUOBPZ4J0RmwU0hBpw>
    <xmx:7zDyam51sAI7z4CV5UPqm18et9bscJ_CSHKOko3hMn2f_EEViUATCA>
    <xmx:7zDyarUhoaKRMSWwg0rSGEn8aFrs6f6gg65oFMSAxZozjr8-Vu__gg>
    <xmx:7zDyao8Lq5MVx3HVG0uSSMBbiY2A2ex-nr0YHd5DyF1Q7ybKo9Puww>
    <xmx:7zDyahYnR_AJvmUchMNVZnbddJdmbfCTdOjJk-KCihVwuRloB37BICb7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:45:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH 2/2] archive: remove USE_THE_REPOSITORY_VARIABLE from
 archival modules
In-Reply-To: <eeed27222be51590775352e5a3b7677e21d36a93.1794251100.git.gitgitgadget@gmail.com>
	(Srujith A. Poojary via GitGitGadget's message of "Mon, 09 Nov 2026
	19:05:00 +0000")
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
	<eeed27222be51590775352e5a3b7677e21d36a93.1794251100.git.gitgitgadget@gmail.com>
Date: Mon, 09 Nov 2026 12:45:34 -0800
Message-ID: <xmqqcxsdybrl.fsf@gitster.g>
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

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/archive-tar.c b/archive-tar.c
> diff --git a/archive-zip.c b/archive-zip.c
> diff --git a/archive.c b/archive.c
> diff --git a/archive.h b/archive.h
> index bbe65ba0f9..8ec59b22e9 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -48,9 +48,9 @@ struct archiver {
>  };
>  void register_archiver(struct archiver *);
>  
> -void init_tar_archiver(void);
> -void init_zip_archiver(void);
> -void init_archivers(void);
> +void init_tar_archiver(struct repository *repo);
> +void init_zip_archiver(struct repository *repo);
> +void init_archivers(struct repository *repo);
>  
>  typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
>  					const struct object_id *oid,

All of the above is straight-forward.  Pass a single "repo"
parameter throughout the callchain and you are done.

> diff --git a/builtin/archive.c b/builtin/archive.c
> index 3c1288a123..e35b9637ce 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -2,6 +2,7 @@
>   * Copyright (c) 2006 Franck Bui-Huu
>   * Copyright (c) 2006 Rene Scharfe
>   */
> +#define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "archive.h"
>  #include "gettext.h"
> @@ -97,7 +98,7 @@ int cmd_archive(int argc,
>  	argc = parse_options(argc, argv, prefix, local_opts, NULL,
>  			     PARSE_OPT_KEEP_ALL);
>  
> -	init_archivers();
> +	init_archivers(the_repository);

This looks curious.  

When would the parameter "repo" an invalid repository (due to
RUN_SETUP_GENTLY defined for "archive" entry in git.c:commands[]),
yet using the_repository is a reasonable choice?

> diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> index 718e74b3ac..3cfc7ffaf3 100644
> --- a/builtin/upload-archive.c
> +++ b/builtin/upload-archive.c
> @@ -34,7 +34,7 @@ int cmd_upload_archive_writer(int argc,
>  	if (!enter_repo(the_repository, argv[1], 0))
>  		die("'%s' does not appear to be a git repository", argv[1]);
>  
> -	init_archivers();
> +	init_archivers(the_repository);

It is correct to use the_repository here, the same repository we
used for the enter_repo() call that immediately comes before this
step.
