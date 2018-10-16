Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7111F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJQGci (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:32:38 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:36751 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbeJQGci (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 02:32:38 -0400
Received: by mail-pf1-f173.google.com with SMTP id l81-v6so12161355pfg.3
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 15:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=R5+kO+rX/Asx6q1jdGrGZB901eBElXzmQZpuDrIeL6o=;
        b=IWde82ATLavT1WfUmw+JoF6zCp+9uR7Hluz6Zcdjm8XB/LzeDYk2v4CwIrVn1LpNNE
         KHhZzNEyNhkaWIMbSD35LrJu7HepHuUZF0bt8GuX2RPgRFfxOOesrl7W1oWupuMIbr8e
         ooZ4Nq6NdaRkfNQ92SXENUH/AX/Ak/NBCBR3aPS0xc7VM0DfdYO4Jn4/EYB3PEah+as2
         mlfxooLqTZIfAAHCwFe+BzgA1t+L0gcphp3/HKp+VmLfB79fdqiZ9MecsTRuhBqfXU70
         4TNdgrNyvf8Ir8rJxSwsNFvmz1HNcBXEW+CYIGmpx50MsRIsPV7v9vghHs9il9M/xqM8
         4ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=R5+kO+rX/Asx6q1jdGrGZB901eBElXzmQZpuDrIeL6o=;
        b=hbEM5ZAUcS2+b3ALsM1Yo3d+YdUojVLA3NUYGESSH7kDcdoSsW3hYH6Q45ecCuYQYy
         JyPt2gHRpUsX3TefqJZXfBePwzCFhSOV9JuZFrYyilO6O6e1MAWitjdg9cd93FITFv++
         WluIdeuPsn24GHFA/5ZAO38z9mLt78GLEHqCDlBTba8nhSAtZBtHh+v2H4i8QvZ4NZ+I
         AAksCVU3aSfijSGyVnpL/XixiEbcP4bv3YJ+Wn/8NZ/+BN20z5VeZNMmjDClLNJjWbWM
         B41PZB6J8BwIvDFvfr1nrJ8eYa5XOpABLMhQ4DPh+KfdAb6rRFhd5AOazwKS5FULAKkD
         iY7g==
X-Gm-Message-State: ABuFfogdzlPkRwZRvErUABnGIrGEghL5VIh/d8JEY8eY7uLzlz3mn9Fl
        +jGzVAdpStuk1RAWjvT8QBI=
X-Google-Smtp-Source: ACcGV634hQewa/iX0iK9SK3aEP1rK4AeI5w17r+hiclQ8eGOX/UVYyBSK8GOhgHv7blSCugedyjGKw==
X-Received: by 2002:a63:ff23:: with SMTP id k35-v6mr22025907pgi.62.1539729603721;
        Tue, 16 Oct 2018 15:40:03 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id g87-v6sm10295235pfj.34.2018.10.16.15.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 15:40:03 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:40:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: On overriding make variables from the environment...
Message-ID: <20181016224001.GC96853@aiede.svl.corp.google.com>
References: <20181016184537.GN19800@szeder.dev>
 <20181016215456.GB96853@aiede.svl.corp.google.com>
 <20181016223330.GP19800@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016223330.GP19800@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:
> On Tue, Oct 16, 2018 at 02:54:56PM -0700, Jonathan Nieder wrote:
>> SZEDER Gábor wrote:

>>> Our Makefile has lines like these:
>>>
>>>   CFLAGS = -g -O2 -Wall
>>>   CC = cc
>>>   AR = ar
>>>   SPATCH = spatch
[...]
>>> I'm not sure what to do.  I'm fine with updating our 'ci/' scripts to
>>> explicitly respect CC in the environment (either by running 'make
>>> CC=$CC' or by writing $CC into 'config.mak').  Or I could update our
>>> Makefile to use '?=' for specific variables, but:
>>
>> That's a good question.  I don't have a strong opinion myself, so I
>> tend to trust larger projects like Linux to have thought this through
>> more, and they use 'CC = cc' as well.
>
> I don't think Linux is a good example to follow in this case, see e.g.
> 6d62c983f7 (Makefile: Change the default compiler from "gcc" to "cc",
> 2011-12-20) (in short: Git is supposed to be buildable with compilers
> other than GCC as well, while Linux not really, so they can hardcode
> 'CC = gcc').

Nowadays Linux builds with clang as well.  People also have other
reasons to override the CC setting (cross-compiling, etc) and to
override other settings like CFLAGS.

> Also, the projects I have on hand usually have 'CC = gcc' hardcoded in
> their Makefiles, too, but those Makefiles were generated by their
> ./configure script (which in turn by ./autogen.sh...), and those tend
> to write CC from the environment into the generated Makefiles.

Yes, I think that's what makes travis's setup normally work.  It makes
sense to me since ./configure is expected to have more implicit or
automatic behavior.  For "make", I kind of like that it doesn't depend
on environment variables that I am not thinking about when debugging a
reported build problem.

When building Git without autoconf, the corresponding place for
settings is config.mak.  Would it make sense for the ci scripts to
write a config.mak file?

Thanks,
Jonathan
