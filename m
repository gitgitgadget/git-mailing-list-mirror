Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02B11F419
	for <e@80x24.org>; Fri, 15 Dec 2017 15:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbdLOPJQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 10:09:16 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37606 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbdLOPJP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 10:09:15 -0500
Received: by mail-qt0-f196.google.com with SMTP id f2so12428063qtj.4
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 07:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A/BMOv+la9/rxq61k3RCmkP9UH0qV6+uJnkHmgp5OsM=;
        b=gNzmUQFjz8kZxiRDWYwoK1j8Mw/rRcgmmhLBmOqfaK6Wajv3N9fUt7p2CC32A2fppq
         gWb/OKZxJkFNNLl1B3Vx7/qVnHuXCRIxd71I5S70PdEXZa9C1U492KezLq0V9Ik8DRDd
         iN9SJ0XbY3iLzTCY9uSTQhUNobY8HHg+RwPtajW48mET0nddUyedO6vWUHOp1oLelqrs
         57lwy7waX+rUEYTGAbhzwM3NeRIW3iO0wsOSgzslECcoWWqA/1w92P2q8qIJbaCsEGUW
         PPVHvzvvtS9Odq03bIJrP64eNNkmYH7WuVd850UfXdtPlsqo5uHwneEXFWG1eVpwLoHs
         t7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=A/BMOv+la9/rxq61k3RCmkP9UH0qV6+uJnkHmgp5OsM=;
        b=b7ImvDml4HhJI/9Oh4xQIeKbYvi+Vt1bvLU3+hDnucrZAdtW5bSgkW6RquhyyIDhyc
         s1ZCDldqiHl8N1hS8teL2Nxoea3ifKD5D4/+1N5gDOfwD/k3+xirlkXh6XG6Szd3v5D5
         qRQVWo8jrdvdSX6mVGV4M2kFwid8hKpjaSO1fkYUoLX8PLN85C/FrkNpL4BnPIC5pWrQ
         dNAWOy9p0hhFa1iVbIHKWM2eRDBZfezfV9Os79V62MSO7vKYUKvtrfe5wjfAC5lV4VrU
         vcLL/WA77q9UimMANFKOqfGIcot7sV8ZVbe85HQqTEisDdyt3NH4dbB/+ZWmEPfkKcrA
         CaNg==
X-Gm-Message-State: AKGB3mJ3QjkupWCTZh4rGZFANNbuCOQ8y00+qcy+emmDid7hfbps6RaX
        2Ec91+XIDKucGSV9uCb8t3E=
X-Google-Smtp-Source: ACJfBov46QAL+MPH5QqZ9gSMYY8a+BjLeRfLhGLtDgxfuoZkJwuZdrtfgf8FvTR3ysssdqF+uleUwA==
X-Received: by 10.200.52.137 with SMTP id w9mr22484319qtb.290.1513350554258;
        Fri, 15 Dec 2017 07:09:14 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id s189sm4155718qke.68.2017.12.15.07.09.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Dec 2017 07:09:12 -0800 (PST)
Date:   Fri, 15 Dec 2017 10:09:10 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        'Junio C Hamano' <gitster@pobox.com>,
        'Jeff King' <peff@peff.net>, 'Dan Jacques' <dnj@google.com>,
        'Alex Riesen' <alexander.riesen@cetitec.com>,
        'Jonathan Nieder' <jrnieder@gmail.com>,
        'Brandon Casey' <drafnel@gmail.com>,
        'Petr Baudis' <pasky@ucw.cz>, 'Gerrit Pape' <pape@smarden.org>,
        "'martin f . krafft'" <madduck@madduck.net>,
        'Eric Wong' <e@80x24.org>,
        'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
        'Joachim Schmitz' <jojo@schmitz-digital.de>,
        Bill Honaker <bhonaker@xid.com>
Subject: Re: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make
 rules
Message-ID: <20171215150910.GI3693@zaya.teonanacatl.net>
References: <20171129195430.10069-1-avarab@gmail.com>
 <20171210211333.9820-1-avarab@gmail.com>
 <003f01d37390$ed0e0440$c72a0cc0$@nexbridge.com>
 <87a7ynd1ml.fsf@evledraar.gmail.com>
 <b8b4534f-1eda-ee52-faed-ec5188c2ad35@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b4534f-1eda-ee52-faed-ec5188c2ad35@grubix.eu>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

Michael J Gruber wrote:
> This patch (currently in origin/next) makes a ton of tests from our test
> suite fail for me on pretty standard systems (Fedora 27, CentOS 7.4.1708).
> 
> Is there anything I'm supposed to do differently now to make our test
> suite run? If yes then a clear and short hint in the patch description
> would me more than approriate.

Interesting.  I'll have to try building next.  I was going
to wait until the first 2.16.0 rc for a full test.

I did apply this patch on top of 2.15.1 on 12/10 and built
an rpm locally for fedora (only f26 though).  I didn't see
any test failures, which is why I thought I'd wait for
2.16.0-rc0 to test further.

FWIW, the minor spec file changes I made (against fedora's
git package master branch) are here:

    https://src.fedoraproject.org/fork/tmz/rpms/git/branch/perl-makefile

The only change in the patch since I tested it is: 

+-modules += Git/Packet

in perl/Makefile.

I don't think any of these changes to the rpm spec file or
the Git/Packet addition in modules look like they'd affect
the test suite, but it's early here and I could be wrong.

I'll try to test a build of next soon to see if I get
similar failures on Fedora/CentOS.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
After one look at this planet any visitor from outer space would say
"I want to see the manager."
    -- William S. Burroughs

