Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E8220986
	for <e@80x24.org>; Fri, 21 Oct 2016 11:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbcJULEG (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 07:04:06 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38315 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932247AbcJULEF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 07:04:05 -0400
Received: by mail-it0-f50.google.com with SMTP id 66so152014646itl.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BfcsPrKzbJSD/uYhLVDi9TaT0J/2Sz3RmKQUzWSmNJY=;
        b=W3ug4IJDpasGupJttpUbG61OM+h1IoGbJ9+V5gjmYIc+w2zH64z3UWh7asreSMpFNC
         LWwX55KxYVhumRsBeAkdm+YslULNMR0dYxxFyU0RqZOWtbGqOKVD0f4x1FR76geVeVHq
         ln2eJPkKt0Pbgc99/mpUZsupbuw1FsbJhBxwBD61m2RzFUw1hn6HCRL5eCfwPROi2vRS
         eSYGad+/oHuwVIXJa1HU5MjRmMYeU98/KZzg+WErdWVH1v6anRxKeZsuY4ejHpApt1t1
         sZRdFaH7BtB5yI2mDHQ18Ecq8CMjK2lZ9d42UlIjsP45OGLFPsCGsCLD3Qob70M17nJf
         Y/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BfcsPrKzbJSD/uYhLVDi9TaT0J/2Sz3RmKQUzWSmNJY=;
        b=eR/xSoQj7oeYTdzMBhtPTs9cWjVTWbH2DLpi+Gh1wB3wJXGL7YlVUnI/OnFN0ls9ii
         A+p5QNFX3mFvjRg7bAtyC+17hgRLWds7vAWd3X3SFBGhoLvWiR8+6z/Q4gNzJS6GvvhB
         tLFf2PgvE4dPy3MttDRO1J1WgpCPRZ+kUIBv163Ws/pNeov0j1NpO8D2gt7RbpsE4EWD
         b7Cs+byl4lp2WO7ZUvvt5Uy5KOoeHdCh4BiYTOFvIs7RoF0LVSOHmpI9Jko8ys8G8Axu
         fORJblNaKsCDofpabKr7zmui8zuCA7iZvk8loiJjp/FKk98E6cCX7dyoJFsgMnRIMB7X
         S8OQ==
X-Gm-Message-State: ABUngvd2YA2FtySbyrimrk3QuE4XE6Ue7Z/Wk9HjH5NBaJ4j6VUrYQWu7omCsTnVF6N4Y01ogdYmrzm1S0jg7Q==
X-Received: by 10.107.59.6 with SMTP id i6mr289510ioa.176.1477047843757; Fri,
 21 Oct 2016 04:04:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Fri, 21 Oct 2016 04:03:32 -0700 (PDT)
In-Reply-To: <1476996017.28685.10.camel@kaarsemaker.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610201154070.3264@virtualbox>
 <20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net> <1476996017.28685.10.camel@kaarsemaker.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Oct 2016 18:03:32 +0700
Message-ID: <CACsJy8DDO_k-gtSj-Nbc9=DvTC1FFQRmc=OtTmh-c4rc=xC_+w@mail.gmail.com>
Subject: Re: Drastic jump in the time required for the test suite
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 3:40 AM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On Thu, 2016-10-20 at 08:31 -0400, Jeff King wrote:
>
>> I'm also not entirely convinced that the test suite being a shell script
>> is the main culprit for its slowness. We run git a lot of times, and
>> that's inherent in testing it. I ran the whole test suite under
>> "strace -f -e execve". There are ~335K execs. Here's the breakdown of
>> the top ones:
>
> You're measuring execve's, but fork (well, fork emulation. There's no
> actual fork) is also expensive on windows iirc, so subshells add a lot
> to this cost.

shells fork on piping as well, and redirection and some other
construct if I remember correctly (I attempted to port busybox ash to
windows and had to find and "fix" all the forks)

> That said, strace -eclone says that a 'make test' forks
> ~408k times, and while this is significantly more than the amount of
> execs in your example, this does include cvs and svn tests and it's
> still in the same ballpark.
-- 
Duy
