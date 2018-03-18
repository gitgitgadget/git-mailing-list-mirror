Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87FCC1F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 09:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeCRJGP (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 05:06:15 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45362 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeCRJGO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 05:06:14 -0400
Received: by mail-io0-f194.google.com with SMTP id m22so17246229iob.12
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 02:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RivSqvxHwL2aYM9P2Z1a0FPUCuD/qysAGk0jQ22dj4I=;
        b=rx8U04T285qIZDxnGUiW0q9MImCX0FYtKO3HONtwXpiGIW+mVN/A4Bas95RBTOYxdv
         7+FoShpNoWSsW9x/l3jcDiWIJ/rogHimM4SJXqJBQFtCZP6ZDGNQNWTz4T6HhazqZ3Ri
         uBhh5qKi5yez7rHwp31lExqWYOqFS57YOhlZP2sDh1BklzcG+pitQCzhHBa/S9pYvlhf
         EFugmAA62UasNJHupmcHXEFSljixKwuLehmSwahM/t8QYp2Z6Q1RqTNY3dG7L62oZu5K
         GGMtP8/R6mWPMKNdhiszRkA9vTmqrJfPnHjWe5pkTPZjdMaoPV06uKr6keEhBqcJAFBH
         SYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RivSqvxHwL2aYM9P2Z1a0FPUCuD/qysAGk0jQ22dj4I=;
        b=drUE+dkhvrBzUcmOfnHyHglEK0xY51jcs/lZyANC3cfFp8wtd9zvISJd7cvhf3mqbu
         HoRiEEV+032uRltsheNG5qOgjkC/KMD9i+lgMrwczkG0Ylgbx2ExoKWgVGxfErv2ai4g
         c83XG44Brbap8IuCk/KCfYNSgo71AaX3EKx9dzD+rC39uxzJs+n4SxbwX8a/jE6XCOcW
         Z6rjBsi/oifjqSICWGFO4DaOJynZ+svrxvtEFn/WZG4CEucLOpdIyXynmnpXXE+j5dNa
         hRlCygoyjQN9Gf8+1cFypUo4FHOagYwi14srWGBgJV2SFjAK0E/i+XiBjuQUYx+O7pe1
         wkPw==
X-Gm-Message-State: AElRT7H5T7qtiWz4mMUzBYytJXXVdtuxYiAHl2Ovhd/eSx9ZfHXbJ0ra
        nUe+xR9bu/KtMqgelofTNPo=
X-Google-Smtp-Source: AG47ELuhNrWVw/vxp810Y/wr29iSNe5WvKaLUu6IEDa9YqMnz8ILOkPnJFV93f0WHCpf2he4MUX0Jw==
X-Received: by 10.107.166.79 with SMTP id p76mr2978834ioe.289.1521363973511;
        Sun, 18 Mar 2018 02:06:13 -0700 (PDT)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id e73sm1145477iod.34.2018.03.18.02.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 02:06:12 -0700 (PDT)
Date:   Sun, 18 Mar 2018 05:06:07 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org, larsxschneider@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in
 DEVELOPER=1
Message-ID: <20180318090607.GA26226@flurp.local>
References: <20180317160832.GB15772@sigill.intra.peff.net>
 <20180318081834.16081-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180318081834.16081-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 09:18:34AM +0100, Nguyễn Thái Ngọc Duy wrote:
> The set of extra warnings we enable when DEVELOPER has to be
> conservative because we can't assume any compiler version the
> developer may use. Detect the compiler version so we know when it's
> safe to enable -Wextra and maybe more.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/detect-compiler b/detect-compiler
> --- /dev/null
> +++ b/detect-compiler
> @@ -0,0 +1,50 @@
> +get_version_line() {
> +	"$CC" -v 2>&1 | grep ' version '
> +}

On MacOS, "cc -v" output is:

--- >8 ---
Apple LLVM version 9.0.0 (clang-900.0.39.2)
Target: x86_64-apple-darwin16.7.0
Thread model: posix
InstalledDir: ...
--- >8 ---

> +get_family() {
> +	get_version_line | sed 's/^\(.*\) version [0-9][^ ]* .*/\1/'
> +}

So, this returns "Apple LLVM".

> +case "$(get_family)" in
> +gcc)
> +	print_flags gcc
> +	;;
> +*clang)
> +	print_flags clang
> +	;;
> +"FreeBSD clang")
> +	print_flags clang
> +	;;
> +*)
> +	: unknown compiler family
> +	;;
> +esac

Which means you probably want to squash in:

--- >8 ---
diff --git a/detect-compiler b/detect-compiler
index bc2ea39ef5..3140416b40 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -41,6 +41,9 @@ gcc)
 *clang)
 	print_flags clang
 	;;
+"Apple LLVM")
+	print_flags clang
+	;;
 "FreeBSD clang")
 	print_flags clang
 	;;
--- >8 ---
