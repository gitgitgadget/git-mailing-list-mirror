From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Wed, 11 Apr 2012 09:44:23 -0700
Message-ID: <7vpqbemd5k.fsf@alter.siamese.dyndns.org>
References: <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr>
 <20120405131301.GB10293@sigill.intra.peff.net>
 <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
 <4F7FF19B.1060407@alum.mit.edu>
 <20120407075150.GA18168@sigill.intra.peff.net>
 <7viphaygsg.fsf@alter.siamese.dyndns.org> <vpq62d6dyzr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:44:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0em-0000RZ-Pt
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469Ab2DKQo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 12:44:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755950Ab2DKQo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:44:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0B486380;
	Wed, 11 Apr 2012 12:44:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=45ywAeNbAHx6XoKVl3ThqXcS4zE=; b=N97iek
	ayHwMpplAuy5LmPf7dueQLHvJjJPvMSHImS1Ua3/+mvp1r7g4tuGZOBamYGeP0BI
	fijr7t6ggo4pzOx7YjBHfCtT7tTxmRAL0Ye1ifun8xFk+Zpu2ln4xNTJ9OU1xh+r
	OSUdCRejx43r6KFnLWAWBLPLr9yzD3GEDNYIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sdR1S7Ov7s2PkO1cdU0KZ1P3gtEKL1JO
	yl2OzEhl1ScpMiEjLDqvfHckw/6ZPPAT79tgNv4G46SAuVlQxvCzx4sklEWwemu5
	CXuwZ8XPL2BwpfridVfCzt/HCPJp6Go2CKrVIjLNm0K+MMGGFIqozAXas83Wg730
	F99jdnV5Je4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E71DD637F;
	Wed, 11 Apr 2012 12:44:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A73E637D; Wed, 11 Apr 2012
 12:44:24 -0400 (EDT)
In-Reply-To: <vpq62d6dyzr.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 11 Apr 2012 18:17:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 985FF8E4-83F5-11E1-8CD3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195209>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> On Sat, Apr 07, 2012 at 09:49:47AM +0200, Michael Haggerty wrote:
>>> ...
>>>> If "push.default" is not set, then have it default to "beginner" mode.
>>>
>>> I would be fine with that (I've suggested it elsewhere in the thread,
>>> though I think I stole the idea originally from you. Speaking of going
>>> in circles. :) ).
>>
>> This makes the first priority for 1.7.10 cycle to come up with a solid
>> implementation of the "beginner" mode, I guess.
>
> I guess so. I found the idea relevant the first time it came in the
> discussion, and I'm starting to get really convinced that this is the
> way to go. And if we're wrong, it will be much easier to migrate to
> either "current" or "upstream" later.
>
> No time to code this right now, but I may come up with a patch in a few
> days. Any idea on the real name? I'd call it "safeUpstream" or
> "safeCurrent", but that's probably by lack of a better name.

I'd say "simple" ;-)
