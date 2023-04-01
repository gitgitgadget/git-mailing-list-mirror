Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F53C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 02:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjDAC2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 22:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjDAC2X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 22:28:23 -0400
X-Greylist: delayed 1967 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Mar 2023 19:28:21 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C86D315
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 19:28:21 -0700 (PDT)
Received: from [2400:4160:1877:2b00:18ba:b9b1:b02:d35b] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <mh@glandium.org>)
        id 1piQS1-006lid-2f
        for git@vger.kernel.org;
        Sat, 01 Apr 2023 01:54:45 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1piQRx-00Fk1F-Kv
        for git@vger.kernel.org; Sat, 01 Apr 2023 10:54:37 +0900
Date:   Sat, 1 Apr 2023 10:54:37 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.6.0
Message-ID: <20230401015437.3ya6abvgxjjcpund@glandium.org>
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
https://github.com/glandium/git-cinnabar/releases/tag/0.6.0

What's new since 0.5.11?

- Full rewrite of the Python parts of git-cinnabar in Rust.
- Push performance is between twice and 10 times faster than 0.5.x,
  depending on scenarios.
- Based on git 2.38.0.
- `git cinnabar fetch` now accepts a `--tags` flag to fetch tags.
- `git cinnabar bundle` now accepts a `-t` flag to give a specific
  bundlespec.
- `git cinnabar rollback` now accepts a `--candidates` flag to list the
  metadata sha1 that can be used as target of the rollback.
- `git cinnabar rollback` now also accepts a `--force` flag to allow
  any commit sha1 as metadata.
- `git cinnabar` now has a `self-update` subcommand that upgrades it
  when a new version is available. The subcommand is only available
  when building with the `self-update` feature (enabled on prebuilt
  versions of git-cinnabar).
- Disabled inexact copy/rename detection, that was enabled by accident.

What's new since 0.6.0rc2?

- Fixed use-after-free in metadata initialization.
- Look for the new location of the CA bundle in git-windows 2.40.

Mike
