Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068341F576
	for <e@80x24.org>; Tue, 23 Jan 2018 09:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeAWJ7f (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 04:59:35 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:41594 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeAWJ7d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 04:59:33 -0500
Received: by mail-pf0-f175.google.com with SMTP id c6so6257415pfi.8
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5VBXet4kneQk79+Uj+oSUH8jPWKO19rZUih9cKZJBVo=;
        b=Jm/5EiXla9pigp6Z59xwXOGxdghNexQw09WaFbOlG1U+TyRnTLnp7s5IjkZLUPr72x
         WZqYuilosiuLuKgxd7GSe5Bu2UPKvmTnefpfipbOs6gsv+DSLFuhhg1MdJ2zeWw7lIL7
         ROKkpOrK4Mr1HuDGYm3MSx9UjLaA6QJHdwsjUPGl7+uMnfSJR3KkOxswvmuMS9x4oViq
         Nzzjv9txH0nFbD/jumhlMVtm6cvsggbwv1MQ9EA86ksYjJIcCOOV0k8zWg00tJxTtPBd
         y51QkubzGq0RptK5omTkTLwflcNCpyKkmQJpjF95IkTsPdh7mTW3CdQNCTTyBb/kbKGe
         nvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5VBXet4kneQk79+Uj+oSUH8jPWKO19rZUih9cKZJBVo=;
        b=mTQISwNKhgtx+XMyBqL7OC7snaXJpXqywI7MlOcRtdBEB66CT1wuHpltIJq587R9m5
         MPsqz7BhLe1eYNwUNd3tConiz2zsvG9Zm4gSIal1raCAGmFdqB8xc1H8Dy4t7cXbME+X
         4PFfHcSLF6hRnsfQ4gjfMTY30s1z2zCqiXdx2aOxyTfwqXjZ2YQlJiTy5z3dN42J9Waa
         0IeKL18NnuVmXRwKCpSMAAXFEfE4BI4tzOJkF61Ecg9PG9uFzq8i2ScvYWEfjmZ+alV8
         /Vl9u9sExfQWBjJZYdroOgGQtpGrXnFqaLZtFTjV1PD2tirwjCG6uAgSHlCJtlKmnGyb
         tqzQ==
X-Gm-Message-State: AKwxytffKFj6vR1L7VfBDShdETJfGkwo/0oC8WPzIxRcefJtKdcPyR66
        scj/H3nfpIkJyxs2BA4M89U=
X-Google-Smtp-Source: AH8x225ROeopUMncMTRJxGdvdp3jjKZ3gvNVkUYLd8Ye8mVkajdRYdK5/oUnYhI7QT8uFIix2hAnVw==
X-Received: by 10.98.8.86 with SMTP id c83mr10072769pfd.84.1516701572743;
        Tue, 23 Jan 2018 01:59:32 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id 62sm16210829pgh.80.2018.01.23.01.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 01:59:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 23 Jan 2018 16:59:27 +0700
Date:   Tue, 23 Jan 2018 16:59:27 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/2] Automate updating git-completion.bash a bit
Message-ID: <20180123095927.GA26613@ash>
References: <20180116103700.4505-1-pclouds@gmail.com>
 <CAM0VKjkz8-VsLJ8i64OHHUH4R4WY5fT6x3X+s=FKuZyfM9txkA@mail.gmail.com>
 <CACsJy8D3wRmP_o5iFJwWtODOJpj-r=JZsJ3P8XxWOCD8rJJrHA@mail.gmail.com>
 <20180117093432.GA19189@ash>
 <CAM0VKj=NeQ_BthG087vswP=mCizXPBcfmCAa9haH4N5MRCNRWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=NeQ_BthG087vswP=mCizXPBcfmCAa9haH4N5MRCNRWQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 07:03:24PM +0100, SZEDER Gábor wrote:
> On Wed, Jan 17, 2018 at 10:34 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > Actually I forgot another option. What if we automate updating the
> > script at "compile" time instead of calling git at run time? E.g. with
> > something like below, a contributor could just run
> >
> >     make update-completion
> >
> > then add git-completion.bash changes to the same patch that introduces
> > new options. If they forget
> 
> They inevitably will :)

OK. We go with the first option then (with caching to reduce overhead
on Windows). I'm not going to bother you with actual code changes. The
diff of completable options looks like below. It would be great if
people could check if some options should NOT be completable for some
reason.

A couple points

- Ignore options that are removed in the diff. They are removed for a
  reason which I will explain when real patches come.

- There are regressions where --foo= becomes --foo, I hope this is ok
  for now. We can tweak this later.

- In some commands you can complete both --foo and --foo= (now it's
  just one form, --foo). I would argue that it's pointless. It's no
  big deal to type '=' (or a space) after we have completed --foo.

- I feel --force is not treated the same way everywhere. But I guess
  that's ok since "forcing" in some command context may be less severe
  than others.

-- 8< --
diff --git a/git-add.txt b/git-add.txt
index 1c249a3..2693cc1 100644
--- a/git-add.txt
+++ b/git-add.txt
@@ -1,10 +1,15 @@
+--all
 --chmod=
 --dry-run
 --edit
 --force
 --ignore-errors
+--ignore-missing
+--ignore-removal
 --intent-to-add
 --interactive
 --patch
 --refresh
+--renormalize
 --update
+--verbose
diff --git a/git-am.txt b/git-am.txt
index b0082bf..552dc96 100644
--- a/git-am.txt
+++ b/git-am.txt
@@ -1,12 +1,24 @@
 --3way
 --committer-date-is-author-date
+--directory
+--exclude
+--gpg-sign
 --ignore-date
 --ignore-space-change
 --ignore-whitespace
+--include
 --interactive
 --keep
+--keep-cr
+--keep-non-patch
+--message-id
+--no-keep-cr
 --no-utf8
+--patch-format
+--quiet
+--reject
+--resolvemsg=
 --scissors
 --signoff
 --utf8
---whitespace=
+--whitespace
diff --git a/git-apply.txt b/git-apply.txt
index 6bf4c2f..71d53d2 100644
--- a/git-apply.txt
+++ b/git-apply.txt
@@ -1,13 +1,17 @@
+--3way
+--allow-overlap
 --apply
+--build-fake-ancestor=
 --cached
 --check
---directory=
---exclude=
+--directory
+--exclude
 --ignore-space-change
 --ignore-whitespace
 --inaccurate-eof
+--include
 --index
---index-info
+--no-add
 --no-add
 --numstat
 --recount
@@ -17,4 +21,4 @@
 --summary
 --unidiff-zero
 --verbose
---whitespace=
+--whitespace
diff --git a/git-branch.txt b/git-branch.txt
index 69594e3..9d308aa 100644
--- a/git-branch.txt
+++ b/git-branch.txt
@@ -1,10 +1,14 @@
---abbrev=
+--abbrev
+--all
 --color
 --column
 --contains
 --copy
+--create-reflog
 --delete
 --edit-description
+--format=
+--ignore-case
 --list
 --merged
 --move
@@ -15,9 +19,10 @@
 --no-merged
 --no-track
 --points-at
+--quiet
 --remotes
 --set-upstream-to=
---sort=
+--sort
 --track
 --unset-upstream
 --verbose
diff --git a/git-checkout.txt b/git-checkout.txt
index 493a1fe..75f19d2 100644
--- a/git-checkout.txt
+++ b/git-checkout.txt
@@ -1,12 +1,14 @@
 --conflict=
 --detach
+--ignore-other-worktrees
 --ignore-skip-worktree-bits
 --merge
 --no-recurse-submodules
 --no-track
---orphan
+--orphan=
 --ours
 --patch
+--progress
 --quiet
 --recurse-submodules
 --theirs
diff --git a/git-cherry-pick.txt b/git-cherry-pick.txt
index 39ba895..f8cdbce 100644
--- a/git-cherry-pick.txt
+++ b/git-cherry-pick.txt
@@ -1,5 +1,14 @@
+--abort
+--allow-empty
+--allow-empty-message
+--continue
 --edit
+--ff
+--gpg-sign
+--keep-redundant-commits
 --mainline
 --no-commit
+--quit
 --signoff
 --strategy=
+--strategy-option
diff --git a/git-clean.txt b/git-clean.txt
index 40407f7..10c6155 100644
--- a/git-clean.txt
+++ b/git-clean.txt
@@ -1,2 +1,4 @@
 --dry-run
+--exclude
+--interactive
 --quiet
diff --git a/git-clone.txt b/git-clone.txt
index f6e892b..1b6a4da 100644
--- a/git-clone.txt
+++ b/git-clone.txt
@@ -1,18 +1,29 @@
 --bare
---branch
---depth
+--branch=
+--config
+--depth=
+--dissociate
+--ipv4
+--ipv6
+--jobs=
 --local
 --mirror
 --no-checkout
 --no-hardlinks
 --no-single-branch
 --no-tags
---origin
+--origin=
+--progress
 --quiet
 --recurse-submodules
 --reference
+--reference-if-able
+--separate-git-dir=
+--shallow-exclude
+--shallow-since=
 --shallow-submodules
 --shared
 --single-branch
 --template=
---upload-pack
+--upload-pack=
+--verbose
diff --git a/git-commit.txt b/git-commit.txt
index 2f98a59..337a57e 100644
--- a/git-commit.txt
+++ b/git-commit.txt
@@ -1,20 +1,26 @@
 --all
---allow-empty
 --amend
 --author=
+--branch
 --cleanup=
---date
+--date=
 --dry-run
 --edit
 --file=
 --fixup=
+--gpg-sign
 --include
 --interactive
---message=
+--long
+--message
 --no-edit
+--no-post-rewrite
 --no-verify
+--no-verify
+--null
 --only
 --patch
+--porcelain
 --quiet
 --reedit-message=
 --reset-author
@@ -22,8 +28,7 @@
 --short
 --signoff
 --squash=
+--status
 --template=
 --untracked-files
---untracked-files=
 --verbose
---verify
diff --git a/git-config.txt b/git-config.txt
index c4bcd1e..651fc27 100644
--- a/git-config.txt
+++ b/git-config.txt
@@ -1,15 +1,28 @@
 --add
+--blob=
+--bool
+--bool-or-int
+--edit
+--expiry-date
 --file=
 --get
 --get-all
+--get-color
+--get-colorbool
 --get-regexp
+--get-urlmatch
 --global
+--includes
+--int
 --list
 --local
 --name-only
+--null
+--path
 --remove-section
 --rename-section
 --replace-all
+--show-origin
 --system
 --unset
 --unset-all
diff --git a/git-describe.txt b/git-describe.txt
index 05eeb7a..275debb 100644
--- a/git-describe.txt
+++ b/git-describe.txt
@@ -1,4 +1,4 @@
---abbrev=
+--abbrev
 --all
 --always
 --broken
diff --git a/git-fsck.txt b/git-fsck.txt
index 9732ebf..3af9964 100644
--- a/git-fsck.txt
+++ b/git-fsck.txt
@@ -1,8 +1,12 @@
 --cache
+--connectivity-only
+--dangling
 --full
 --lost-found
 --name-objects
 --no-reflogs
+--progress
+--reflogs
 --root
 --strict
 --tags
diff --git a/git-gc.txt b/git-gc.txt
index 3b7ca6f..c08e60a 100644
--- a/git-gc.txt
+++ b/git-gc.txt
@@ -1,2 +1,3 @@
 --aggressive
 --prune
+--quiet
diff --git a/git-grep.txt b/git-grep.txt
index 6bec8f7..f7770be 100644
--- a/git-grep.txt
+++ b/git-grep.txt
@@ -1,9 +1,14 @@
+--after-context=
 --all-match
 --and
 --basic-regexp
+--before-context=
 --break
 --cached
+--color
+--context
 --count
+--exclude-standard
 --extended-regexp
 --files-with-matches
 --files-without-match
@@ -14,14 +19,17 @@
 --ignore-case
 --invert-match
 --line-number
---max-depth
+--max-depth=
 --name-only
 --no-index
 --not
 --or
 --perl-regexp
+--quiet
+--recurse-submodules
 --show-function
 --text
---threads
+--textconv
+--threads=
 --untracked
 --word-regexp
diff --git a/git-init.txt b/git-init.txt
index a7d3da6..aec6a35 100644
--- a/git-init.txt
+++ b/git-init.txt
@@ -1,5 +1,5 @@
 --bare
 --quiet
+--separate-git-dir=
 --shared
---shared=
 --template=
diff --git a/git-ls-files.txt b/git-ls-files.txt
index 04d6f08..6810eb0 100644
--- a/git-ls-files.txt
+++ b/git-ls-files.txt
@@ -1,20 +1,23 @@
 --abbrev
 --cached
+--debug
 --deleted
 --directory
+--empty-directory
+--eol
 --error-unmatch
---exclude=
---exclude-from=
---exclude-per-directory
+--exclude
+--exclude-from
 --exclude-per-directory=
 --exclude-standard
 --full-name
 --ignored
---ignored
 --killed
 --modified
 --no-empty-directory
 --others
+--recurse-submodules
+--resolve-undo
 --stage
 --unmerged
 --with-tree=
diff --git a/git-ls-remote.txt b/git-ls-remote.txt
index c58c80e..381384b 100644
--- a/git-ls-remote.txt
+++ b/git-ls-remote.txt
@@ -1,5 +1,7 @@
 --get-url
 --heads
+--quiet
 --refs
 --symref
 --tags
+--upload-pack=
diff --git a/git-mv.txt b/git-mv.txt
index c26c9e6..28ae674 100644
--- a/git-mv.txt
+++ b/git-mv.txt
@@ -1 +1,2 @@
 --dry-run
+--verbose
diff --git a/git-name-rev.txt b/git-name-rev.txt
index 7b1acde..1e5044a 100644
--- a/git-name-rev.txt
+++ b/git-name-rev.txt
@@ -1,3 +1,8 @@
 --all
+--always
+--exclude
+--name-only
+--refs
 --stdin
 --tags
+--undefined
diff --git a/git-notes_add.txt b/git-notes_add.txt
index 87cb06b..4c2dfc1 100644
--- a/git-notes_add.txt
+++ b/git-notes_add.txt
@@ -1,4 +1,5 @@
---file=
---message=
---reedit-message=
---reuse-message=
+--allow-empty
+--file
+--message
+--reedit-message
+--reuse-message
diff --git a/git-notes_append.txt b/git-notes_append.txt
index 87cb06b..4c2dfc1 100644
--- a/git-notes_append.txt
+++ b/git-notes_append.txt
@@ -1,4 +1,5 @@
---file=
---message=
---reedit-message=
---reuse-message=
+--allow-empty
+--file
+--message
+--reedit-message
+--reuse-message
diff --git a/git-notes_copy.txt b/git-notes_copy.txt
index 93aa025..d088b96 100644
--- a/git-notes_copy.txt
+++ b/git-notes_copy.txt
@@ -1 +1,2 @@
+--for-rewrite=
 --stdin
diff --git a/git-push.txt b/git-push.txt
index 1f4182f..5ea1e39 100644
--- a/git-push.txt
+++ b/git-push.txt
@@ -1,16 +1,24 @@
 --all
+--atomic
 --delete
 --dry-run
+--exec=
 --follow-tags
 --force
 --force-with-lease
---force-with-lease=
+--ipv4
+--ipv6
 --mirror
+--no-verify
+--porcelain
+--progress
 --prune
+--push-option
 --quiet
 --receive-pack=
---recurse-submodules=
+--recurse-submodules
 --repo=
 --set-upstream
+--signed
 --tags
 --verbose
diff --git a/git-remote_add.txt b/git-remote_add.txt
index aed6530..4889f31 100644
--- a/git-remote_add.txt
+++ b/git-remote_add.txt
@@ -1,6 +1,6 @@
 --fetch
---master
---mirror=
+--master=
+--mirror
 --no-tags
 --tags
 --track
diff --git a/git-replace.txt b/git-replace.txt
index 53cd1aa..d494653 100644
--- a/git-replace.txt
+++ b/git-replace.txt
@@ -3,3 +3,4 @@
 --format=
 --graft
 --list
+--raw
diff --git a/git-reset.txt b/git-reset.txt
index eafefbc..840cbae 100644
--- a/git-reset.txt
+++ b/git-reset.txt
@@ -1,6 +1,9 @@
 --hard
+--intent-to-add
 --keep
 --merge
 --mixed
 --patch
+--quiet
+--recurse-submodules
 --soft
diff --git a/git-revert.txt b/git-revert.txt
index abd5c1e..ffa0d80 100644
--- a/git-revert.txt
+++ b/git-revert.txt
@@ -1,7 +1,11 @@
+--abort
+--continue
 --edit
+--gpg-sign
 --mainline
 --no-commit
 --no-edit
+--quit
 --signoff
 --strategy=
---strategy-option=
+--strategy-option
diff --git a/git-show-branch.txt b/git-show-branch.txt
index e3c3096..37c9594 100644
--- a/git-show-branch.txt
+++ b/git-show-branch.txt
@@ -5,7 +5,7 @@
 --independent
 --list
 --merge-base
---more=
+--more
 --no-color
 --no-name
 --reflog
diff --git a/git-status.txt b/git-status.txt
index 2dce372..ed86ad5 100644
--- a/git-status.txt
+++ b/git-status.txt
@@ -1,10 +1,12 @@
 --branch
---column=
+--column
 --ignored
---ignore-submodules=
+--ignore-submodules
 --long
 --no-column
+--null
 --porcelain
 --short
---untracked-files=
+--show-stash
+--untracked-files
 --verbose
diff --git a/git-tag.txt b/git-tag.txt
index b983562..a5419db 100644
--- a/git-tag.txt
+++ b/git-tag.txt
@@ -1,18 +1,21 @@
 --annotate
---cleanup
+--cleanup=
+--color
 --column
 --contains
 --create-reflog
 --delete
---file
+--file=
 --force
+--format=
+--ignore-case
 --list
---local-user
+--local-user=
 --merged
 --message
 --no-contains
 --no-merged
 --points-at
 --sign
---sort=
+--sort
 --verify
diff --git a/git-worktree_add.txt b/git-worktree_add.txt
index 9dd7f92..3cb6a7e 100644
--- a/git-worktree_add.txt
+++ b/git-worktree_add.txt
@@ -1 +1,5 @@
+--checkout
 --detach
+--guess-remote
+--lock
+--track
diff --git a/git-worktree_lock.txt b/git-worktree_lock.txt
index a0bc06b..6ad59bb 100644
--- a/git-worktree_lock.txt
+++ b/git-worktree_lock.txt
@@ -1 +1 @@
---reason
+--reason=
-- 8< --
--
Duy
