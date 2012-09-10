From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Probable bug in file run-command.c function
 clear_child_for_cleanup
Date: Mon, 10 Sep 2012 13:12:52 -0700
Message-ID: <7v4nn5ocvv.fsf@alter.siamese.dyndns.org>
References: <504CAB66.1050003@optimisefitness.com>
 <20120910134406.GA7496@sigill.intra.peff.net>
 <CABPQNSaufY9vUAFp9VL2i=6bNmO5_2+anzX6+omfq+UgP03kXg@mail.gmail.com>
 <20120910141027.GA8284@sigill.intra.peff.net>
 <7v8vchodgc.fsf@alter.siamese.dyndns.org>
 <20120910200110.GA32437@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	David Gould <david@optimisefitness.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:13:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBALv-0004zX-6Y
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757646Ab2IJUM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:12:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213Ab2IJUMz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:12:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43439861F;
	Mon, 10 Sep 2012 16:12:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xTlPn408hN/cJtwJPE/0SA+VKCc=; b=e4/RwY
	1iqamw08AwgRLvH/DDqHMlxb3wrNgT2Z4xBNzFKMDOu/mqqBcRZ9nw8Lz2NngI/J
	0FtRS9ARB+jHMXGKyyIfCc1epPVsBwRufvvGOxumq3z5CurHbiE1iVRLgb4UzPap
	mD3/IQJHDeiUjlM8uoG6/0RSMx3IgfEMvPh6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x/k/w3p/au2rxpodMmbXgwBER42xpgTS
	P1mPpQ9m9/UMyDqoFIWiPwUdB9AH/iadmdKpXz/7KvqSYvrwOr/dOFyt/9QlKn7s
	ZW/gCaXdsnyBIGTk4vfNaNB5B3c0ncIPcVHCi3B8jLZWTMuBMqSFXU4018BnujjU
	mDrWNf+xasw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FF4A861E;
	Mon, 10 Sep 2012 16:12:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BDD78617; Mon, 10 Sep 2012
 16:12:53 -0400 (EDT)
In-Reply-To: <20120910200110.GA32437@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 10 Sep 2012 16:01:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7305F12-FB83-11E1-917F-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205171>

Jeff King <peff@peff.net> writes:

> On Mon, Sep 10, 2012 at 01:00:35PM -0700, Junio C Hamano wrote:
>
>> >> And to conclude my bikeshedding for the day: Shouldn't "last" ideally
>> >> be called something like "prev" instead? It's the previously visited
>> >> element, not the last element in the list.
>> >
>> > It is the "last" element visited (just as "last week" is not the end of
>> > the world), but yes, it is ambiguous, and "prev" is not. Either is fine
>> > by me.
>> 
>> OK, so who's gonna do the honors?
>
> I was hoping to give David a chance to submit his first-ever patch to
> git.

OK. David, is it OK for us to expect a patch from you sometime not
in distant future (it is an old bug we survived for a long time and
nothing ultra-urgent)?
