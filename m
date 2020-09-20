Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DD8C43466
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 23:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DD82145D
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 23:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgITXXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 19:23:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35292 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgITXXL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Sep 2020 19:23:11 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DF1E160734;
        Sun, 20 Sep 2020 23:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600644160;
        bh=fZZw266efkJAmngcgeMBkD9MAu2r1I2hEvAtHjDOQ0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=K9r4Bbb8XM6NTi1dvLdRJtRpOOrnmxa//Ih4FXC1DFB5HxblBWRzMw5Nt5ikcRCv4
         Pai9k/Ueg22j1pVTYzIlKtbTMZjMJYrfDhPj4KM+F/Me6IQBpbZGJ7auCmShWsxyBb
         HwDgY99ak/fzCOmdhTRPzHS0xGFTQbm3yl3YxtdXvKDPZTUAYrfUW+qrgEOf20vnUL
         w64xDgjqvQBp4dlkAKQWhAmL6XheouvK7SN0Q1isVu+JmQ1Vuowz35Znntm9oPKZjB
         apgU1OHv/KVgl2RHQ74rikEfdhftziRrai3DnDU8Qt4+D0cVVFocyIl8HejMaFxRmK
         qsAkU+oQr2hNHAnoNGMp939f0sDnau+Z0x8qS5V3hGzobm7+2v5eTkCa9voOBIn7gs
         9e/lTBa4m+AyB2/aPxZ+uxvkfPxA9Hj8EGLEWXoJE0LnJO3qnJhx1/fjY8dANiLTF6
         vTZDueyupL5AEMLbrPY2qs+2kJJkbEH/e2HIjlryteNshfzR7v5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 0/3] FAQ entries for merges and modified files
Date:   Sun, 20 Sep 2020 23:22:28 +0000
Message-Id: <20200920232231.1300394-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces a few new FAQ entries on various topics.

Changes from v1:
* Fix typos in commit messages.
* Talk about case-insensitive file names, not files, to avoid ambiguity.
* Warn people about rebases.
* Switch from "long-running" to "long-lived" and explain the situation
  more clearly without relying on people understanding the meaning of
  the adjective.

brian m. carlson (3):
  docs: explain why squash merges are broken with long-running branches
  docs: explain why reverts are not always applied on merge
  docs: explain how to deal with files that are always modified

 Documentation/gitfaq.txt | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

Diff-intervalle contre v1 :
1:  c4f3e6e19c ! 1:  9f8f348fa8 docs: explain why squash merges are broken with long-running branches
    @@ Commit message
         independent, bisectable commits.  As common as this is, this tends to
         cause significant problems when squash merges are used to merge
         long-running branches due to the lack of any new merge bases.  Even very
    -    experienced developers may make this mistakes, so let's add a FAQ entry
    +    experienced developers may make this mistake, so let's add a FAQ entry
         explaining why this is problematic and explaining that regular merge
         commits should be used to merge two long-running branches.
     
    @@ Documentation/gitfaq.txt: How do I know if I want to do a fetch or a pull?::
     +--------------------
     +
     +[[long-running-squash-merge]]
    -+What kinds of problems can occur when merging long-running branches with squash merges?::
    ++What kinds of problems can occur when merging long-lived branches with squash merges?::
     +	In general, there are a variety of problems that can occur when using squash
    -+	merges with long-running branches.  These can include seeing extra commits in
    -+	`git log` output, with a GUI, or when using the `...` notation to express a
    -+	range, as well as the possibility of needing to re-resolve conflicts again and
    -+	again.
    ++	merges to merge two branches multiple times.  These can include seeing extra
    ++	commits in `git log` output, with a GUI, or when using the `...` notation to
    ++	express a range, as well as the possibility of needing to re-resolve conflicts
    ++	again and again.
     ++
     +When Git does a normal merge between two branches, it considers exactly three
     +points: the two branches and a third commit, called the _merge base_, which is
     +usually the common ancestor of the commits.  The result of the merge is the sum
     +of the changes between the merge base and each head.  When you merge two
    -+long-running branches with a regular merge commit, this results in a new commit
    -+which will end up as a merge base when they're merged again, because there is
    -+now a new common ancestor.  Git doesn't have to consider changes that occurred
    -+before the merge base, so you don't have to re-resolve any conflicts you
    -+resolved before.
    ++branches with a regular merge commit, this results in a new commit which will
    ++end up as a merge base when they're merged again, because there is now a new
    ++common ancestor.  Git doesn't have to consider changes that occurred before the
    ++merge base, so you don't have to re-resolve any conflicts you resolved before.
     ++
     +When you perform a squash merge, a merge commit isn't created; instead, the
     +changes from one side are applied as a regular commit to the other side.  This
    @@ Documentation/gitfaq.txt: How do I know if I want to do a fetch or a pull?::
     +diff`, `git log`, or a GUI will result in showing all of the changes since the
     +original merge base.
     ++
    -+As a consequence, if you want to merge two long-running branches, it's best to
    -+always use a regular merge commit.
    ++As a consequence, if you want to merge two long-lived branches repeatedly, it's
    ++best to always use a regular merge commit.
     +
      Hooks
      -----
2:  645798d18b ! 2:  248d7e7b4b docs: explain why reverts are not always applied on merge
    @@ Commit message
         A common scenario is for a user to apply a change to one branch and
         cherry-pick it into another, then later revert it in the first branch.
         This results in the change being present when the two branches are
    -    merge, which is confusing to many users.
    +    merged, which is confusing to many users.
     
         We already have documentation for how this works in `git merge`, but it
         is clear from the frequency with which this is asked that it's hard to
    @@ Commit message
     
      ## Documentation/gitfaq.txt ##
     @@ Documentation/gitfaq.txt: original merge base.
    - As a consequence, if you want to merge two long-running branches, it's best to
    - always use a regular merge commit.
    + As a consequence, if you want to merge two long-lived branches repeatedly, it's
    + best to always use a regular merge commit.
      
     +[[merge-two-revert-one]]
     +If I make a change on two branches but revert it on one, why does the merge of those branches include the change?::
    @@ Documentation/gitfaq.txt: original merge base.
     +If this is a problem for you, you can do a rebase instead, rebasing the branch
     +with the revert onto the other branch.  A rebase in this scenario will revert
     +the change, because a rebase applies each individual commit, including the
    -+revert.
    ++revert.  Note that rebases rewrite history, so you should avoid rebasing
    ++published branches unless you're sure you're comfortable with that.  See the
    ++NOTES section in linkgit:git-rebase[1] for more details.
     +
      Hooks
      -----
3:  10ad244b1e ! 3:  e2495d4358 docs: explain how to deal with files that are always modified
    @@ Metadata
      ## Commit message ##
         docs: explain how to deal with files that are always modified
     
    -    Users frequently have problems where two files differ only in case,
    +    Users frequently have problems where two filenames differ only in case,
         causing one of those files to show up consistently as being modified.
         Let's add a FAQ entry that explains how to deal with that.
     
    @@ Documentation/gitfaq.txt: information about how to configure files as text or bi
     +	Internally, Git always stores file names as sequences of bytes and doesn't
     +	perform any encoding or case folding.  However, Windows and macOS by default
     +	both perform case folding on file names.  As a result, it's possible to end up
    -+	with multiple files or directories that differ in case.  Git can handle this
    -+	just fine, but the file system can store only one of these files, so when Git
    -+	reads the other file to see its contents, it looks modified.
    ++	with multiple files or directories whose names differ only in case.  Git can
    ++	handle this just fine, but the file system can store only one of these files,
    ++	so when Git reads the other file to see its contents, it looks modified.
     ++
     +It's best to remove one of the files such that you only have one file.  You can
     +do this with commands like the following (assuming two files `AFile.txt` and
