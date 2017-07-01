Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1699020209
	for <e@80x24.org>; Sat,  1 Jul 2017 17:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdGARYm (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 13:24:42 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36601 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbdGARYl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 13:24:41 -0400
Received: by mail-pg0-f52.google.com with SMTP id u62so77023144pgb.3
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wWvtHuPCekdkn1e7Qw5F1C5AO1cv43Cd/TDWGL0Y0S4=;
        b=jwtCxnYmBIBFW5cwiVadhQdCYNJ2fcic4nJhIWT6amTI4MSiCGupA7uyCocrIR4hpl
         JNcWYImj0brzyVU9cDBj9WGxqXDNHq7+Ya+5OG1kf/VQktPoOgd6rg6/IKKIevwxSZUb
         TDw97AmJOF9ewuowIny1CgMe9x3u0uf1w+L44I/rcgNV1Wk+P47VhEO43ywaTqYG0ELx
         EcZPpGnifOKRF6IrPMhyyH+O1bDVIckK7pcCxsQmZ2v4NAyTgSQPGP0tABHIn6CEyTqW
         3rcKIl3IwhmnHZSC8gjfKw93TFqhz7j6DGDqR7F5CtV2U/qfKvw0p9ykh6tTDY6btMXe
         ch3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wWvtHuPCekdkn1e7Qw5F1C5AO1cv43Cd/TDWGL0Y0S4=;
        b=nCeSqE0a3gHvGhU9H0Klf/iuTfly+A9LnCe9LiZtd8zK2FhKq045tDGN30OAAdIISv
         ybDSKtdBMRdGIR/QPUkNERcn4bYb5a0S6UYZ2M905gZZa935Fi4QFVhfDFkV0/+e9wkp
         wav580BnwWSjJIU8zEKC2K4M8H2eQETNCEBXDLFk0h+0wTpr0leG4/huaxLuplyIv4nB
         m21s0tR4xKovQ4kGfrNgYpbH5l5XvxJEYgh8dzvzXDGlAVVmbjYciFpw1FRXGdetdoDG
         SqPWUsdczQtzP/u5aXxzvaAACDOU52HWFDBry10upKxQNQH4ucwa+CuXvND999ZnkzQM
         poRg==
X-Gm-Message-State: AIVw112RgotGXLEaBvOVdHjwh4V/LRMGHAM37kl3aQL3WxByH6XAjvmS
        iTAUnDRkMDRTppWvTX4=
X-Received: by 10.84.224.75 with SMTP id a11mr1665145plt.286.1498929880596;
        Sat, 01 Jul 2017 10:24:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fd45:ceab:278e:5d13])
        by smtp.gmail.com with ESMTPSA id y66sm24365892pfa.54.2017.07.01.10.24.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 10:24:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Check DB_ENVIRONMENT using is_directory()
References: <20170628162958.519-1-tboegi@web.de>
        <20170701125057.16169-1-tboegi@web.de>
Date:   Sat, 01 Jul 2017 10:24:39 -0700
In-Reply-To: <20170701125057.16169-1-tboegi@web.de> (tboegi@web.de's message
        of "Sat, 1 Jul 2017 14:50:57 +0200")
Message-ID: <xmqqr2y0nk88.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> In setup.c is_git_directory() checks a Git directory using access(X_OK).
> This does not check, if path is a file or a directory.
> Check path with is_directory() instead.
> ---
> After all the discussions (and lots of tests) I found that this patch
> works for my setup.
> All in all could the error reporting be improvved for is_git_directory(),
> as there may be "access denied", or "not a directory" or others, but
> that is for another day.

Wouldn't this be a slight regression, though?  

We used to ignore an unsearchable directory but now we blindly say
"ah, it is a directory".

Checking is_directory() in addition to the existing access() would
be making a progress by fixing one bug (i.e. we no longer are
confused by an executable file there); skipping that access() based
on the filesystem quirks can be left for another day, of course.

> setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index 358fbc2..5a7ee2e 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -321,7 +321,7 @@ int is_git_directory(const char *suspect)
>  
>  	/* Check non-worktree-related signatures */
>  	if (getenv(DB_ENVIRONMENT)) {
> -		if (access(getenv(DB_ENVIRONMENT), X_OK))
> +		if (!is_directory(getenv(DB_ENVIRONMENT)))
>  			goto done;
>  	}
>  	else {
