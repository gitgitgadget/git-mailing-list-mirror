Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975C4C2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 12:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74868206CB
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 12:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLWM4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 07:56:53 -0500
Received: from gateway36.websitewelcome.com ([192.185.196.23]:31044 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbfLWM4x (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Dec 2019 07:56:53 -0500
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Dec 2019 07:56:53 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 1002940ABE792
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 06:08:03 -0600 (CST)
Received: from gator4087.hostgator.com ([192.185.4.99])
        by cmsmtp with SMTP
        id jNGWiz2ZK4kpjjNGWiVp6A; Mon, 23 Dec 2019 06:56:52 -0600
X-Authority-Reason: nr=8
Received: from mail-qk1-f169.google.com ([209.85.222.169]:42987)
        by gator4087.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <xda@abalgo.com>)
        id 1ijNGW-001Jf2-LS
        for git@vger.kernel.org; Mon, 23 Dec 2019 06:56:52 -0600
Received: by mail-qk1-f169.google.com with SMTP id z14so12168753qkg.9
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 04:56:52 -0800 (PST)
X-Gm-Message-State: APjAAAXcYz25TLWMsYBTo9LDxRgafdE9wFOkBIaXJD4Gxiodvmr97Mg9
        t66383OEn8EtBMOHCTuXjkPgomXgYjm20wP3WXc=
X-Google-Smtp-Source: APXvYqzrvjw8B7LoAIdYMkG1cIZ5LqFhRDVe+geUpo38i0uyvpJaulUEAtf2ty/Yfltvtom24buzGDv6cHMkzzY5pG8=
X-Received: by 2002:a05:620a:1001:: with SMTP id z1mr13902834qkj.99.1577105812214;
 Mon, 23 Dec 2019 04:56:52 -0800 (PST)
MIME-Version: 1.0
From:   Arnaud Bertrand <xda@abalgo.com>
Date:   Mon, 23 Dec 2019 13:56:41 +0100
X-Gmail-Original-Message-ID: <CAEW0o+jV+r1UMZReRXa3g_fyqCYxHTVYVf6pWvjB7_isofbBaw@mail.gmail.com>
Message-ID: <CAEW0o+jV+r1UMZReRXa3g_fyqCYxHTVYVf6pWvjB7_isofbBaw@mail.gmail.com>
Subject: Feature request: add a metadata in the commit: the "commited in
 branch" information
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4087.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - abalgo.com
X-BWhitelist: no
X-Source-IP: 209.85.222.169
X-Source-L: No
X-Exim-ID: 1ijNGW-001Jf2-LS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: mail-qk1-f169.google.com [209.85.222.169]:42987
X-Source-Auth: abalgo
X-Email-Count: 4
X-Source-Cap: YWJhbGdvO2FiYWxnbztnYXRvcjQwODcuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git is a nice tool but one of the most important missing information
is the branch in which a commit was done.
I understood that in git philosophy, once it is merged, a branch can
disappear. But for a lot of companies, a SCM is also a guardian of the
history.
With this point of view, keeping track of the branch name when the
commit was done should be a very very big improvement (and a Major
argument to switch to git)
I speak just about a meta-data, exactly as the committer username,
email or date... no more.
If the branch is removed in the future or is renamed... so what, we
have at least its name at the time of the commit (better than
nothing).

Today, all my git repositories are using hooks to add the name of the
branch as header of the comment. But it would be so better to have it
officially and automatically and accessible as a git log meta-data.
It does not imply any constrains, simply a few characters more in the commit.
We can also imagine a core.branchInCommit parameter (true by default
;-) ) that could be set to false for those that don't one it.
The only commands affected should be git commit, git merge --no-ff and
git log that should be able to show this metadata.


Best regards,

Arnaud Bertrand
