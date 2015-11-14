From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-candidate: git based patch tracking and review
Date: Sat, 14 Nov 2015 05:07:42 -0800
Message-ID: <xmqqbnawzq3l.fsf@gitster.mtv.corp.google.com>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
	<5643107B.20501@alum.mit.edu> <20151111151204.GA4249@salo>
	<20151114081707.GA32739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 14 14:08:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxaZA-0000Wj-7j
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 14:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbbKNNHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2015 08:07:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750998AbbKNNHu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2015 08:07:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C49D2776B;
	Sat, 14 Nov 2015 08:07:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XdEV3KDv4LbAdkQ1QHJE+nr5Plo=; b=ZoScgM
	ENYNQnlzJbqRdMhbtWaiWcY+MJK3zslc9gtgexHhIxOdkZnazEmqxwoieCibxqLK
	0vR4ova3zcJeVMGMjoOiBpUq1tPH3mFVm7UN/8ivLAYN3RPKDKtK+77SUapU1Psf
	zxeDBn6q562KdYQag7mQrlKw3tL0e8LA+LT34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PsX97Ygtl4fcs32CSjbzN/WXTBkrjHKd
	Na5Vw0+Ke2UZhid4L/2//B/g/eSyKn1mu1A2hN9XpaODbWcLTkcQQGzsb3lcDk6j
	VBe64fOmYhHg7SUBhbd4Ewf0lcTa3BRjcEjevFv8lluA1G0iZBCjpvOo2Jj3Uxui
	uQ56nOQsvvc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 84BF12776A;
	Sat, 14 Nov 2015 08:07:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0CBEE27769;
	Sat, 14 Nov 2015 08:07:43 -0500 (EST)
In-Reply-To: <20151114081707.GA32739@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 14 Nov 2015 03:17:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B1836CE4-8AD0-11E5-84B3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281304>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 11, 2015 at 03:12:05PM +0000, Richard Ipsum wrote:
>> 
>> The aim is not to bless one particular system but to eventually
>> provide a common data model that all review systems can share,
>> so that it is possible to do distributed reviews with arbitrary UIs
>> in a widely compatible way.
>
> I think that's a laudable goal, but I didn't see any discussion or
> documentation of the data model in your patches. Maybe that would be a
> good place to start.

Even before doing that it might be a good idea to pick brains of
folks who work on Gerrit, who has already done one such data model
that may be generic enough to serve as a good starting point. ISTR
that they were migrating to a notes based storage to ease federated
code review systems?

>> If we add git-candidate to contrib then it can act as a reference
>> implementation, so that this data model can be validated and tested
>> by additional developers.
>
> That can happen outside of git's contrib/ directory, too.
>
> I think Michael's "bless" argument applies to the data model, too. Is
> your data model a good one? Should other systems adopt it, or is it
> still a work in progress? We don't know yet.
>
> I think I'd rather see it prove itself before entering the git tree, if
> only because it doesn't really gain anything by being inside the git
> tree. Once upon a time that was a good way to get publicity and easy
> hosting, but these days it is easy to find git hosting, and I am not
> sure people actually explore contrib/ all that much.
