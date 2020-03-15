Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30108C0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6EA206D5
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz1CxS0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgCOByM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:54:12 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:33554 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgCOByM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 21:54:12 -0400
Received: by mail-il1-f174.google.com with SMTP id k29so13092253ilg.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 18:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=fKxKiMjpAj0dkdqET483Lvi8Rx9MSGj3uMe484JDWyM=;
        b=Bz1CxS0IyMwY0OCMgA59/eelemjFbWysMFgo0WHd6Ulcxb9HIysETEE6stqw9F1JoO
         pqtk9KKvDWPcEPvmsoDh1qU+e2rUBwJc2s4A8AUM0pNvYT9OYaj/VMhRxbirfjgKDDQ7
         fK2b9WzSMgBlx4ncNPT59Y6Vu8kWFeIFifY83rOsCXmYUA60xD1fQOL37XqlNEN3Cg3Q
         db2TpbFHgUN4eiRywU7pMDQQEE21QlzyD+D/uni03yXAqp96Vnjxw+vWMW/lz7HhSok9
         LLnq9JV+WAhGdshELFGykqKUPyfwIz16rsIFfimhvEgRHXDX6qA8eBLhn8QpzFi9GMYg
         ohSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=fKxKiMjpAj0dkdqET483Lvi8Rx9MSGj3uMe484JDWyM=;
        b=q55Olv9Guaek2Z0uI/KocjXkiiC7yiZKYzAfM1lgdBpl7HfX2TJu9EvHDT443N999b
         s0kJBrESqv5ykeReclXn09xBF9e8UDOL5iMTzFMeAhsYqOkeIg9WYqMIc+e9QN7yGFso
         Iqyi+g4T1KZItSDmu2/ADQX1P2hXEU2VG7WgpfeZuJevr6roVIm3r+7I1VB893bSgXY0
         DEb4uPfVio5WSnhj3YVWvZ+ZG5no1nIKRZxZBEs9uDtd2pECHC0OPhECCSBJekce1AE1
         DS2Msb/gQjz9MURPwjXvz8RoVcvGB+HviYedYebTWdeDJFDT3LzsoWx/YECuUNFvHDQc
         KvjA==
X-Gm-Message-State: ANhLgQ1/KEiQqTwoN2W1P6+f/AKmFJJzVBJTeR3836E4ZUmQReJL5F9f
        MDkz2vgu4K7wD2Sq4L1Wwp7Wv/8giZaCGm4S2vBaBJXb
X-Google-Smtp-Source: ADFU+vu1ZQYOw7a28ioW0LswVTh6bSlKRSTuhVa99tvT7MGsdXqWjc9Ey/NjO5iZguFqgb3QK0i+/oH+PDZAofYUFG8=
X-Received: by 2002:a05:6e02:be7:: with SMTP id d7mr21477849ilu.238.1584237251417;
 Sat, 14 Mar 2020 18:54:11 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 14 Mar 2020 21:54:00 -0400
Message-ID: <CAH8yC8=FZrDmHBSk=GFZd08Ovk4zffyB7KEOoyUpAPLYi_xUeA@mail.gmail.com>
Subject: Why am I on Master instead of my branch
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to test some changes I made on a branch on some other
machines. The changes were committed and pushed. However, after a
checkout and pull on the other machines the changes were missing.

When I do a 'git branch' I am on master for some reason:

$ git branch
  cmake-inno-setup-COVERAGE
  config-guess
  declarations
* master

However, I have never switched back to master:

$ history | grep git | grep -E 'master|cmake'
...
2630  git checkout cmake-inno-setup-COVERAGE
 2631  git fetch upstream cmake-inno-setup-COVERAGE
 2632  git checkout cmake-inno-setup-COVERAGE
 2634  git checkout cmake-inno-setup-COVERAGE
 2635  git branch cmake-inno-setup-COVERAGE
 2757  git diff upstream/master
 2766  history | grep git | grep -E 'master|cmake'
<end of history>

How am I on master when I checked out cmake-inno-setup-COVERAGE?
