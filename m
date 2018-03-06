Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923F81F404
	for <e@80x24.org>; Tue,  6 Mar 2018 23:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeCFXYJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 18:24:09 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36887 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754035AbeCFXYI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 18:24:08 -0500
Received: by mail-wm0-f49.google.com with SMTP id 139so1312362wmn.2
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 15:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jtTdIoJ8bJ7WIVWw9/r+P+CVXiwb5lNK5UyKLzBWkuo=;
        b=GIAARiwzJsntfIR1107WOC+b5/qUx3A4yix82EimdpDVJie5u0KVZnIe5OxR+fRvsd
         DlF4zk4/6W/ql7MkmotkJ1z4/EP2vsvv/77Ey3mpVN/uE72XCgbtuCC3/m9aekh0hi+C
         vyBHVnBPCb+aWdHqWIGnQqZNCRN0lwkP3DK4m1Wv7Ts06LbrhIoWZ6yN+cAo8V8L+XIT
         KjFbl6K85QegTk1Xj9r6ZWG+YuByPcSNxYg3c/gipDxKuwaw7d96BQkSNzZyepFobFim
         ESer/fqyiphztm7nBrOlkVNALSFhgQnnn3vYba91iTW9rhfZUXgpUVubjmqmDGMK2C+l
         ugoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jtTdIoJ8bJ7WIVWw9/r+P+CVXiwb5lNK5UyKLzBWkuo=;
        b=OKURybV++HrobijlgRyeU+ohGXpyk/5ZMO+w4QvNCu7F9jTozWy6/jf+xj06KqiiUh
         rhTuCn/E7xiciXs4zpmHfqCmQ4O1WgN9WfpdjY6AV9weAHDW7lCz0spWSNSSu4IPELKf
         KFeiCf/NSXeEn9Cz+oUT/es5ud+0V0PeYhZpHAN5IykvEkBsajUkx2deBB6EKlj+Iniy
         u2XTs8n3pjPqn71k7jrlNRHS63iYalR+RRvlCz0IeFuk69qQTQOJ4NriQr3n4wn4yd92
         lgRF11YqR6svy3M8Cl5hIzyCq0vZLsr2Bq8BlCj0eoKPc5cCgHroudkeM50opgR1S7cA
         ySYQ==
X-Gm-Message-State: AElRT7HHhNFIt+5hnC91GUL7aVe5NL0li5rVi+1N/sng5fRTf6nIppvP
        J++95gyvuXtdf830hetCaao=
X-Google-Smtp-Source: AG47ELvOgeNfLikCHaChBHB7e2SohBCQqEZBuCSAq1g5VCqYYFyRA4WRLfb16vg3xGuxaI9QonJ+xA==
X-Received: by 10.28.175.139 with SMTP id y133mr11904085wme.98.1520378646575;
        Tue, 06 Mar 2018 15:24:06 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v63sm46166547wrc.69.2018.03.06.15.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 15:24:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
        <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 06 Mar 2018 15:24:05 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 6 Mar 2018 19:12:16 +0100
        (STD)")
Message-ID: <xmqqzi3k23fu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I don't think its possible to guess the semantics of the original merge
>> as users can use custom merge strategies and amend the result. It would
>> be possible to detect and unamended '-s ours' merge but special casing
>> that may end up causing users more confusion rather than helping them.
>
> FWIW I agree.

I think it is a mistake to sacrifice predictability only to add
cleverness that sometimes work.  Elsewhere in the thread, I think I
saw an argument to treat interactive and non-interactive something
very different, but there is no fundamental difference between them
(it is far easier with interactive to force the command to "port"
each change to a vastly different context) so having consistent
behaviour between the two cases is important, too.

>
> My original plan was to always merge recursively and suggest to use `exec`
> commands if anything else is needed.
>
> But now with that excellent new idea to perform successive three-way
> merges of the original merge commit with the new tips, using the old tips
> as merge base, I am considering to change that.

OK, does this mean we want to wait before merging the "recreate
merge" topic down to 'next'?  For more than a few weeks, it has been
slated for 'next'.

