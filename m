Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE2D20188
	for <e@80x24.org>; Mon,  8 May 2017 05:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbdEHFIZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 01:08:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35367 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdEHFIY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 01:08:24 -0400
Received: by mail-pg0-f67.google.com with SMTP id i63so8958601pgd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 22:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xX0tGzOFfp2x1IRpb1cNDjCU/Y2Bcrtc3gJwVB89TvM=;
        b=FyuFydNwZuoJ2uCZp2cuNUD3sooQOtdTAxWtKwEfHqSEKlR4wNmTiP0BbFnw4U6qwN
         mmVzbtIBMMX3QJvG8TXiaQFZBU5sG1vqGM4ftB17xwDzioo2It4VQQk0zXuvFEAFIOv3
         25XkpV5l8xYAFohJzWj5cjsl0t2bkIFhn0I0ZuF3eI0dz8Rueprg9vUPRe7QTvPhUhBk
         mlcWN6r9G9C6iQ4LYWiJL+RnEm6iwue/E6VJLk6oXq4rYRKlGEPpfbbYqBup20DrDP63
         cWJiANHFJIxAkbC3J01e4OmhcGkCjeUtLSceykmwjJsFOA4vcWELXx3i4lSJ1h3IN9sC
         o+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xX0tGzOFfp2x1IRpb1cNDjCU/Y2Bcrtc3gJwVB89TvM=;
        b=QyCYuJVBkGtNXkj/SQiDJ+BIJmUH3iaTVODMlDbwjhC2ITCuFsK2DDzb1bw6SgyvXN
         V+UPM7B9ppb5K2MacJ28G+oj6EPxhEsRhYcfs5A15adFJf+7SXEhmA4NUcTn2Pe6tZS+
         7QRe3hd4odYQ7FrdTkUNPKPWaCHLl/8k05XL7jAnV/3flb915V4RkfuMSHSjvyPAd1B5
         ufY//FY8lZOG3RNnLFJy/H8CK4iu7IsfZZ9vYgzi3AtoWKMAeWhraSW8EfM65kY+cKT1
         zMEmnNcTsty6t6H05bIkN4lxHFx/UrYfloNRV3EpbtVIlH1R9U0EYJNtwFCjiq1wwKc2
         gFkA==
X-Gm-Message-State: AN3rC/4da4y8i/p4X1a1cKMeYLgrDxnExFbf1fJ73+avxa7F0v3svKxU
        bMUx1od2XKHHUA==
X-Received: by 10.99.149.20 with SMTP id p20mr16491875pgd.112.1494220103710;
        Sun, 07 May 2017 22:08:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id x21sm22322351pfa.71.2017.05.07.22.08.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 22:08:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/7] Fix build with core.autocrlf=true
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
        <cover.1493891336.git.johannes.schindelin@gmx.de>
        <0a2af24e3423e402e6607fdc69fcbeb8cfe5489a.1493891336.git.johannes.schindelin@gmx.de>
Date:   Mon, 08 May 2017 14:08:21 +0900
In-Reply-To: <0a2af24e3423e402e6607fdc69fcbeb8cfe5489a.1493891336.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 4 May 2017 11:49:20 +0200
        (CEST)")
Message-ID: <xmqqzieo7x6i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When generating common-cmds.h, the Unix tools we use generally operate on
> the assumption that input and output deliminate their lines using LF-only
> line endings. Consequently, they would happily copy the CR byte verbatim
> into the strings in common-cmds.h, which in turn makes the C preprocessor
> barf (that interprets them as MacOS-style line endings). Therefore, we
> have to mark the input files as LF-only: command-list.txt and
> Documentation/git-*.txt.

I guess nobody in the Windows land opens the doc source with
Notepad, like experienced Git developers runs "less" on them as a
faster way than accessing HTMLized (or manified) versions, and
marking Documentation/git-*.txt explicitly as eol=lf is OK.  That
was the only thing I had brief worry about this patch.

Thanks, will queue.

> diff --git a/.gitattributes b/.gitattributes
> index 320e33c327c..8ce9c6b8888 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -1,3 +1,9 @@
>  * whitespace=!indent,trail,space
>  *.[ch] whitespace=indent,trail,space diff=cpp
> -*.sh whitespace=indent,trail,space
> +*.sh whitespace=indent,trail,space eol=lf
> +*.perl eol=lf
> +*.pm eol=lf
> +/Documentation/git-*.txt eol=lf
> +/command-list.txt eol=lf
> +/GIT-VERSION-GEN eol=lf
> +/mergetools/* eol=lf
> diff --git a/git-gui/.gitattributes b/git-gui/.gitattributes
> index 33d07c06bd9..59cd41dbff7 100644
> --- a/git-gui/.gitattributes
> +++ b/git-gui/.gitattributes
> @@ -2,3 +2,4 @@
>  *           encoding=US-ASCII
>  git-gui.sh  encoding=UTF-8
>  /po/*.po    encoding=UTF-8
> +/GIT-VERSION-GEN eol=lf
