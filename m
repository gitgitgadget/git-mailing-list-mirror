From: Junio C Hamano <gitster@pobox.com>
Subject: Re: default behaviour for `gitmerge` (no arguments)
Date: Tue, 12 Jan 2010 10:11:26 -0800
Message-ID: <7vhbqr2nxt.fsf@alter.siamese.dyndns.org>
References: <loom.20100111T185144-655@post.gmane.org>
 <7v7hrojukz.fsf@alter.siamese.dyndns.org>
 <20100112162355.GB25092@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gareth Adams <gareth.adams@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:11:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUlDU-0004oT-4f
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 19:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab0ALSLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 13:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531Ab0ALSLj
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 13:11:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab0ALSLi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 13:11:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EFDF904FC;
	Tue, 12 Jan 2010 13:11:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u0l4CkpnOMDfTCFN8nWjDnYmTKg=; b=rDKZs/
	+V1Bc1cn3hCEpZQKLpiopzmpUJQf0TjWquUCpg6kda98XXQ+ybCcHoqCvFkLglAl
	AJZXd/whJczbS6k+L9l/3gN6dsZIBNuJ+nYNXC9rzS750o9rIMJhS0o1nOEFCn/R
	Ojk60NKpwPXypq2NRgoaUye/FaJzgKDLUVqSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CV3Jzg5UmNI064KnYNe1KTMRCEOeL6Y6
	V7efaHN+P4WTsliWUvm2hwZfBt6eoT1s+sS4T4/Ks20wG9D0oKbl+Q3yV5vGXD+J
	CctL5/gB1NVkUluEm0TJq4AcOdDORlGAKOrvMq40Jnw5G5nPey9CLCX4tXsLOMWE
	mN1fEjSx9B4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 156FD904F8;
	Tue, 12 Jan 2010 13:11:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53FDB904F7; Tue, 12 Jan
 2010 13:11:28 -0500 (EST)
In-Reply-To: <20100112162355.GB25092@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 12 Jan 2010 11\:23\:55 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E98AC9C8-FFA5-11DE-9D6C-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136743>

Jeff King <peff@peff.net> writes:

> Hmm. If we had the oft-discussed-but-never-agreed-upon shorthand for
> "the upstream of" then we wouldn't need a special merge option. You
> could just do:
>
>   git merge %HEAD ;# (or git merge %, IIRC the proposal correctly)

I don't think "whatever _HEAD_ tracks" makes sense at the semantic level
(i.e. you don't do "branch.HEAD.merge") but a syntax for "whatever the
named _branch_ tracks" with "if a branch is not named, the current branch
is implied" (i.e. the one in parentheses) would.

It is an entirely different matter what the special syntax to trigger that
"upstream-ness" should be.  I vaguely recall @{upstream} or @{u} were the
concensus?
