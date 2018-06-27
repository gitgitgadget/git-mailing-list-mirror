Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393461F597
	for <e@80x24.org>; Wed, 27 Jun 2018 19:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966341AbeF0TLp (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 15:11:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54581 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966222AbeF0TLo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 15:11:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id i139-v6so6957081wmf.4
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5s0ItGY7ZD8pOmw4xHf+927qIf0CvDM0VVjeWsvBlqU=;
        b=BFwfShADpIYHJbBSiLUuP5QeKrerf9eXsjqBLoFR4jRz2qfeA3gCJX6NSAWZpqQCaU
         GygCUAj69UXj41R/o6/Ha/YMU4/9xjoDuRy20CjbCQ8tu+Reo1+8IHC+SVEUc10BDdv5
         VZ2g59G/2H0IL6yAuhIHxub/mF2t0zjGWBfL3uC/tDqxLGVKm+TlyYFo91wErzarp4MZ
         Lis7bgoHGEkeHq4dLOnmSVWg+Zng+sBLTStOqj6+7p93XLB2GPhs4KT62dyI4VRDCAiq
         oyAMFYF2UlCIcD5dl8ePI2c5t9Mgkpb9sL4ObjDQM7x5p085VOg42uNdhiEu0iiGQkmw
         /ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5s0ItGY7ZD8pOmw4xHf+927qIf0CvDM0VVjeWsvBlqU=;
        b=DrCKq3ycAf1FT/i8/cCEpAJxbrnTh8ShXBvSlqTPdxxP6WbYaUdyQjKDKlwTtwqCfM
         qx2/LdCiLdT7sXQgAHEw7N7alr6r+zY3WBZf3EqzLpYLGhgC7lHiq7UEbKRSUeH7r3G+
         ajciRd86MXHbRzzt7RotWCOJ2AS+V1S9kQ7ZbYZ8MvM7FmkQUiRVB14kaSbdK9Iu10RU
         MuwzuUXBHz/4GMpusiRZFtzHZQWqo7nFdVKmrzo/PlNmriw2QRQqQZ3OVdPbIKV5M2af
         OeryrMpjfIpbqxZxVqw9WkFnZDrS0Mr3nLwqwbYiKGb+FMYujFtfI/uugFssZokwC5jJ
         A8Rg==
X-Gm-Message-State: APt69E1w7gcNV0uh4UidIUt4BuNXlUb6nUbLVmyzqnXSUIc6tBjfef9w
        iZ/xcSNOwaGTAPlBkaQxiVCJH9RJ
X-Google-Smtp-Source: AAOMgpcnxyJJ12jxcz2YtyaqZnIRz7o9n17nG9RjBoPfLXXj+KiGC0nebs0SiIsY3/c0F7uxu46ehg==
X-Received: by 2002:a1c:5982:: with SMTP id n124-v6mr3523056wmb.9.1530126702486;
        Wed, 27 Jun 2018 12:11:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 132-v6sm8824372wmr.33.2018.06.27.12.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:11:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, bturner@atlassian.com,
        Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH v3] Documentation: declare "core.ignorecase" as internal variable
References: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
        <c899089d-c195-26b5-66ce-de0273a7152b@syntevo.com>
Date:   Wed, 27 Jun 2018 12:11:40 -0700
In-Reply-To: <c899089d-c195-26b5-66ce-de0273a7152b@syntevo.com> (Marc
        Strapetz's message of "Tue, 26 Jun 2018 23:50:56 +0200")
Message-ID: <xmqqzhzgdoyb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Strapetz <marc.strapetz@syntevo.com> writes:

> [1. text/plain]
> The current description of "core.ignoreCase" reads like an option which
> is intended to be changed by the user while it's actually expected to
> be set by Git on initialization only. Subsequently, Git relies on the
> proper configuration of this variable, as noted by Bryan Turner [1]:
> 
>     Git on a case-insensitive filesystem (APFS, HFS+, FAT32, exFAT,
>     vFAT, NTFS, etc.) is not designed to be run with anything other
>     than core.ignoreCase=true.
> 
> [1] https://marc.info/?l=git&m=152998665813997&w=2
>     mid:CAGyf7-GeE8jRGPkME9rHKPtHEQ6P1+ebpMMWAtMh01uO3bfy8w@mail.gmail.com
> 
> Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
> ---
>  Documentation/config.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Hmph.  Do other people have difficulty applying this patch to their
trees?  It is just several lines long so I could retype it myself,
but I guess "Content-Type: text/plain; charset=utf-8; format=flowed"
has destroyed formatting of the patch rather badly.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1cc18a828..c70cfe956 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -390,16 +390,19 @@ core.hideDotFiles::
>  	default mode is 'dotGitOnly'.
>
>  core.ignoreCase::
> -	If true, this option enables various workarounds to enable
> +	Internal variable which enables various workarounds to enable
>  	Git to work better on filesystems that are not case sensitive,
> -	like FAT. For example, if a directory listing finds
> -	"makefile" when Git expects "Makefile", Git will assume
> +	like APFS, HFS+, FAT, NTFS, etc. For example, if a directory listing
> +	finds "makefile" when Git expects "Makefile", Git will assume
>  	it is really the same file, and continue to remember it as
>  	"Makefile".
>  +
>  The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
>  will probe and set core.ignoreCase true if appropriate when the repository
>  is created.
> ++
> +Git relies on the proper configuration of this variable for your operating
> +and file system. Modifying this value may result in unexpected behavior.
>
>  core.precomposeUnicode::
>  	This option is only used by Mac OS implementation of Git.
