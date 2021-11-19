Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E94C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 22:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhKSWQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhKSWQh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 17:16:37 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24F1C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 14:13:34 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1moC8M-00EI3K-0G
        for git@vger.kernel.org; Fri, 19 Nov 2021 22:13:30 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1moC8I-00C1SM-2t
        for git@vger.kernel.org; Sat, 20 Nov 2021 07:13:22 +0900
Date:   Sat, 20 Nov 2021 07:13:22 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.5.8
Message-ID: <20211119221322.mkrf5z3jt4362ylk@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git-cinnabar is a git remote helper to interact with mercurial
repositories. It allows to clone, pull and push from/to mercurial remote
repositories, using git.

Code on https://github.com/glandium/git-cinnabar
This release is available on
https://github.com/glandium/git-cinnabar/releases/tag/0.5.8

What's new since 0.5.7?

- Updated git to 2.34.0 for the helper.
- Python 3.5 and newer are now officially supported. Git-cinnabar will
  try to use the `python3` program by default, but will fallback to
  `python2.7` if that's where the Mercurial libraries are available. It
  is possible to pick a specific python with the `GIT_CINNABAR_PYTHON`
  environment variable.
- Fixed compatibility with Mercurial 5.8 and newer.
- The prebuilt binaries are now optimized on arm64 macOS and Windows.
- `git cinnabar download` now properly returns an error code when
  failing to extract the prebuilt binaries.
- Pushing to a non-empty Mercurial repository without having pulled at
  least once from it is now prevented.
- Replaced the nagging about fsck with a smaller check always happening
  after pulling.
- Fail earlier on `git fetch hg::url <sha1>` (it would properly fetch
  the Mercurial changeset and its ancestors, but git would fail at the
  end because the sha1 is not a git sha1 ; use `git cinnabar fetch`
  instead)
- Minor fixes.

Mike
