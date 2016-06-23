Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504CB1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 19:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbcFWTLm (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 15:11:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbcFWTLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 15:11:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E8E9258F8;
	Thu, 23 Jun 2016 15:11:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CpNpc02PFCrxjwI2P4OqsJRHM5g=; b=faSQdS
	99hUY5xiyhCInebZaLuW+RxJ1Fs0EwAPzku3S9vPFcZDabaOH0tattWOY06f6arT
	2oeUJeZsdQSg42sPj6AAA/8DHIrsVpRWeBcHU6dN1nMjVgDnUbPgcbMgNaZDV5hi
	KN7JIFEVSSMKrMxXwqhMS5dteh3HgbW3+hxkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nPIkwSevgcIWxWIbgIm+/xoIlXQXCVhd
	432f5NOtmlC8ETzxFlMNB6F3Lz1SmTOfI9KaUljCh5U3mZiTyrzrton9oUQ3Lk7e
	AzPiaTd81KT7pdge1p65bzEggtW3NAjaj4awhKy2zktinm47qwIBzDU0c8XfdtCP
	KvNaO1x0OvQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 36954258EE;
	Thu, 23 Jun 2016 15:11:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B108A258ED;
	Thu, 23 Jun 2016 15:11:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Simon Courtois <scourtois@cubyx.fr>
Subject: Re: [PATCH v2 7/7] color: support strike-through attribute
References: <20160623173048.GA19923@sigill.intra.peff.net>
	<20160623174015.GG15774@sigill.intra.peff.net>
	<xmqqpor7iwgo.fsf@gitster.mtv.corp.google.com>
	<20160623183907.GA32368@sigill.intra.peff.net>
	<xmqqlh1vivp8.fsf@gitster.mtv.corp.google.com>
	<20160623190414.GA568@sigill.intra.peff.net>
Date:	Thu, 23 Jun 2016 12:11:37 -0700
In-Reply-To: <20160623190414.GA568@sigill.intra.peff.net> (Jeff King's message
	of "Thu, 23 Jun 2016 15:04:14 -0400")
Message-ID: <xmqqd1n7iuty.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 504A893A-3976-11E6-A0E1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm. I see the same thing screen and with tmux, as well (though I don't
> usually use either myself). I suspect they have to filter ANSI codes
> because they're using the codes themselves (so anything that moves the
> cursor is going to be a definite problem), and strike-through probably
> just isn't common enough to have been added to the whitelist.

screen needs to do a full emulation, not working as a passthru.  It
pretends to be a VT100/ANSI and attempt to show on non-VT100/ANSI
terminal via termcap/terminfo ;-)

So it is understandable that the omitted support for less common
ones.

But we are straying deep into an uninteresting (to the list)
tangent, so let's stop it here.

