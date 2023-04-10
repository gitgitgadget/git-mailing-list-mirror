Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D08BC76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 19:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDJTvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 15:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJTvN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 15:51:13 -0400
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Apr 2023 12:51:11 PDT
Received: from qs51p00im-qukt01080101.me.com (qs51p00im-qukt01080101.me.com [17.57.155.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75B1BE7
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 12:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mervin.works;
        s=sig1; t=1681155879;
        bh=JbB3VTX2h5MwRZC838VcVpQLdSMv00nawQyqNg7GdmI=;
        h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To;
        b=jHvNvCXLrM3EmTg30cqVTXXItNVWoVFvrmOCuQsKJy3zcY6a3PqlPHaySY+Uj5sJ+
         sDiMgiXfS5PCA+HVVi+qHonXj5sLXpphdjmy1CV7hmKeLBqEr5wJkTz39V/5787r3u
         8iLmIlBTkGf1MrnMMm5IbAx8oCKpPrmtf79Qs3gBXPSOyl4+1OzBmkO7wlPpCSsV1G
         EyGz1kwn3AqGT3aARrDPtjvv1SplCy8ax5vFkEDDe0g91qwQjazor9CV6ZwD+PVKxb
         m5GSjNA4p82FRngvTCJ8pbC95vBDflfdhs5C3L2EvXKm/WLC02/A0zN/O1nEHRVa0W
         FJpohNHzxsx8Q==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080101.me.com (Postfix) with ESMTPSA id 9AE5D6180D23
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 19:44:38 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Mervin Guy <mail@mervin.works>
Mime-Version: 1.0 (1.0)
Subject: 'git config --edit' unexpected behavior
Message-Id: <0E8CDEA4-21CC-4CF1-809F-3FE37849ED47@mervin.works>
Date:   Mon, 10 Apr 2023 15:44:26 -0400
To:     git@vger.kernel.org
X-Mailer: iPad Mail (20F5028e)
X-Proofpoint-ORIG-GUID: GLHsXsfRV52QpqBuZHYioJOikYJ5jnet
X-Proofpoint-GUID: GLHsXsfRV52QpqBuZHYioJOikYJ5jnet
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=813
 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2304100170
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

- Changed my directory to a git-repo I was working on, using 'cd <directory_=
name>'. Then I ran 'git config --global -e'.

What did you expect to happen? (Expected behavior)

- I exepected the command to display my current-config file, with all settin=
gs included, in my editor.

What happened instead? (Actual behavior)

- My config-file was overwritten and displayed a default-setup message, the c=
onfig-file was lost after this point.
  I experimented with different ways of activating the command, but they all=
 led to an overwrite of the file.

What's different between what you expected and what actually happened?

- The config-file should've displayed as-was, and no overwrite should've occ=
urred unless explicitly commanded.

Anything else you want to add:

- It should be noted that I've been updating my config-file manually, up unt=
il this point. When updating it, I used
 '[subsection] component' rather than 'subsection.component'.

[System Info]
git version: 2.40.0
cpu: i686
sizeof-long: 4
sizeof-size_t: 4
shell-path: /bin/sh
compiler info: gnuc: 12.2
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/ash

