Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90A61F453
	for <e@80x24.org>; Wed, 31 Oct 2018 06:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeJaPEw (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 11:04:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42672 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeJaPEv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 11:04:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so15069203wru.9
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 23:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2AAdjEqifQVlvC8MTvLxmAvEPlf6rSmwbVO0AkJnpg0=;
        b=lCwErQ1/5c1YFUfvPlyFRzSWdRCp6kq567e53Wv+7QVknasA8saxaSYf/Gtl5Inm0v
         NORSNPQr8oVOKum1a3zO3WlTjQzA9bkUo78Q4ZoI5daVpfv5t89HlOxXMlr7R5JRJ226
         OibZt9O4YFCqvEePHy1m8lVTDG1Ey3tmM5XG999SD4dnXWOtxYaZX5r9he3Q2cjUzOPQ
         DawTHtHxiZxY2elrFUCZVQCH3BcjGHb9SH9QmyfHBbHYoLbHr0VC4vHcnFNo1riiS92t
         BkbUA20pqsMFVDrBDKR07UJcLuKNGUlbBrMrybTPbw2gcR4IPGcf/130lIONquTE3JIp
         6iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2AAdjEqifQVlvC8MTvLxmAvEPlf6rSmwbVO0AkJnpg0=;
        b=bVcKoHNKJKYJJakf3VpszCp7Mco2TN9WCsOtxtJ42VLHP4IibxAv3T1RBPkyEkrb1f
         gSj3OTsJOTz4+bWwObg6gaXlukxDNeZfUMXPLka+yaqdjPL864fbEt2O7jbBni6IfP/V
         WxAvuYmeW16VwzoDJbmEicyFDecf9kMRWt4wd+0aKzMSAv9hRkm6H1SgyFk7H3JWta9J
         n9NPP1Zxd74aRJ7w9nHCI6+LLnT6qYtz7Ms07fXbjI6GsagawamgRnUwDgBe2zymPkb9
         FZ/CBFF0iZRqwulcBBx87QYZYeavrCZ5c8HkJjMtwSIPFm5ovqvXWCsBttRVJyle8Wfk
         XuGg==
X-Gm-Message-State: AGRZ1gJVDFSv4o6opux7npaz1QYS/G+2kn7kIPYQmHSkj8AxLYmhMsCV
        6P8Px2dWj4ECdYG+PIOvA38=
X-Google-Smtp-Source: AJdET5cg5luvL4M6a2EA2eL6r1HDbXe4vC3533ls7tFV1EfclxEL32BEIKDa+AjnE+4PWicM64LYfQ==
X-Received: by 2002:a5d:438e:: with SMTP id i14-v6mr1492222wrq.156.1540966089619;
        Tue, 30 Oct 2018 23:08:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x8-v6sm65650422wrd.54.2018.10.30.23.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 23:08:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Webster <chris@webstech.net>
Cc:     johannes.schindelin@gmx.de, gitgitgadget@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Use correct /dev/null for UNIX and Windows
References: <pull.59.git.gitgitgadget@gmail.com>
        <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com>
        <xmqqsh0mwwah.fsf@gitster-ct.c.googlers.com>
        <CAGT1KpWoGD0xgTrC-+X1WqY_M=2arYbs4ZX6Nnj-zHK6mgu+nw@mail.gmail.com>
        <CAGT1KpWC_+=u7fCzQJsU8d_gSQzE5rsx46cTXogvaRPHZ1iiHw@mail.gmail.com>
Date:   Wed, 31 Oct 2018 15:08:08 +0900
In-Reply-To: <CAGT1KpWC_+=u7fCzQJsU8d_gSQzE5rsx46cTXogvaRPHZ1iiHw@mail.gmail.com>
        (Chris Webster's message of "Tue, 30 Oct 2018 22:41:15 -0700")
Message-ID: <xmqqbm7awsvr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Webster <chris@webstech.net> writes:

>>> > Use File::Spec->devnull() for output redirection to avoid messages
>>> > when Windows version of Perl is first in path.  The message 'The
>>>
>>> Dscho, "Windows version of Perl is first in path" somehow feels
>>> contradicting with what one of the topics I saw from you were trying
>>> to enforce (or, at least, "set as the supported configuration").
>>>
>>> I am guessing that the Perl you are building and shipping with Git
>>> for Windows would yield what the shell that ends up running the
>>> scriptlet `git config --get-color $key` prefers when asked for
>>> File::Spec->devnull(), and nothing will break with this patch even
>>> if that is "/dev/null", but I thought I'd double check.
>>>
>>> Thanks.
>>>
> This problem originally showed up in the
> https://github.com/so-fancy/diff-so-fancy project, which has a copy of
> DiffHighlight.pm.   That project allows diffsofancy (perl) to be run
> from the command line without requiring the bash environment ((well ,
> sort of) including the associated perl).

Thanks for additional comments.  

In any case, Windows is not my bailiwick, so I'll hope that the
above comments from you would help Dscho in his response and wait.
I know use of File::Spec->devnull() won't hurt POSIX folks so making
sure this won't break Git for Windows is the primary thing I woudl
worry about this patch.

