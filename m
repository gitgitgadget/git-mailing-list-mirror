From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Thu, 12 Apr 2012 14:33:58 -0700
Message-ID: <7vlim04ou1.fsf@alter.siamese.dyndns.org>
References: <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <vpqty12h995.fsf@bauges.imag.fr>
 <20120405131301.GB10293@sigill.intra.peff.net>
 <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
 <4F7FF19B.1060407@alum.mit.edu>
 <20120407075150.GA18168@sigill.intra.peff.net>
 <4F7FFD7A.80104@pileofstuff.org>
 <20120412071150.GB31122@sigill.intra.peff.net>
 <4F874639.5090207@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:34:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIReb-0006jh-16
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 23:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762854Ab2DLVeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 17:34:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049Ab2DLVeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 17:34:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5FB16335;
	Thu, 12 Apr 2012 17:34:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UyVWFHkS3dECtP79ECusTkXsji0=; b=YRfzbc
	wzv2Z8Lm+qoJW7qJviYFKAfyCgGtC8px+p1tcTom8gv6FqFdAy3l7JWWQxGpslcj
	cEcZnpfdp6UP/NQ+2y2G7E+o1d1OlvgRfKDk3DPVMvRniNNKINUm6ubG4Vicvb+S
	J1gab0ncnTVAxsUjOHB/mm1j9qZSRa6LzFxmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c3p910DtvXm/95CkAQCUWcKsrdHoOlnd
	j13oPWYPvHytzQRvfkwjai/xGsLCtGIh2pJfs6l8hKW47f+koTpkaz5ugyg5WHpY
	8cuWaAXPukZwLCSJJVnumeOPE/Ld1RF16AQozzVNa7RiN+XhzxeYYEe7Rx7s8IYx
	RplGZ58Dqw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB2146334;
	Thu, 12 Apr 2012 17:34:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F30F6333; Thu, 12 Apr 2012
 17:34:00 -0400 (EDT)
In-Reply-To: <4F874639.5090207@pileofstuff.org> (Andrew Sayers's message of
 "Thu, 12 Apr 2012 22:16:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37869F1C-84E7-11E1-B688-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195375>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

> So if the problem is that the documentation cues the reader to think
> about upstreams but not to think about downstreams, the solution is to
> find excuses to talk more about downstreams.  As far as I'm concerned
> @{upstream} means "the place that commits come from when I `git pull`",
> so it makes perfect sense to me that @{downstream} would mean "the place
> commits go to when I `git push`".

In a separate message I completely misunderstood what you meant by
"downstream".

If you had something like this:

	[remote "origin"]
        	url = ...
        [remote "destination"]
                pushURL = ...

	[branch "topic"]
        	remote = origin
                merge = refs/heads/master
		pushRemote = destination # new
                push = refs/heads/topic # new

you could express that asymmetric layout in a natural way.  When you say
"git push" while on your "topic" branch, it will go to "destination"
remote to update their "topic" branch.

Interesting...
