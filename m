Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331E920248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfCUUvH (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:51:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44362 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCUUvH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:51:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id w2so41120wrt.11
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5x3ZzohCCs0bm7jHQWGNUGdrB1xwPCm0SViSLp4e5fI=;
        b=Wg3Psilx6HYYN+DjzFp5T1biDVSX9GOuIOJSdkqhu/EmpxZtBRm8lwD0N29h4QI8IC
         ZDJbcBMnlHHV0i/xdwfyc5lt8GFfyvl/SDL+luzTr37x/fXwkUjXz01xIJZFAycbo9YU
         3c324isfs55MO15DptKZ61461qrkacNHjHwiQRrwXYYIagBzzKAnwFSF9xcrrkyv4hs5
         6V+xI63G70RDJqKYRrUSukGpsotIJmttQlx1ZY9w+8sQ7OFIu3Alzd9oaa3WpKGfh9Gc
         LW4QTWvlo5tK5gsGgcHpY9GvD/WMmEHbWpjYDPbU2/5o7sS6dzFzT6ooOvjhU0IeIEwc
         Mh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5x3ZzohCCs0bm7jHQWGNUGdrB1xwPCm0SViSLp4e5fI=;
        b=h9sdPOvuqFee2ls2nEuDjhc8aiSIzhOpkyjPfqLrqM0fdwXEjzBqXvfYOQlP8wmyFn
         XhWmSbqk9PPwfeaZB9VNOGBU2rLpQu4gVyN2d8F/Rcgiae1ttUHdb4Hxyk8pUPZxHucx
         bf0IncLDYiDh8Jlx5yV2L6IFUxmxRhl9n4yMHBH/hhQghYJviC4uyXESDqK8JapjG4FV
         8h+Xgmm6cqAJlVaRDrwYuoGFJY9sZWPJ8asS0YG3Z0qWYpWloNiaevezx7AeLEtHDXUe
         a5k8AkNJdgKC2hiold7dwTYGOQ7sM9xodeTD71+g40SGa6nugSU6R6zzUH9QuWLasMBl
         ytMw==
X-Gm-Message-State: APjAAAWYMWgE0AvOsDeE729ErPE6aWC3WlGjLeFZvNOZAbwtaR6EFc//
        WPsFA/84ZH1fAnWp1zS6nBR9vGAd
X-Google-Smtp-Source: APXvYqxbaC8aQwUGehP83FX8OyQ266Bny7Ftc/vmE0vwWe73tf7pahLHvuNW1z/rYywW0+lWqEuDJQ==
X-Received: by 2002:adf:812a:: with SMTP id 39mr4066783wrm.48.1553201463528;
        Thu, 21 Mar 2019 13:51:03 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b4sm6053978wmj.3.2019.03.21.13.51.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 13:51:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] gc docs: modernize and fix the documentation
Date:   Thu, 21 Mar 2019 21:50:44 +0100
Message-Id: <20190321205054.17109-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For v1 see: https://public-inbox.org/git/20190318161502.7979-1-avarab@gmail.com/

This addresses all the feedback it got, which includes splitting out
various "while we're at it" fixes, and then I found/remembered some
more things I needed to fix.

It would still be great to have Peff submit some version of his
https://public-inbox.org/git/20190319001829.GL29661@sigill.intra.peff.net/
reply to the NOTES section sometime, but I had to stop somewhere.

I also documented the fast-import caveat discussed in
https://public-inbox.org/git/87o964cnn0.fsf@evledraar.gmail.com/ while
I was at it, as promised.

Ævar Arnfjörð Bjarmason (10):
  gc docs: modernize the advice for manually running "gc"
  gc docs: stop noting "repack" flags
  gc docs: clean grammar for "gc.bigPackThreshold"
  gc docs: include the "gc.*" section from "config" in "gc"
  gc docs: re-flow the "gc.*" section in "config"
  gc docs: note how --aggressive impacts --window & --depth
  gc docs: downplay the usefulness of --aggressive
  gc docs: note "gc --aggressive" in "fast-import"
  gc docs: clarify that "gc" doesn't throw away referenced objects
  gc docs: remove incorrect reference to gc.auto=0

 Documentation/config/gc.txt       |  34 ++++++-
 Documentation/git-fast-import.txt |   7 ++
 Documentation/git-gc.txt          | 142 ++++++++++--------------------
 3 files changed, 84 insertions(+), 99 deletions(-)

Range-diff:
 1:  d48b9c7221 !  1:  89719142c7 gc docs: modernize the advice for manually running "gc"
    @@ -3,10 +3,17 @@
         gc docs: modernize the advice for manually running "gc"
     
         The docs have been recommending that users need to run this manually,
    -    but that hasn't been needed in practice for a long time.
    +    but that hasn't been needed in practice for a long time except in
    +    exceptional circumstances.
     
         Let's instead have this reflect reality and say that most users don't
    -    need to run this manually at all.
    +    need to run this manually at all, while briefly describing the sorts
    +    sort of cases where "gc" does need to be run manually.
    +
    +    Since we're recommending that users run this most of the and usually
    +    don't need to tweak it, let's tone down the very prominent example of
    +    the gc.auto=0 command. It's sufficient to point to the gc.auto
    +    documentation below.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -20,20 +27,24 @@
     -Users are encouraged to run this task on a regular basis within
     -each repository to maintain good disk space utilization and good
     -operating performance.
    -+Most users should not have to run this command manually. When common
    -+porcelain operations that create objects are run, such as
    -+linkgit:git-commit[1] and linkgit:git-fetch[1], `git gc --auto` will
    -+be run automatically.
    - 
    +-
     -Some git commands may automatically run 'git gc'; see the `--auto` flag
     -below for details. If you know what you're doing and all you want is to
     -disable this behavior permanently without further considerations, just do:
    -+You should only need to run `git gc` manually when adding objects to a
    -+repository without regularly running such porcelain commands. Another
    -+use-case is wanting to do a one-off repository optimization.
    +-
    +-----------------------
    +-$ git config --global gc.auto 0
    +-----------------------
    ++When common porcelain operations that creates objects are run, they
    ++will check whether the repository has grown substantially since the
    ++last maintenance, and if so run `git gc` automatically. See `gc.auto`
    ++below for how to disable this behavior.
     +
    -+If you know what you're doing and all you want is to disable automatic
    -+runs, do:
    ++Running `git gc` manually should only be needed when adding objects to
    ++a repository without regularly running such porcelain commands, to do
    ++a one-off repository optimization, or e.g. to clean up a suboptimal
    ++mass-import. See the "PACKFILE OPTIMIZATION" section in
    ++linkgit:git-fast-import[1] for more details on the import case.
      
    - ----------------------
    - $ git config --global gc.auto 0
    + OPTIONS
    + -------
 -:  ---------- >  2:  d90a5b1b4c gc docs: stop noting "repack" flags
 -:  ---------- >  3:  fedd9bb886 gc docs: clean grammar for "gc.bigPackThreshold"
 2:  e670d514ce !  4:  6fad05a67c gc docs: include the "gc.*" section from "config" in "gc"
    @@ -34,16 +34,52 @@
      
      gc.auto::
      	When there are approximately more than this many loose
    + 	objects in the repository, `git gc --auto` will pack them.
    + 	Some Porcelain commands use this command to perform a
    + 	light-weight garbage collection from time to time.  The
    +-	default value is 6700.  Setting this to 0 disables it.
    ++	default value is 6700.
    +++
    ++Setting this to 0 disables not only automatic packing based on the
    ++number of loose objects, but any other heuristic `git gc --auto` will
    ++otherwise use to determine if there's work to do, such as
    ++`gc.autoPackLimit`.
    + 
    + gc.autoPackLimit::
    + 	When there are more than this many packs that are not
    + 	marked with `*.keep` file in the repository, `git gc
    + 	--auto` consolidates them into one larger pack.  The
    + 	default	value is 50.  Setting this to 0 disables it.
    ++	Setting `gc.auto` to 0 will also disable this.
    +++
    ++See the `gc.bigPackThreshold` configuration variable below. When in
    ++use, it'll affect how the auto pack limit works.
    + 
    + gc.autoDetach::
    + 	Make `git gc --auto` return immediately and run in background
    +@@
    + this configuration variable is ignored, all packs except the base pack
    + will be repacked. After this the number of packs should go below
    + gc.autoPackLimit and gc.bigPackThreshold should be respected again.
    +++
    ++If the amount of memory estimated for `git repack` to run smoothly is
    ++not available and `gc.bigPackThreshold` is not set, the largest
    ++pack will also be excluded (this is the equivalent of running `git gc`
    ++with `--keep-base-pack`).
    + 
    + gc.writeCommitGraph::
    + 	If true, then gc will rewrite the commit-graph file when
     @@
      	With "<pattern>" (e.g. "refs/stash")
      	in the middle, the setting applies only to the refs that
      	match the <pattern>.
     ++
    -+These types of entries are generally created as a result of using `git
    -+commit --amend` or `git rebase` and are the commits prior to the amend
    -+or rebase occurring. Since these changes are not part of the current
    -+project history most users will want to expire them sooner, which is
    -+why the default is more aggressive than `gc.reflogExpire`.
    ++These types of entries are generally created as
    ++a result of using `git commit --amend` or `git rebase` and are the
    ++commits prior to the amend or rebase occurring.  Since these changes
    ++are not part of the current project most users will want to expire
    ++them sooner, which is why the default is more aggressive than
    ++`gc.reflogExpire`.
      
      gc.rerereResolved::
      	Records of conflicted merge you resolved earlier are
    @@ -52,15 +88,38 @@
      --- a/Documentation/git-gc.txt
      +++ b/Documentation/git-gc.txt
     @@
    - repository without regularly running such porcelain commands. Another
    - use-case is wanting to do a one-off repository optimization.
    - 
    --If you know what you're doing and all you want is to disable automatic
    --runs, do:
    -+If you know what you're doing and want to disable automatic runs, do:
    + --auto::
    + 	With this option, 'git gc' checks whether any housekeeping is
    + 	required; if not, it exits without performing any work.
    +-	Some git commands run `git gc --auto` after performing
    +-	operations that could create many loose objects. Housekeeping
    +-	is required if there are too many loose objects or too many
    +-	packs in the repository.
    + +
    +-If the number of loose objects exceeds the value of the `gc.auto`
    +-configuration variable, then all loose objects are combined into a
    +-single pack.  Setting the value of `gc.auto`
    +-to 0 disables automatic packing of loose objects.
    ++See the `gc.auto' option in the "CONFIGURATION" section below for how
    ++this heuristic works.
    + +
    +-If the number of packs exceeds the value of `gc.autoPackLimit`,
    +-then existing packs (except those marked with a `.keep` file
    +-or over `gc.bigPackThreshold` limit)
    +-are consolidated into a single pack.
    +-If the amount of memory estimated for `git repack` to run smoothly is
    +-not available and `gc.bigPackThreshold` is not set, the largest
    +-pack will also be excluded (this is the equivalent of running `git gc`
    +-with `--keep-base-pack`).
    +-Setting `gc.autoPackLimit` to 0 disables automatic consolidation of
    +-packs.
    +-+
    +-If houskeeping is required due to many loose objects or packs, all
    ++Once housekeeping is triggered by exceeding the limits of
    ++configuration options such as `gc.auto` and `gc.autoPackLimit`, all
    + other housekeeping tasks (e.g. rerere, working trees, reflog...) will
    + be performed as well.
      
    - ----------------------
    - $ git config --global gc.auto 0
     @@
      CONFIGURATION
      -------------
 3:  d6f1e001a4 !  5:  994e22a0d6 gc docs: de-duplicate "OPTIONS" and "CONFIGURATION"
    @@ -1,18 +1,10 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    gc docs: de-duplicate "OPTIONS" and "CONFIGURATION"
    +    gc docs: re-flow the "gc.*" section in "config"
     
    -    In an earlier commit I started including the "gc.*" documentation from
    -    git-config(1) in the git-gc(1) documentation. That still left us in a
    -    state where the "--auto" option and "gc.auto" were redundantly
    -    discussing the same thing.
    -
    -    Fix that by briefly discussing how the option itself works for
    -    "--auto", and for the rest referring to the configuration
    -    documentation.
    -
    -    This revealed existing blind spots in the configuration documentation,
    -    move over the documentation and reword as appropriate.
    +    Re-flow the "gc.*" section in "config". A previous commit moved this
    +    over from the "gc" docs, but tried to keep as many of the lines
    +    identical to benefit from diff's move detection.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -20,91 +12,33 @@
      --- a/Documentation/config/gc.txt
      +++ b/Documentation/config/gc.txt
     @@
    - 	objects in the repository, `git gc --auto` will pack them.
    - 	Some Porcelain commands use this command to perform a
    - 	light-weight garbage collection from time to time.  The
    --	default value is 6700.  Setting this to 0 disables it.
    -+	default value is 6700.
    -++
    -+Setting this to 0 disables not only automatic packing based on the
    -+number of loose objects, but any other heuristic `git gc --auto` will
    -+otherwise use to determine if there's work to do, such as
    -+`gc.autoPackLimit`.
    -++
    -+The repacking of loose objects will be performed with `git repack -d
    -+-l`.
    - 
    - gc.autoPackLimit::
    -+
    - 	When there are more than this many packs that are not
    - 	marked with `*.keep` file in the repository, `git gc
    - 	--auto` consolidates them into one larger pack.  The
    --	default	value is 50.  Setting this to 0 disables it.
    -+	default value is 50.  Setting this (or `gc.auto`) to 0
    -+	disables it. Packs will be consolidated using the `-A` option
    -+	of `git repack`.
    -++
    -+See the `gc.bigPackThreshold` configuration variable below. When in
    -+use it'll effect how the auto pack limit works.
    - 
    - gc.autoDetach::
    - 	Make `git gc --auto` return immediately and run in background
    -@@
    - 	If non-zero, all packs larger than this limit are kept when
    - 	`git gc` is run. This is very similar to `--keep-base-pack`
    - 	except that all packs that meet the threshold are kept, not
    --	just the base pack. Defaults to zero. Common unit suffixes of
    --	'k', 'm', or 'g' are supported.
    -+	just the base pack. Defaults to zero or a memory heuristic.
    -+	Common unit suffixes of 'k', 'm', or 'g' are supported.
    - +
    - Note that if the number of kept packs is more than gc.autoPackLimit,
    - this configuration variable is ignored, all packs except the base pack
    - will be repacked. After this the number of packs should go below
      gc.autoPackLimit and gc.bigPackThreshold should be respected again.
    -++
    -+If the amount of memory is estimated not enough for `git repack` to
    -+run smoothly and `gc.bigPackThreshold` is not set, the largest pack
    -+will also be excluded (which is the equivalent of running `git gc`
    -+with `--keep-base-pack`).
    + +
    + If the amount of memory estimated for `git repack` to run smoothly is
    +-not available and `gc.bigPackThreshold` is not set, the largest
    +-pack will also be excluded (this is the equivalent of running `git gc`
    +-with `--keep-base-pack`).
    ++not available and `gc.bigPackThreshold` is not set, the largest pack
    ++will also be excluded (this is the equivalent of running `git gc` with
    ++`--keep-base-pack`).
      
      gc.writeCommitGraph::
      	If true, then gc will rewrite the commit-graph file when
    -
    - diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
    - --- a/Documentation/git-gc.txt
    - +++ b/Documentation/git-gc.txt
     @@
    - --auto::
    - 	With this option, 'git gc' checks whether any housekeeping is
    - 	required; if not, it exits without performing any work.
    --	Some git commands run `git gc --auto` after performing
    --	operations that could create many loose objects. Housekeeping
    --	is required if there are too many loose objects or too many
    --	packs in the repository.
    + 	in the middle, the setting applies only to the refs that
    + 	match the <pattern>.
      +
    --If the number of loose objects exceeds the value of the `gc.auto`
    --configuration variable, then all loose objects are combined into a
    --single pack using `git repack -d -l`.  Setting the value of `gc.auto`
    --to 0 disables automatic packing of loose objects.
    -+See the `gc.auto' option in the "CONFIGURATION" below for how this
    -+heuristic works.
    - +
    --If the number of packs exceeds the value of `gc.autoPackLimit`,
    --then existing packs (except those marked with a `.keep` file
    --or over `gc.bigPackThreshold` limit)
    --are consolidated into a single pack by using the `-A` option of
    --'git repack'.
    --If the amount of memory is estimated not enough for `git repack` to
    --run smoothly and `gc.bigPackThreshold` is not set, the largest
    --pack will also be excluded (this is the equivalent of running `git gc`
    --with `--keep-base-pack`).
    --Setting `gc.autoPackLimit` to 0 disables automatic consolidation of
    --packs.
    --+
    --If houskeeping is required due to many loose objects or packs, all
    -+Once housekeeping is triggered by exceeding the limits of
    -+configurations options such as `gc.auto` and `gc.autoPackLimit`, all
    - other housekeeping tasks (e.g. rerere, working trees, reflog...) will
    - be performed as well.
    +-These types of entries are generally created as
    +-a result of using `git commit --amend` or `git rebase` and are the
    +-commits prior to the amend or rebase occurring.  Since these changes
    +-are not part of the current project most users will want to expire
    +-them sooner, which is why the default is more aggressive than
    +-`gc.reflogExpire`.
    ++These types of entries are generally created as a result of using `git
    ++commit --amend` or `git rebase` and are the commits prior to the amend
    ++or rebase occurring.  Since these changes are not part of the current
    ++project most users will want to expire them sooner, which is why the
    ++default is more aggressive than `gc.reflogExpire`.
      
    + gc.rerereResolved::
    + 	Records of conflicted merge you resolved earlier are
 -:  ---------- >  6:  916433ef73 gc docs: note how --aggressive impacts --window & --depth
 4:  257aff2808 !  7:  457357b464 gc docs: downplay the usefulness of --aggressive
    @@ -3,19 +3,17 @@
         gc docs: downplay the usefulness of --aggressive
     
         The existing "gc --aggressive" docs come just short of recommending to
    -    users that they run it regularly. In reality it's a waste of CPU for
    -    most users, and may even make things actively worse. I've personally
    -    talked to many users who've taken these docs as an advice to use this
    -    option, and have.
    +    users that they run it regularly. I've personally talked to many users
    +    who've taken these docs as an advice to use this option, and have,
    +    usually it's (mostly) a waste of time.
     
    -    Let's change this documentation to better reflect reality, i.e. for
    -    most users using --aggressive is a waste of time, and may even be
    -    actively making things worse.
    +    So let's clarify what it really does, and let the user draw their own
    +    conclusions.
     
    -    Let's also clarify the "The effects [...] are persistent" to clearly
    -    note that that's true to the extent that subsequent gc's aren't going
    -    to re-roll existing packs generated with --aggressive into a new set
    -    of packs.
    +    Let's also clarify the "The effects [...] are persistent" to
    +    paraphrase a brief version of Jeff King's explanation at [1].
    +
    +    1. https://public-inbox.org/git/20190318235356.GK29661@sigill.intra.peff.net/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -23,27 +21,45 @@
      --- a/Documentation/git-gc.txt
      +++ b/Documentation/git-gc.txt
     @@
    - --aggressive::
    - 	Usually 'git gc' runs very quickly while providing good disk
      	space utilization and performance.  This option will cause
    --	'git gc' to more aggressively optimize the repository at the expense
    --	of taking much more time.  The effects of this optimization are
    + 	'git gc' to more aggressively optimize the repository at the expense
    + 	of taking much more time.  The effects of this optimization are
     -	persistent, so this option only needs to be used occasionally; every
     -	few hundred changesets or so.
    -+	'git gc' to more aggressively optimize the repository to save storage space
    -+	at the expense of taking much more time.
    -++
    -+Using this option may optimize for disk space at the expense of
    -+runtime performance. See the `--depth` and `--window` documentation in
    -+linkgit:git-repack[1]. It is not recommended that this option be used
    -+to improve performance for a given repository without running tailored
    -+performance benchmarks on it. It may make things better, or worse. Not
    -+using this at all is the right trade-off for most users and their
    -+repositories.
    -++
    -+The effects of this option are persistent to the extent that
    -+`gc.autoPackLimit` and friends don't cause a consolidation of existing
    -+pack(s) generated with this option.
    ++	mostly persistent. See the "AGGRESSIVE" section below for details.
      
      --auto::
      	With this option, 'git gc' checks whether any housekeeping is
    +@@
    + 	`.keep` files are consolidated into a single pack. When this
    + 	option is used, `gc.bigPackThreshold` is ignored.
    + 
    ++AGGRESSIVE
    ++----------
    ++
    ++When the `--aggressive` option is supplied, linkgit:git-repack[1] will
    ++be invoked with the `-f` flag, which in turn will pass
    ++`--no-reuse-delta` to linkgit:git-pack-objects[1]. This will throw
    ++away any existing deltas and re-compute them, at the expense of
    ++spending much more time on the repacking.
    ++
    ++The effects of this are mostly persistent, e.g. when packs and loose
    ++objects are coalesced into one another pack the existing deltas in
    ++that pack might get re-used, but there are also various cases where we
    ++might pick a sub-optimal delta from a newer pack instead.
    ++
    ++Furthermore, supplying `--aggressive` will tweak the `--depth` and
    ++`--window` options passed to linkgit:git-repack[1]. See the
    ++`gc.aggressiveDepth` and `gc.aggressiveWindow` settings below. By
    ++using a larger window size we're more likely to find more optimal
    ++deltas.
    ++
    ++It's probably not worth it to use this option on a given repository
    ++without running tailored performance benchmarks on it. It takes a lot
    ++more time, and the resulting space/delta optimization may or may not
    ++be worth it. Not using this at all is the right trade-off for most
    ++users and their repositories.
    ++
    + CONFIGURATION
    + -------------
    + 
 -:  ---------- >  8:  d80a6021f5 gc docs: note "gc --aggressive" in "fast-import"
 -:  ---------- >  9:  a5d31faf6f gc docs: clarify that "gc" doesn't throw away referenced objects
 -:  ---------- > 10:  9fd1203ad5 gc docs: remove incorrect reference to gc.auto=0
-- 
2.21.0.360.g471c308f928

