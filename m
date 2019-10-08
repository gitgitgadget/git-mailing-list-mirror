Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364BE1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 12:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfJHMka (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 08:40:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37268 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730648AbfJHMka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 08:40:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so16546677qkd.4
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ay6YHp2sXiV8IUYiHz2FBSnlgqFfDlCQMeojfP3p7Lw=;
        b=LnF8dxOohf+AK4glc+BMcGtoOJE21BYrcxMyYKOPnS9uok0NilYfy96DI4DJ78jKNe
         EHcsQDFDsfU1YQHaAag/Uo0UBosobYMtxg7ZnMomBN8zZDRB+w0wSvkMtnOvdTpFdrDn
         GEOvnROAQqBW8L4W6RPfgh4K8MYQQ52rjcD53u0Dj3Xcv/75XHrYQf4uIw2hAqzLC3wM
         X0/sjguC/dwRtpT5TE0VY5mWdXB6XM5ovt/lh0WR3tsPnspGcYfKBny+mabBZJiDKbFO
         Rypixk5tSdBbttWJu87VrcpWM6GdsxZy2BLApsOoYgn+s0R9phtgrF7FaGNQrrVTRYuh
         YGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ay6YHp2sXiV8IUYiHz2FBSnlgqFfDlCQMeojfP3p7Lw=;
        b=sGJTn6/vKCebyUf1u8HaI5PAuRQQW97tZy9DLHzMZHhkhviE2yR74E3zg3T/9uWrx9
         peP5WN7+28ewuwzl2T5EUQMGrE27sDhK6fEeclwLn6C0dN6uxIuQ6X1Irf5/AkEvzAA8
         +698I0a4maJX6n9mwR3kX1AyQ0uE3AKdSgM0vBdPVBK75lGQgbkb0LJ/z2i3h1at4/fW
         uifyf07Smcq6C8SV0Td4Upv4JfhlFtdN+1Fy/7p/tsQw3O03zBC7hmwGmola47VZY0IX
         4RAPopaFMo8QhQBj9+CAC0fLqUlRBRV2onQI67UlrZ95Q1uwpi+RCSuvjFFM/DCVeiEf
         vtVQ==
X-Gm-Message-State: APjAAAWJjlhN1YJq/SMp7XKxi5crrELnHGDEBBELsK8ydjAb2ecb8wSt
        s9hBYfv7a7YUo7L/4qbQO6c=
X-Google-Smtp-Source: APXvYqwqN43wxVJEQadcD0xXN5Ltjcrbn2CLiItDNFMBj0FH8sAqs0nUhj7DSvJMokl7DudhtnPWNw==
X-Received: by 2002:a37:9507:: with SMTP id x7mr28621881qkd.214.1570538429501;
        Tue, 08 Oct 2019 05:40:29 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c988:3ed2:5e14:1c0f? ([2001:4898:a800:1010:7abe:3ed2:5e14:1c0f])
        by smtp.gmail.com with ESMTPSA id 4sm9612498qtf.87.2019.10.08.05.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 05:40:29 -0700 (PDT)
Subject: Re: [PATCH 00/15] SHA-256 test fixes, part 6
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <99b996a5-1c68-c186-b480-fdd2ed69cae9@gmail.com>
Date:   Tue, 8 Oct 2019 08:40:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191005211209.18237-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2019 5:11 PM, brian m. carlson wrote:
> This series consists mostly of additional test fixes for SHA-256, plus
> some test framework improvements and a new option to rev-parse.
> 
> Up until now, most of the test changes have been directly related to
> fixing hash values or sizes in some way.  In other words, previous test
> fixes would be required even for a Git binary that supported only
> SHA-256 and not SHA-1.
> 
> In this series, we also introduce some test changes that deal with the
> extension that will allow the same binary to handle both.  The changes
> themselves are relatively uninteresting, but changes like these will be
> making appearances in future test fix series as well.  They may appear
> bizarre and out of place at times, but rest assured that they will be
> useful in the future.
> 
> The other notable thing in this series is the introduction of a new
> rev-parse option, --object-format.  We know, according to the transition
> plan, that we'll need to support users working with input and output
> in different hash algorithms.  Since we're starting to see this kind of
> code appear in the codebase, it makes sense to introduce a helper that
> lets scripters determine the appropriate value, and we should introduce
> this code sooner, rather than later, so people can start using it.
> 
> We had had some discussions about the name of options to be used for
> hash algorithms but I don't recall us coming to a definitive conclusion.
> Opinions about the name[0] are of course welcome.  I'm not particularly
> attached to any name, so whatever the consensus is works for me.
> 
> [0] Possibilities include --object-format, --show-object-format, --hash,
> --show-hash, --hash-algorithm, --show-hash-algorithm, and more.
Outside of a question regarding using a test-tool instead of adding an
option to 'git rev-parse', I found this series very readable.

My confusion around the printf|git hash-object stuff that is now
resolved. The error was in my reading, not in the presentation.

Thanks for your continued hard work on this subject!

-Stolee
