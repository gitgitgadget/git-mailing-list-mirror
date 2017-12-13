Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CDB31F407
	for <e@80x24.org>; Wed, 13 Dec 2017 23:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdLMXEG (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 18:04:06 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:42041 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbdLMXED (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 18:04:03 -0500
Received: by mail-wr0-f181.google.com with SMTP id s66so3560005wrc.9
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 15:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cW0AwjcNt3/o0uw2gkfeQdBpy4lXGomd6ETwgP95wSs=;
        b=o8b+zy8CmZZBB1HzlsgTwf6Ai73NqACC3VA+UcapXR61IP6MJxeriXeLVuy/grrtdy
         up9kXZsqcknwFSexhCOAlno/GtIKFRFkpMGMsUguox50YzjQhEM8RTYtWmi2DvtTpGBm
         9l14EZVDTeoCULJaLiZv86FmudIMAkUwrDUn64rXRPNVGtHKdfUuHZ+TnybLCuByrBQZ
         AbROq86ZCF3ltN+zKQYt5sNDXFO9gIPk2NZnxK+fsXCc+UnJC4IhFrWQSFV0bOpUPXD8
         qzoxmn1lzEGqaBjo9NkST9TK1ZVeYBm5+L9E7wJ2iR68pGBcJiFLxYW7Fe1Ti0Oz5vFK
         o1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cW0AwjcNt3/o0uw2gkfeQdBpy4lXGomd6ETwgP95wSs=;
        b=EGh3+qNXczur1b2UD3o0xsCRlqrMFx41tumcEPOXCz/UU0xsd7PtW0ov8NYUlbKUN8
         uBSbAG3/AvOuY6u7Dbs/+hFsmbO9R5wx9vZe7eJr9HjQQ8cu0H6AaRWh/LFq4JbHIUV0
         KKqo4UKlT4nlDLqwG17fVgCYh8z8GgxIG4HWgfHCyv5xrfXyOaf7P2NBVU7PRjvcS8jw
         V9WC1HDEgdwF1/48LL8VYHjR74AwOa+k63mBB+mEg/f+lZ5pX132s0hchoW2Dim58KZ7
         Yk2BApBDu1+RIBv5FNG5I11wqnpJlAmuJeZ85mHmjCihZLQWSHxIMcsfkBibplDG+I7L
         VJ9w==
X-Gm-Message-State: AKGB3mIzg6I7tst/2mdrHk5UN/1jSnLLTU8N9IOJY3kY0X2wqyJ3h+Rv
        i0q4kEZzNWNLrICohMTvwVHgQP4A
X-Google-Smtp-Source: ACJfBovaMoruktmlIo2i5GQOzhQetAx/o6lqa1+hGGm9OOVWJowDawtacm9EdaFSEnLKh04SpaFzug==
X-Received: by 10.223.136.164 with SMTP id f33mr3804932wrf.162.1513206242371;
        Wed, 13 Dec 2017 15:04:02 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id s187sm1409716wmf.16.2017.12.13.15.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Dec 2017 15:04:01 -0800 (PST)
Date:   Wed, 13 Dec 2017 23:05:47 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Reid Price <reid.price@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Apparent bug in 'git stash push <subdir>' loses untracked files
Message-ID: <20171213230547.GC24597@hank>
References: <CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 12/13, Reid Price wrote:
> When running 'git stash push <subdir>' if there are both tracked and
> untracked files in this subdirectory, the tracked files are stashed
> but the untracked files are discarded.
> 
> I can reproduce this on my system (OSX, git 2.14.1) by running the
> below script as
> 
>     bash -x ./stashbug.sh &> output.txt
> 
> I could not find this indicated anywhere as an existing issue by
> performing generic searches, apologies if this is known.

Thanks for the detailed bug report below.  This is indeed a bug, and
indeed has been broken ever since I introduced the pathspec feature.
Sorry about that.

While I did implement this feature in the first place, I must admit
that I'm a bit out of my depth in terms of my shell foo to fix this
cleanly here.

Just to demonstrate what is wrong, the below diff fixes it (but it
does so in an ugly way that needs a temporary file, and needs a
specific version of the 'read' utility, that supports the '-d' flag,
which isn't in POSIX).

For the pathspec case what we're doing after creating the stash is to
essentially emulate what 'git reset --hard <pathspec>' would do.  As
'git reset --hard <pathspec>' doesn't exist, we do so using the
sequence below of reset -> checkout-index -> clean for the given
pathspec.

This works when the pathspec doesn't match any untracked files, but if
it matches untracked files such as in your case it removes them as
well as the files it should have removed.

One solution to that would be to limit the pathspec given to 'git
clean'.  And that is where my shell foo doesn't go far enough for me
being able to do that, as lists of filenames, which can include spaces
tend to get quite hairy.

Maybe the best solution would be to introduce 'git reset --hard --
<pathspec>', or maybe someone who knows shell programming a little
better than me has an idea? 

diff --git a/git-stash.sh b/git-stash.sh
index 1114005ce2..01bf74015e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -322,10 +322,15 @@ push_stash () {
 
                if test $# != 0
                then
+                       git ls-files -z >"$(git rev-parse --git-dir)"/stash-to-remove
                        git reset -q -- "$@"
                        git ls-files -z --modified -- "$@" |
                        git checkout-index -z --force --stdin
-                       git clean --force -q -d -- "$@"
+                       while read -r -d '' to_delete
+                       do
+                               git clean --force -q -d -- "$to_delete"
+                       done <"$(git rev-parse --git-dir)"/stash-to-remove
+                       rm "$(git rev-parse --git-dir)"/stash-to-remove
                else
                        git reset --hard -q
                fi
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 39c7f2ebd7..6952a031b2 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1064,4 +1064,20 @@ test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
        test foo,bar = $(cat foo),$(cat bar)
 '
 
+test_expect_success 'stash -- <subdir> leaves untracked files in subdir intact' '
+       git reset &&
+       >subdir/untracked &&
+       >subdir/tracked1 &&
+       >subdir/tracked2 &&
+       git add subdir/tracked* &&
+       git stash -- subdir/ &&
+       test_path_is_missing subdir/tracked1 &&
+       test_path_is_missing subdir/tracked2 &&
+       test_path_is_file subdir/untracked &&
+       git stash pop &&
+       test_path_is_file subdir/tracked1 &&
+       test_path_is_file subdir/tracked2 &&
+       test_path_is_file subdir/untracked
+'
+
 test_done

>   -Reid
> 
> Contents of stashbug.sh
> ------------------------
>     #!/bin/sh
> 
>     uname -a
>     git --version
>     mkdir -p stashbug
>     cd stashbug
>     git init
>     mkdir dir
>     touch dir/tracked
>     git add dir/tracked
>     git commit -m 'initial'
>     tree; git status
>     mkdir dir/untracked_dir
>     touch dir/untracked_dir/casualty1
>     touch dir/casualty2
>     echo 'contents' > dir/tracked
>     tree; git status
>     git stash push dir/
>     git stash show -v
>     tree; git status
>     git stash pop
>     tree; git status
> ------------------------
> 
> Resulting output.txt
> ---------------------
>     + uname -a
>     Darwin Reids-MacBook-Pro.local 15.6.0 Darwin Kernel Version
> 15.6.0: Tue Apr 11 16:00:51 PDT 2017;
> root:xnu-3248.60.11.5.3~1/RELEASE_X86_64 x86_64
>     + git --version
>     git version 2.14.1
>     + mkdir -p stashbug
>     + cd stashbug
>     + git init
>     Initialized empty Git repository in /Users/reid/git/stashbug/.git/
>     + mkdir dir
>     + touch dir/tracked
>     + git add dir/tracked
>     + git commit -m initial
>     [master (root-commit) 895197e] initial
>      1 file changed, 0 insertions(+), 0 deletions(-)
>      create mode 100644 dir/tracked
>     + tree
>     .
>     └── dir
>         └── tracked
> 
>     1 directory, 1 file
>     + git status
>     On branch master
>     nothing to commit, working tree clean
>     + mkdir dir/untracked_dir
>     + touch dir/untracked_dir/casualty1
>     + touch dir/casualty2
>     + echo contents
>     + tree
>     .
>     └── dir
>         ├── casualty2
>         ├── tracked
>         └── untracked_dir
>             └── casualty1
> 
>     2 directories, 3 files
>     + git status
>     On branch master
>     Changes not staged for commit:
>       (use "git add <file>..." to update what will be committed)
>       (use "git checkout -- <file>..." to discard changes in working directory)
> 
>         modified:   dir/tracked
> 
>     Untracked files:
>       (use "git add <file>..." to include in what will be committed)
> 
>         dir/casualty2
>         dir/untracked_dir/
> 
>     no changes added to commit (use "git add" and/or "git commit -a")
>     + git stash push dir/
>     Saved working directory and index state WIP on master: 895197e initial
>     + git stash show -v
>     diff --git a/dir/tracked b/dir/tracked
>     index e69de29..12f00e9 100644
>     --- a/dir/tracked
>     +++ b/dir/tracked
>     @@ -0,0 +1 @@
>     +contents
>     + tree
>     .
>     └── dir
>         └── tracked
> 
>     1 directory, 1 file
>     + git status
>     On branch master
>     nothing to commit, working tree clean
>     + git stash pop
>     On branch master
>     Changes not staged for commit:
>       (use "git add <file>..." to update what will be committed)
>       (use "git checkout -- <file>..." to discard changes in working directory)
> 
>         modified:   dir/tracked
> 
>     no changes added to commit (use "git add" and/or "git commit -a")
>     Dropped refs/stash@{0} (93ceee344b947ecd8a27a672e3aedd2b2e1acc99)
>     + tree
>     .
>     └── dir
>         └── tracked
> 
>     1 directory, 1 file
>     + git status
>     On branch master
>     Changes not staged for commit:
>       (use "git add <file>..." to update what will be committed)
>       (use "git checkout -- <file>..." to discard changes in working directory)
> 
>         modified:   dir/tracked
> 
>     no changes added to commit (use "git add" and/or "git commit -a")
> ---------------------
