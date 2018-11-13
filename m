Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887FD1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 09:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbeKMTHp (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 14:07:45 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:34711 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeKMTHp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 14:07:45 -0500
Received: by mail-io1-f44.google.com with SMTP id f6so5329166iob.1
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 01:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BJ+axj/7n2uw66s4gN5P973CCcnYdA9D8x9k8yxI6bs=;
        b=MTMVrqudz5iuo0HZfuuD54hP2SPuZKoAsl3DFVQwtBoRO8JMgC7iuBnZoY5c4hxv1q
         KPK4KMgWcwcIRpiQPj5QTLrgxBNTH70rpfk/i2ilVV4hH09PVAtTKLQpdqcmJsH0MYCm
         +Vlba68yO6tOWXBomiDHic0bqk3DEpyRmHi4Ktgba3K7VKLFgx3r/XMh/mUjOLUlmNLL
         PQ04BeRtXDsXSWyGD7cmoiJxdXEZ5CsByXDrEgkaDTyld9uUKCG7qim8PM2NqKGP3S9J
         IvkuHYG8BIcMZxBhfSWHO76fXJpYEDB6yIhqgIDc6uq3j8Hu/HMFjsx6jUfBkhZk0v6u
         XhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BJ+axj/7n2uw66s4gN5P973CCcnYdA9D8x9k8yxI6bs=;
        b=gydGBZuXlhBL3sA7ulvvWzpGh6VLfGzq8jE3r2222fKixV9VOk2rqC4hEAh+TNzdhM
         okPW2TWJkXY696dngXaNofyYaUhtHGKExJ6pe8XP75Wj36JGrY15UbsUBMpaUTjNNqnT
         IiFdPfNTBgV8w1iIA06RSfVFBgpuZEYi5EXwNZ9I0dtqVcjcIotdXZ8cKZ9eUeUNZiGq
         jzDvX5LieWMSX1z54RW82VQ2aA8ACgkQpxM9lcS8HzTq26+0nMBWT2a4J1acKttu8maA
         LEzEWFgCfLGGbpNs6H0z9hcV0+1xAjc4OJKRwUqLEx4ZA8UFEBO7K1EyXpsVCkbq+Gy0
         ZBjA==
X-Gm-Message-State: AGRZ1gLQKgZ5v1QsuBvlUivttS8Gx7KYdEtIU6qkzvuH2wAYUAgDmnFE
        v09JKlxlyd5OcRbdlRjnou+PFdQMrKKr9btwj2Q=
X-Google-Smtp-Source: AJdET5caMkPcxGrZhV6HA7Ajlhq/WVez7XCO+9U53iRUw0BCCQTNUPoNbg1JgH90BDJX79oGAgxdO9dvlDFcsrT27JE=
X-Received: by 2002:a6b:b3c2:: with SMTP id c185-v6mr3404002iof.169.1542100235568;
 Tue, 13 Nov 2018 01:10:35 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7ehi1gpb.fsf@gitster-ct.c.googlers.com> <20181113074017.17292-1-carenas@gmail.com>
 <nycvar.QRO.7.76.6.1811130948420.39@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1811130948420.39@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 13 Nov 2018 01:10:24 -0800
Message-ID: <CAPUEspgqUZ9eKAGug=SGRedR=KBQswpsTZU+0PYHdGsCA4iZLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] read-cache: use time_t instead of unsigned long
To:     Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 12:49 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 12 Nov 2018, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>>
> > if time_t can't represent a valid time keep the indexes for failsafe
>
> Is this sentence incomplete? What are those "indexes"?

the indexes that are created when core.splitIndex =3D true

the code that was modified looks for a configuration parameter (or the
default) that says something like "2 weeks ago" and that then converts
that into a timestamp that can be compared with the modification time
for the files that compose that index and then decides to delete
anyone that is older than the "expiration date".

since time_t is used for the stat.mtime there is a chance that the
timestamp might overflow its size, so if an overflow is detected we
assume the value to be equivalent to "never" and keep the files.

note this scenario will only matter around 2038 and it should be fixed
by then as part of the Year 2038 problem if we still care about 32-bit
UNIX by then, 32-bit Windows has until next century.

Carlo
