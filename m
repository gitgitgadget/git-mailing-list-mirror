Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6F561F424
	for <e@80x24.org>; Wed, 27 Dec 2017 18:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbdL0SvS (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:51:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57579 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751184AbdL0SvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:51:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E71E6BC9D8;
        Wed, 27 Dec 2017 13:51:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eGgydjKtgDeoR8wJ3CZHqW5lX+E=; b=GKYuE7
        dbAsvf4Q3chKeil2xtLFj4T86GvgVDPFXo4wpuLtkCNa7hsLly7Z1PglnQVWNvyY
        EMk1ejbhT9q6FvDyeyBT7xqI9zg6nRWUlL3e5dk+HZMrYmPTfIChCKPi0GyPNlN/
        jwGNBYC/TSoKHV+MFXKc4aQ69F+zz6vh3WkDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yNxY7n1u5iEj/QHLVdy1N92FB3js2uTh
        YogYgiW58XHibbR+8/Co9C7COJR4hEiNbA3LUggyFV5wLusvkJmtmt+3fTWfLPTy
        AcDBB4aig3ko1OL8YqqLp8n8NXNIx+3RHBtgkqeWNq9Fq/6qoR3jshhDRAadWjgd
        2SXFm70YfeA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEBA1BC9D7;
        Wed, 27 Dec 2017 13:51:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5175CBC9D6;
        Wed, 27 Dec 2017 13:51:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from 5.8.0
References: <20171223174400.26668-1-avarab@gmail.com>
        <20171224143831.GD23648@sigill.intra.peff.net>
        <871sjkrtrm.fsf@evledraar.gmail.com>
        <20171224230839.f6r66u37wj4ai3sj@untitled>
        <87y3lrr78q.fsf@evledraar.gmail.com>
        <20171225015744.o47ackbwi2wbtkbv@untitled>
Date:   Wed, 27 Dec 2017 10:51:15 -0800
In-Reply-To: <20171225015744.o47ackbwi2wbtkbv@untitled> (Eric Wong's message
        of "Mon, 25 Dec 2017 01:57:44 +0000")
Message-ID: <xmqqzi64m2cc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB27E7D6-EB36-11E7-9A1D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Fair enough, I haven't run 5.8 in a while, either.  One concern
> I have is it makes reviewing more difficult as the language gets
> bigger and (even more) unfamiliar constructs pop up.  This is
> probably more important for git as most of us are not dedicated
> Perl hackers.

Yes, but that cuts both ways.  When we do get a less amateur Perl
folks who contribute and review, they are more and more likely to be
fluent in modern versions of Perl than the ancient ones some of us
who learned the tongue long time ago are familiar with.  Telling
them to limit themselves to what is also available in ancient
versions is a burden that is backwards.

So

> What mostly bugs me about this is going from:
>
> 	"we'll accept patches to keep your old system working"
>
>  to:
>
> 	"your software is too old, upgrade or go away"

is something we need to be able to say at some point.
