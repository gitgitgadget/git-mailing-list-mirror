Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73D41FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 10:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbcHPKHn (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 06:07:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751510AbcHPKHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 06:07:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71C1B31B59;
	Tue, 16 Aug 2016 06:07:41 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gKg78JCkUdGFLDzrzQeLShYqU6c=; b=VzYCsl
	4V0sz5dz2VnQJK6EgE2aGFZ3PpT9eCxZRp4ZrJOefP4KHY/5SHOQuamJWfPWLMZZ
	0FBV8sLg8+0bHol4aZe97ubND8aD1YO3a35YmgFN2pscKkeVW8OwM+a7Q9xWp6Sf
	aryZtcgDNS8KPYIRL3r4Cpn/V9fTIlLHUte90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CLMsfya2ISPmhN76rU4nQgWDUV1B7rQd
	CF5ebdq8UyX5Cw/+NfUUQ8h1RDiwQzzorhe7qoZ2aP3uwXsJt26zDyvoYJ71lB9v
	iobG30QungO6IYTBADShbGAlOQZwwq7HF8wNl/YUUanIYpx3Ybn2BfHiMbYmGh7u
	9EtSB4JDzXo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69E2C31B58;
	Tue, 16 Aug 2016 06:07:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9F5B31B56;
	Tue, 16 Aug 2016 06:07:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly platform-independent
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
	<xmqqk2fihv90.fsf@gitster.mtv.corp.google.com>
	<xmqqoa4tg2yi.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608161026110.4924@virtualbox>
	<alpine.DEB.2.20.1608161035320.4924@virtualbox>
	<xmqqmvkddoqi.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 16 Aug 2016 03:07:38 -0700
In-Reply-To: <xmqqmvkddoqi.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 16 Aug 2016 02:53:09 -0700")
Message-ID: <xmqqinv1do2d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44563FD2-6399-11E6-9064-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The trick to catch non-ascii depends on core.quotepath set to true
> (which is the default).  You would need to run ls-files with an
> explicit "-c core.quotepath=false" to be safe.
> ...
> The invocation of "git -c core.quotepath=false ls-files" needs to at
> least have 2>/dev/null to squelch an unnecessary error message.  In
> such a scenario, we may miss a new offending pathname, but we will
> not have false positive and I think that is the best we can do.
>
> Thanks.

Needless to say (1) both "false" should have been "true"; (2) I
shouldn't be crawling out of bed and typing with hazy brain early in
the morning.

Sorry for typoes and thinkos.
