Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51186C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 20:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEBA21569
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 20:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFU7Wblx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAMUOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:14:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41441 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMUOG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 15:14:06 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so9536718oie.8;
        Mon, 13 Jan 2020 12:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddauMHJ4wziSDim2RMTdZVRWhwRM9nMspEY+7QpNCXA=;
        b=FFU7WblxM4VvJQ+MPQyNJdmGR39bPUvW8WVuZv8fFvd6Q/ejvinr+6stvIum014Hzk
         /BUQS3ft7VgkW5Nh6bzFPGLCKGOT8Nh4stKQwEVF55a+Z+ZzERNPshxz84ZkZmZ9T0g5
         woJUBJdQvPQoV5enLOv0lOVONKH8xPOtwygzDX9Aaf/5Z/YaWypSsZSxJnvgd4UF+EaY
         fui8G04QA7Itxw9C24hFU2NTLKuDLc9hLRwmpuLf9a46SDPQYlh4jHLyqlPsbI18iBRR
         z0UxplDucNIBANuQRRYrLShqrD0NkR0lrFVVbOxIyYh7AuVEoj0x8zF5wyfUyjyaW+jg
         IG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddauMHJ4wziSDim2RMTdZVRWhwRM9nMspEY+7QpNCXA=;
        b=IQDrBMyQkYEPPf0V6jISylUESwsUGUnY402/yH3adQSitPgKWaQjEMZmHf5EB9rqlS
         5huO9DV1qVZTHGoYj3G1jU6SqYj4w+OrWnh2E0LQKjqjIxP19JxhwaGHxnJfZ+mbkkrn
         Mq1OWIelFD1g/hsO7doQDzuFR4H9D2DNfnGNyDWJFaW/k7kEujYpCGNFND7DSutz7X8N
         Zaw+m1a4HchgIuX0OjH2oHImNKD80Gi9lEZdoEMpPEUiC8la2tiJrDfZv0jbCqWWcFjL
         Z32C1td0B8nuelBDmoO7FsCc4rUBWLnUPUIvVxDqNIldeZr3dHhqRSNN2OhGe637z9gf
         7kqw==
X-Gm-Message-State: APjAAAWiGmY1AiHnA8QUXZvxNJg2y4EVT7KTZyPRENFuguwGIX8bSkIH
        kv13hrCAFNBLYeVmf47/8NnmGZQNVX4Yo7uFH+M=
X-Google-Smtp-Source: APXvYqym2NUm20BGgXe8buAx6fSCDojiidpkqY9jFkknU/kEAd06doGTq1KSroQ13IPbLwQnnIkFcO2pWrWGxgl0Vbw=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr13276159oib.6.1578946445536;
 Mon, 13 Jan 2020 12:14:05 -0800 (PST)
MIME-Version: 1.0
References: <xmqqtv4zjgv5.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtv4zjgv5.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Jan 2020 12:13:54 -0800
Message-ID: <CABPp-BFP38okGPTmyUJ-vVqq4=T0CypuyD05e6ArEfwhq2mdpg@mail.gmail.com>
Subject: [ANNOUNCE] git-filter-repo v2.25.0 (Was Re: [ANNOUNCE] Git v2.25.0)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jan 13, 2020 at 11:32 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> The latest feature release Git v2.25.0 is now available at the
> usual places.  It is comprised of 583 non-merge commits since
> v2.24.0, contributed by 84 people, 32 of which are new faces.

The latest release of git-filter-repo, v2.25.0, is also now available.  It
is comprised of 29 non-merge commits since v2.24.0, contributed by 6
people, 5 of whom are new.

The public repo is at

    https://github.com/newren/git-filter-repo

The tarballs can be found at:

    https://github.com/newren/git-filter-repo/releases

git-filter-repo can now also be installed via pip[1] or a variety of
package managers across Windows, Mac OS, or Linux (and maybe
others)[2].

New contributors whose contributions weren't in v2.24.0 are as follows.
Welcome to the git-filter-repo development community!

  Karl Lenz, Benoit Fouletier, Andreas Schneider, Julian Berman,
  Matthisk Heimensen

[1] https://github.com/newren/git-filter-repo/blob/master/INSTALL.md#installation-via-pip
[2] https://github.com/newren/git-filter-repo/blob/master/INSTALL.md#installation-via-package-manager

----------------------------------------------------------------

git-filter-repo 2.25 Release Notes
==================================

(Note: Additional information is available for many release notes at
    https://github.com/newren/git-filter-repo/issues/<NUMBER>)

Fixes:
 * A bug in empty/degenerate commit pruning could result in path
   filters being ignored for commits not in the first parent history
   of a commit when the first parent history is pruned away.  This has
   been corrected, with the unwanted files now being pruned. (#3, #35)
 * blob-callbacks and --replace-text could result in commits becoming
   empty, but such commits were overlooked for empty pruning.  This
   has been corrected. (#42)
 * On case-insensitive file systems, fast-import will have files whose
   names differ in case only overwrite each other.  Avoid such
   clobbering of history while rewriting when a repo is cloned onto
   such a filesystem (#24).
 * Prevent --analyze from choking on typechanges in conjunction with
   renames.
 * Workaround python subprocess bug on Windows in the bfg-ish and
   filter-lamely (a.k.a. filter-branch-ish) scripts, so that these
   scripts can also be run on Windows (#27)

Enhancements:
 * Due to pruning of commits which become empty, a merge commit can
   become degenerate in a variety of ways.  One of these is that one
   parent can become the ancestor of the other, making the merge
   commit unnecessary (unless it introduces some file changes).  Add a
   new --no-ff option to avoid pruning such a merge commit when the
   first parent is the one that is an ancestor of the other parent.
 * Warn users who try to use invalid path components (#32)
 * Parse mailmap entries with no email address (#29)
 * Allow --dry-run and --debug to be used together (#29)

Installation improvements:
 * Fix some path and documentation installation issues (#12, #10)
 * Update GPL license file (#34)
 * Add packaging scripts for uploading to PyPI (#11, #16, #43)

Documentation improvements:
 * Ficks sum tiepos in reeport fiuhls genereighted bye --analyze (#18, #40)
 * Include several documentation updates, including fixing an error (#41);
   most of these updates were in response to common questions.

Miscellaneous:
 * Prefer 'coverage3' to 'python3-coverage' in testing, to match name
   of upstream package.
 * Add a basic .gitignore


Changes since v2.24.0 are as follows:

Andreas Schneider (1):
      Update GPL license file

Benoit Fouletier (2):
      Makefile: fix documentation installation
      Makefile: fix path installation issues

Elijah Newren (21):
      filter-repo (README): add sections on prerequisites and installation
      Explain how to use a python3 executable not named "python3"
      filter-repo (README): add code of conduct and contributing guidelines
      run_coverage: prefer coverage3 to python3-coverage
      Contributing.md: mention testsuite line coverage
      contrib: clarify a few points of usage
      Reference package managers in installation instructions
      Contributing.md: clarify notes about PEP-8
      filter-repo: don't have analyze choke on typechange types
      filter-repo: move file filtering out of _tweak_commit() for re-use
      filter-repo: actually fix issue with pruning of empty commits
      release: tweak packaging scripts for uploading to PyPI
      filter-repo: avoid clobbering files whose names differ in case only
      contrib: update bfg-ish and filter-lamely with windows workaround
      Contributing.md: clarify reasons for using git.git submission guidelines
      filter-repo: warn users who try to use invalid path components
      filter-repo: add new --no-ff option
      filter-repo: fix bad column label in path-all-sizes.txt report
      git-filter-repo.txt: fix example of editing blob contents
      filter-repo: fix pruning of empty commits with blob callbacks
      INSTALL: a few small tweaks and clarifications

Julian Berman (1):
      release: add packaging scripts for uploading to PyPI

Karl Lenz (3):
      .gitignore: ignore the test result directories
      filter-repo: parse mailmap entries with no email address
      filter-repo: allow --dry-run and --debug to be used together

Matthisk Heimensen (1):
      filter-repo: fix typo in generated analysis README
