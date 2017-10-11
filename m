Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6138620437
	for <e@80x24.org>; Wed, 11 Oct 2017 02:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756690AbdJKCFd (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 22:05:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57399 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752099AbdJKCFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 22:05:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47F8FA5F91;
        Tue, 10 Oct 2017 22:05:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=seqoM2NTSc8v3QFr7WRtbc2yTWI=; b=W8mSKH
        HYjk/texKC+IuG/B8JQ/hmAzhCZWRkLVT2/l6LAhI+RavtclRAMRKalgcmPpTXG/
        DqOdLNlVuwmY3CyI8ySwE+E7lDR4RkB4cSBsCAijnG4Yf8O7qG9utg88tcs1AxTf
        bHTlM/DK52FqzFXZqzirJRruofZQLATSkguOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RCEUpY9ultrzjdFN1nYGxixDQDRjOmXy
        CtRMsb1xHW20AvHdIuJYiIeDU1f3aBNJAwVaaafyhOaYQQPPlPCt1HCquDNee+vj
        joP77hPb9AfDt34srMbbc2jzLiJnw5jECeTbFgDR8CqRozjt8ViG99XQsgs+ierB
        g7/ck6WKY+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FF1AA5F8E;
        Tue, 10 Oct 2017 22:05:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 115A6A5F83;
        Tue, 10 Oct 2017 22:05:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nazri Ramliy <ayiehere@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What happened to "git status --color=(always|auto|never)"?
References: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
        <20171010001619.GL19555@aiede.mtv.corp.google.com>
        <CAEY4ZpPj3=+gL_wBW548qzAuS=aC=qswuPx-4H9DS=X10iJWVw@mail.gmail.com>
        <20171010005942.GO19555@aiede.mtv.corp.google.com>
        <CAEY4ZpMKE6yf2baaJt+x6c_esorFnyWvLZ=_KS1iRs6XbL42hw@mail.gmail.com>
        <20171010102509.e7ucbyon6ka6722l@sigill.intra.peff.net>
        <xmqqfuarp3mt.fsf@gitster.mtv.corp.google.com>
        <20171010130602.ivhsbu2ymnzt7gko@sigill.intra.peff.net>
        <20171010190314.GW19555@aiede.mtv.corp.google.com>
        <20171010193729.nrx7cgifsmpd4c2e@sigill.intra.peff.net>
Date:   Wed, 11 Oct 2017 11:05:21 +0900
In-Reply-To: <20171010193729.nrx7cgifsmpd4c2e@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 10 Oct 2017 15:37:30 -0400")
Message-ID: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3F6CA4E-AE28-11E7-A169-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 10, 2017 at 12:03:14PM -0700, Jonathan Nieder wrote:
>
>> Where I worry is about commands where the line between porcelain and
>> plumbing blur, like "git log --format=raw".  I actually still prefer
>> the approach where "color.ui=always" becomes impossible to express in
>> config and each command takes a --color option.
>> 
>> If we want to be extra fancy, we could make git take a --color option
>> instead of requiring each command to do it.
>> 
>> To support existing scripts, we could treat "-c color.ui=always" as a
>> historical synonym for --color=always, either temporarily or
>> indefinitely.  Making it clear that this is only there for historical
>> reasons would make it less likely that other options make the same
>> mistake in the future.
>
> So that's basically my (2), with the twist that we claim it's only
> horrible and inconsistent for historical reasons. :)
>
> Is that the direction we want to go?

Your (2), and Jonathan's "git --color=..."  as an extension to it,
is probably the least risky approach forward, as you said earlier.
And I think that it would get us closest to the ideal world (in
which color=always did not exist in the configuration system), while
breaking least number of various "questionable" scripts in the wild.


