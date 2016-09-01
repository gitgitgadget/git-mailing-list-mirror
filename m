Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F451F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 22:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbcIAWL1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:11:27 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35230 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbcIAWL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:11:26 -0400
Received: by mail-qk0-f182.google.com with SMTP id v123so100403992qkh.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 15:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XlbFf+OFfdzODzPO6DSgU2daULr8+SAJYVtor9FB+hk=;
        b=P6xNfDPaypGa+iVdc+D6nJZ0S+YkCM5P7MFU01J+qIGgKYilKnjzcfgSHbchKSTy0R
         UKO+OetQ8OiZ3FnnPd/ctGvwpJOv2VDVPD243NVZNE9XhJtCQNB1TJm4fzr1Jzrmvo0w
         xaVajuxf8bjTH8H4tMpElTEbuGDntxdy/F+ZOAX2NxAoMYZtpIGRigKgYStj6QvJOUwz
         uqsvygiHI8g09W3fyqJF1aHjNChLHg8MhCXLPhddqezTBBp3yZoAa7yVQE299v6ZGlda
         9tlyi61V1ql9v118MwpftesBa+MgP70bIvKQg6gnLADnQ9kACjlKIudgUZfd0lGW8O9S
         Q1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XlbFf+OFfdzODzPO6DSgU2daULr8+SAJYVtor9FB+hk=;
        b=jAUu1pPhpAgDKJLklj9kEFiDYHCjojjVtvNYY8bOCoAcdFjCTl7EyPup7qrQS29ZQ1
         AE4kEbdnh/RnlTBD1Y8/QGZYRu3bv56dG1Wrp1gnkpuUDaRk8cR0Shn+eiXdbVTjwRCG
         P7VjS60btOnD0/dBv77cGsYLGxyOKfCXBq8K+AOFwKJGtzkc9qXMXkgKGktujNT3FBLz
         AYVyqJSjzWaPn8BwxMffv9z4V/RDkWNPmut2uKxAV4svQSYr9o3996zA91kL+31x3L9X
         VONaatN9YcxP9r5Rvw89+dOMO30w3DKMDEmYOpWO9hOiE6/0mK6A30clNGdVo8UL/Pwf
         x85g==
X-Gm-Message-State: AE9vXwPN5o6MLHiOPLzcGyZQEl7L05FAyp3rJVb1Qp2nQ9RS+TrTHl79FELE9SLmX3zXOu8n+zlFK8jcDJaEZQ==
X-Received: by 10.55.106.2 with SMTP id f2mr19185271qkc.124.1472749065070;
 Thu, 01 Sep 2016 09:57:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.195.20 with HTTP; Thu, 1 Sep 2016 09:57:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1609011027210.129229@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
 <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
 <20160830084357.rdmt2ehngrz6rqaq@sigill.intra.peff.net> <xmqq37lm3w6u.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608311233440.129229@virtualbox> <CAGdFq_iJeziyXBPL2GVHNXZcjGAwQVN2EhJs4AtJCSx7ghn32Q@mail.gmail.com>
 <alpine.DEB.2.20.1609011027210.129229@virtualbox>
From:   Sverre Rabbelier <srabbelier@gmail.com>
Date:   Thu, 1 Sep 2016 09:57:04 -0700
Message-ID: <CAGdFq_h3UuW7wX0-=SuS22mX_C086HRZZ=i1sYVya80dd+qMYQ@mail.gmail.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed tests
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2016 at 1:27 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 31 Aug 2016, Sverre Rabbelier wrote:
>> On Wed, Aug 31, 2016 at 3:36 AM Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > On Tue, 30 Aug 2016, Junio C Hamano wrote:
>> > > Jeff King <peff@peff.net> writes:
>> > > > Hmm, interesting. Your approach seems reasonable, but I have to wonder
>> > > > if writing the pid in the first place is sane.
>> > > >
>> > > > I started to write up my reasoning in this email, but realized it was
>> > > > rapidly becoming the content of a commit message. So here is that
>> > > > commit.
>> > >
>> > > Sounds sensible; if this makes Dscho's "which ones failed in the
>> > > previous run" simpler, that is even better ;-)
>> >
>> > I did not have the time to dig further before now. There must have been a
>> > good reason why we append the PID.
>> >
>> > Sverre, you added that code in 2d84e9f (Modify test-lib.sh to output stats
>> > to t/test-results/*, 2008-06-08): any idea why the -<pid> suffix was
>> > needed?
>>
>> I can't really recall, but I think it may have been related to me
>> doing something like this:
>> 1. Make a change, and start running tests (this takes a long time)
>> 2. Notice a failure, start fixing it, leave tests running to find
>> further failures
>> 3. Finish fix, first tests are still running, start another run in a
>> new terminal (possibly of just the one failed test I was fixing) to
>> see if the fix worked.
>>
>> Without the pid, the second run would clobber the results from the first run.
>>
>>
>> If only past-me was more rigorous about writing good commit messages :P.
>
> :-)
>
> Would present-you disagree with stripping off the -<pid> suffix, based on
> your recollections?

No objections, I think it should be fine. If anyone uncovers a
particularly compelling reason later on, it's only a commit away :).

-- 
Cheers,

Sverre Rabbelier
