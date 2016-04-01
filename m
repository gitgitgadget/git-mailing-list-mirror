From: Junio C Hamano <gitster@pobox.com>
Subject: Re: weird diff output?
Date: Fri, 01 Apr 2016 12:04:18 -0700
Message-ID: <xmqqbn5ti219.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
	<CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
	<xmqqzithxj8l.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
	<CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
	<20160330045554.GA11007@sigill.intra.peff.net>
	<CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
	<CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
	<CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com>
	<CAGZ79kbk5T5SdSzfZ8Q6TQmXgiG+ZSUYc5E7_95KtariDU8MHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 21:04:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am4Mr-00042P-SY
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 21:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbcDATEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 15:04:22 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750808AbcDATEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 15:04:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7FD084F4BA;
	Fri,  1 Apr 2016 15:04:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Av3sFPjcfNbsFApg1Z8xt9suA10=; b=tWEtnB
	CKDKDYKC04XmeoGwYzH7VI5CC6vWJYw6MLH33+bBZ+9RCwfP6v1AcSmToJ9QjYMs
	xZjpNUdUFKodA7bfU7lQU+ONkTt8RIJyXz46KiQkQMvE6+EmVlL7A9yw45OJ8efK
	V9oePi8H4K+DtkwcUCqU4FQOrRWvNis7pHd9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JNa6FTXe2DwSEmBbw3/NYrk2Ut9Dr4g8
	hCn5kFz7uxWUh5T5MjNapvuPA4GctRQ5uU8VcLfnQCIMC6KItIexahTlEcxWrEBc
	Wa3HC03CZFqVLpbLgjg/mysrip++pEqpzo0BYKavra8rRNnTQ6rlbFFVyabSLz63
	HmQwpSFfNaM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6B1154F4B9;
	Fri,  1 Apr 2016 15:04:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CD6F44F4B5;
	Fri,  1 Apr 2016 15:04:19 -0400 (EDT)
In-Reply-To: <CAGZ79kbk5T5SdSzfZ8Q6TQmXgiG+ZSUYc5E7_95KtariDU8MHQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 30 Mar 2016 12:40:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 89D12608-F83C-11E5-8110-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290574>

Stefan Beller <sbeller@google.com> writes:

> Thanks for going through examples!
> (I would, too. But fixing a submodule regression is more important
> now; I only develop new features when there are no known regressions
> caused by me)

This is a tangent but perhaps as an experiment perhaps we can try it
as the rule for everybody to adopt for one cycle, and see if that
improves the quality of the end-user experience?
