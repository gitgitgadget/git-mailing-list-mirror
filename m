Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF1C35242
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 16:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661BD20704
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 16:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbgAXQet (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:34:49 -0500
Received: from a3.inai.de ([88.198.85.195]:55758 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388242AbgAXQet (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 11:34:49 -0500
Received: by a3.inai.de (Postfix, from userid 25121)
        id 9DFFD587588C7; Fri, 24 Jan 2020 17:34:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 9B91060C531F1;
        Fri, 24 Jan 2020 17:34:47 +0100 (CET)
Date:   Fri, 24 Jan 2020 17:34:47 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Derrick Stolee <stolee@gmail.com>
cc:     git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
Subject: Re: Misrendering of git 2.25 log --graph
In-Reply-To: <75f5c537-bb46-7f04-54fe-0bc62762a682@gmail.com>
Message-ID: <nycvar.YFH.7.76.2001241730030.32144@n3.vanv.qr>
References: <nycvar.YFH.7.76.2001232353220.26179@n3.vanv.qr> <b64e8fb7-1dd3-439f-6ab1-1b88c52879d1@gmail.com> <75f5c537-bb46-7f04-54fe-0bc62762a682@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 2020-01-24 15:06, Derrick Stolee wrote:
>
>I completely misread your ordering here. You are clear that this
>is an issue in 2.24 and NOT 2.25. Sorry.
>
>I'm not sure that there is anything to do since the graph rendering
>has changed so much, and we intend to keep the new version instead.

I now have a minimized reproducer, for *2.25*:

» ../git/git log --oneline --graph --all --decorate --topo-order
*   e1ee7b8 (HEAD -> master) Merge branch 'k9' into k10
|\  
| *   7b48214 Merge branch 'k8' into k9
| |\  
| | *   ed02a51 Merge branch 'blah' into k8
| | |\  
| | | * 44279cf blah
| | * |   4053c4d Merge branch 'k7' into k8
| | |\ \  
| |/ / /  
| | | _   
| | * 5b449d6 update 8.7 news
| |/  
| * 43a324f foo
|/  
* 5932a51 root

» ../git/git --version
git version 2.25.0.24.gbc7a3d4dc0

The repository https://github.com/jengelh/git-issue-20200123 has been
re-populated with the new contents.
