From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6] Add contrib/credentials/netrc with GPG support
Date: Thu, 07 Feb 2013 22:15:48 -0800
Message-ID: <7vhaln49gr.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com> <87fw1ar3og.fsf_-_@lifelogs.com>
 <87ehgvua6h.fsf@lifelogs.com> <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com> <7vhalqsfkf.fsf@alter.siamese.dyndns.org>
 <8738xaqy40.fsf_-_@lifelogs.com> <7vip66qu0u.fsf@alter.siamese.dyndns.org>
 <7vtxpqnwiv.fsf@alter.siamese.dyndns.org> <876226p97h.fsf_-_@lifelogs.com>
 <7vtxpn4r7a.fsf@alter.siamese.dyndns.org> <87mwvfbmgi.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 07:16:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3hFu-0004BR-4Q
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 07:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915Ab3BHGPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 01:15:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307Ab3BHGPu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 01:15:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BFA07EED;
	Fri,  8 Feb 2013 01:15:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kaoTrsaZm9Dgb2Gj4JtSfMHB9Tw=; b=R/Dp2s
	1JW1CL565S0k2CXJYssAPCH/JkP0Xwsvj0jJBCH4H9/Xa3ezhBz0m+zyy1COKj6e
	W1WO+4satrT9o08uLsyhXZtXoqDLM+RfXr58AZvc3r0my2L25NUu71B86usDAXe8
	c/zvRE1De/nf4XBNaU5slHbtS32X9ataCb1vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CWP7J0EQQg6jc/tsawVaHBB1YYPV9Jgx
	GeAV4knwO37XSD9gpuSL1HPs2UOwE0RI+ZDdmVyIMS8cE8r/TsP92R2PUtPCm+hR
	gXyXOBDk9ZSQEMSuArfPjNPenDGWHfD7HLYLvQ1GTRTe5bWXXciDjk9zACJ64o1a
	A0GoCff5dkU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FF2E7EEC;
	Fri,  8 Feb 2013 01:15:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DB5F7EE9; Fri,  8 Feb 2013
 01:15:49 -0500 (EST)
In-Reply-To: <87mwvfbmgi.fsf@lifelogs.com> (Ted Zlatanov's message of "Thu,
 07 Feb 2013 20:53:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FBC56270-71B6-11E2-99B2-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215758>

Ted Zlatanov <tzz@lifelogs.com> writes:

> I agree this Makefile is not a good test to ship out.  It was my quickie
> test rig that I should have reworked before adding to the patch.  Sorry.

Nothing to be sorry about.  Starting with quick-and-dirty and
polishing for public consumption is what the review cycle is about,
and we are here to help that process.

> I see contrib/subtree/t and contrib/mw-to-git/t that I could copy.  The
> test will have a few files to parse, and will be able to compare the
> expected to the actual output.  Does that sound like a good plan?

Yup.

Thanks.
