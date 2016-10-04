Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93F2320986
	for <e@80x24.org>; Tue,  4 Oct 2016 20:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbcJDUk2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 16:40:28 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36047 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbcJDUk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 16:40:27 -0400
Received: by mail-yw0-f172.google.com with SMTP id u124so50049845ywg.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R9cecvJ8v7tn+LvwU9D+eNRz98axHRPAQ2xxEGYqktc=;
        b=CMYMnzGa3AE5Bu6+WeIHcXD/+M/tK9Gia8IvWivbDLa7ma9c1ZQ+8fjA3tWysxmzkS
         5X0xXob4JoDLjWnho9XIBZg6oxjWvOVad4fxPd7sGIoMNJaYRutAQKPz31PmQFZFIcZF
         hA49lqTjlC+k3DYCnYPyY91djrtPrwjvlQTpGKXRGa7HoEdZIv4+Xd1BWc2XtyJt0he6
         Gpv7ogPhCXtusXTqypBKp4q31Guh5gKE6X4DPivXOnt/XHrIEW/KeDvBEBdIE6nRw5I1
         MlbNw+zz/GB1Z5A24uwikQ/7I9JzBS1fU3LYR9NvRD4dZO4goKg9VwC0ov7PeGWCRsHR
         CSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R9cecvJ8v7tn+LvwU9D+eNRz98axHRPAQ2xxEGYqktc=;
        b=OJEo97NtE0gvURgAtWLbuydwCmoN2EjX1Jgl3vdL0askHOwxrduTET3N/Uvmwh3wj0
         XRrcZAxaOgN0jDR3SiU+gQ9/o1O5zGT79V4gStzBBlP8a7AXiGZYuj1iiR7y8dWeszy8
         JAVjdvzEX/2mfPzbegE4hIiuliEZx/1NM7WXHgviRHUY47Qs9DfMVkyRjlUs5An7bTzi
         cR925tIQfGPbY/ZsLcf+3XREKboSqKwsZFH3lNN4EU8WlLLLhU7k1EVYA67x19H6fBnY
         heVAUx6Xbih3p2JLap8Mo4HzXwvRANqS3rpCbBZe5vZXldKSWFcNEhk/IVUb3d+MIZZe
         i2nQ==
X-Gm-Message-State: AA6/9RnZ5SvzzeQqb18VRWwyuBMod2uu+RQdshxRH3nnVjkbHo3N68DQQt5fpjQEGIDecHahwC4RBkjL1+9q2A==
X-Received: by 10.129.177.3 with SMTP id p3mr4386973ywh.318.1475613626920;
 Tue, 04 Oct 2016 13:40:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 4 Oct 2016 13:40:06 -0700 (PDT)
In-Reply-To: <20161004134120.aj6oywkiy4li7aeh@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <CA+P7+xob7ohj1MxuLGGLwwJyi4RfqUTeLkbw86u+VvbU=uEyAw@mail.gmail.com> <20161004134120.aj6oywkiy4li7aeh@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 4 Oct 2016 13:40:06 -0700
Message-ID: <CA+P7+xrRBCjkmWGKYbA9b1=pNHcckphF-Ko8i7OoPAcs9y-bNQ@mail.gmail.com>
Subject: Re: [PATCH 0/18] alternate object database cleanups
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 6:41 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 03, 2016 at 10:47:31PM -0700, Jacob Keller wrote:
>
>> > The number of patches is a little intimidating, but I tried hard to
>> > break the refactoring down into a sequence of obviously-correct steps.
>> > You can be the judge of my success.
>>
>> I read through them once. I'm going to re-read through them again and
>> leave any comments I had.
>
> Thanks for having the fortitude to read them all. :) After looking at
> your comments, I don't _think_ there's anything that necessitates a
> re-roll, but I'll respond to a few of them individually.
>
> -Peff

Ya, I don't either. Most of my comments were just me trying to make
sure I understood what you were doing.

Thanks,
Jake
