Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7087A1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 01:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeJJIaB (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 04:30:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41193 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbeJJIaB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 04:30:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so3740363wru.8
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RyOA/R0eU7Ufl8DpKw9YIL1HfasBnx0lpNZTZ2y0TiI=;
        b=dgMFHohThGmUFQOvJTaVsPbCoI3luIry7+DoMp4IInXqscqRuW3q7lbcdTbHTKxi5f
         Qo5ixoPJJ1K5nFEP0kvN//sj29NBmqbpWB81C7PTcrUgSrmKFGF72rb60QyDo6nhfBC+
         BdHVzSXm60zCFGNV0MRYiMO1SdkQ1reYYDCKyIGDoi81xL0ooW6cm3pjJgZA4ezC+p/n
         9kVDSUiB2JNLTV5Lg260NYkOSEmoUhP7WWk5JT/XswqZarHZ4iKZOPd5tYeY45hIgEqq
         k8X9fQ1gOtJOJeX3Mo+UlHIH2WP3muHB6ou2w31lEIxUmFqagVc18Tota+MqRgVUwbEH
         4BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RyOA/R0eU7Ufl8DpKw9YIL1HfasBnx0lpNZTZ2y0TiI=;
        b=G5BJ3oPIxDB3HikvLkZcpL5mnwbcT9/1qi4N6cD6f3O+htlMYy8fZmqFpxjbbDUnNb
         itZ1mB7XZD0JyUEdxISTjt/qq6hqOBL4hH4LYA+JCr4Bikn9CLNsJgUMXaYDwtqtG/3O
         A35db9ZdVTLznKxaNR/CvpmEw1YsuX527i7AgredU+yuXOq00udkLT1poDrTvPjHpmPL
         pSXKVU+JwQFdaiL9f/siFWEYgM92C+PT3T9AYpy2bAktz6/QwodAYIZbV4V/oU76JenE
         /WxCAoOk8gTFK7L74El0NJ68UvSvkTegHCgSmkXONpdj4aTdeyU+mvjpJY5HIe8n0KVj
         10lQ==
X-Gm-Message-State: ABuFfohBncNNIUgQl9tQf/k58JxbvEMJrNIj+C7x2IZbEEEqivtO39bW
        oX65FktB7RZFZMB4LLuR48k=
X-Google-Smtp-Source: ACcGV63YsyiCoxw7kiWQDkf1QRTYr+zxnTMiS1P/OBKQx20Nww87Zwa9kXaRMd4jxDg3JpUxn/7N0g==
X-Received: by 2002:a5d:6490:: with SMTP id r16-v6mr20014582wru.99.1539133818646;
        Tue, 09 Oct 2018 18:10:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z8-v6sm15662438wrr.67.2018.10.09.18.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 18:10:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        nico@cam.org, Nick Alcock <nix@esperi.org.uk>,
        koreth@midwinter.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git <git@vger.kernel.org>
Subject: Re: What's so special about objects/17/ ?
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
        <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
        <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
        <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
        <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
        <87k1mta9x5.fsf@evledraar.gmail.com>
        <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com>
        <xmqqlg79tta8.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZq3xtsbscrRFD8CSn++yrvdM6Ux+nkQ3AamgabXtPL+w@mail.gmail.com>
        <xmqq4ldwszh8.fsf@gitster-ct.c.googlers.com>
        <CAGZ79ka5kKrSqPCWFMDetRLYxDqcguJUzJXDex9q-VMwT-ABAw@mail.gmail.com>
Date:   Wed, 10 Oct 2018 10:10:16 +0900
In-Reply-To: <CAGZ79ka5kKrSqPCWFMDetRLYxDqcguJUzJXDex9q-VMwT-ABAw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 9 Oct 2018 10:37:59 -0700")
Message-ID: <xmqqmurmobd3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:
>> Oh, I think I misled you by saying "more important".
>> ...
> I do challenge the decision to take a hardcoded value, though, ...

I do not find any reason why you need to say "though" here.  If you
understood the message you are responding to that use of hardcoded
value was chosen not to help the end-user experience, it should have
been clear that we are in agreement.

I also sometimes find certain people here are unnecessarily
combative in their discussion.  It this just some language issue?


