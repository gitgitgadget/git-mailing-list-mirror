Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF721FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 07:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933912AbcLUH4H (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 02:56:07 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34732 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933416AbcLUH4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 02:56:06 -0500
Received: by mail-yw0-f179.google.com with SMTP id t125so95518142ywc.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 23:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tateT6TqUZD1UfKHe+p67vKCGr/2flI5a/ulGcl0+DY=;
        b=GruhG4CSq5uai1g9SccWNj1WrJECLtWu1zIyMwvGsBgmruQeLG2NPxoZ3AvMaaaSLV
         fabkPmeOZDboBJg3PFOyJK8tKL4/mfjHMIoK9GukN51h/CBoqoMZgRi5ZHJFzItc6yL1
         TYwDZIXDjw8h1A+yLhxU4IJehT9WU+ryd3HotPYPxYGGpWyqoMAq1DtuBWJIMptdOt1M
         DuBs4dKZ1Lr7qr5gZqtf5REya4Qq6FVmfIZtE+q1RnZQ2bDoU3l/IrMXHEWlU0rc8OL8
         yvruCbabQf9Vnn9iZ1uupZe+Yt70X610p1gfqFFHD034sR40hbSdv5VnX3nHal0tStnx
         OKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tateT6TqUZD1UfKHe+p67vKCGr/2flI5a/ulGcl0+DY=;
        b=eEFPsj4FjmBcOfpuOjpBBjen6iZ0/kZdb+QMViZgAReI3jpsLxHar/jNUL52S7iKNm
         imcNdEQvqXXKloNeXCcojdAE617B7ClYVW/Fn+aOyFXkXY5+mwQBpvRCKGQwyPeFyI2Y
         kHSrsFsy6iQmCIcvUBvJHt7xMSccyBrawwaOwn7NFaZWGKP+WbFfvHoo5Gmwf5UF3bqU
         oqvKijlVR0PqAW48DYJrFcncYzMyt+yaTgyB5Lz/rxkVd6XebBWtLylQRvfVmelRUANZ
         yEzCL1vSyn7MPQHpJtFjsBEcEe7w25uoVRGXwU9TQHvz0LxXik0utSNK1g7yIMEvHuEy
         CyIw==
X-Gm-Message-State: AIkVDXIFF6o9MgNLKWAErbsW5BVC8SE0ud/7NSHbMNMPJp30ETU7m5bWFLfM4lLND7wiVhmpQ0DzdfZ2rUh/pw==
X-Received: by 10.13.234.19 with SMTP id t19mr3062856ywe.204.1482306966125;
 Tue, 20 Dec 2016 23:56:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Tue, 20 Dec 2016 23:55:45 -0800 (PST)
In-Reply-To: <20161221032221.s7jmgnfrr6tyuyuk@sigill.intra.peff.net>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
 <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
 <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net> <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
 <16b115e0-3a7e-a5c2-1526-44bbcfc97db8@kdbg.org> <xmqq60melazp.fsf@gitster.mtv.corp.google.com>
 <xmqq1sx2lara.fsf@gitster.mtv.corp.google.com> <xmqqvauejvnr.fsf@gitster.mtv.corp.google.com>
 <20161221032221.s7jmgnfrr6tyuyuk@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 20 Dec 2016 23:55:45 -0800
Message-ID: <CA+P7+xrMgzFcuqwBg6z2_ZPgAVKwLX2eyK6D4C0v-c3zAMFqUg@mail.gmail.com>
Subject: Re: Allow "git shortlog" to group by committer information
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 7:22 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 20, 2016 at 10:35:36AM -0800, Junio C Hamano wrote:
>
>> -- >8 --
>> Subject: SQUASH???
>>
>> Make sure the test does not depend on the result of the previous
>> tests; with MINGW prerequisite satisfied, a "reset to original and
>> rebuild" in an earlier test was skipped, resulting in different
>> history being tested with this and the next tests.
>
> Yeah, this looks good, and obviously correct.
>
> I do wonder if in general it should be the responsibility of skippable
> tests to make sure we end up with the same state whether they are run or
> not. That might manage the complexity more. But I certainly don't mind
> tests being defensive like you have here.
>
> -Peff

That seems like a good idea, but I'm not sure how you would implement
it in practice? Would we just "rely" on a skipable test having a "do
this if we skip, instead" block? That would be easier to spot but I
think still relies on the skip-able tests being careful?

Thanks,
Jake
