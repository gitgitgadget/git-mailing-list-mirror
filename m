From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/7] tests: paint known breakages in yellow
Date: Fri, 21 Dec 2012 07:46:55 -0800
Message-ID: <7vd2y32ys0.fsf@alter.siamese.dyndns.org>
References: <1356059558-23479-1-git-send-email-gitster@pobox.com>
 <1356059558-23479-3-git-send-email-gitster@pobox.com>
 <50D4230F.9080502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Spiers <git@adamspiers.org>,
	Jeff King <peff@peff.net>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 16:47:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm4oo-0006MX-Rv
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 16:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab2LUPrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 10:47:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592Ab2LUPrG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 10:47:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14C5A891F;
	Fri, 21 Dec 2012 10:47:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rfkb29D9388wmOv2Xk4zv4ycg50=; b=G+a9Ux
	/ol/0X8sb/NAXoXMJXIpqN0GWTaeWW4KmW0wbc9rH63gRdhGRKBUmF2kslxK+8M7
	kVvhmJjnuRhsDJ5mVaEQN6Z+flLmv+//6mjQQR8BXHAUW4Nk+RmsNQsUBkymYA7u
	C/e38cU4OlElVy0eXTqDTtMngfPBi7yQ/bDxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gm5VyKBNtrIfM9Twx/9Hf9J6gWCbDNZm
	bM3z42seHjtTJtjHcZVTT11iIR9T4LYYso/byhvyR86BnCQLKWrCwPw1ZLzGZDvx
	ptrpe8VirjtalrzJWXWHKw3C+xyH2okYtz6OiBHOVZNPDX5sPhipM2azTXdAvBoe
	6Cm6Kg6fql8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0111B891E;
	Fri, 21 Dec 2012 10:47:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2030D8913; Fri, 21 Dec 2012
 10:47:01 -0500 (EST)
In-Reply-To: <50D4230F.9080502@gmail.com> (Stefano Lattarini's message of
 "Fri, 21 Dec 2012 09:51:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8ED6EE6-4B85-11E2-915C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211976>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> On 12/21/2012 04:12 AM, Junio C Hamano wrote:
>> From: Adam Spiers <git@adamspiers.org>
>> 
>> Yellow seems a more appropriate color than bold green when
>> considering the universal traffic lights coloring scheme, where
>> green conveys the impression that everything's OK, and amber that
>> something's not quite right.
>>
> Here are few more details about the behaviour of other testing
> tools, in case you want to squash them in the commit message for
> future references:
>
> 1. Automake (at least up to 1.13) and Autotest (at least up to the
>    2.69 Autoconf release) use "bold" green for reporting expected
>    failures.
>
> 2. On the other hand, the 'prove' utility (as of TAP::Harness v3.23
>    and Perl v5.14.2) use yellow (not bold) for the same purpose.

Nice to know, thanks.

I re-read the above three times, trying to see how to add it to the
log message, but having hard time phrasing it.

The only thing the additional knowledge adds seems to be to give
rationale for the old choice of "bold green"---it was not chosen
from thin-air but can be viewed as following the automake/autotest
scheme, and other systems cannot agree on what color to pick for
this purpose.

I do not see a need to justify why we chose differently from
automake/autotest; we could say something like:

    Yellow seems a more appropriate color than bold green when
    considering the universal traffic lights coloring scheme, where
    green conveys the impression that everything's OK, and amber that
    something's not quite right.  This is in line with what 'prove'
    uses, but different from 'automake/autotest' do.

but we are not in the business of choosing which is more correct
between prove and automake/autotest, and I do not see how it adds
much value to tell readers that color choices are not universally
agreed upon across various test software suites---that's kind of
known, isn't it?

So...
