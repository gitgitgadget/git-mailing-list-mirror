Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FE6C4332F
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 23:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiK0XDE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 27 Nov 2022 18:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0XDD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 18:03:03 -0500
X-Greylist: delayed 545 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Nov 2022 15:02:58 PST
Received: from rincon.dynax.at (rincon.dynax.at [62.171.155.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F49D118
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 15:02:58 -0800 (PST)
Received: from smtpclient.apple (62-178-42-31.cable.dynamic.surfer.at [62.178.42.31])
        (Authenticated sender: hagen)
        by rincon.dynax.at (Postfix) with ESMTPSA id 07B4F4BA43
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 23:53:50 +0100 (CET)
From:   "signal@dynax.at" <signal@dynax.at>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: =?utf-8?Q?making_use_of_=24sm=5Fpath_=40_git_submodule_foreach_?=
 =?utf-8?Q?=E2=80=94recursive?=
Message-Id: <70ED2ECF-DAF1-4CCB-9E05-2599211F3569@dynax.at>
Date:   Sun, 27 Nov 2022 23:53:50 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

when using 
git submodule foreach —recursive [..] 
$sm_path contains only the relative part of the latest recursion. Since the command has no generic way of knowing from which recursion level it is executed any $sm_path of deeper recursion level is useless unless there is a way for the command to find out from which recursion it is called.

I suggest $sm_path should be extended to be relative to the repo from where the submodule recursion started or another variable should contain the recursive part.

Viele Grüße/Cheers,
Hagen.
