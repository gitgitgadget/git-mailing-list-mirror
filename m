Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52F31FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 10:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeAJKxS (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 05:53:18 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:33772 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbeAJKwx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 05:52:53 -0500
Received: by mail-ot0-f175.google.com with SMTP id x15so13923111ote.0
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 02:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4YyBD4Wu1QJOe7Yx6cdRrQS/gWNekKHUjCYle612uTk=;
        b=lpsE1ZjXHfMGGDq9ZsuJM2DkQv4dYsSIEkzM0IgJXYcA9HXmRnxMF+BkdnUdSFiMll
         Xpbz7WsPhYM4rf25E8E6a0gYYgkWQm/eBTnZZMIPZMiFioXXpJtbnim0llZ1+LjOUv+M
         vNDQT2bqRl9K1p+lJCihB88NtN8VBXI2ST8N7QkSRR8Y6zeFZPqzNQXVKId27qdp2Xw8
         DBCUiLn/0XBts/evHmnAkIudMj8TckUpInMinuM6jy7j2efF9+ofiHtYqJOOEUy5rmb+
         quMsc9Bb0ichPOvEJZA9BCZpJuOGZDf5C7O2072VZoHDe7yaotFtXTDV2RHCSw9NO3JK
         PYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4YyBD4Wu1QJOe7Yx6cdRrQS/gWNekKHUjCYle612uTk=;
        b=mTbvhSlMS4tVrWRNsh4IOL9cVxR0CjGLwrX4rKcvDS/8iUIlW006bYEzwwQlD3Hy+n
         NHJmSHzJ5nkrwsWg8Pr2PRGdfndQGE3rg51FD1NL7/bxBOdxdP/WIDQCGxy9mTmtALm3
         ZwyoskF0Zei/3z3tF3UV+ureO2j1FRT7EZT/owgZNb/1+lhPSCK1Qp/5BHb6C1sR07HD
         UC1CT2Lywn5irgdYilq6zjj4qVMOYZS+rLEpVqKk4Ee/Ha09sB5/3dFxn9QAtZhBDY+Z
         NAZ7/Li6mJ5SIIcQlm7OpRVxG077KXr7YAkudB+VSh01vfgegzNFoB8aiaeLOsiNEGNJ
         t3ig==
X-Gm-Message-State: AKwxytejhBrlKZdd+CDnY3+jINSVqBl4b75G6IZSc3k9A6jFD3EeMZYx
        RGY+m71OI36PehnZ752K7fOTf18cCGEHWSSsQp0=
X-Google-Smtp-Source: ACJfBov+nWntPdYOUVXOqV/qru/fD266YavouNs0hLcPd/mAPMd6K8fqLGDo/wL4OSDuSs/DOY04CmUeG3AxtuU47OU=
X-Received: by 10.157.87.133 with SMTP id q5mr533668oth.106.1515581572836;
 Wed, 10 Jan 2018 02:52:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Wed, 10 Jan 2018 02:52:22 -0800 (PST)
In-Reply-To: <20180110103832.GA4018@dinwoodie.org>
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <20180105221222.28867-1-avarab@gmail.com> <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com>
 <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <CACsJy8CDz57RR+VHpaPb5YMhKG5kUgb9rt5TWKL8n+e7Xart3g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801081319520.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180110090724.GA2893@ash> <20180110103832.GA4018@dinwoodie.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 10 Jan 2018 17:52:22 +0700
Message-ID: <CACsJy8D+OdRxr5MazYUzJXKVCpfC=faWCKTYX+E20kYvg9Pt=Q@mail.gmail.com>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on
 Windows proper
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 5:38 PM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
>> One disadvantage of this though, if this kind of framework does not
>> get popular, then any new test feature must be added at both places
>> but it's a waste of time to support both. So...
>
> I don't follow: if we end up implementing every test twice, as we have
> here, then I agree, but I don't think there's much value in doing that
> except as a proof of concept, as in this immediate discussion.  The
> obvious-to-me way to do this would be following the precedent of the
> core code: gradually migrate things away from shell code to C code.

Not the tests themselves. Test features, like --valgrind, --debug,
--verbose and that kind of stuff. These are handled by test-lib.sh. If
we add support for --new-fancy-thing to test-lib.sh then we need some
more code in test-lib.c as well.
-- 
Duy
