Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D991F453
	for <e@80x24.org>; Tue, 22 Jan 2019 20:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfAVUWt (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 15:22:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34478 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVUWs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 15:22:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so29012021wrw.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 12:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PA/g3gHu6GO3Iqr/zrgt3v6arTQbBMN4I7uluTfoXWE=;
        b=YDMbmORLUpb90X2k9t4hjkCWQ+Fd8vLS6rO4U6NJykQCiRRHdpToY2nufSwR6gVxgo
         /IEJkog26/K9uRsymW/VyJ5zNqKFx78pDiGAgr4/mQSR6Fy3jI8hZqJzK0Hf4C5XqyeD
         nv7/WWIXTXEkHVM4TU6ScG3dbWpDQfev5TJW3CpxsNQf68gAAkWlv96NyFt2b7QexJpJ
         hG0ip3dTiPBJyltBxa2brBWnKPLlB92DBorysFPOvreJb8c7xYpLbE/SVC627dO2MgpR
         D+dTuOSN+wfy+0l9c6kSMJK0H4MA+4NA6KRPcVTv+Il+hfDU0UYY4nwu4w2+tf3+5GQJ
         2Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PA/g3gHu6GO3Iqr/zrgt3v6arTQbBMN4I7uluTfoXWE=;
        b=hfLVQeWPpMlsgGwQtXT6qyFpYN+pqRJJkl0+KCVOv5tv80CIl/yezc1+qs7sPPjHKr
         koYfO8g3TcVY4myCTUxi/gPjZcU4T39YpQL+rTrVdZ+toLF8agKy0Hfc2j5e/8gSLjRF
         0pKq0OQvWQ/Ym5ZBCYl18C92U2nNK5Fpk4AAfhWK0DAc8dDHKImwxHwqoj3AMEoP4+cw
         NRzAiOcmlbKdeQENa0HY+r0s2/is8dBraTarRDU0/ED7CU3f7ebGCWmTKBSlGxX9Bsxh
         y6ukPQ+GlG3GphMsQDR0g1oy0BY7styNholyvuR3B/RQ8JZl3cB15vpkuITQPk4e5kSY
         Zmew==
X-Gm-Message-State: AJcUukfhQ+cbamTDIGClIaJ0q1gV8LjlBib6BCLe/OmNjXwl+n0cUNxG
        Tr3hpJeUFGGJkfAM51KNcas=
X-Google-Smtp-Source: ALg8bN7Tno8/rxHNx41Tr1NxCpgg3BCvJkpmSHfGWrt/qqFNVbmNgQXTBCM86FoD1i5t0AD7tXWjWw==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr35013815wru.28.1548188566519;
        Tue, 22 Jan 2019 12:22:46 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t4sm94856153wrm.6.2019.01.22.12.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 12:22:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sven van Haastregt <svenvh@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-submodule.sh: shorten submodule SHA-1s using rev-parse
References: <20190120204653.3224-1-svenvh@gmail.com>
Date:   Tue, 22 Jan 2019 12:22:45 -0800
In-Reply-To: <20190120204653.3224-1-svenvh@gmail.com> (Sven van Haastregt's
        message of "Sun, 20 Jan 2019 20:46:53 +0000")
Message-ID: <xmqqfttkfnmy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sven van Haastregt <svenvh@gmail.com> writes:

> Until now, `git submodule summary` was always emitting 7-character
> SHA-1s that have a higher chance of being ambiguous for larger
> repositories.  Use `git rev-parse --short` instead, which will
> determine suitable short SHA-1 lengths.

In general I think it is a good idea to scale as the repository
grows by asking "rev-parse --short" to do the job.

One thing it is not clear to me is that this codepath is prepared to
handle sha1_src and sha1_dst referring to an object that does not
exist (i.e. $missing_(src|dst)=t); the original code will still give
us 7 hexdigit to show on the headline, but does the updated code
that uses "rev-parse --short" give us a reasonable output?

>
> Signed-off-by: Sven van Haastregt <svenvh@gmail.com>
> ---
>  git-submodule.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 5e608f8bad..a422b0728d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -850,8 +850,8 @@ cmd_summary() {
>  			;;
>  		esac
>  
> -		sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
> -		sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
> +		sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src)
> +		sha1_abbr_dst=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_dst)
>  		if test $status = T
>  		then
>  			blob="$(gettext "blob")"
