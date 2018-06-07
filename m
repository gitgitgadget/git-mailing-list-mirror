Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F220B1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeFGFsk (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:48:40 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39563 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeFGFsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:48:39 -0400
Received: by mail-pl0-f67.google.com with SMTP id f1-v6so5351061plt.6
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ak0WTHFthY5uX5iQgIRceBFc8i6DGvFTkocUhsZAz9A=;
        b=btovduDTDcPZGSQHo5j5c2J2MKxgPVhPdr4ZjyPxv0ejX6snKkIaH5D96IVff7XJJQ
         gbqTjHIj8X4DuqJFz5c6ISOF6/+UUJm4uoD3V4LZQ7uxxK0ziEv0PlGX3L/xit3y0L8y
         RchE7vnUUo/BA1T8e6svg0cID7x/JgQM7ESXykwqTYYCVK6gfFzLsjWPnXjvduWLGKsT
         KwN1/QCSFHCvhAt5RUNreUagAISCaW8Czq/Q8RIE/crYVpKJChdYze5LVt+UJxgQKXBD
         oGerQ0zZ4a/YMr97pV1aZwDYYCndwADXTkE7tb4Njyv/AFA9fA6VKNuDaNkFNJ1PtN5n
         Fffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ak0WTHFthY5uX5iQgIRceBFc8i6DGvFTkocUhsZAz9A=;
        b=UBvBaHbZWTjig/ecd5EqpBUY5zhOmaH2frV0kCFtAuwG7lolwQlR/EWT23hjae3lmz
         zGI0UvzpH8rrXXSF8GDL/Pm8EQuG/8LJIeActQ4XeO86qeAdvLAwA3dDjYHeQtPe7c0M
         UFYGshEnYSmyVoB6QWiRqSQYYS7LJ5lGwhNkP6EUh5DJITaMlyNaqbkKue5if99ZW+At
         mcVQ4ChC4dREJNw0Srd4oYlOqUb+a8wkR5/+MGuMnRSONug5wuKJV1jWsWXYUB1B14RN
         pcTR5/GuaRKFlFfWl5SfjOdZAmC5d9f76BtJsTpMya6bohfcDtrTh2PC2aSfhYq5d/yO
         20Pw==
X-Gm-Message-State: APt69E0Od9k1b7m0NbvQG/r4q1MFZGQeaACicRXA6uVV1kFkZIU0fZIO
        xG12szrri24V6Z49q6UW4YI=
X-Google-Smtp-Source: ADUXVKJMify90bkLw1OqG2A0iXZTEsLHBa+UiWKWCRDCnPnoy+hQucWdFLs6XaHSsBXL7qaqVMI27w==
X-Received: by 2002:a17:902:bf01:: with SMTP id bi1-v6mr556283plb.43.1528350518317;
        Wed, 06 Jun 2018 22:48:38 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z4-v6sm60213743pfm.28.2018.06.06.22.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:48:37 -0700 (PDT)
Date:   Wed, 6 Jun 2018 22:48:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git@vger.kernel.org, Rick van Hattem <wolph@wol.ph>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached
 --options
Message-ID: <20180607054834.GB6567@aiede.svl.corp.google.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
 <20180417220219.30445-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180417220219.30445-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

SZEDER Gábor wrote:

> Other Bash versions, notably 4.4.19 on macOS via homebrew (i.e. a
> newer version on the same platform) and 3.2.25 on CentOS (i.e. a
> slightly earlier version, though on a different platform) are not
> affected.  ZSH in macOS (the versions shipped by default or installed
> via homebrew) or on other platforms isn't affected either.
[...]
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -282,7 +282,11 @@ __gitcomp ()
>  
>  # Clear the variables caching builtins' options when (re-)sourcing
>  # the completion script.
> -unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
> +if [[ -n ${ZSH_VERSION-} ]]; then
> +	unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
> +else
> +	unset $(compgen -v __gitcomp_builtin_)
> +fi

As discussed at [1], this fails catastrophically when sourced by
git-completion.zsh, which explicitly clears ZSH_VERSION.  By
catastrophically, I mean that Rick van Hattem and Dave Borowitz report
that it segfaults.

I can't reproduce it since I am having trouble following the
instructions at the top of git-completion.zsh to get the recommended
zsh completion script loading mechanism working at all.  (I've
succeeded in using git's bash completion on zsh before, but that was
many years ago.)  First attempt:

 1. rm -fr ~/.zsh ~/.zshrc
    # you can move them out of the way instead for a less destructive
    # reproduction recipe
 2. zsh
 3. hit "q"
 4. zstyle ':completion:*:*:git:*' script \
      $(pwd)/contrib/completion/git-completion.zsh
 5. git checkout <TAB>

Expected result: segfault

Actual result: succeeds, using zsh's standard completion script (not
git's).

I also tried

 1. rm -fr ~/.zsh ~/.zshrc
    # you can move them out of the way instead for a less destructive
    # reproduction recipe
 2. zsh
 3. hit "2"
 4. mkdir ~/.zsh; cp contrib/completion/git-completion.zsh ~/.zsh/_git
 5. echo 'fpath=(~/.zsh $fpath)' >>~/.zshrc
 6. ^D; zsh
 7. git checkout <TAB>

and a similar process with fpath earlier in the zshrc file.  Whatever
I try, I end up with one of two results: either it uses zsh's standard
completion, or it spews a stream of errors about missing functions
like compgen.  What am I doing wrong?

Related question: what would it take to add a zsh completion sanity
check to t/t9902-completion.sh?

When running with "set -x", here is what Dave Borowitz gets before the
segfault.  I don't have a stacktrace because, as mentioned above, I
haven't been able to reproduce it.

	str=git
	[[ -n git ]]
	service=git
	i=
	_compskip=default
	eval ''
	ret=0
	[[ default = *patterns* ]]
	[[ default = all ]]
	str=/usr/bin/git
	[[ -n /usr/bin/git ]]
	service=_dispatch:70: bad math expression: operand expected at `/usr/bin/g...'

	zsh: segmentation fault  zsh

Here's a minimal fix, untested.  As a followup, as Gábor suggests at [2],
it would presumably make sense to stop overriding ZSH_VERSION, using
this GIT_ scoped variable everywhere instead.

Thoughts?

Reported-by: Rick van Hattem <wolph@wol.ph>
Reported-by: Dave Borowitz <dborowitz@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

[1] https://public-inbox.org/git/01020163c683e753-04629405-15f8-4a30-9dc3-e4e3f2a5aa26-000000@eu-west-1.amazonses.com/
[2] https://public-inbox.org/git/20180606114147.7753-1-szeder.dev@gmail.com/

diff --git i/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
index 12814e9bbf..e4bcc435ea 100644
--- i/contrib/completion/git-completion.bash
+++ w/contrib/completion/git-completion.bash
@@ -348,7 +348,7 @@ __gitcomp ()
 
 # Clear the variables caching builtins' options when (re-)sourcing
 # the completion script.
-if [[ -n ${ZSH_VERSION-} ]]; then
+if [[ -n ${ZSH_VERSION-} || -n ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
 	unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
 else
 	unset $(compgen -v __gitcomp_builtin_)
diff --git i/contrib/completion/git-completion.zsh w/contrib/completion/git-completion.zsh
index 53cb0f934f..c7be9fd4dc 100644
--- i/contrib/completion/git-completion.zsh
+++ w/contrib/completion/git-completion.zsh
@@ -39,7 +39,7 @@ if [ -z "$script" ]; then
 		test -f $e && script="$e" && break
 	done
 fi
-ZSH_VERSION='' . "$script"
+GIT_SOURCING_ZSH_COMPLETION=1 ZSH_VERSION='' . "$script"
 
 __gitcomp ()
 {
