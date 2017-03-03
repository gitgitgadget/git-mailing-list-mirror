Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A60E20133
	for <e@80x24.org>; Fri,  3 Mar 2017 18:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbdCCS6w (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 13:58:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54358 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751584AbdCCS6v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 13:58:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8BCC64380;
        Fri,  3 Mar 2017 13:43:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b0cJcu4cltUt0198vA6m99e5fag=; b=cqadfT
        KyG+EB0+neMxctm8A2ywTbXEoSAP/QYlrV2eqwG5C4nAbj0aH+zulcb1aPXTonrM
        WQO0Wx2TIt3WNzc3oAWCGp1VBpQC6AWmZ4b6iaQd1qPND3v/mdMJDNHZBEkgzWrW
        FBs9mdjjzZ1iwhm9O2UPL6oGp43e0dzK0UuqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rI6BsMg6MaQ6SwjWKWjISiV65BuiOJTB
        I5gQz9meYKQvj4anOxlLSnq/WVgx/MnXAhEtjgln4nYnEyQ3ZlEW85jwknBTKtC8
        hiafxXOX2tGu07UqFJUgbyYfw6E5tAHAZIr1N8WpsM7BuXuphwuVQDcewBVqzqlw
        3l9v3lbCdlw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A24D36437F;
        Fri,  3 Mar 2017 13:43:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A56D6437E;
        Fri,  3 Mar 2017 13:43:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
        <20170302105157.59791-1-larsxschneider@gmail.com>
        <alpine.DEB.2.20.1703021210170.3767@virtualbox>
        <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
        <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703030315580.3767@virtualbox>
Date:   Fri, 03 Mar 2017 10:43:44 -0800
In-Reply-To: <alpine.DEB.2.20.1703030315580.3767@virtualbox> (Johannes
        Schindelin's message of "Fri, 3 Mar 2017 03:17:30 +0100 (CET)")
Message-ID: <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 553FFB54-0041-11E7-9CC3-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 2 Mar 2017, Junio C Hamano wrote:
>
>> Another question is which v3 people mean in the discussion, when you
>> and Dscho work on improvements at the same time and each post the
>> "next" version marked as "v3", and they comment on one of them?
>
> But then, Lars & I communicate in a more direct way than the mailing list
> when discussing teeny tiny details such as: "could you have a look at my
> mail" or "how would you change .travis.yml to do XYZ".
>
> With that level of communication, there is almost no danger of two v3s.

Sure, that is true between two (or more) people who communicate
privately.  The issue you raised on Lars's "v1" and your original
unversioned one can be seen either (1) as similar to having two v1's
or (2) having (an implicit) v0 and v1 that won't cause confusion.

As I said already, because the v0 and v1 (or v1 and v1) came from
two different people, it's not such a big deal if Lars named his
first one v1 or v2, just like it won't cause problem if his reroll
were done as v2 or v3.  

I see he did v2 which you Acked in a different thread.  Will replace
what's been on 'pu' and running with Travis the past few days with
it.  Let's wait for one or more Travis cycles and then merge it to
'next'.

Thanks.
