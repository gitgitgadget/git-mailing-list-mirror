Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1016920372
	for <e@80x24.org>; Thu, 12 Oct 2017 21:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755627AbdJLVFL (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 17:05:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52834 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbdJLVFK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 17:05:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id k4so16649431wmc.1
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RnJYb+1R/4D5/Bz6OE1FK9e8HuvOK761HW6s18abHdo=;
        b=Bq89tCmgsTpt+3xozmWdv2oKIhWH2hr6QrJ6/j3re3ndAAonyZfw0GYSGRkqj9c0aN
         Il4kB1n/3wksAtgZsJ07ixxZX12oEHhQdUM5tBVqC1EW5joLiLG11hil/paaxA56j7W+
         QmIrnE52ZA+RLjDsGNkfxWBr2Khj8PVfMVOORwD3VHPFeQ4CwkIdg0oBU72hUzCjWt2x
         +aHvVr45EnMC/FgqAbk53EvR95VoOFO75njx7xb/zHQ3VVylNLplsmQyrTLCWp0lXwd/
         /E6PTYf5S960NkvmAdl1NmDBcSBEYmNhWpUMekXCVryh0yLdm8e9Qt/xOwXHYyfVmYBK
         sm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RnJYb+1R/4D5/Bz6OE1FK9e8HuvOK761HW6s18abHdo=;
        b=AwSXGB5m70P1TS+WEwXCfUjXrizCp0VAQiTo76wKrfegSy7mT0aaVACP29LYcDSXCB
         0pD6SUhOtNfzvonkoOr6jQZowVeBbUvQE+eS2+42cvv/SsRHDZwFD3Fg0TM51Q65oO5t
         rJIIeOAxPv2rRnKYoGhcpWBPjHU8HNBHI/QY38kelHOtCt2IYUmOtSn+IS7VbKEjCQiu
         yCh8RTNTnDhlbBv/jgVCgGAlBDECjeB0IWFPk0laK07I/Y8b9Knlqyn2yfNQ7RgXrKm1
         MbK1iPtppA5nuh9Ou5swJZzI6cmrHm/z6Cv+OAdwFlSUZIs+1KHrfL6BlvVXZzQPiNIH
         0hHQ==
X-Gm-Message-State: AMCzsaWfVfmiXVHbXn/mIJXvWBxc7hrrrQH09b0WUJTIf6bTcXKekp5Y
        EdVrFyixxfzaiPynQbuU2GA=
X-Google-Smtp-Source: AOwi7QDij4fB2Dmk2knVmGXTK0rR03A+iyJ6zyiAA1lFBNSWZGofaj8mZh92MTCU6s7yvcBSF+SCNg==
X-Received: by 10.80.172.5 with SMTP id v5mr4278744edc.91.1507842308840;
        Thu, 12 Oct 2017 14:05:08 -0700 (PDT)
Received: from evledraar (dhcp-077-250-131-208.chello.nl. [77.250.131.208])
        by smtp.gmail.com with ESMTPSA id q12sm12157266edj.29.2017.10.12.14.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Oct 2017 14:05:07 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1e2kfD-0006Km-1n; Thu, 12 Oct 2017 23:05:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: undefined reference to `pcre_jit_exec'
References: <CAH8yC8mvG3bSpgshHay7B0SSyAafWLrPTtVZRuq2cShn9xQ9JA@mail.gmail.com> <20171012201023.wrfbs7p7lups5glz@sigill.intra.peff.net> <CAH8yC8nHpdA+fX3pcaLRzEYwTCmoxF3NKSh6SUkORZuEvg0JGA@mail.gmail.com> <20171012203832.ui52j7cdrztc6vhs@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.1 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171012203832.ui52j7cdrztc6vhs@sigill.intra.peff.net>
Date:   Thu, 12 Oct 2017 23:05:06 +0200
Message-ID: <874lr46prx.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 12 2017, Jeff King jotted:

> On Thu, Oct 12, 2017 at 04:34:38PM -0400, Jeffrey Walton wrote:
>
>> > It looks like autoconf turns on USE_LIBPCRE1, but isn't smart enough to
>> > test NO_LIBPCRE1_JIT.
>>
>> If Git wants Jit, then I am inclined to configure PCRE to provide it.
>
> It does make things faster. OTOH, we lived for many years without it, so
> certainly it's not the end of the world to build without it.
>
> There are some numbers in the commit message of fbaceaac47 (grep: add
> support for the PCRE v1 JIT API, 2017-05-25).
>
>> A quick question if you happen to know... Does PCRE Jit cause a loss
>> of NX-stacks? If it causes a loss of NX-stacks, then I think I prefer
>> to disable it.
>
> I don't know. Ævar (cc'd) might.

Sorry, no idea. I do see some references to that in sljit (which pcre
JIT uses), but haven't tried this myself. From what I understand of how
NX works it should fail really fast if it doesn't, so it would be cool
if you could try it and report if it works.
