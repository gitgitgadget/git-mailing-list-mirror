Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9171F453
	for <e@80x24.org>; Fri,  9 Nov 2018 16:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeKJBuJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 20:50:09 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41125 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeKJBuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 20:50:09 -0500
Received: by mail-io1-f68.google.com with SMTP id a5-v6so1611438ioq.8
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 08:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TTQSW0fHboqD/SQjXRmqSlH1notXdmYt8QjL4Tb3+zc=;
        b=qz7ApiQz4JnWXn6sDQ/vhgiDB/aVVpUy+awnUQHtiaCKoNoZQrKgz7UTel9ESSK6Q+
         mT8fICNxOkOH/VT1F0mrLmf+fkuBTbs3J+7EN6NRbusYN0kT4XitfN7jodrdNifLyvHH
         FpuPxZ5JEVWjCIcTRPuZRHWkhuAbQikYrCe3fAlv3JJNQ0smjrFigF1uySEseLvzIzd7
         URpM4onsN0iyUHhqOr8CIAAVCWyO/FB1FSExCkwAURNMp5BVsAXp+grKfZmvzvwZ7zkK
         VsYwln/sukR8aSil8S4vbPn1nupB5WtQES2hiCBCvUjAJCQmnXlz1usYh9MAdqPtzUTC
         ewmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TTQSW0fHboqD/SQjXRmqSlH1notXdmYt8QjL4Tb3+zc=;
        b=kE+hPhxe82vOk+0QwZ9BIpjhGvxX72duBlgULyM2vdTGBLj5INnqUc7NDmkF9hXQTt
         mHgQr+MggNbniQKfTUV13+NMYmXdGTKXnMGqLHlRLfFwqD4U3HETRMW1iGkQ2RTe4HQA
         rMiARsNaF2uWscKmzs/5DmU9UX7Igr6zLUwc6cN8s97r5w2Pln+df94em8QInzjl4uaj
         8o/5Nf7wZqI6YjB/L1zcia/prmcASM44xtMBdk+jnWU44drmOzZWDWxH07HcBqxwivr+
         g2aCB4P8A93eaI4FpwKfX+a7Nb0kwMlAgFdY4aakOgjsInxvIxOW9eJ/XWYz7q+rFfRa
         R9gA==
X-Gm-Message-State: AGRZ1gJbRZIbGaFoJ9JB39Ui1IPyWGsEoTrWYOB52gJlH5IVYzIBWW8p
        gAg2L3le8OFxS3osen24qWtSjLHlsD7jEz7pK+vfIw==
X-Google-Smtp-Source: AJdET5eVq1uXiwi11ulLjCClqiytz6EStHpBmzFdjQDW5/BhOWlWu4ZiX9RGNG5Y/TwZfauVUz1LeO8yYht5JnlqrI4=
X-Received: by 2002:a6b:6f0e:: with SMTP id k14-v6mr3514087ioc.236.1541779736420;
 Fri, 09 Nov 2018 08:08:56 -0800 (PST)
MIME-Version: 1.0
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com> <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com> <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com> <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com> <20181029232738.GC24557@sigill.intra.peff.net>
 <20181107225524.GA119693@amazon.com> <87d0re5pt3.fsf@evledraar.booking.com>
In-Reply-To: <87d0re5pt3.fsf@evledraar.booking.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Nov 2018 17:08:27 +0100
Message-ID: <CACsJy8BvD6eSaxu1KyXawMcBCQGMQ5DywQpsycTTjKusioZZuQ@mail.gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     gerardu@amazon.com, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 9, 2018 at 2:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> I'm planning to re-submit mine with some minor changes after the great
> Documentation/config* move lands.
>
> As noted in
> https://public-inbox.org/git/87bm7clf4o.fsf@evledraar.gmail.com/ and
> https://public-inbox.org/git/87h8gq5zmc.fsf@evledraar.gmail.com/ I think
> it's regardless of Jeff's optimization is. O(nothing) is always faster
> than O(something), particularly (as explained in that E-Mail) on NFS.

Is it really worth adding more code to maintain just to shave a couple
seconds (or a few percent clone time)?
--=20
Duy
