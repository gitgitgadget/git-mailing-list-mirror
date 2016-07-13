Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F15C520196
	for <e@80x24.org>; Wed, 13 Jul 2016 16:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbcGMQEG (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 12:04:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750923AbcGMQED (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 12:04:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CFF62B5AB;
	Wed, 13 Jul 2016 12:03:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q8wUMAJxYYwMnnS5EH8U3OV7uCE=; b=W33sdV
	W5c51BQkRydriwypiTYWHTJFst9rD0cU74mpPPQVkbC+kvFEgn3eS71F/F0GmlIa
	7eDmbg4MGLJlZAEehCHv/R2Hf7I6czTjHwf04ssI+YnSxnpJ4bIcLOb4nb3nKIYb
	1ZqyLqEBwJigJqe/R1Nfp3ufalE9qlQVe0Spg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sfXcnMJUBJCYgHo0ks4YZTZFJwyvMfUf
	VQO3IdzLeSJfEQaDAp6WhB3ERZjUB9c4qmSWLQmooCj7HhiVjkvkONyfiDIncwY3
	o9mlND2cBOnMMsd79iHrXdy7kwhgs0d5YYW0E6GXwA1jw+3AylLYtxRtrXZW/W3P
	9sAp3MmPb84=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35B6F2B5AA;
	Wed, 13 Jul 2016 12:03:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AEBA12B5A9;
	Wed, 13 Jul 2016 12:03:17 -0400 (EDT)
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
Date:	Wed, 13 Jul 2016 09:03:15 -0700
In-Reply-To: <alpine.DEB.2.20.1607131329510.6426@virtualbox> (Johannes
	Schindelin's message of "Wed, 13 Jul 2016 13:35:31 +0200 (CEST)")
Message-ID: <xmqqlh1534qk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 500798D0-4913-11E6-A8E2-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This was just a quick fix, intended to allow me to release Git for Windows
> v2.9.1 in a timely manner (which is now delayed for other reasons).
> ...
>> You'll need to adjust check_show as I did in my earlier patch.
>
> Makes sense!

Hmph, so what is your preferred approach?  You'll do your own v2.9.1
that is different from others at t0006?

I was hoping to hear from you sooner and do v2.9.2 with your t0006
workaround with lazy-prereq changes from Peff (i.e. "Makes sense!"
above), so that you do not have to do two releases in a row
(i.e. skipping v2.9.1 saying "Git for Windows skipped that one
because it was not quite right; this release fixes the issue" in
your v2.9.2 announcement).

Thanks.
