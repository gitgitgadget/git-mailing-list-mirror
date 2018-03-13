Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2071F404
	for <e@80x24.org>; Tue, 13 Mar 2018 12:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932712AbeCMMgH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 08:36:07 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:39551 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeCMMgG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 08:36:06 -0400
Received: by mail-wr0-f178.google.com with SMTP id k3so2778038wrg.6
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EomjXLdq6gg/JnigqfpcUXfp165dRnpXtShOiLFN6bI=;
        b=fJ2hI940yBFrPAX6t0SevMPK4ed9VT4XUGGByDq4RWlsvZrGq8HA/9FLtq2XWmuE+R
         kwg1uugtMiFN43j6M/Kl17ktNIEcecymcqis4aRZ03Fdmvo8g0aR1JMxz4iOYIa19d9c
         1J/xXXu/6qI9Ovsq2LPFr9G+g628uxxe6+wKsb2e7golbW8XhA9f/gcfgjVuRqHirElj
         Mzaju1g3cLjUadzHNU2JyFQY0K5BfMJO6hJEqs0RK/72pyW/wn61duI6rlxMQJEdFky/
         aHt8geIS+Tcfne3wxYzfCXsHkH8webBj9RVPUY+l+oG7s4OK9oMvmAeMUIy5oAbI8vfJ
         VcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EomjXLdq6gg/JnigqfpcUXfp165dRnpXtShOiLFN6bI=;
        b=Kqn/n7O9pCe+Dvi3qeVY8AvSnVV+sc4BpyX5qZcPW2A279Ah+Pr7/Q2RAtq9d3ANwP
         z72ZRCUT/XmJ3a+t1Fu/zyv47rdBN1paSEHsrICJAoJMhftSyUb9fIAo8n8s4QhE/1ss
         cevMpG+KHqoY/vS2/rsXfsBRq15N8Kc/jjhJMT7S0u1ri6dwu3kwsC9EW5yB3ZGy7NQu
         Rhbwzn3UWcA4NMKX770M4vdTMaGVCj8NrsyeJe3x7Crx9AJbujqgMbw/bx2dU5BchWci
         2aZe2tUM9on7B/mB6GK5MaKnEtXcF2ieyLPvEAyvitGf2ynRM1YuVzMRG7J3molwogZA
         FIaA==
X-Gm-Message-State: AElRT7EdQFEJYgGdSCG51gZCQnDeX41y5dLpnZa2PfnxWsb0ZIL0alNf
        HyslI7FTQl6EQgeWIU65Ix8=
X-Google-Smtp-Source: AG47ELsU0iaEFBHwhoa5gfo0jXVWxd0k7TU7IhmL4LwaozB/p2dxHOe6q5s0kh2sd2htqtswaJF0OA==
X-Received: by 10.223.171.13 with SMTP id q13mr433158wrc.183.1520944565671;
        Tue, 13 Mar 2018 05:36:05 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o204sm169388wma.1.2018.03.13.05.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 05:36:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Daniel Jacques <dnj@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Why don't we symlink libexec/git-core/* to bin/git?
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <871sguorb5.fsf@evledraar.gmail.com> <CAD1RUU_EuLSo5fPjZe7v3882Tkx2Dymxn619smS-wuoejKyG+w@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAD1RUU_EuLSo5fPjZe7v3882Tkx2Dymxn619smS-wuoejKyG+w@mail.gmail.com>
Date:   Tue, 13 Mar 2018 13:36:03 +0100
Message-ID: <87y3iwp2z0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 08 2018, Daniel Jacques jotted:

>> It would be great to have this rebooted now that my perl cleanup efforts
>> have un-blocked this. Will be happy to help review & test the next
>> iteration.
>
> Yes, I was just thinking the same thing. I wanted to make sure the Perl
> changes had landed, and I'm pleased to see that they have. I should have
> time in the next few days to rebase and put up a new version of the patch
> series. I'll keep you in the loop, and thanks for pinging!

Related to this, I came across this bug report
https://gitlab.com/gitlab-org/omnibus-gitlab/issues/3265 which is
wondering why we're installing N copies of the git binary, presumably
they're building with NO_INSTALL_HARDLINKS.

Just doing this:

    diff --git a/Makefile b/Makefile
    index de4b8f0c02..2222319a4f 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -2596,7 +2596,7 @@ endif
              for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
                    $(RM) "$$execdir/$$p" && \
                    test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
    -               ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
    +               ln -s "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
                    cp "$$bindir/$$p" "$$execdir/$$p" || exit; \
              done; \
            } && \

Seems to work for me, although obviously this would need to be optional,
and it'll get in the way of Daniel's patch since it use the absolute
path.

But is there any reason anyone can think of for why we shouldn't be
figuring out the relative path and symlinking the two?
