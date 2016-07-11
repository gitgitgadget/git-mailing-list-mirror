Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3AF1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 19:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbcGKTHt (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 15:07:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750770AbcGKTHt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 15:07:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 396C42C2DD;
	Mon, 11 Jul 2016 15:07:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9joLbqRuDE+DtOupvsOBhepvdH0=; b=TZjuZ6
	2CwzKPifegTUP91AflU1FfTu80kZzN+lMFgBr2KhUiD0r4sZxU/cuaw/ji6xPJKJ
	f7XZi7j416cgM9RF5Qx5qnWpnIDyqEd/7WRXdBeHdVwQQd1w0ComF0SzPvT1uff7
	xCNeyxGnZZ5E4Fr4yNTnA4aX8QXx6Do/xjWb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PfAF3DDYAjgwAN7bt6n71mAe2iQ5e6T9
	M6HjwvjoWOxLsbEoJuq7dTIABUi6/IRXb40QRDgymWii2mjv5gNu0BS8XEUK3fWF
	HtoHp3X+YixelrQVPrgVRiIfbS+umm50ME5IN2X4bqnDFPKuOgsN0QwgZel6wNcq
	eNpOFamJ70w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 315D62C2DC;
	Mon, 11 Jul 2016 15:07:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B056B2C2DB;
	Mon, 11 Jul 2016 15:07:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Theodore Ts'o <tytso@mit.edu>
Cc:	Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] pretty: add format specifiers: %gr, %gt, %gI, gi
References: <20160710055402.32684-1-tytso@mit.edu>
	<20160710061644.GA19640@sigill.intra.peff.net>
	<20160710142622.GE26097@thunk.org>
	<20160711050201.GA18031@sigill.intra.peff.net>
	<20160711164317.GB3890@thunk.org>
Date:	Mon, 11 Jul 2016 12:07:45 -0700
In-Reply-To: <20160711164317.GB3890@thunk.org> (Theodore Ts'o's message of
	"Mon, 11 Jul 2016 12:43:17 -0400")
Message-ID: <xmqqa8ho9eny.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1712344-479A-11E6-835E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

>> I'm on the fence, so I'll let you decide how you want to proceed. I can
>> live with "%gr" and "%gt", as they are at least symmetric with their
>> author/committer counterparts.
>
> I'm on the fence myself.  I can live with either, since either way the
> long message command line will be going in .gitconfig.  I have a
> slight preference for %gr and %gt, as %gT isn't orthogonal with
> %ad/%cd, but I could be easily pursuaded otherwise.
>
> Does anyone else have a strong opinion?

I am fine with %gr/%gt, with the understanding that the step beyond
that would not be to add %gT but to do %(reflog:...), and giving
similar longform to other things like %ad so that we can move things
in the "maybe cumbersome to type but more readable" direction.

