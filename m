Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7EA20323
	for <e@80x24.org>; Thu, 23 Mar 2017 00:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbdCWAcf (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 20:32:35 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36737 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbdCWAce (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 20:32:34 -0400
Received: by mail-qk0-f178.google.com with SMTP id p22so28453428qka.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Xkr3+impMxb+1sh9ANLGYwGHhWkfXaacxGar5QeebaQ=;
        b=CZJVR02YP04dxAykbF+384LLMCDn0xKZkxvJ/J2Eqdz5xZZWP1vPMc9cNjb2eLG5RM
         FcfsrWw9vcmTdCzL13P+n6PFbCfKQSmUW3Cke+JH04Wgn9SezN5bFHMhmbu1UNloP7rJ
         NaUBSExrPFTA8GFtN7E6FZGbiqe3wM0zTzpu/weNk/NTwikfBBpqU941wAA4bCY7rtLu
         97V4v4hnFCn5yQTi0tXs+yE2drMVd67GiwVTvUf7eCJXXA88VuhhTtOh0a6iVX7aTRgX
         PVbT7XdxvoKGhgucPqJiQ6lx+gjNTVYH84BugOa51lbfprpP+ui73OVNvVQgPydSFwo2
         Zrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Xkr3+impMxb+1sh9ANLGYwGHhWkfXaacxGar5QeebaQ=;
        b=TFoDSOXs0rFM1eTh3yW/wDOHanCaiTbnO5tdXm8whcPMwewsu0E1tnagDSdtdq58iv
         cIG8mCGjbaIZHb8f1X9DijC0suYkrh/P/ei11lsik6K7AiAwFoGu6/WE7EmRgs3wp9ba
         8HTCqq5nv1SkdhlV6obwXyM5l7Sw1IJV+1t3TVTN59EdZNFmSnHSjfaE1lcu+cqNX9oB
         YhoWu23XF2rysEYmj6LZYBsdKEHa9pFRZu1CnZnVpDVmWr+tK62fPwSOQMfBV98CmxuM
         Z1tMXGlb65NXceugRjtKXCbZ5U4mP5QhLZBDcY3H+aUuH03AuMvTmOIscge7mD6MWZkQ
         QIIg==
X-Gm-Message-State: AFeK/H3xFwWAbEUFUnQt/RgVjzv61Qg4UYXjI9SR9MWnKaVchc/5iq/W6DjHoXad8SJav9O6w3qi3eYFfoTaTA==
X-Received: by 10.55.119.65 with SMTP id s62mr37140225qkc.130.1490229152267;
 Wed, 22 Mar 2017 17:32:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.45.231 with HTTP; Wed, 22 Mar 2017 17:32:31 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 22 Mar 2017 18:32:31 -0600
Message-ID: <CAOc6etYTDyyRud9D3jubh7tC9MeyGZXONWM+=Kb+uwx0voSLpw@mail.gmail.com>
Subject: blame --line-porcelain is providing me with funny output
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everybody!

As part of my improvements to difflame I want to use revision
information as provided by blame --line-porcelain so that I can avoid
some git calls to cat-file -p to get revision information hoping that
information would be a match. However I'm not finding that to be the
case.

$ git blame --no-progress -w --line-porcelain -L 72,72
4e59582ff70d299f5a88449891e78d15b4b3fabe -- t/lib-submodule-update.sh

3290fe6dd2a7e2bb35ac760443335dec58802ff1 72 72 1
author Stefan Beller
author-mail <somemail@gmail.com>
author-time 1484160452
author-tz -0800
committer Junio C Hamano
committer-mail <somemail@pobox.com>
committer-time 1484337771
committer-tz -0800
summary lib-submodule-update.sh: reduce use of subshell by using "git -C"
previous d7dffce1cebde29a0c4b309a79e4345450bf352a t/lib-submodule-update.sh
filename t/lib-submodule-update.sh
                       git -C sub1 checkout modifications &&



If we then take a look at the information on that revision using
cat-file -p on the revision:

$ git cat-file -p 3290fe6dd2a7e2bb35ac760443335dec58802ff1


tree 7df89dad28ec8b08875395265a3f2e13ba180174
parent d7dffce1cebde29a0c4b309a79e4345450bf352a
author Stefan Beller <somemail@google.com> 1484160452 -0800
committer Junio C Hamano <somemail@pobox.com> 1484337771 -0800

(which, just in case, resembles the information provided by git
show... but is simpler to parse with cat-file).

Committer mails are matching, however author mail does not match
between line-porcelain and cat-file. Is there a reason for that?


Thanks in advance.
