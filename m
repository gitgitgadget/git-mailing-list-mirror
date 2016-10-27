Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A6820193
	for <e@80x24.org>; Thu, 27 Oct 2016 21:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938624AbcJ0Vuh (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 17:50:37 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35853 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030445AbcJ0VuD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 17:50:03 -0400
Received: by mail-yw0-f171.google.com with SMTP id u124so63066724ywg.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qiSTP9XMepfCrC0URVySCcngzevhECf6SflauydL/pk=;
        b=IksXpS0aRC2fKQsmUfYZ1I/HxLuMPY+tg2Wys2/8ghx95/jms/Dyv5/ZG2PtiiENPq
         YaU0iXQQPQg02yOzXbrfJCv+6seMDi2z3HR4Cjx7pqv5HCgm0M/svYCck+NIAcfE3V4g
         pAga39nFjEZvyAzRXAFCZ5mpgjpPzFrRWjo6mcQfxHGYikUIXGWVg5yt8ccEiyK0eOHW
         S91hDkZY6338scKLqWKtMJvXW5G8AkuM+BRigAOsz3/SfPeHrBzTAcIHjZ3DVKKAdoE0
         gicYpVPZdUUQxiUXJQ8Hu6WwZWNq6WBogWDfai7AZWj4LIlKmFKUXxQv1tw1XlAPSW/x
         mN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qiSTP9XMepfCrC0URVySCcngzevhECf6SflauydL/pk=;
        b=T44NhddVNKogXmlIbqtkdpxgDlurRt5CtNhe3dlucousa9jNEXWx0aNmpyJ05CmNdC
         llNHuvcIS9awfYTp1Vj9vx427SUxlBrAJMGb08RCjqmJE0PWlcEjCQidtkrAMAbJDzu9
         xMBxRiOm6gtYgEqzPwRjopqpSVjQVy5cU/g20D1srLdSpVMYhkKPgTGl5Reh5NGeq6E1
         44Zd9PxzT595mBMV0WIz15KBHa1RM7o1SsxvAwDRc3Mtf6gxg2PqF1/py1127tumK4JW
         iy/9+AEay3V8n4RPoyYQjgi0gz3aQ0TAjIlZACKdzeu8OkuEZMRoA8tdcmGTlQPeHkPP
         VpwA==
X-Gm-Message-State: ABUngvf8j/O5Z7I4ACc/hbOvI2oot3alhFReVVdshQWNDXejEiEXg5xsULF6o3mgIbkI60xtI9KDaP6WeKRbKQ==
X-Received: by 10.13.244.69 with SMTP id d66mr10323786ywf.318.1477605002008;
 Thu, 27 Oct 2016 14:50:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Thu, 27 Oct 2016 14:49:41 -0700 (PDT)
In-Reply-To: <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org>
References: <20161026215732.16411-1-sbeller@google.com> <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com> <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com> <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
 <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org> <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com> <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 27 Oct 2016 14:49:41 -0700
Message-ID: <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 1:05 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> The implementation under discussion (well we did not discuss the
>> implementation a
>> whole lot yet) ...
>
>
> There's not a whole lot to discuss: it must be rewritten from scratch (it's
> not just the memory barriers, it is everything else, too). But time is much
> better spent on an attr_start() solution.
>
> -- Hannes
>

Ok, so I've been reading this thread. I don't understand your
objections to emulating in this way.. Could you clearly spell out why
you believe this solution isn't acceptable? So far all I've understood
was "it's not critical sections" and "it penalizes Windows too much"
but... If Windows cannot statically initialize a pthread mutex, then
we *have* to dynamically initialize it somewhere. This solution adds a
single check before each lock and is safe due to use of memory
barriers. Yes, this will cost a tiny bit extra overhead for each use
of "pthread_mutex_lock" but I fail to see how that is a huge
penalty...

So I'm trying to understand if that really is your only concern,
because I don't actually buy that it is a huge overhead to pay.

I agree with Stefan that there isn't really a great place to put a
dynamic initialization.

To be clear I am trying to understand the objections since so far all
I have read is "this is bad, and I object" without clearly explaining
reasoning.

Regards,
Jake
