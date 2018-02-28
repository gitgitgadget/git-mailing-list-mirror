Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764BC1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933088AbeB1TJe (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:09:34 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:50537 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeB1TJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:09:32 -0500
Received: by mail-wm0-f44.google.com with SMTP id w128so7160897wmw.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K7jWLb8S99V56uaNukpIRuXB9RqbjYGu2oxHjMNZVuQ=;
        b=XkEwLY1uBEeDG+lCB5sIh3iBHASlqCSOSrceq6QsisQEH2kxPveOOkPvssV4ziKpRJ
         DuuwufOBHvJCl3xH73u8k9HWNixVk/QN2t5ldC2FczzdaeatP0DiVrxNz/RwQFBr0d+l
         LWno2hsb+ptSA+xsrhIzTdIlwHr/UUZ4oj447+yDtMhjzL7qDQ1JwMcIkmtU5j3l5nAV
         6wRfmIfXJk17uGt92zMEOE2C/FLitJ+B9JAAWScRwLdoqnlRFAU2kL5P/EnEzO0vczLj
         JqZl/sjbLoxUYgkcANJuHlHuHfxL64T0jGiU3p7z1Zy9A/OAmAYa0QscE/FKGYNglgHj
         YYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7jWLb8S99V56uaNukpIRuXB9RqbjYGu2oxHjMNZVuQ=;
        b=IyhO1psvmGxYGApuASFQb0SeZ6Q9eFaMpNOfqHdRjvRkMSNgxQQEc9peVx01/unYvH
         QvZ14KNqJnNaccINpwzc1OA0JrmpqJyPGV0nQ+UdRQu2DC8isA7VTqVnEWmpsdwcq95M
         KvN9Zn6o6dUeiBsI8ZyrkuBrIPwpumEYIM8uSSyz18qvvKnd1VYXGLwmL8CkS5zvTiMV
         In97glUR0hmZLcRm1NMBhkeQrXlut3ja68WvPom2ccKb5a7L9QLARI11LCAkWJFXeGx5
         zPGrNTLuaZEtDEML1jz4yCSAJqYUcl+/wCA27Pwst1LuHSw578NHKeC/ZMzESTQh914L
         EP0Q==
X-Gm-Message-State: APf1xPA9G3PkUS5EjhSlDxa/rA26wvyemJ3zzNGtNG1EMxzn8w00FHPq
        OQ+IjfvkOMnnwitQ7CcQOug=
X-Google-Smtp-Source: AG47ELvwWdwzolqOUWcPSjZ+yjjyxv73ewQr/S9opGEBiVzzvgPlBvJVD9eTgs8NltoL6+eo1Ccyrw==
X-Received: by 10.28.95.139 with SMTP id t133mr15319154wmb.88.1519844971654;
        Wed, 28 Feb 2018 11:09:31 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 188sm2595135wmx.12.2018.02.28.11.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 11:09:30 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
 <CA+P7+xrzxYSE0OyL8uyF+ErwfWFEgcqnHmaciwWkK-76sQ6ktw@mail.gmail.com>
 <8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com> <871sh5ofil.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <c8c2e915-cb55-9881-e54d-2c84ad7e16bb@gmail.com>
Date:   Wed, 28 Feb 2018 20:09:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <871sh5ofil.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 28/02/2018 06:21, Sergey Organov wrote:
> 
> > > > > (3) ---X1---o---o---o---o---o---X2
> > > > >        |\                       |\
> > > > >        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
> > > > >        |             \          |
> > > > >        |              M         |
> > > > >        |             /          |
> > > > >        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
> > > > >
> > > >
> > > > Meh, I hope I`m rushing it now, but for example, if we had decided to
> > > > drop commit A2 during an interactive rebase (so losing A2' from
> > > > diagram above), wouldn`t U2' still introduce those changes back, once
> > > > U1' and U2' are merged, being incorrect/unwanted behavior...? :/
> > >
> > > In that case, the method won't work well at all, so I think we need a
> > > different approach.
> > >
> >
> > Hmm, still rushing it, but what about adding an additional step, 
> > something like this:
> 
> I think it's unneeded, as it should work fine without it, see another
> reply.

Unfortunately, I have a broken test case saying different - it could 
very well be a flawed test, too, but let`s elaborate in that 
other sub-thread[1], indeed.

Regards, Buga

[1] https://public-inbox.org/git/87606hoflx.fsf@javad.com/
