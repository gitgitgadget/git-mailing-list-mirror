From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: Handle "git show" output correctly
Date: Wed, 12 Sep 2012 14:18:53 -0700
Message-ID: <7vpq5raqiq.fsf@alter.siamese.dyndns.org>
References: <1347472823.12986.3.camel@eddie.install.bos.redhat.com>
 <1347473304-21418-1-git-send-email-pjones@redhat.com>
 <7vtxv3atvu.fsf@alter.siamese.dyndns.org>
 <1347482918.21933.5.camel@eddie.install.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Jones <pjones@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 23:19:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBuKw-0008H7-3j
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 23:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab2ILVS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 17:18:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47813 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194Ab2ILVS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 17:18:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7A5D92D9;
	Wed, 12 Sep 2012 17:18:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQSHKS4v+oyJVX6p3oqnwpJGwGI=; b=lvHa84
	F0nXGX6cA+f0XAoS8CeTZXLFfo1oWnxjLF4umHYwMO0JlTIcgA2ysprlCSSHbTqe
	2iqPZjM2bLXAUV5LWa8sjuluSNB2WIlfi5Pf1yIyTX6bNu90vR2XbIHjnLsv6l+N
	0jNBM0rpY3mGDsfeFs4F6fTRDC5vLAEbbRWa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mO91MRwBVJNaD1EFSlVnKRfbsAF/p5VR
	/5LE0cv7Ahjfrp9j1NcG7uFZPksuK2iCCCrRBUJMMkQ/9UD8vYIOD41YUyglY0tw
	j8k6Fwh2tbm3qVbskLAEydh7fxKkz/7Vitlj2Lba0XBWVoH/C5dy3gFAfAGKlu5I
	ORS+YKHCwq8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C457492D8;
	Wed, 12 Sep 2012 17:18:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30A2092D4; Wed, 12 Sep 2012
 17:18:55 -0400 (EDT)
In-Reply-To: <1347482918.21933.5.camel@eddie.install.bos.redhat.com> (Peter
 Jones's message of "Wed, 12 Sep 2012 16:48:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75549C80-FD1F-11E1-A70D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205340>

Peter Jones <pjones@redhat.com> writes:

> Well, if that happens, maybe we could regexp match on
> "[[:alnum:]_-]+: /someexprthatlookslikeanemailaddress/" ?

I doubt that would be even reliably done.

> But we could
> also just wait to cross that bridge until we get to it?

Not really.  If we start encouraging people to use "git show" output
as a kosher input to "am", we would have to support such use
forever, and we end up painting ourselves in a corner we cannot get
out of easily.
