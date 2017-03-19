Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2202095B
	for <e@80x24.org>; Sun, 19 Mar 2017 00:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbdCSATr (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 20:19:47 -0400
Received: from lang.hm ([66.167.227.134]:44050 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbdCSATq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 20:19:46 -0400
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v2J0JakI011014;
        Sat, 18 Mar 2017 16:19:36 -0800
Date:   Sat, 18 Mar 2017 17:19:36 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Is there a way to have a local version of a header file?
In-Reply-To: <xmqqy3w2yybt.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.75.62.1703181712100.3797@qynat-yncgbc>
References: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc>        <CACBZZX5FMdjuxxNru+XfTQdSXEQ_b0OP2rngGZLf1sSHR_D8Ng@mail.gmail.com>        <nycvar.QRO.7.75.62.1703180750460.3797@qynat-yncgbc>        <CACBZZX7G=C84kz4n26VTnWWUTKRv1rVvms=8AvELtMSCviu1kQ@mail.gmail.com>
        <xmqqzigi31fl.fsf@gitster.mtv.corp.google.com>        <nycvar.QRO.7.75.62.1703181539310.3797@qynat-yncgbc> <xmqqy3w2yybt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 18 Mar 2017, Junio C Hamano wrote:

> David Lang <david@lang.hm> writes:
>
>>> Ship a config.h.sample file, have a Makefile rule that is forced to
>>> run before any compilation happens that checks if config.h exists
>>> and then created it if missing by copying config.h.sample over, and
>>> then all other source files can include config.h without having to
>>> know anything about config.h.sample's existence.
>>>
>>> Did I miss something?
>>
>> There is no makefile with the arduino IDE/build system :-(
>
> How does "the build system" you want to make it work with actually
> work?  Is it incapable of "compiling" a "source file" into an
> "object file" that happens to be a text using an arbitrary
> "compiler"?

It looks for all *.ino files (which need to contain C code) in the specified 
("project") directory and compiles and links them all into one blob, it adds a 
smidge of code at the beginning to run setup() followed by loop(). It then dumps 
this blob (via serial/USB) into the flash of the device that will run it.

it's a very dumbed down system, designed for non-programmers to do trivial 
things (blink a few LEDs, etc) that's been pushed to far more sophisticated uses 
than it was ever designed for.

David Lang

> I was hoping that readers are imaginative enough to replace Makefile
> with whatever way things are normally built with when reading my
> message, and the reader can just replace "source file" with
> "config.h.sample", "compiler" with "test -f config.h || cat
> config.h.sample >config.h" and "object file" with "config.h".
>
