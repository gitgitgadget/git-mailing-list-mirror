Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E574420D12
	for <e@80x24.org>; Thu,  1 Jun 2017 00:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdFAAsj (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 20:48:39 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36077 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdFAAsi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 20:48:38 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so21873074pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 17:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=K9VW/Lg1UWur3YpiX3SpXmVq85/TCuiOs5fPNFoZWpY=;
        b=R/O/R6CyYw2+Dqb34Q8QNxFUL4pQIem4RpycvPx7BDkYLD5vvVWPSHQJovacqo59oG
         YvsOUv6qVY8vEtFUyjjROqBBYl9CX30dU+O3ZYZshMBzMR+5LMy1+SK95hWpa/HZNCw6
         dtbTEplI6Gp2gapoqWQ/RxqEJR670J7grgcOs1snPEQKaN23fbOVa6tBlDKEOpx4hKbu
         Q7OV4hz00hsV8ZOr3ex9p9jjioWxCG1easT9aXj2Ct5LE6+7mKnORH5Ny3RGtMJ3Ei8h
         YqVFcLN9Ky419GpX0Wj1BgE54cUJaIE8UnbAF+TOvIBmUcDBmauf1i8CQ0qc4UsHPyQ1
         2JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=K9VW/Lg1UWur3YpiX3SpXmVq85/TCuiOs5fPNFoZWpY=;
        b=eYZa8E6VY4Vf+gzxk7ALO7KIRNvYJvovngAe3dWPWOzOu+3sfDhegvUt/U16xt7pTw
         PRcIKlyk6khlHbbHUtpYSUv2264+9xWTmFrn2DeyOP1U1FuF4VsHLrlKiiyKybtzbE3E
         cy2yawksid6r/zmZ0JXggTxU7Qu79PnfnMZeuxEFhcxlK4qaJIK0ivxGg3el0dR4pUjf
         IkfJk6IQTw9Vz2u++TJZ/pVt20cKjNfGvZ/aZ0BnD3xRjSd548hsF2M8eXkceSYlPmFx
         Dt6Iaot/5x8Uu0nRCF4utOEqp3sz6c8qMWDgcXEBHob6V7qDEXROlYDwWxym6t3lK/7L
         RBQQ==
X-Gm-Message-State: AODbwcBhC4+WAgBzCQrwKks/chirVPIvrwbq/1/8InI5mL9D59kFwRO4
        PHxKzeo6MMip0g==
X-Received: by 10.84.139.195 with SMTP id 61mr41775534plr.152.1496278117906;
        Wed, 31 May 2017 17:48:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id i68sm31043075pfi.72.2017.05.31.17.48.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 17:48:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (May 2017, #08; Mon, 29)
References: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
        <CACBZZX6YFKTLKxep2oW0_HrX+kNJ2PX5G4UCboB+4yosmLqr5g@mail.gmail.com>
Date:   Thu, 01 Jun 2017 09:48:35 +0900
In-Reply-To: <CACBZZX6YFKTLKxep2oW0_HrX+kNJ2PX5G4UCboB+4yosmLqr5g@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 May
 2017 20:59:06
        +0200")
Message-ID: <xmqqr2z48rdo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Mon, May 29, 2017 at 8:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * ab/pcre-v2 (2017-05-26) 7 commits
>>  - grep: add support for PCRE v2
>>  - grep: un-break building with PCRE < 8.20
>>  - grep: un-break building with PCRE < 8.32
>>  - grep: add support for the PCRE v1 JIT API
>>  - log: add -P as a synonym for --perl-regexp
>>  - grep: skip pthreads overhead when using one thread
>>  - grep: don't redundantly compile throwaway patterns under threading
>>  (this branch uses ab/grep-preparatory-cleanup.)
>>
>>  Update "perl-compatible regular expression" support to enable JIT
>>  and also allow linking with the newer PCRE v2 library.
>>
>>  Will merge to 'next'.
>
> First a general question: When you say "will merge" in these E-Mails,
> that means "before the next what's cooking in ~7 days, right? I.e. if
> there's no issues in a given series does the pu->next->master cycle
> take 3wks?

No.  "What's cooking" is not even once-per-week to begin with ;-)

These merely mean "the current plan is to merge this, not in too far
distant future, and not until the message hits the mailing list, but
the plan can change based on bug reports and people are encouraged
to find and report blocking issues before such a merge happens,
thanks".

Depending on many factors (the impact of the topic, the complexity
of the changes, etc.), the time a series spends in each stage
differs.  A truly trivially correct change may already have been in
'next' for a few days when the first issue of "What's cooking"
report that mentions it is sent out and the topic may graduate to
'master' two days later.  A more complex series may have to spend
more than a few weeks in 'next' before getting merged to 'master'.

> Anyway, the PCRE v1 set of JIT patches break builds on PCRE compiled
> with --disable-jit, which is apparently Johannes's Windows
> configuration.

OK.  Thanks for reporting and stopping me.  I'll mark it as such...

> And a perf test in a commit message that makes no sense since I split
> up the PCRE v1 patch.

... and wait for an update.
