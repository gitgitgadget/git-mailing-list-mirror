Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39894C433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 18:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiB0SC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 13:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiB0SC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 13:02:56 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D676B0A1
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 10:02:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cm8so14504112edb.3
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1IHHKwhvA+g7o9SINMIEXXBkpu4XCYeNs6D5U9jr1I=;
        b=qbfMSJf+fmtFhovyx51WPdoLKeIYCaTlj0fXHbism+qxXJJCtYz7tcStxe4HwXq+N2
         rdblJEuOH/okDR0f4jjYa6pfWZYldBWhYDqEl28TVImRljvTkDEB5yT/Eh0SlhcSWzLK
         +s6yYtFwtIaAdDRfPFGs3a8MTcnSDyCaUK04QsXepo9o+EIr6QZdRJFFTyeXV3X3MAbA
         oRA2jhLTNpYwEpvUdgCMQ42EQn5NH09+8ioPNP5GL6DgCjcGprCxR0n5b4xbHFX8zFW4
         4ueaHtJWxnEmifBE6ZnAvTrxGnZIxBYJ2sqTM6Q/Gq4NuF8L72ZJsp5MEDjfiqDcNgEy
         V+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1IHHKwhvA+g7o9SINMIEXXBkpu4XCYeNs6D5U9jr1I=;
        b=nbbsHZIyKFlFdr01d2iKc2xp3I+iaoo7D1xxrn07ddW0NaYNuF/yYAe04CHQBPjayd
         lPcueizMRQ8HHimBa//7xFp1jSJUIjjp2mYc7IszT3hjGxGmPs51afgP+TzoM5ppzWtC
         Qgcr8E4htE6Tfpe2qeC9CYvv+fV3EkY+EPRg+b2IKV3JaIWafsjf/pJiButFIVmPkx8c
         YTVs6IItWcq9NQaoy4GPhILkpkSgjx7lQKwaVdbYTm5GmswPrkAJ20cExXKndaPID2+w
         KZYhsHzy4b0WXWx4OAbLriN+B1O0TouzizJ3F3EeLgnxkGCF2jyyPfEwkfy0KrXxzu1Y
         OBPA==
X-Gm-Message-State: AOAM5333DW9ARSWijefaJR7WOkbL2A9MherX8kuVgQlSqIx6tFGHuLV5
        BcQv1CXilQRepD3strlhZ4gZOsKgIgEcSvJ3
X-Google-Smtp-Source: ABdhPJwZCuUheo05Bg5Y3xlg8njXGYq9dAy+6UPjuV9I5iF0GhvS4T+NQR261cHNoilA8i7Okj/p+g==
X-Received: by 2002:aa7:d4ca:0:b0:410:d232:6b76 with SMTP id t10-20020aa7d4ca000000b00410d2326b76mr16200506edr.370.1645984938337;
        Sun, 27 Feb 2022 10:02:18 -0800 (PST)
Received: from gmail.com (91.141.32.73.wireless.dyn.drei.com. [91.141.32.73])
        by smtp.gmail.com with ESMTPSA id i12-20020a50870c000000b0040f3f1d4497sm4902060edb.27.2022.02.27.10.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 10:02:17 -0800 (PST)
Date:   Sun, 27 Feb 2022 19:02:03 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rerere-train: modernise a bit
Message-ID: <20220227180203.pakrqimsxbjx47tu@gmail.com>
References: <xmqqsfsjuw8m.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsfsjuw8m.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 11:05:45PM -0800, Junio C Hamano wrote:
> The script wants to create a list of merges using "rev-list" and
> filters commits that do not have more than one parent, but if we
> always pass "--merges" to "rev-list", there is no need to filter.
> 
> The command uses "git show --pretty=format:..." on a single commit
> while generating progress reports, which means this title line is
> left unterminated.  It should have used --pretty=tformat:...

Yep, tformat is more correct semantically, but it's worth noting that there
is no behavior change here. These commands behave the same

	git show -s --pretty=tformat:"Learning" HEAD
	git show -s --pretty=format:"Learning" HEAD

I guess we automagically add a final newline somewhere, if it's missing.

If there is a final newline ("Learning%n"), then the commands show different
behavior. The subject (%s) can never have a newline, so that's not the
case here.

I'd add something like this (for the lack of knowing where exactly the
implicit newline comes from):

	No harm was done because we implicitly add the trailing newline,
	but it should have used --pretty=tformat:...

> instead, or better yet, use the more modern --format=... to ensure
> that the title line is properly terminated.

> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/rerere-train.sh | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git c/contrib/rerere-train.sh w/contrib/rerere-train.sh
> index 75125d6ae0..499b07e4a6 100755
> --- c/contrib/rerere-train.sh
> +++ w/contrib/rerere-train.sh
> @@ -66,14 +66,9 @@ original_HEAD=$(git rev-parse --verify HEAD) || {
>  
>  mkdir -p "$GIT_DIR/rr-cache" || exit
>  
> -git rev-list --parents "$@" |
> +git rev-list --parents --merges "$@" |
>  while read commit parent1 other_parents
>  do
> -	if test -z "$other_parents"
> -	then
> -		# Skip non-merges
> -		continue
> -	fi
>  	git checkout -q "$parent1^0"
>  	if git merge $other_parents >/dev/null 2>&1
>  	then
> @@ -86,7 +81,7 @@ do
>  	fi
>  	if test -s "$GIT_DIR/MERGE_RR"
>  	then
> -		git show -s --pretty=format:"Learning from %h %s" "$commit"
> +		git show -s --format="Learning from %h %s" "$commit"
>  		git rerere
>  		git checkout -q $commit -- .
>  		git rerere
