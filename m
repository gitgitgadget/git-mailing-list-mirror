Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C00451F453
	for <e@80x24.org>; Sat,  3 Nov 2018 10:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeKCTbb (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 15:31:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53393 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbeKCTbb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 15:31:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id v24-v6so3958205wmh.3
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ssnZCNKJ4/jMQ7PmpX/rMzbYfvxTMHvTVDGT+9U7qxo=;
        b=r53TCqWZRibDex6bsM1MNYIfVwKtvAmww4C0xU2he3R2PLkLEOxn+1C53nhNg42r1+
         9e2K4HZZcCiDdcjiE5p/9oKyVHsJOuEf9uwsEMXskBbNK6ZKC0J2tboJ8ANSJT8tyybe
         GDtIIEtq2I2yLnJLvOJL7avWS7T8SEqP0YldzjmkYhSrIljpP6UtYj17P/fajD5M7FCp
         +Air+aFV4pu/MLX2ip0VIld+EKmc4PJAMBGCPv50J+jT2OjuASz/kRn4vk8hz1NFEayz
         I4RyrDoicmmSYjQuZDVDdCL/0XKKDMhub5KJvzWmjzb1ZZNzchcMhW8Bg93+6byDftgn
         zSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ssnZCNKJ4/jMQ7PmpX/rMzbYfvxTMHvTVDGT+9U7qxo=;
        b=q677A1fNpmAdKYCX9c9nzGS+BRh8wjeUvk8rxXGsiF6tQSYCC9lakUSS/2CZXkNekI
         tw89KiLy2VAV9Nb10CHOEAe75eMke8eoMAD8Y44kB/3tVW+wRItiQRDo8nuKRDUt0+Cx
         n9oB29gdvj68J7WlUZ13XfYUOTLtBK6mrCCu94s+6kVcHOSK/xEvzmnwfmbIyC3ORng6
         mhQrxVisFKeax2JS/EPec2T8WzdRzp+UDgNKCOj2ck6i4yXqsrbJHWtaREd6gCVx7NPa
         /47Olj409fw4bEwPcg0azJr+CrBN9Dhf+s90zSHpZmAyQvVeDw/q9bgAd0/BLxyh/TGr
         3Umw==
X-Gm-Message-State: AGRZ1gI1NoRiPErqiiLaqzaYO6ZJOoiAdSX1qTCDv9rq7xS4MQ2NjsbM
        bMKGo7/ZfpGBDpRQcPQyouM=
X-Google-Smtp-Source: AJdET5ep2Ktg+uu448J0tY1K8MjOcr3vkvq/M3QcuICoi3hn7e9HF+rxXhFVMJogOrERpVYTKpCCxg==
X-Received: by 2002:a1c:ab54:: with SMTP id u81-v6mr506908wme.45.1541240440053;
        Sat, 03 Nov 2018 03:20:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u9-v6sm24864503wrr.66.2018.11.03.03.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 03:20:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Anmol Mago <anmolmago@gmail.com>, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Subject: Re: [PATCH v2] completion: use builtin completion for format-patch
References: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com>
        <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
        <CACsJy8Ajc0qWw3RLak1PRPXvQzMHjaFuWJ6BPkhiVg=7fQvCnA@mail.gmail.com>
        <xmqqk1lxvaj6.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AowaAW91wGMYbC8aTOB1NoqQN-5NGx=qUCHp0i6zQRDA@mail.gmail.com>
        <xmqqzhuss6dd.fsf@gitster-ct.c.googlers.com>
        <20181103060317.GA5432@duynguyen.home>
        <20181103075918.GA905@archbookpro.localdomain>
        <CACsJy8B4vrtsBu79J2kYNmcNQfRkgetdbi8XOPjm7j1kNDJ6Yg@mail.gmail.com>
Date:   Sat, 03 Nov 2018 19:20:38 +0900
In-Reply-To: <CACsJy8B4vrtsBu79J2kYNmcNQfRkgetdbi8XOPjm7j1kNDJ6Yg@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 3 Nov 2018 09:29:31 +0100")
Message-ID: <xmqqmuqqmphl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> Would it make sense to make send-email's completion helper print these
>> out directly? That way, if someone were to modify send-email in the
>> future, they'd only have to look through one file instead of both
>> send-email and the completions script.
>
> I did think about that and decided not to do it (in fact the first
> revision of this patch did exactly that).
>
> If we have to maintain this list manually, we might as well leave to
> the place that matters: the completion script. I don't think the
> person who updates send-email.perl would be always interested in
> completion support. And the one that is interested usually only looks
> at the completion script. Putting this list in send-email.perl just
> makes it harder to find.

I do not necessarily disagree with the conclusion, but I am not sure
if I agree with the last paragraph.  If the definition used to list
completable options was in the send-email command, it is more likely
that a patch to send-email.perl that would add/modify an option
without making a matching change to the definition in the same file
gets noticed, whether the developer who is doing the feature is or
is not interested in maintaining the completion script working, no?
Similarly, if one notices that an option the command supports that
ought to get completed does not get completed, and gets motivated
enough to try finding where in the completion script other existing
options that do get completed are handled, wouldn't that lead one to
the right solution, i.e. discovery of the definition in the
send-email script?  

Quite honestly, I would expect that our developers and user base are
much more competent than one who

 - wants to add completion of the option Y to the command A, which
   has known-to-be-working completion of the option X, and yet

 - fails to imagine that it could be a possible good first step to
   figure out how the option X is completed, so that a new support
   for the option Y might be able to emulate it.

Now, once we start going in the direction of having both the
implementation of options *and* the definition of the list of
completable options in send-email.perl script, I would agree with
your initial assessment in a message much earlier in the thread.  It
would be very tempting to use the data we feed Getopt::Long as the
source of the list of completable options to reduce the longer-term
maintenance load, which would mean it will involve more work.  And
in order to avoid having to invest more work upfront (which I do not
think is necessarily a bad thing), having the definition in the
completion script might be easier to manage---it is closer to the
status quo, especially the state before you taught parse-options API
to give the list of completable options.

Thanks.
