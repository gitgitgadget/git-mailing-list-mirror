Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B697C2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 19:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbcGMTlo (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 15:41:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750941AbcGMTln (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 15:41:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B7A942985D;
	Wed, 13 Jul 2016 15:41:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=po17rwdBeuXvzBuzhIxc/ZKz/Cw=; b=dhefrM
	1/slU/I5IeZWGwFrU2V/q3TO2xevOeiA1jzgSJnnzvbNPWZl9+7N+9MkBqnFcgBz
	t2vJS9XRzaX4xNgxMMuPcbkOnXvB4sJaXd8nazJSV+rHTnmYR3/p3Z86WVvAXvy6
	/VqAm2Q+ezODHCSlSc3YDACXeu4sDT3/7bRII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TtHq2ix3byrLCwXML1taHDIX6CMcVQru
	NgzVNzmhLOVIcc1+YQTkHLrIyi/JP6HhZn2yWLjR5fSp+QrYB9WLhuBdFmkOiGgT
	t1vpXBqHumUEaxWccjkMdF71U/XUzV4qUP13YHCWWWLsEWh60QRg1Dpsl7uG8pyL
	DcvzaspiEg0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B05322985C;
	Wed, 13 Jul 2016 15:41:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34AC22985B;
	Wed, 13 Jul 2016 15:41:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
	<xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607120927410.6426@virtualbox>
	<20160712073912.GA26431@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607121257450.6426@virtualbox>
	<20160712140427.GB613@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607131329510.6426@virtualbox>
	<xmqqlh1534qk.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607132105091.6426@virtualbox>
Date:	Wed, 13 Jul 2016 12:41:24 -0700
In-Reply-To: <alpine.DEB.2.20.1607132105091.6426@virtualbox> (Johannes
	Schindelin's message of "Wed, 13 Jul 2016 21:10:29 +0200 (CEST)")
Message-ID: <xmqqvb09z5p7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9633A86-4931-11E6-BBEA-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I was hoping to hear from you sooner and do v2.9.2 with your t0006
>> workaround with lazy-prereq changes from Peff (i.e. "Makes sense!"
>> above), so that you do not have to do two releases in a row
>> (i.e. skipping v2.9.1 saying "Git for Windows skipped that one
>> because it was not quite right; this release fixes the issue" in
>> your v2.9.2 announcement).
>
> I am sorry that you expected me to be more available. It is a pretty crazy
> week already (and trying to get a Git for Windows v2.9.1 out of the door
> after dropping everything else on Tuesday morning added quite a bit to the
> load), so I am at times unable to even read the Git mailing list.

Actually these back-and-forth was an attempt to help you reduce the
load by not having to worry about the t0006 workaround.  Checking
your inbox would have been quicker than writing another of your own
version.

> As I am more concerned with Jeff Hostetler's patch now (the "very verbose
> porcelain status"; I merged the Pull Request after seeing no comments on
> his mail, but then Peff provided some good feedback, so now I am not quite
> certain how to go about it: revert, or wait if the 2nd iteration is
> acceptable and take that), so I am not immediately releasing any version,
> anyway.

As I said, I'd be waiting for a reroll of that to queue on 'pu', but
as a new feature, it won't appear in any of the v2.9.x releases.
