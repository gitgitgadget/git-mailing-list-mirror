Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A6F1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 14:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbdBIOXZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 09:23:25 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:41852 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdBIOXW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 09:23:22 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id 91A09C4FF;
        Thu,  9 Feb 2017 13:25:54 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (mailhost.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 8BA3A100209;
        Thu,  9 Feb 2017 13:25:54 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 7CC28125EA8;
        Thu,  9 Feb 2017 13:25:54 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Jeff King <peff@peff.net>, pclouds@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: Re: [PATCH/RFC] WIP: log: allow "-" as a short-hand for "previous branch"
References: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
        <xmqqtw882n08.fsf@gitster.mtv.corp.google.com>
        <20170206181026.GA4010@ubuntu-512mb-blr1-01.localdomain>
        <xmqqtw86zzk4.fsf@gitster.mtv.corp.google.com>
        <20170207191450.GA5569@ubuntu-512mb-blr1-01.localdomain>
        <vpqh944eof7.fsf@anie.imag.fr>
        <CAN-3QhoZN_wYvqbVdU_c1h4vUOaT5FOBFL7k+FemNpqkxjWDDA@mail.gmail.com>
Date:   Thu, 09 Feb 2017 13:25:54 +0100
In-Reply-To: <CAN-3QhoZN_wYvqbVdU_c1h4vUOaT5FOBFL7k+FemNpqkxjWDDA@mail.gmail.com>
        (Siddharth Kannan's message of "Wed, 8 Feb 2017 22:53:05 +0530")
Message-ID: <vpqwpczlfe5.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> Hello Matthieu,
>
> On 8 February 2017 at 20:10, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> In a previous discussion, I made an analogy with "cd -" (which is the
>> source of inspiration of this shorthand AFAIK): "-" did not magically
>> become "the last visited directory" for all Unix commands, just for
>> "cd". And in this case, I'm happy with it. For example, I never need
>> "mkdir -", and I'm happy I can't "rm -fr -" by mistake.
>>
>> So, it's debatable whether it's a good thing to have all commands
>> support "-". For example, forcing users to explicitly type "git branch
>> -d @{1}" and not providing them with a shortcut might be a good thing.
>
> builtin/branch.c does not call setup_revisions and remains unaffected
> by this patch :)

Right, I forgot this: in some place we need any revspec, but "branch -d"
needs a branch name explicitly.

> [...]
> As you might notice, in this list, most commands are not of the `rm` variety,
> i.e. something that would delete stuff.

OK, I think I'm convinced.

Keep the arguments in mind when polishing the commit message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
