Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A40B20248
	for <e@80x24.org>; Sat, 30 Mar 2019 08:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfC3Itn (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 04:49:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39809 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfC3Itn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 04:49:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so2151477pfo.6
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VSHw91zndpsbgSOaPskN0LWip81/yoI0BdDAopsxMZw=;
        b=tFlnliFjYHtDn/S2Y3kd+sMgk7rUeZiOb1avFs8SRNEO6E4s+fw4ODTgJhDCsllzYU
         YmpcofRBcEKnBwec/ZmCP6jL7H3QCH9yXzZF8lnal8xyMu71+dqrAozOD1g/Wl46V63j
         GkKQBVWysSEX21ALSfhUQkTlkhybkgXeDJa2cqqTc9PBg6EqUQ4gB8534wZyFKxlVrL+
         TWeR9x0vejm3l/GzcOUohHij26ekQaqGbimk4XyfFPfHjufUF2XHvAdK6m24Uup/ADPC
         R8sHHkHqHwFskwf581NTXUPsYl40NsB4tDFG+sYDYVHwoP4hAd5Jyy0gDif5kgoQbVw6
         JyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VSHw91zndpsbgSOaPskN0LWip81/yoI0BdDAopsxMZw=;
        b=EznEJA7TYDKXBT65pblBgnLgYUH9mCOnj8fXUtGUHM9824S3wEFHTL/vaiZ9LQx+m4
         2Is774xiTqxzAp2DaECLxnapqGSylpkfZmyvfY1kJkDHBac/LVKiKdbq4hkbtq8biPxK
         akuFTfOjRc9dPoK8w5fiLBhZyA63cNJMq+LYdreUlUXKaUpv2QfKCVsxWWr6wBU5z88n
         1Cz3h1OyaKCGZmYsncijy36yk9BgWyD/B0IQTEygVOCg7SuHFa2K+FUGb0lhQecIT4Ij
         t0HfLGFRDSJO43pZsAMK9z+NIrMVeeQEbsBHRXUlj2GtpiZqX9r/+qduzQ2Aghp5WnSx
         jY8A==
X-Gm-Message-State: APjAAAUGLqQ4pbb9BV8KFsyPM9/CQ+vyGFpZBORFxD05go8abhiuc/aO
        gUE8btBLWW+fQubQb6iH0b4ndGT2Y2w=
X-Google-Smtp-Source: APXvYqwz1ly5wnOLjBVkW3KC/uf942XNOHjxlwb528XpDEXJXFJ1tNDEI4tXC7lyB336sI5Gb67TCg==
X-Received: by 2002:a63:4e5b:: with SMTP id o27mr50524159pgl.204.1553935782325;
        Sat, 30 Mar 2019 01:49:42 -0700 (PDT)
Received: from ar135.iitr.local ([223.176.239.198])
        by smtp.gmail.com with ESMTPSA id n9sm5612255pff.43.2019.03.30.01.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 01:49:41 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     newren@gmail.com
Cc:     Johannes.Schindelin@gmx.de, alban.gruin@gmail.com,
        artagnon@gmail.com, christian.couder@gmail.com,
        git@vger.kernel.org, rafa.almas@gmail.com,
        rohit.ashiwal265@gmail.com, s-beyer@gmx.net, t.gummerer@gmail.com
Subject: Re: [GSoC][RFC v2] Improve consistency of sequencer commands 
Date:   Sat, 30 Mar 2019 14:18:22 +0530
Message-Id: <20190330084822.11285-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABPp-BEsqW61f4SWehTpFzMF97AzTUB_StOS83GAmZOC7QohSg@mail.gmail.com>
References: <CABPp-BEsqW61f4SWehTpFzMF97AzTUB_StOS83GAmZOC7QohSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 2019-03-30  0:38 UTC Elijah Newren <newren@gmail.com> wrote:

> I'm curious if you're looking at an old version of the documentation
> (...or maybe the documentation just isn't that clear?).  Interactive
> rebases have supported --signoff since commit a852ec7f273c ("rebase:
> extend --signoff support", 2018-03-20)

Oh~ after having a quick look at my currently installed version of git,
it was 2.17.1, which has outdated man pages :sweat_smile:. Yes, you are
correct, I'm sorry.

Feeling dumb
Rohit

