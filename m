Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A273EDE99C
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 10:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbjINKE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbjINKE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 06:04:27 -0400
X-Greylist: delayed 577 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 03:04:23 PDT
Received: from st43p00im-ztdg10073201.me.com (st43p00im-ztdg10073201.me.com [17.58.63.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2591A1BE3
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mpbell.io; s=sig1;
        t=1694685284; bh=YP7CYmDPOx6MylvJpZQqQKNS4jpbkKXPY+kZknqI/YI=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=LduVkzWAnM9eSI/04dHCPXWJ4D08Y1Po5TgsdC8GUDz0jlo1wyK+ibTvTQx6yibVM
         WKuZevm1vcEFHGtH/sQHP8+MTv9XqM6o/DA9J7a4B8X/3TzNp5luj/r/x8PCOrEnJ6
         8O1nTFhAXhTP9o7iCzglLFgEIhsLYPi2Hw+njt2SebLKyxj3D6kqTIlfiv1q7mQ1+K
         gWSq/T69fNM8+SHsv3tpB/QYrKFG/sIB+Y+B1B7qYUYv4MeQUkDuaX1th0f75kD7Ux
         vqI/HUE9k5UScSwQQFKqD+A2Kjct6sG8xkXHWgxUwY+k5DgH1abP+vJ9gPCYHW1sj+
         LKjHqOQxwTqnw==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPSA id 8A9C49A003D
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 09:54:43 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Blake Campbell <bc@mpbell.io>
Mime-Version: 1.0 (1.0)
Date:   Thu, 14 Sep 2023 10:54:30 +0100
Subject: skip-worktree autostash on pull 
Message-Id: <AB6A85F5-3E76-4462-931E-AD76E0066C37@mpbell.io>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (20G81)
X-Proofpoint-GUID: AcKBkCrKsRkBydDOEDnfDc7XLNYoOldS
X-Proofpoint-ORIG-GUID: AcKBkCrKsRkBydDOEDnfDc7XLNYoOldS
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=454
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1030
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2309140083
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all - I use update-index --skip-worktree on some config files that I chan=
ge locally and don=E2=80=99t want to commit, but every time I pull from the r=
emote I have to go through a process of no-skip-worktree, stash, pull, stash=
 pop, then skip-worktree again, which is all a bit tedious! Ideally some swi=
tch like --autostash for git pull would be really useful. Does anyone know i=
f something like that exists?=20

Thanks!
Blake.=20
