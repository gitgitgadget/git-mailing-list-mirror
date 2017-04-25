Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80871207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 22:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1953235AbdDYWp1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 18:45:27 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33896 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1953231AbdDYWp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 18:45:26 -0400
Received: by mail-io0-f194.google.com with SMTP id h41so55503334ioi.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G/4R38qzgCx9ykLRFCnbgjxt6TZWd3z45pLEHz90TSY=;
        b=a3XNqtE4sWanQBPVesn2lSX/ngunw1sCzaDvGHXVfDTw0nSzPYVKAJQFqHjK/NCqVl
         TEtxh/OtiTjKMKWI9EzVlP8si9/5jKSyt/h5zvPPRZ3FfAJ5x91I4sux5gwksYF6wULX
         NAn/RE5d+N1m/VsHz3PIY4L97AUg3Fdu/nX+jSAnXLd5nXRve9wKcGxLmqJWZE801YCg
         /H2sQFBRw5u6ObPfa50FXA44QB9lZoF8UZFqLQZDz8X3u5aEvYKpOO6y0l0dnj2OQQef
         /zspl8QBqE+ZJZOMv9/65fh7wgkR1bpalZUJSo48hv4ta8vhJZmBPGr8MGb26g4JZ0tv
         6zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G/4R38qzgCx9ykLRFCnbgjxt6TZWd3z45pLEHz90TSY=;
        b=Cep0NJ+edrNhaBGgj3EnszZM4zPuNyxB0kSsrfJGRChEkXaRBSTvrrBHF4lc0wrzxg
         9GotPQXGwYlKko/IYlNFKLMBl1g59/vgquU5fMel0RM2aq5PC6oEiDbwbyjg+n1a/cs4
         DmizxujMsJABP86My3T7inyeCu7rHK5vQOGTdHz61a65xcDU1psXTovnb8ndorxS/iDT
         Tuq1u9QiD5UgCjSTP2fsD9lL/woq1tqlRa7ch1SsGcxM00A5u/8O3nxOP7qixT8ZlnUm
         jp8CbwtvwDXIUW3oHBUJAshYzJDfRqfytJ8LKCv6plvj8E3ee/l7IDbvU0Yt2v7DvFWx
         GEqA==
X-Gm-Message-State: AN3rC/7ibwmFULF+R2fkl9MhfoJ6A1r/0/VT+Wom/al/cY4UOFK2if0z
        /iAUWwwpyMEKhA==
X-Received: by 10.107.144.138 with SMTP id s132mr20703208iod.22.1493160324980;
        Tue, 25 Apr 2017 15:45:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:c0ea:3a03:d3a7:cb53])
        by smtp.gmail.com with ESMTPSA id k33sm746381ioi.35.2017.04.25.15.45.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 15:45:24 -0700 (PDT)
Date:   Tue, 25 Apr 2017 15:45:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] clone: add a --no-tags option to clone without tags
Message-ID: <20170425224521.GM28740@aiede.svl.corp.google.com>
References: <xmqq60i1dvnk.fsf@gitster.mtv.corp.google.com>
 <20170419143831.6868-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170419143831.6868-1-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Add a --no-tags option to "git clone" to clone without tags. Currently
> there's no easy way to clone a repository and end up with just a
> "master" branch via --single-branch, or track all branches and no
> tags. Now --no-tags can be added to "git clone" with or without
> --single-branch to clone a repository without tags.

Now I've read the discussion from v1, so you can see my thoughts
evolving in real time. :)

The above feels a bit misleading when it says "there's no easy way to
clone a repository and end up with just a 'master' branch".
--single-branch does exactly that.  Some annotated tags *pointing to
its history* come along for the ride, but what harm are they doing?

In other words, I think the commit message needs a bit more detail about
the use case, to say why omitting those tags is useful.  The use case
is probably sane but it is not explained.  A side effect (and my main
motivation) is that this would make it crystal clear to people looking
at the patch in history that it is talking about tags that are part of
"master"'s history, not tags pointing elsewhere.

> Before this the only way of doing this was either by manually tweaking
> the config in a fresh repository:

Usually commit messages refer to the state of things without some
patch using the present tense --- e.g. "Without this patch, this
--no-tags option can be emulated by (1) manually tweaking the config
in a fresh repository, or (2) by setting tagOpt=--no-tags after
cloning and deleting any existing tags".

[...]
> Which of course was also subtly buggy if --branch was pointed at a
> tag, leaving the user in a detached head:
>
>     git clone --single-branch --branch v2.12.0 git@github.com:git/git.git &&
>     cd git &&
>     git config remote.origin.tagOpt --no-tags &&
>     git tag -l | xargs git tag -d

At this point I lose the trail of thought.  I don't think it's
important to understanding the patch.

> Now all this complexity becomes the much simpler:
>
>     git clone --single-branch --no-tags git@github.com:git/git.git
>
> Or in the case of cloning a single tag "branch":
>
>     git clone --single-branch --branch v2.12.0 --no-tags git@github.com:git/git.git

Nice.

[...]
>  Documentation/git-clone.txt | 14 ++++++++-
>  builtin/clone.c             | 13 ++++++--
>  t/t5612-clone-refspec.sh    | 73 +++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 95 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 30052cce49..57b3f478ed 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
>  	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
>  	  [--dissociate] [--separate-git-dir <git dir>]
> -	  [--depth <depth>] [--[no-]single-branch]
> +	  [--depth <depth>] [--[no-]single-branch] [--no-tags]

Can I pass --tags to negate a previous --no-tags?

[...]
> +--no-tags::
> +	Don't clone any tags, and set
> +	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
> +	that future `git pull` and `git fetch` operations won't follow
> +	any tags. Subsequent explicit tag fetches will still work,
> +	(see linkgit:git-fetch[1]).
> ++
> +Can be used in conjunction with `--single-branch` to clone & maintain

nit: s/&/and/

[...]
> +test_expect_success 'clone with --no-tags' '
> +	(
> +		cd dir_all_no_tags && git fetch &&
> +		git for-each-ref refs/tags >../actual

nit: this would be easier to read with the 'cd' and 'git fetch' on
separate lines.

[...]
> +test_expect_success '--single-branch while HEAD pointing at master and --no-tags' '
> +	(
> +		cd dir_master_no_tags && git fetch &&

Likewise.

> +		git for-each-ref refs/remotes/origin |
> +		sed -e "/HEAD$/d" \
> +		    -e "s|/remotes/origin/|/heads/|" >../actual

Can $/ be expanded by the shell?

The rest looks sensible.

Thanks and hope that helps,
Jonathan
