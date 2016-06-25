Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A511FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 06:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbcFYGOg (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 02:14:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751026AbcFYGOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 02:14:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3D712183C;
	Sat, 25 Jun 2016 02:14:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Te7MefIzHItA2hCkN84oDOJggSo=; b=PGvEhc
	qWK0opagVFA7Zk5rewLyqvPXucA5xgAJeBbz+1BFYZO8chHPZIsbVExrNeGDjyYE
	NuW8X1nerUuJx+nwmyzQCOAdt7yPW0nrYL3AGHJK33pmqtt2YUt4B68iJOEUDeox
	azfWBMtDbcIdKCREIGYffSuJ5FVYPLunOnPuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lwjk1n+ut6J9WNzzWt6qhLMeHHzr7MaD
	fCGAf9Ejb9xAY6GCK9OoeFp3CFl09yT2jlMt5WB2/QzqYFJIcULrj1hi06L7Rx+4
	ys1180gPS7eoowb6FBQR57MB/rWSnK19SLL36c9CFR2ahhj+IbQ23e4aezy+R6MG
	IEoHxVY5pIY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B7052183B;
	Sat, 25 Jun 2016 02:14:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23C492183A;
	Sat, 25 Jun 2016 02:14:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC] gc: correct gc.autoPackLimit documentation
References: <20160625011450.GA14293@dcvr.yhbt.net>
	<20160625020620.GA31290@sigill.intra.peff.net>
	<20160625025300.GA29053@dcvr.yhbt.net>
Date:	Fri, 24 Jun 2016 23:14:32 -0700
In-Reply-To: <20160625025300.GA29053@dcvr.yhbt.net> (Eric Wong's message of
	"Sat, 25 Jun 2016 02:53:00 +0000")
Message-ID: <xmqqa8i9eqwn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 161B2676-3A9C-11E6-A93F-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

>> That's neither here nor there for the off-by-one in gc or its
>> documentation, of course, but just FYI.
>
> I'm now inclined to fix the problem in gc and leave the
> documentation as-is (unless it cause other problems...)

I think that is the best in the longer term.
