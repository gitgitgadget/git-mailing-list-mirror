Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798481F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 01:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfJIBch (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 21:32:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34329 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfJIBch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 21:32:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so535595wrp.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 18:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bxrc7auuXQuPZSKljGIXqRhagYF0EHg5kECgG+ACNCU=;
        b=UDp9QXIe109b2p9/1K8+E7CCAZXrR+WX3xCeC0N6p93fAAcOKDHXQ0kGCcdkVO8onB
         94XBS7eOD1bcKfQwFu0SLyeViVFocJ8Mwx4BgrU3ZzMq2rzPB6YTHtf80Ov/ikcsvfY8
         WoIJ9SrOVJT2cqfnWkJNSRJbbB4xaIGAPQP4GOtvEaQftp6PtDFzR8FT/qcSYy++LQtR
         Bf8tx9m64S0VJ0+rDBFRRs6os4j8oGXY48ypaDngYK9aOyJbJ7P6tAP0S2lTyrP8ZDHY
         sBuE0VSDvcQ76cmULTuB2UHi1hpr3PrAoqOaoKMXJlSXjaX+9fh2rpiKfp/wE0SKwNab
         vK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bxrc7auuXQuPZSKljGIXqRhagYF0EHg5kECgG+ACNCU=;
        b=NJw2pFncm02BttVZm2wJLcFBMSvB5Q+Oc4leEo7PizCCneZA12LuzkdDK7jOYDoWxB
         FyL4gPKWKoyq83ucCVh+JkmaYESEm3Pu6oyo90PRqUR2nOgAWwECbtDGR+GcChDc6ZkB
         lbk95E0r1le+iYMREauiJPNTNAcMZ3IT5KUNbqTTbfYHrpYovH2QW26TEUfAMfbHxpwx
         l29qTLSPqsMZTE4nyNUm1rzRsT/tUEW9lrAJobYxKHjkE33NvpjOWX9O2zAahCL5D1W8
         DV+ozfBQm1N25NjLQOEDUtVZeEHGzCsXkJfRlb49a97qkXGBXkazHwzXi0AiiGcln9x7
         TnnQ==
X-Gm-Message-State: APjAAAUvLscMIHN6tVRr07qt01Qq4KSRskJtPq01jvagZK8SAtlyQz9P
        HgRnWjhAhI5ghpKuOPRfm4Q=
X-Google-Smtp-Source: APXvYqxj/OhX0QJQVVu4a/49R1SgIau0Vz4yL0IAigMDZBJ9Wx9GXF80k3fLDpD4IuSoz9lV+7ECbA==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr634879wru.120.1570584754320;
        Tue, 08 Oct 2019 18:32:34 -0700 (PDT)
Received: from szeder.dev (x4dbe0d12.dyn.telefonica.de. [77.190.13.18])
        by smtp.gmail.com with ESMTPSA id b186sm586245wmd.16.2019.10.08.18.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 18:32:33 -0700 (PDT)
Date:   Wed, 9 Oct 2019 03:32:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
Message-ID: <20191009013231.GF29845@szeder.dev>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
 <20190921121104.GA6787@szeder.dev>
 <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
 <20191007172951.GC11529@szeder.dev>
 <xmqqk19fn9jp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk19fn9jp.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 08, 2019 at 01:30:34PM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >> 		func(PROGRESS | REGRESS);
> >> 		func(PROGRESS + REGRESS);
> >> 		func(PROGRESS * 3);
> >> 	}
> >> 
> >> how caller came about to give 3?
> >
> > No, they tend to show (PROGRESS | REGRESS), at least both gdb and lldb
> > do.

I was wrong here, gdb does this, but lldb, unfortunately, doesn't; see
my other reply in this thread.

> OK.
> 
> >  If the enum has only constants with power-of-two values, then that
> > is the right way to write it, and the other two are asking for trouble
> 
> If the programmer and the debugger knows the constants are used to
> represent bits that can be or'ed together, what you say is correct,
> but that is entirely irrelevant.
> 
> What I was worried about is that the constants that are used to
> represent something that are *NOT* set of bits (hence "PROGRESS * 3"
> may be perfectly a reasonable thing for such an application)

I don't really see how that could be reasonable, it's prone to break
when changing the values of the enum constants.

> may be
> mistaken by an overly clever debugger and "3" may end up getting
> shown as "PROGRESS | REGRESS".  When there are only two constants
> (PROGRESS=1 and REGRESS=2), we humans nor debuggers can tell if that
> is to represent two bits that can be or'ed together, or it is an
> enumeration.
> 
> Until we gain the third constant, that is, at which time the third
> one may likely be 3 (if enumeration) or 4 (if bits).

Humans benefit from context: they understand the name of the enum type
(e.g. does it end with "_flags"?), the name of the enum constants, and
the comment above the enum's definition (if any), and can then infer
whether those constants represent OR-able bits or not.  If they can't
find this out, then that enum is poorly named and/or documented, which
should be fixed.  As for the patch that I originally commented on, I
would expect the enum to be called e.g. 'midx_flags', and thus already
with that single constant in there it'll be clear that it is intended
as a collection of related OR-able bits.

As for the debugger, if it sees a variable of an enum type whose value
doesn't match any of the enum constants, then there are basically
three possibilities:

  - All constants in that enum have power-of-two values.  In this case
    it's reasonable from the debugger to assume that those constants
    are OR'ed together, and is extremely helpful to display the value
    that way.

  - The constants are just a set of values (1, 2, 3, 42, etc).  In
    this case the variable shouldn't have a value that doesn't match
    one of the constants in the first place, and I would first suspect
    that the program might be buggy.

  - A "mostly" power-of-two enum might contain shorthand constants for
    combinations of a set of other constants, e.g.:

      enum flags {
              BIT0 = (1 << 0),
              BIT1 = (1 << 1),
              BIT2 = (1 << 2),

              FIRST_TWO = (BIT0 | BIT1),
      };
      enum flags f0 = BIT0;
      enum flags f1 = BIT0 | BIT1;
      enum flags f2 = BIT0 | BIT2;
      enum flags f3 = BIT0 | BIT1 | BIT2;

    In this case, sadly, gdb shows only matching constants:

      (gdb) p f0
      $1 = BIT0
      (gdb) p f1
      $2 = FIRST_TWO
      (gdb) p f2
      $3 = 5
      (gdb) p f3
      $4 = 7

