Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C07C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 18:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F0320828
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 18:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hqAQ/ULy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfLJSFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:05:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50559 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfLJSFu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 13:05:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24428210C0;
        Tue, 10 Dec 2019 13:05:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=N
        OirRWY6grfPU8sXDBbIzZh4yyU=; b=hqAQ/ULytTxuApGJxbDtXYPTa6B+VoXg3
        AlA2fAhgdBiT0hvth3f6IkWrCJUwM1cCY5CWlkNVWBSa+P+/NArgdKCT2nmGdUIp
        ipKOxxHlJPhdc9iT7gtGbb2a3AoWmPhk1FjClGB4EHmPmGOGgdQl2BZx1KuG3nIB
        De7glS2dVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=hOK5+FgCN6VdvqtQlf+zDp222zH41ROCjD+WFU3I9d3IJ5SqNe1xhXXq
        d3F2aYTrAVAZtA2V0tHqSwhNuXX7RzA/R0pmORWxIJfkAB1IiyjtV+VAREsRrs1U
        7+CIY8UUf4Jw0icNSolAzL0JiT62b9uHj6C1dx95uIEtNkiGqiM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CF35210BF;
        Tue, 10 Dec 2019 13:05:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78E67210BE;
        Tue, 10 Dec 2019 13:05:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.24.1 and others
Date:   Tue, 10 Dec 2019 10:05:46 -0800
Message-ID: <xmqqr21cqcn9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1231074-1B77-11EA-95ED-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Today, the Git project is releasing the following Git versions:

    v2.24.1, v2.23.1, v2.22.2, v2.21.1, v2.20.2, v2.19.3, v2.18.2,
    v2.17.3, v2.16.6, v2.15.4, and v2.14.6

These releases fix various security flaws, which allowed an attacker
to overwrite arbitrary paths, remotely execute code, and/or overwrite
files in the .git/ directory etc.  See the release notes attached for
the list for their descriptions and CVE identifiers.

Users of the affected maintenance tracks are urged to upgrade.

These flaws were discovered and reported by Joern Schneeweisz of
GitLab and by Microsoft Security Response Center (and in particular
Nicolas Joly), and were fixed by Johannes Schindelin, Jeff King,
Garima Singh and Jonathan Nieder on the git-security mailing list.
The release engineering and coordination was led by Johannes
Schindelin.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.24.1'
and other tags:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.14.6 Release Notes
=========================

This release addresses the security issues CVE-2019-1348,
CVE-2019-1349, CVE-2019-1350, CVE-2019-1351, CVE-2019-1352,
CVE-2019-1353, CVE-2019-1354, and CVE-2019-1387.

Fixes since v2.14.5
-------------------

 * CVE-2019-1348:
   The --export-marks option of git fast-import is exposed also via
   the in-stream command feature export-marks=... and it allows
   overwriting arbitrary paths.

 * CVE-2019-1349:
   When submodules are cloned recursively, under certain circumstances
   Git could be fooled into using the same Git directory twice. We now
   require the directory to be empty.

 * CVE-2019-1350:
   Incorrect quoting of command-line arguments allowed remote code
   execution during a recursive clone in conjunction with SSH URLs.

 * CVE-2019-1351:
   While the only permitted drive letters for physical drives on
   Windows are letters of the US-English alphabet, this restriction
   does not apply to virtual drives assigned via subst <letter>:
   <path>. Git mistook such paths for relative paths, allowing writing
   outside of the worktree while cloning.

 * CVE-2019-1352:
   Git was unaware of NTFS Alternate Data Streams, allowing files
   inside the .git/ directory to be overwritten during a clone.

 * CVE-2019-1353:
   When running Git in the Windows Subsystem for Linux (also known as
   "WSL") while accessing a working directory on a regular Windows
   drive, none of the NTFS protections were active.

 * CVE-2019-1354:
   Filenames on Linux/Unix can contain backslashes. On Windows,
   backslashes are directory separators. Git did not use to refuse to
   write out tracked files with such filenames.

 * CVE-2019-1387:
   Recursive clones are currently affected by a vulnerability that is
   caused by too-lax validation of submodule names, allowing very
   targeted attacks via remote code execution in recursive clones.

Credit for finding these vulnerabilities goes to Microsoft Security
Response Center, in particular to Nicolas Joly. The `fast-import`
fixes were provided by Jeff King, the other fixes by Johannes
Schindelin with help from Garima Singh.


Git v2.15.4 Release Notes
=========================

This release merges up the fixes that appear in v2.14.6 to address
the security issues CVE-2019-1348, CVE-2019-1349, CVE-2019-1350,
CVE-2019-1351, CVE-2019-1352, CVE-2019-1353, CVE-2019-1354, and
CVE-2019-1387; see the release notes for that version for details.

In conjunction with a vulnerability that was fixed in v2.20.2,
`.gitmodules` is no longer allowed to contain entries of the form
`submodule.<name>.update=!command`.


Git v2.16.6 Release Notes
=========================

This release merges up the fixes that appear in v2.14.6 and in
v2.15.4 addressing the security issues CVE-2019-1348, CVE-2019-1349,
CVE-2019-1350, CVE-2019-1351, CVE-2019-1352, CVE-2019-1353,
CVE-2019-1354, and CVE-2019-1387; see the release notes for those
versions for details.


Git v2.17.3 Release Notes
=========================

This release merges up the fixes that appear in v2.14.6 and in
v2.15.4 addressing the security issues CVE-2019-1348, CVE-2019-1349,
CVE-2019-1350, CVE-2019-1351, CVE-2019-1352, CVE-2019-1353,
CVE-2019-1354, and CVE-2019-1387; see the release notes for those
versions for details.

In addition, `git fsck` was taught to identify `.gitmodules` entries
of the form `submodule.<name>.update=!command`, which have been
disallowed in v2.15.4.


Git v2.18.2 Release Notes
=========================

This release merges up the fixes that appear in v2.14.6, v2.15.4
and in v2.17.3, addressing the security issues CVE-2019-1348,
CVE-2019-1349, CVE-2019-1350, CVE-2019-1351, CVE-2019-1352,
CVE-2019-1353, CVE-2019-1354, and CVE-2019-1387; see the release notes
for those versions for details.


Git v2.19.3 Release Notes
=========================

This release merges up the fixes that appear in v2.14.6, v2.15.4
and in v2.17.3, addressing the security issues CVE-2019-1348,
CVE-2019-1349, CVE-2019-1350, CVE-2019-1351, CVE-2019-1352,
CVE-2019-1353, CVE-2019-1354, and CVE-2019-1387; see the release notes
for those versions for details.


Git v2.20.2 Release Notes
=========================

This release merges up the fixes that appear in v2.14.6, v2.15.4
and in v2.17.3, addressing the security issues CVE-2019-1348,
CVE-2019-1349, CVE-2019-1350, CVE-2019-1351, CVE-2019-1352,
CVE-2019-1353, CVE-2019-1354, and CVE-2019-1387; see the release notes
for those versions for details.

The change to disallow `submodule.<name>.update=!command` entries in
`.gitmodules` which was introduced v2.15.4 (and for which v2.17.3
added explicit fsck checks) fixes the vulnerability in v2.20.x where a
recursive clone followed by a submodule update could execute code
contained within the repository without the user explicitly having
asked for that (CVE-2019-19604).

Credit for finding this vulnerability goes to Joern Schneeweisz,
credit for the fixes goes to Jonathan Nieder.


Git v2.21.1 Release Notes
=========================

This release merges up the fixes that appear in v2.14.6, v2.15.4,
v2.17.3 and in v2.20.2, addressing the security issues CVE-2019-1348,
CVE-2019-1349, CVE-2019-1350, CVE-2019-1351, CVE-2019-1352,
CVE-2019-1353, CVE-2019-1354, CVE-2019-1387, and CVE-2019-19604;
see the release notes for those versions for details.

Additionally, this version also includes a couple of fixes for the
Windows-specific quoting of command-line arguments when Git executes
a Unix shell on Windows.


Git v2.22.2 Release Notes
=========================

This release merges up the fixes that appear in v2.14.6, v2.15.4,
v2.17.3, v2.20.2 and in v2.21.1, addressing the security issues
CVE-2019-1348, CVE-2019-1349, CVE-2019-1350, CVE-2019-1351,
CVE-2019-1352, CVE-2019-1353, CVE-2019-1354, CVE-2019-1387, and
CVE-2019-19604; see the release notes for those versions for details.


Git v2.23.1 Release Notes
=========================

This release merges up the fixes that appear in v2.14.6, v2.15.4,
v2.17.3, v2.20.2 and in v2.21.1, addressing the security issues
CVE-2019-1348, CVE-2019-1349, CVE-2019-1350, CVE-2019-1351,
CVE-2019-1352, CVE-2019-1353, CVE-2019-1354, CVE-2019-1387, and
CVE-2019-19604; see the release notes for those versions for details.


Git v2.24.1 Release Notes
=========================

This release merges up the fixes that appear in v2.14.6, v2.15.4,
v2.17.3, v2.20.2 and in v2.21.1, addressing the security issues
CVE-2019-1348, CVE-2019-1349, CVE-2019-1350, CVE-2019-1351,
CVE-2019-1352, CVE-2019-1353, CVE-2019-1354, CVE-2019-1387, and
CVE-2019-19604; see the release notes for those versions for details.


