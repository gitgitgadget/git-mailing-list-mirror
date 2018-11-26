Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162CF1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 15:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeK0Cch (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 21:32:37 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:44652 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeK0Cch (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 21:32:37 -0500
Received: by mail-io1-f49.google.com with SMTP id r200so14244093iod.11
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 07:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nlv1iq+HkAGFMYaUJWSlzwb81wW6La86VrcqBlUuZfk=;
        b=vH4GuFiXlZPafN4bcWzRlnn/rz4gR1gp4SgUjkGsvNci/C1ZzJs+N3xhzj+VH0s9fD
         efNCRZhZFeewYEqfrgaX1rT7IbnqM9UaNR/rGdJ1OSNBw2Cj3W2P2SVFPkq39mahlO5U
         tvNEvd6a9yO5GixwZ8Jy0SWn3l2Ngthtpe+QRCTfmf8nwqJzjVwCaqbmlZ8OmCPZADWW
         pItom9nwaLQDCfBZxtcWrMbKbmZ2Ho7n49JfwuBzEm8Mu1bmjmut+GYFUAUd4CRHfoCT
         dJOez7mcqyjskPdw+Odkv8doR9LIDsFP3JJ4n4NaBr9RLLYxz0VVLUx5V8lzJ+FU0nC/
         HIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nlv1iq+HkAGFMYaUJWSlzwb81wW6La86VrcqBlUuZfk=;
        b=uMXGpKuTACbhz/9xrIDIzljsZDZxsUwNdb9se0Zv2TpkNVPKRKLw1G7yB+nbJ326GO
         pY7MBnFhRuPJIdlhEDNMqt5LeabV4butluFeLK5568tlAJrwWlj4FiNqTAnENjZt0yeD
         PZP0ghG/6XN7gGj8ZDED4gyKVpforGzkQCtRDm/+cFeBuFXtQeKqLsa87Omhv4mgwD9v
         XxfgeWGX5aHb8lB95urA1lpPhRhZclsc2wxjVk8JialR0jPBRiBJh3MNwmF+g63suUbX
         Cg2Gph6U6USSpWgNEPZNdj36C/N4TCf49MMO1VA59NAZ3iReM/hGUSCUq7lsrgYmht7Y
         DrPQ==
X-Gm-Message-State: AA+aEWaoigxxXrMDGXhJ4jX8Ry1lupgSXkLNBDJkVaYwweQMMcYhBjW3
        FPYXh7tTUUcOFEZ51ICICtmhDy0S+EMvUIthIq16Vg==
X-Google-Smtp-Source: AFSGD/Xa9RnxyqJiX1RX6iH00fudlnAkzIv8nnIhiBb2WNqjKElZck1qzFjZlvtYju7VZKLoI/KMhXRlaHBQQXJedi4=
X-Received: by 2002:a5d:9455:: with SMTP id x21mr3832307ior.282.1543246688540;
 Mon, 26 Nov 2018 07:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20181110133525.17538-1-pclouds@gmail.com> <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
 <8736rx1ah9.fsf@evledraar.gmail.com> <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
 <20181120174554.GA29910@duynguyen.home> <20181125222021.GL4883@hank.intra.tgummerer.com>
 <xmqq1s781qx8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s781qx8.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Nov 2018 16:37:41 +0100
Message-ID: <CACsJy8Dn2xWWkivxT1VYQak8sHwvFEHrz5VALeajfTs2feuNtw@mail.gmail.com>
Subject: Re: [RFC] Introduce two new commands, switch-branch and restore-paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 4:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > I like the idea of splitting those commands up, in fact it is
> > something I've been considering working on myself.  I do think we
> > should consider if we want to change the behaviour of those new
> > commands in any way compared to 'git checkout', since we're starting
> > with a clean slate.

Better defaults? Hell yes!

> > One thing in particular that I have in mind is something I'm currently
> > working on, namely adding a --index flag to 'git checkout', which
> > would make 'git checkout' work in non-overlay mode (for more
> > discussion on that see also [*1*].
>
> Ah, thanks for reminding me of that.  That explains why I felt
> uneasy to see "restore" in the proposed command name.

About that name. I didn't want to start the command name with checkout
to avoid completion conflict (the obvious choice was checkout-path,
the function name behind it). And I didn't find any other good name,
so I picked "restore" out of git-checkout.txt's one-line description.
If we end up with a better command name, perhaps reword that line too.
-- 
Duy
