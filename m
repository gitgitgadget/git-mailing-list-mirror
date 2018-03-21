Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E96C1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 20:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeCUU73 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 16:59:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44603 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbeCUU71 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 16:59:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id u46so6575176wrc.11
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hHd86b0S5qn8r0XXRAby9Au8mfHKD4PBnAlrWay8GKw=;
        b=qnLilYOcuy2MvZIPa7TnTsBaKNFSvYrrt7oMCTTS0986srW2fclw+mtJZCcN9Jx7uU
         R+MqYtwbjhP0YAdmyekkfmlk1OfvansR5otTIgfUh5EoLdGUZFOXPT98A9dx8fD/qzy1
         6mAQj/ZWzVo7bybvH++Ei4ng0hrfIemkp0YBR5CH6S8i9JzgDb7wJuaIBoCETEuuF12J
         kyptAa+MIr4W1cdgbQ/eWIcMmppsK5BYbvgzgWuLH+CPE1n2iN7CUDt9+czaeClfwjdi
         U1anc6UJGQZUlF9owUQHRQI1bF9feVrsL1PRChDJeEcsTWruPZUUN17Ote6KJ7CrW6j4
         A3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hHd86b0S5qn8r0XXRAby9Au8mfHKD4PBnAlrWay8GKw=;
        b=n2JpCkUui2NwY6+uTrTaDIwhTEx8QVBBT4OeBZif6AlfqF8uHDR8WxFV6etcUj62gK
         g+T50zKSPUFJVO0rtExhw+UlNEIwzv1vJPAW5ZN3KK5GtQozPq9bSZhWQiInZ782Ye7w
         g5JyT5R4HqvJf1Ktu9qCk/YaHsop3AqQr/vB38hFIOuB4u6vSDK2jTPdgo4uKSSdSO1C
         jX+z5ZjYqw2JCpyEjUsvfRksXeeatG7ACr4pRHNLxYatV/CnvDDI/ZeFAf2+DPBQkug9
         rDD5amb1FSXeAAP1MP0Bg8tiAm6kCm3ed/NhkFSm+AMJGD8ymoZt1gLTdvb6pZt+ILPi
         p7fw==
X-Gm-Message-State: AElRT7FmQzm+1Wu18KzypN2UGCp7xABAMHIsMAV6WJyh3nWEC74NDUCz
        NxI9H2ifL3Zn8flQaLTxcDQ=
X-Google-Smtp-Source: AG47ELvueRM22iOuZnzdNf7ZI0Nhy7lA00qEEepgzpIiWfQ/SeyFZavMi5F9unHzMsO0wLWUycYDkQ==
X-Received: by 10.223.166.179 with SMTP id t48mr17463631wrc.161.1521665966159;
        Wed, 21 Mar 2018 13:59:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b38sm7759392wrg.81.2018.03.21.13.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 13:59:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: add option completion for most builtin commands
References: <20180321193039.19779-1-pclouds@gmail.com>
Date:   Wed, 21 Mar 2018 13:59:24 -0700
In-Reply-To: <20180321193039.19779-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 21 Mar 2018 20:30:39 +0100")
Message-ID: <xmqqd0zxno0j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> These commands can take options and use parse-options so it's quite
> easy to allow option completion. This does not pollute the command
> name completion though. "git <tab>" will show you the same set as
> before. This only kicks in when you type the correct command name.
>
> Some other builtin commands are not still added because either they
> don't use parse-options, or they are deprecated, or they are those
> -helper commands that are used to move some logic back in C for
> sh-based commands.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 276 +++++++++++++++++++++++++
>  1 file changed, 276 insertions(+)

Wow, just wow.  It however looks a lot of boilerplates, e.g. looking
at these, we notice ...

> +_git_blame() {
> +	case "$cur" in
> +	--*)
> +		__gitcomp_builtin blame
> +		return
> +		;;
> +	esac
> +}
> +
>  
> +_git_cat_file() {
> +	case "$cur" in
> +	--*)
> +		__gitcomp_builtin cat-file
> +		return
> +		;;
> +	esac
> +}
> +
> +_git_check_attr() {
> +	case "$cur" in
> +	--*)
> +		__gitcomp_builtin check-attr
> +		return
> +		;;
> +	esac
> +}

... the only thing we need for the above three is a table that says
"use blame for blame, cat-file for cat_file, and check-attr for
check_attr".

And that pattern repeats throughout the patch.  I wonder if we can
express the same a lot more concisely by updating the caller that
calls these command specific helpers?

