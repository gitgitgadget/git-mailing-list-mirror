Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAD401F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 01:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeKULfP (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 06:35:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37623 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKULfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 06:35:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so2863828plr.4
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 17:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DNkTMxIFb/oraD3WXd7+cRmAmxo7mVgIFa3M3FER5hQ=;
        b=E8OfiQEjUszslGpDARURfi2NLX4TYBVr7wzA9vqUOJ3ohtncGhe/vS808DXDWSiSP9
         /9Vodqgk2MAnmKcm6f3z7ZYLx2ENnezO/147ei18Z18Bd5tk7BjFR8MSP2/GOI1gTtRW
         8nwqDdxrHrY/32D2wj49FL1mMSSVn1qO20Ojek+luXzj2CVXX2EOS5UBsAsT3eQKJQi+
         jj+hwbxp0kF8eYEhI0syydMcqJvWogxfaADMPEJkFZbauSUeeU0gZpc9GQHkuspj5lhO
         k3ivm1unEMEIcAz71o+9GDj0RWVjXdJwwyzEdRlU/NteclygGQmZJPFLkkmFkLd73ktA
         BAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DNkTMxIFb/oraD3WXd7+cRmAmxo7mVgIFa3M3FER5hQ=;
        b=d0tOzcnEb1DoYOZOlx4FCrfyUrfVVWdPxVM/OaFvuJYKShwSxYn8JM9lR+WvJCCWZM
         Acqy43iTese6NCJ1wYkKTyiG00nH+vry/Hjseut9twDnjYBC++e7z6kLLR6oU801C8qi
         UiQcZhGHlXbWBQsg60RbjhjRrfjpWxKQFmAiBoPdsZwgVgCeRgMw7IA1KjdwBV/pMrma
         upVQwG+xz1uxcK7s4VZYDK9EvizTFSg/lswEHaeoG/u6xUbaKWVbo6JhMaS9XTOV6xtL
         UfWNq8jA6ou9t9dvZkBC6Gw4sbBlmHfRJaI9vIaybXSUHczeNEW3BcqpvihozySRA8A8
         Mx0w==
X-Gm-Message-State: AA+aEWaSp7TZMtOqS3/2YTqeHdsQN93IT0U7ROP7U0WlR+dMsvoTTWc5
        vP2AYtur+tA1yo3YF8fBf6A=
X-Google-Smtp-Source: AFSGD/WF+lBx+++y6XjEpNG6hCaHyMm1LQ8vVBMZg9/d4wtuZoJ93hmgHgTfNRBwrQo6vI//YzWC2g==
X-Received: by 2002:a17:902:4281:: with SMTP id h1-v6mr4614150pld.114.1542762192264;
        Tue, 20 Nov 2018 17:03:12 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id j197sm62927568pgc.76.2018.11.20.17.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 17:03:11 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:03:09 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com
Subject: Re: [PATCH 5/5] index: offer advice for unknown index extensions
Message-ID: <20181121010309.GE149929@google.com>
References: <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
 <20181120061544.GF144753@google.com>
 <87sgzwyu94.fsf@evledraar.gmail.com>
 <cabd2e37-7389-ac74-6626-629eab7da53f@gmail.com>
 <xmqqefbf9t4j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefbf9t4j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

>              This series has a strong smell of pushing back by the
> toolsmiths who refuse to promptly upgrade to help their users, and
> that is why I do not feel entirely happy with this series.

Last reply, I promise. :)

This sentence might have the key to the misunderstanding.  Let me say
a little more about where this showed up in the internal deployment
here, to clarify things a little.

At Google we deploy snapshots of the "next" branch approximately
weekly so that we can find problems early before they affect a
published release.  We rely on the ability to roll back quickly when a
problem is discovered, and we might care more about compatibility than
some others because of that.

A popular tool within Google has a bundled copy of Git (also a
snapshot of the "next" branch, but from a few weeks prior) and when we
deployed Git with the EOIE and IEOT extensions, users of that tool
very quickly reported the mysterious message.

That said, the maintainers of that tool did not complain at all, so
hopefully I can allay your worries about toolsmiths pushing back.
Once the problem reached my attention (a few days later than I would
have liked it to), the Git team at Google knew that we could not roll
back and were certainly alarmed about what that means about our
ability to cope with other problems should we need to.  But we were
able to quickly update that popular tool --- no issue.

Instead, we ran into a number of other users running into the same
problem, when sharing repositories between machines using sshfs, etc.
That, plus the aforementioned inability to roll back Git if we need
to, meant that this was a serious issue so we quickly addressed it in
the internal installation.

In general, we haven't had much trouble getting people to use Git
2.19.1 or newer.  So the problem here does not have to do with users
being slow to upgrade.

Instead, it's simply that upgrading Git should not cause the older,
widely deployed version of Git to complain about the repositories it
acts on.  That's a recipe for difficult debugging situations, it can
lead to people upgrading less quickly and reporting bugs later, and
all in all it's a bad situation to be in.  I've used tools like
Subversion that would upgrade repositories so they are unusable by the
previous version and experienced all of these problems.

So I consider it important *to Git upstream* to handle this well in
the Git 2.20 release.  We can flip the default soon after, even as
soon as 2.21.

Moreover, I am not the only one who ran into this --- e.g. from [1],
2018-10-19:

  17:10 <peff> jrnieder: Yes, I noticed that annoyance myself. ;)
  17:11 <newren> Yeah, I saw that message a few times and was slightly
                 annoyed as well.

Now, a meta point.  Throughout this discussion, I have been hoping for
some acknowledgement of the problem --- e.g. an "I am sympathetic to
what you are trying to do, but <X>".  I wasn't able to find that, and
that is part of what contributed to the feeling of not being heard.

Thanks for your patient explanations, and hope that helps,
Jonathan

[1] https://colabti.org/irclogger/irclogger_log/git-devel?date=2018-10-19#l114
