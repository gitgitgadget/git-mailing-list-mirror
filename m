Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A02C207D6
	for <e@80x24.org>; Thu,  4 May 2017 21:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdEDVkQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 17:40:16 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:33706 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdEDVkP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 17:40:15 -0400
Received: from homiemail-a7.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 49A9B8B211
        for <git@vger.kernel.org>; Thu,  4 May 2017 14:40:15 -0700 (PDT)
Received: from homiemail-a7.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a7.g.dreamhost.com (Postfix) with ESMTP id 967EA25C06B
        for <git@vger.kernel.org>; Thu,  4 May 2017 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:from:date:message-id:subject:to:content-type; s=
        bit-booster.com; bh=WRK5V81rD4O5TpnSgc/oKURVj5Y=; b=EMgSlznzkzhi
        /eU8Jf9h5sCQmt+mB5+4LsMiPEgJndD7eMs5qrB+aSAro2IwkMVvpsrgMkvzB5UC
        dcpm+JNUR7rpouSu2nQK+B3dUHb/P0dl6a4/sLAyfTi9oIZGlrbkDYprzMi05N8Z
        uo3kMj2zdgGzyUJxytaVMMz6dNl4WII=
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com [209.85.214.49])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a7.g.dreamhost.com (Postfix) with ESMTPSA id 64D1B25C062
        for <git@vger.kernel.org>; Thu,  4 May 2017 14:40:15 -0700 (PDT)
Received: by mail-it0-f49.google.com with SMTP id x188so7038273itb.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 14:40:14 -0700 (PDT)
X-Gm-Message-State: AN3rC/5s9tFJhKT9X2w00ejAl44BXIBwXsflWJ+y5xkcop3lHXJzGmA4
        HfxkeQz7ZavV5HUmf9WEsbxW7rP/JA==
X-Received: by 10.36.14.15 with SMTP id 15mr4971653ite.100.1493934013246; Thu,
 04 May 2017 14:40:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.150.198 with HTTP; Thu, 4 May 2017 14:40:12 -0700 (PDT)
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Thu, 4 May 2017 14:40:12 -0700
X-Gmail-Original-Message-ID: <CAAj3zPzHiwgS=2CSKP1y8zGUxHUWiq9TSeMhixeL+9ZfffY-pw@mail.gmail.com>
Message-ID: <CAAj3zPzHiwgS=2CSKP1y8zGUxHUWiq9TSeMhixeL+9ZfffY-pw@mail.gmail.com>
Subject: not uptodate. Cannot merge
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

My little bitbucket "cherry-pick" button is failing on Windows from a
"git reset --hard" blowing up.

My situation:  Git-2.10.2.windows.1 / Bitbucket-4.14.3 / Windows
10-10.0-amd64.   But I suspect even more recent Git will have the same
problem.

Now, I'm pretty far from Kansas here as you'll see from my "git clone"
invocation:

git.exe clone -c core.checkStat=minimal -c core.fileMode=false -c
core.ignoreStat=true -c core.trustctime=false -c
core.logAllRefUpdates=false --shared
C:\Users\gsylvie\dev\bb\target\bitbucket\home\shared\data\repositories\1
C:\Users\gsylvie\dev\bb\target\bitbucket\home\caches\bbClones\1


Right after cloning I create a ".git/info/attributes" file containing
just this one line:

* -text


After the clone, here's the sequence of commands leading up to the bad
"git reset --hard".  These are all fine (well, the "--aborts" whine a
little, but that's expected):

git.exe branch --unset-upstream
git.exe update-index --refresh
git.exe rebase --abort
git.exe cherry-pick --abort


And here's the "git reset --hard" that fails:

git.exe reset --hard --quiet d6edcbf924697ab811a867421dab60d954ccad99 --

---
Exit=128
error: Entry 'basic_branching/file.txt' not uptodate. Cannot merge.
fatal: Could not reset index file to revision
'd6edcbf924697ab811a867421dab60d954ccad99'.
---

For now I've come up with an astonishing workaround:   I just run "git
status" afterwards, and then everything is fine!

I'm going to limp along with this remedy, but I thought I'd share it
here in case anyone has any ideas, or in case it really is a bug.


- Sylvie


p.s.  Thanks for mentioning "git-reverse.sh" in git rev news!
