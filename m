Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F2641F858
	for <e@80x24.org>; Thu, 28 Jul 2016 19:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479AbcG1Tw4 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 15:52:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757309AbcG1Tww (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 15:52:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DA9C2F07B;
	Thu, 28 Jul 2016 15:52:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5E/vz1xABtoBZ03Ru7CfObNjT/c=; b=uG61Ch
	OWI0a+6HX1oulW7UDAGsR4Xpb4KMPUikHknQDm/AfKUoiZSVcroV0iWFab0jsR4c
	e5x9IA9Q7se21x970iAsDhJHucA8gjeFyM1zg+kMF9CkdIZq2pZ2EwlPZtCTaipH
	UZXeudzG/c7wqke8p/HOFXYrDoXk0JVrgFjr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ox0wbu3mZ/tm0O7gXkLyL3hj9z07C9gM
	MCr1AAOEXAeIXZ48CuRNCiiJQsDz3HZeKycZtxi+2l+eHfq+HyVEmPcbKOk2ib17
	oJSHizrpalUgMc4mgc0vgiN0TZ4xFDjtlUFh1csEtMrQ9RqcEsvCELuRUytde/Qz
	gkrif9cTLVg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3609C2F07A;
	Thu, 28 Jul 2016 15:52:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABBD82F078;
	Thu, 28 Jul 2016 15:52:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] t7406: correct depth test in shallow test
References: <20160728172641.8376-1-sbeller@google.com>
	<20160728172641.8376-2-sbeller@google.com>
	<xmqqeg6dsj33.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka5n1_5CM3DOGHcd3W=4KJb9d-sb=E1pyvzP=XWGVXE3g@mail.gmail.com>
	<CAGZ79kZfXKC66uokqOXeWND=V+53YfAkfd1NUK7A4jM2UAea7A@mail.gmail.com>
Date:	Thu, 28 Jul 2016 12:52:48 -0700
In-Reply-To: <CAGZ79kZfXKC66uokqOXeWND=V+53YfAkfd1NUK7A4jM2UAea7A@mail.gmail.com>
	(Stefan Beller's message of "Thu, 28 Jul 2016 12:24:03 -0700")
Message-ID: <xmqq37mtsfov.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD911358-54FC-11E6-9633-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The depth of 2 I chose originally turns out to be a lucky
> accident too, as the depth from "Commit 2" is 2,
> so that we would observe the same depth no matter if
> a --depth 2 was given and working or not.
>
> I'll redo this test (as 2 tests, one is testing the situation as
> we have now, i.e. the desired tip is reachable from within
> the depth argument, the second test will test if it is not
> reachable.)

Good that I was puzzled ;-) Looking forward to see an improved test.

Thanks.
