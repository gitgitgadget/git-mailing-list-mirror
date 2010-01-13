From: Junio C Hamano <gitster@pobox.com>
Subject: Re: default behaviour for `gitmerge` (no arguments)
Date: Wed, 13 Jan 2010 15:13:12 -0800
Message-ID: <7vska9k393.fsf@alter.siamese.dyndns.org>
References: <loom.20100111T185144-655@post.gmane.org>
 <7v7hrojukz.fsf@alter.siamese.dyndns.org>
 <20100112162355.GB25092@coredump.intra.peff.net>
 <7vhbqr2nxt.fsf@alter.siamese.dyndns.org>
 <20100112182550.GA15696@coredump.intra.peff.net>
 <7vwrzmqypn.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001131024420.3043@intel-tinevez-2-302>
 <7v6376pc9w.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001131202510.3043@intel-tinevez-2-302>
 <7vpr5dn5vt.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001132348570.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Gareth Adams <gareth.adams@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 00:13:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVCP1-0007jZ-P0
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 00:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab0AMXNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 18:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177Ab0AMXNY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 18:13:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab0AMXNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 18:13:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A8BF90EC1;
	Wed, 13 Jan 2010 18:13:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4EaeOSpj0EC/sO3CliLKyTi99cY=; b=nAldQL
	GQi3dDEQfngqHL95QuaJp0NbKJXk9IoGiiTLEd8zEs0JNhLXMXzAfnzIIhnxQvXA
	w9tVc8hyzUBgYybM5JzhMAO9K8J5IwxtZgg3rrg6la+79BjKHF28VEEotWzwgZLB
	yrnIfh36lPgA5HqgObLddB0glZc7NruS1ydiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fw+RpTe5SWbyBmDlVIXZ41RaU/r9HR1q
	nrRXIDYnsumbntluhQb4IMRnOq1x3wBeicy66gwTNMyxJ75ouadX4y0zEiO5YHju
	kp1HvlZsMtNG4jtUkik4XUfjlHIV4QXIJy9eJtUpVwXQguzPTbqnX4OvzaK7iW9W
	/1V+BDDtWjs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA0BA90EBE;
	Wed, 13 Jan 2010 18:13:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1D2F90EB7; Wed, 13 Jan
 2010 18:13:13 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1001132348570.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed\, 13 Jan 2010 23\:49\:30 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3C7DC9C0-0099-11DF-99F1-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136895>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> What I was asking was:
>> 
>> 	*PROVIDED* *IF* you wanted to keep the same semantics between
>>          them, then you would have patched i-b-n, but you didn't.  Was there
>>          a reason callers of s-b-n should know about @{u} but callers of i-b-n
>> 	shouldn't?
>> 
>> Expected answer was either:
>> 
>> 	(a) Codepath X that uses i-b-n shouldn't interpret @{upstream} as
>>             a symbolic name given by the user, but it should treat it as a
>>             mere SHA-1 expression instead for *this and that* reason.
>>             Otherwise we will see *this* breakage when the user does
>>             *that*.  That is why i-b-n doesn't know about the new syntax;
>>             or
>> 
>> 	(b) It was a thinko; all codepaths that use i-b-n should know the
>>             new syntax as they _are_ interested in learning the symbolic
>>             name when the user gives @{upstream}.
>
> And I gave answer (c): I do not remember.

That's fine.  As long as we know it is (c) (your earlier response sounded
as if you were saying (b)), we know that there might be issues we need to
find and carefully look at before using this topic.
