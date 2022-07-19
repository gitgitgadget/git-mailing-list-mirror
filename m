Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D039BC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiGSS3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbiGSS3X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:29:23 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5C48C8A
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:29:22 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h11-20020a170902f54b00b0016bfdca124fso8941506plf.9
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oWnOX0kqh4v4pze0cGUnd+rFMRxs42h+STPamxWo7zU=;
        b=DgcLI/I4QiL+zZ7dNCrRzJmKItcUOVML7xHKp7sG5/JmZCdhZd30PFuLDYPLF6xaRO
         vNudgKY31bglaK4YY0MADgGX8CxBRU9uJBTYlceCpuYMS1pAN3RAM/DL9jXVo2rAHgv2
         /n3haGaBO7ZUCzUM09eat1B5k08hHGer6FBAzf597yNC8HBULelSpmP1f5PWKEczVVs8
         FMrvP9xgb1amhnn/twnRUrypCHHk+nQdf8nDy/4wRHw5Aaa3aKnf1vvmx4uVGmbFKAvK
         6zQfhPI3hgLJb+ZQOcXsHAn6lANIwYD0dSHjaalzdG2nXOFMN87EiYL24Tp4naTyo9Tz
         VFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oWnOX0kqh4v4pze0cGUnd+rFMRxs42h+STPamxWo7zU=;
        b=Dr7ZGaQcknYUciZFH/nup9RMf9XlMd0ckgi0WQCQY3mTjlopRlZIkAD1RF4O5+x2Jd
         ZBzqA0sLw0SMo+aC+iT6vIxlZCDJJ+ctjvxC5u2Lc/KMrWUEZWO543lTeA/4+sShsb6m
         IdToGwoN4H7dPP5SBvP0A6W5Yz7F9T+GyjI5PToV5jtawEkejf4fLN6VgHwCjuNaAw13
         a+wDIzhQC0W0o43s/A+8kJU3o4KT+S6Rrv8nsIfT05LmEIHNH1Mx3q4lkMsAJVlOJLSp
         rxwZWsKkC22OONC3WhwmK92nAV5lKykjrQpkRumau9St7QJdMzfZ+moiJNAKVEWEU1oc
         Hwtg==
X-Gm-Message-State: AJIora+/05XfTbX9y500budl9bIhkxFvFsvaZC+OclwRGM2TeVrvqhtz
        KIZmNBHeB9b9g301brWZGMRZWI+TAdRnhg==
X-Google-Smtp-Source: AGRyM1shtqQNem8R80TXyqnfwxM4g6yfM/Hg2n5B0L4rKO8BKzFG3RQoJ0HGevdUUM1s0zr9OT4hDvoRCh9ObA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:228d:b0:16c:56e4:8640 with SMTP
 id b13-20020a170903228d00b0016c56e48640mr34681503plh.90.1658255362104; Tue,
 19 Jul 2022 11:29:22 -0700 (PDT)
Date:   Tue, 19 Jul 2022 11:29:20 -0700
In-Reply-To: <pull.1293.git.1658251503775.gitgitgadget@gmail.com>
Message-Id: <kl6llespt0qn.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1293.git.1658251503775.gitgitgadget@gmail.com>
Subject: Re: [PATCH] osx-keychain: fix compiler warning
From:   Glen Choo <chooglen@google.com>
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Update git-credential-osxkeychain.c to remove 'format string is not a string
> literal (potentially insecure)' compiler warning by treating the string as
> an argument.
>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>     osx-keychain: fix compiler warning
>     
>     Running make in contrib/credential/osxkeychain currently shows the
>     following warning:
>     
>     warning: format string is not a string literal (potentially insecure)
>     
>     This small change to treat the string as an argument fixes the issue.
>     
>     Thanks, Lessley

Thanks! I literally just ran into this warning, and it's been already
fixed :)

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1293%2Fldennington%2Ffix-osx-keychain-warning-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1293/ldennington/fix-osx-keychain-warning-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1293
>
>  contrib/credential/osxkeychain/git-credential-osxkeychain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index 0b44a9b7cc6..bf77748d602 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -168,7 +168,7 @@ int main(int argc, const char **argv)
>  		"usage: git credential-osxkeychain <get|store|erase>";
>  
>  	if (!argv[1])
> -		die(usage);
> +		die("%s", usage);
>  
>  	read_credential();

Looks good!

>  
>
> base-commit: 71a8fab31b70c417e8f5b5f716581f89955a7082
> -- 
> gitgitgadget
