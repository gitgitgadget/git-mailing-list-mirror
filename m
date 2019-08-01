Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E942B1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 22:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389403AbfHAWTE (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 18:19:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61903 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfHAWTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 18:19:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 246F8153B83;
        Thu,  1 Aug 2019 18:19:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=Dvn3Kg7wQQyHUmS/YSQOa5lMD34=; b=QnUR28B
        1jlkleAKQCw+ttDbeeWxjmuio+OQDf5aq9VnJs8Oc9DWWfJFZYTtgCaMaA4zs1gO
        9jeTywidwCphqAelrgT8JWQBZ4SzkNzgaQeuv/dQkifVMSnAttoI/awOWYTwc3pp
        BcSxuzUwvN5VDz2LB/3gaGNAHfMsLCkZmhF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=w2cdyuy8mfFPh2yw84iQFI5f66/lpHQot
        aBKCCLqMdIIenGsOTSy2j3mBoNhsNag5GKWuT1zycvAHQe2Z7MiHkkmWmQusMYyx
        hy22B9lvAlsacigYthsGEx20OYNeKZxAlG8fm0TQ1ufXXtuOmMqT6cDpHu1FPtWp
        LFalv412Gs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 161E1153B82;
        Thu,  1 Aug 2019 18:19:01 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26102153B81;
        Thu,  1 Aug 2019 18:19:00 -0400 (EDT)
Date:   Thu, 1 Aug 2019 18:18:58 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
Message-ID: <20190801221858.GN4545@pobox.com>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net>
 <20190801002125.GA176307@google.com>
 <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
 <20190801213638.GA30522@sigill.intra.peff.net>
 <xmqqa7csmudm.fsf@gitster-ct.c.googlers.com>
 <xmqq5zngmtzh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zngmtzh.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 5C9B56B2-B4AA-11E9-AF02-72EEE64BB12D-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>>> +	if (mailmap < 0)
>>>>  		mailmap = 0;
>>>> -	}
>>>
>>> This should be "mailmap = 1" to match the commit message, no? (Which
>>> also implies we may want a new test).
>>
[...]
> +test_expect_success 'log.mailmap is true by default these days' '
> +	git log --author Santa | grep Author >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'Only grep replaced author with --use-mailmap' '
>  	git log --use-mailmap --author "<cto@coompany.xx>" >actual &&
>  	test_must_be_empty actual

With log.mailmap true by default, should we also have some
tests to ensure that --no-use-mailmap and log.mailmap=False
do the right thing?  (I mean eventually, not necessarily
with this patch as extra work for you Junio.)

(If I was certain the answer is "yes" and more familiar with
t4203, I would have sent this in diff format.)

-- 
Todd
