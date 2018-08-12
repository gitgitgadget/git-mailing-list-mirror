Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4821F404
	for <e@80x24.org>; Sun, 12 Aug 2018 03:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeHLFj0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 01:39:26 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:50440 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeHLFj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 01:39:26 -0400
X-Greylist: delayed 2632 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Aug 2018 01:39:25 EDT
Received: from glandium by mitsuha.glandium.org with local (Exim 4.91)
        (envelope-from <mh@glandium.org>)
        id 1fofyN-0002y9-Ku
        for git@vger.kernel.org; Sun, 12 Aug 2018 11:19:15 +0900
Date:   Sun, 12 Aug 2018 11:19:15 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.5.0
Message-ID: <20180812021915.57qmjcnqeoct2ybx@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git-cinnabar is a git remote helper to interact with mercurial
repositories. It allows to clone, pull and push from/to mercurial remote
repositories, using git.

Code on https://github.com/glandium/git-cinnabar
This release on
https://github.com/glandium/git-cinnabar/releases/tag/0.5.0

What's new since 0.4.0?

- git-cinnabar-helper is now mandatory. You can either download one with `git cinnabar download` on supported platforms or build one with `make`.
- Performance and memory consumption improvements.
- Metadata changes require to run `git cinnabar upgrade`.
- Mercurial tags are consolidated in a separate (fake) repository. See the README file.
- Updated git to 2.18.0 for the helper.
- Improved memory consumption and performance.
- Improved experimental support for pushing merges.
- Support for [clonebundles](https://www.mercurial-scm.org/wiki/ClonebundlesExtension) for faster clones when the server provides them.
- Removed support for the .git/hgrc file for mercurial specific configuration.
- Support any version of Git (was previously limited to 1.8.5 minimum)
- Git packs created by git-cinnabar are now smaller.
- Fixed incompatibilities with Mercurial 3.4 and >= 4.4.
- Fixed tag cache, which could lead to missing tags.
- The prebuilt helper for Linux now works across more distributions (as long as libcurl.so.4 is present, it should work)
- Properly support the `pack.packsizelimit` setting.
- Experimental support for initial clone from a git repository containing git-cinnabar metadata.
- Now can successfully clone the pypy and GNU octave mercurial repositories.
- More user-friendly errors.

Development process changes

It took about 6 months between version 0.3 and 0.4. It took more than 18 months to reach version 0.5 after that. That's a long time to wait for a new version, considering all the improvements that have happened under the hood.

From now on, the `release` branch will point to the last tagged release, which is roughly the same as before, but won't be the default branch when cloning anymore.

The default branch when cloning will now be `master`, which will receive changes that are acceptable for dot releases (0.5.x). These include:
- Changes in behavior that are backwards compatible (e.g. adding new options which default to the current behavior).
- Changes that improve error handling.
- Changes to existing experimental features, and additions of new experimental features (that require knobs to be enabled).
- Changes to Continuous Integration/Tests.
- Git version upgrades for the helper.

The `next` branch will receive changes for the next "major" release, which as of writing is planned to be 0.6.0. These include:
- Changes in behavior.
- Changes in metadata.
- Stabilizing experimental features.
- Remove backwards compability with older metadata (< 0.5.0).

Mike
