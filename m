Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E091FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 20:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbdBGUyN (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 15:54:13 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33745 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932365AbdBGUyL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 15:54:11 -0500
Received: by mail-pg0-f66.google.com with SMTP id 194so13034545pgd.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 12:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5Bhz053GkdknIlD3RKFHLhfJUOSIzf+Vf+r5dDTHFTo=;
        b=Xj6J9tOP4Zc7qbh5v4Jv5QRqLuJ0QENd+AJOzsvh7IRGa1drnHIBjxI5I8Im9VfKP9
         VOOM6BsxFo+MiAGm7B3VPTUPUKAC92CXSqTaebyshazM9dBjrdbtPj5fsWor7SSCAhNn
         wiIHQwDNNzrvbfX0rwXIIU4s36r1QLbizszMiqurqQk4xVSOoqJaZQkvw8BwC7EByTVR
         owFbnAtxJTVbD9uxYql8+CbxTx6qysGc1JL7NmsxYiav1gyetuaCaJFx2cKxMba2rB76
         MACfDnyLuyKgto1Gmx9KzI8zOok3urqoGoWczV3rLLvzB78eq/ozTgZ9SUa4x2y+10UO
         lw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5Bhz053GkdknIlD3RKFHLhfJUOSIzf+Vf+r5dDTHFTo=;
        b=WHxBDj8LfYnuKdHZC8bpdXG0HF/4fV4UDRpZumjjvZDZ6jOnLIKN22ITdiRrkrqe2O
         fTcah6r4S6bRtr48QAzT2Y6ED1t1DmcB0GUtYfZ7SEhEA9QcjYROEkpvnT2RmGh8AzEt
         4xquRbSbCzlbb+jTB90zE0Tuv1nR7zRL5WkZyM5fVXZt3iWHync5sHpjvnbUurwR0TiW
         Ipr0r1imtlaY37JFRQ2S0VFFik+c1wYiVddSIox9GIOx9Gfk+0kea7RqCKn/QlUVfVD/
         OrIvqMhKJj8ThZWviBLa6MagUfrdG9YFicDaw/kxA84Hat3N0sXOXD8qmU87SpryPQew
         /KBw==
X-Gm-Message-State: AIkVDXLMkRw6YNtSvYcbYgqh/eNCYrNovs+yEagBOjJi79cOwBxJK2QFBZgySviAPzz1tQ==
X-Received: by 10.98.5.2 with SMTP id 2mr22276069pff.77.1486500851238;
        Tue, 07 Feb 2017 12:54:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:1564:f4f3:f1b4:c9b2])
        by smtp.gmail.com with ESMTPSA id w125sm13853131pgb.11.2017.02.07.12.54.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 12:54:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shawn Pearce <spearce@spearce.org>,
        Stefan Saasen <ssaasen@atlassian.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git clonebundles
References: <CADoxLGPFgF7W4XJzt0X+xFJDoN6RmfFGx_96MO9GPSSOjDK0EQ@mail.gmail.com>
        <CAJo=hJsS6FmL9iNScaXqkWJumALfGr8Od5QkbfZ+ZG3osxkp7Q@mail.gmail.com>
        <CAP8UFD2ffeHr0-z3xPFFODqRTTgVnrrWcYRbASpUOrp0QGnp6g@mail.gmail.com>
        <xmqq4m070xua.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702071303370.3496@virtualbox>
Date:   Tue, 07 Feb 2017 12:54:09 -0800
In-Reply-To: <alpine.DEB.2.20.1702071303370.3496@virtualbox> (Johannes
        Schindelin's message of "Tue, 7 Feb 2017 13:04:50 +0100 (CET)")
Message-ID: <xmqqzihxyb66.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If people think it might be useful to have it around to experiment, I
>> can resurrect and keep that in 'pu' (or rather 'jch'), as long as it
>> does not overlap and conflict with other topics in flight.  Let me try
>> that in today's integration cycle.
>
> I would like to remind you of my suggestion to make this more publicly
> visible and substantially easier to play with, by adding it as an
> experimental feature (possibly guarded via an explicit opt-in config
> setting).

I do not understand why you want to give this topic undue prominence
ovver any other random topic that cook in 'pu' and later merged down
to 'next' and then 'master' only after they turn out to be useful
(or at least harmless).

If there were somebody who is the champion of that topic, advocating
that any clone-bundle solution must be based on this topic, it would
be different.  Even though I am not opposed to the topic myself, I
am not that somebody.  That is why I kept it around to wait to see
if somebody finds it potentially useful and then discarded it after
seeing no such person stepped up.

That champion of the topic would spend the necessaly engineering
effort to document it as experimental, to make sure that there is a
reasonable upgrade/transition route if the "v3" format turns out to
be not very useful, etc. by rerolling the patches or following-up on
them to advance it from 'pu' down to 'next' and to 'master' just
like any other topic.

Judging from the tone of his message (i.e. "unfortunately" in it),
Christian may want to be one, or somebody else may want to be one.
