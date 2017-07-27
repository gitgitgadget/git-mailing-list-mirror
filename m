Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122522047F
	for <e@80x24.org>; Thu, 27 Jul 2017 00:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbdG0AuK (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 20:50:10 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33639 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbdG0AuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 20:50:08 -0400
Received: by mail-io0-f172.google.com with SMTP id j32so53299205iod.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 17:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JV9uar40eUb7EBekPaj3Jm9i4zMaEyWM5jcri2yQRDQ=;
        b=AOyKJAjPD9a68zjnxf++12G0DmXQ6rTki0P/7QFmTBXmrlyhOK1AGmeallRdb4jD3L
         V2rPYlDs0+jZipi/otj/t9572s6cQQszr9mynrkkqF8LUjjjcsF6J0gQVI8Iq/ixD3Rw
         LKFWuT1Ky2zMtpD+kYZ2hOM7CQKfdvdCHrAQCCMRn76p8QLB1GVISdhyNK4hMRGRe2+L
         lS5neGpxnY92i7c+exyQbMBby+jdRVUm03i7K2ExKGyJKzFNsU9vLHveqL/Bso4b0MTp
         2LJoKhYPdTFU8f29ws06dx2BusTGjrcuND3u1cKNskARMhL1t8kdd1RfPrzWixxLuk5/
         CDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JV9uar40eUb7EBekPaj3Jm9i4zMaEyWM5jcri2yQRDQ=;
        b=dcO9+5VWY30iOTdeq0Fcd6vvKmwx2qOJDZsSf2bhyhOs2ig+1aNfK5PtJfVEdHETwV
         YQJ/v7G8qWOnVF6TM5YwnUmcI1Ts2a31xwWMM6bon8kVNpQgOywlmf1YKjdTjP2ifzdP
         H5CkKBA9KZ7ufCCsRMP4Ve7+uW+IHt4amrfjjLmrZMOV2lioVlwcCpYEKjl9Of+gwFi0
         dAsUJmkkuhCMIRlcN0EF/9slMvlc0DhOR/V03f/FI+Sm1trPX5bGMBkW0X4NziG/tiCl
         N3Qca13moEDYqdTpvCP954jyjbDu3J/FJ5SDHJfjHGpWtGknFFRo4TD5eX20TUzOgC05
         AbAw==
X-Gm-Message-State: AIVw112PP4/u4++lV2F/sS1iIiVMKzu1Zw8Nvxpv3BEtKZassTIaGV5L
        D5rrQSz35naX7OQw78Zr+x9GHzLIWSg8
X-Received: by 10.107.56.7 with SMTP id f7mr3427633ioa.52.1501116607719; Wed,
 26 Jul 2017 17:50:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.131.97 with HTTP; Wed, 26 Jul 2017 17:49:47 -0700 (PDT)
In-Reply-To: <xmqqa84c6v41.fsf@gitster.mtv.corp.google.com>
References: <87ziclb2pa.fsf@gmail.com> <20170704071909.phs4bf5ybdord2lv@tigra>
 <87van8boe9.fsf@gmail.com> <20170705083611.jgxbp4sqogicfwdb@sigill.intra.peff.net>
 <xmqqshiaizhz.fsf@gitster.mtv.corp.google.com> <xmqqo9sxdwjp.fsf@gitster.mtv.corp.google.com>
 <CAMy9T_FmE=8xzjRJJRxLwQjoMStJx5sYO_xtODv2OEZm54DurA@mail.gmail.com> <xmqqa84c6v41.fsf@gitster.mtv.corp.google.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 26 Jul 2017 17:49:47 -0700
X-Google-Sender-Auth: lVgxi2tghxOU-YiUU_ksgU88Dd8
Message-ID: <CAPc5daXj4sBuWP0r6t0nArXt1DJW+9byT49M_g8LcjrqBMJnRg@mail.gmail.com>
Subject: Fwd: Should "head" also work for "HEAD" on case-insensitive FS?
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heh, then I'll forward my response and we are even ;-)


---------- Forwarded message ----------
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, Jul 10, 2017 at 10:48 AM
Subject: Re: Should "head" also work for "HEAD" on case-insensitive FS?
To: Michael Haggerty <mhagger@alum.mit.edu>


Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think the most natural thing would be to use different encoding
> rules for pseudo-refs (references like "HEAD" and "FETCH_HEAD") and
> for other references (those starting with "refs/").
>
> Pseudo-refs (with the partial exception of "HEAD") are quite peculiar
> beasts....

I agree with the reasoning, but what I am worried about is that
their handling in the existing refs.c code may be leaky and/or
inconsistent.

What I saw was that a test have ended up with .git/%46%4F%4F when it
was told to create a ref "FOO" (which indicates that "FOO" was
passed to the files backend), which later failed to read it back
because the pseudo_ref handling refs.c wanted to see ".git/FOO" on
the reading side.

Perhaps it is only a bug in t/t1405-main-ref-store.sh?

> But...since we are talking about introducing a new loose reference
> filename encoding, ...

Yes, but that is an encoding detail I do not have to get involved
and folks with platform needs can add more on top---we need to make
sure that the places that encode and decode are identified in the
code first, and the things like "FOO is encoded upon writing because
files-backend is asked to write it, but not decoded because refs.c
thinks it is pseudo-ref and does not give a say to files-backend"
shouldn't be happening before we can start working on the details of
the encoding.  Making a conscious decision that pseudo-refs are left
as-is is OK, but we need to see both reading and writing side
following the same codepath to make that decision, which does not
seem to be the case in the current code.
