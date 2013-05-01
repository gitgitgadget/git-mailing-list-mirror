From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Wed, 01 May 2013 11:53:39 -0700
Message-ID: <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXc9z-0000y6-I0
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074Ab3EASxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:53:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755776Ab3EASxm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:53:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE1FC1BE0C;
	Wed,  1 May 2013 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kheF9W3bXPy3Yr7VscY/YgYm7W4=; b=O8SjsU
	amGmhrWjeDOjsdwi7q+y5hf/70Nt72yvGijjxUe/Iht5vOgQMaamec6Z/m3v/m1c
	WJmANSG+N9Q25COSN5WPwBSE9J811SLRpo0gAt8N5plXhBHkBTGN8QcpKaPncScS
	iGnLKrkEU+/1o8B1FLHPBuYhmR8nbOT0LeSNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t6KTqRur9G2k0+uzqKpdOouYV0WYYM+4
	8D5cjmk4eiuWqpnIjFXLXDEDCBou3AjsWcmnYZckJNnZH/MsT6uLUWPNc5HU6iuP
	u9bnzoUSSZXR4nJbxRhwmB5NK9oCI75f0XysGBzt+HEA8TrBIusUVv2YbVGEP7Mp
	o+RrIsBWrnY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1CD31BE0B;
	Wed,  1 May 2013 18:53:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32F291BE05;
	Wed,  1 May 2013 18:53:41 +0000 (UTC)
In-Reply-To: <1367425235-14998-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 1 May 2013 21:50:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70CF2F14-B290-11E2-B7AF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223123>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> To emphasize what we're testing in @{1}@{u}, document that @{0}@{0} is
> also nonsense.  This makes it clear that @{<n>} does not resolve to a
> ref whose upstream we can determine with @{u}/ reflog we can dig with
> @{0}.
>
> Since HEAD is implicit in @{},...

Just making sure.  HEAD@{$n} and @{$n} for non-negative $n mean
totally different things.  @{0} and HEAD@{0} are almost always the
same, and @{1} and HEAD@{1} may often happen to be the same, but as
a blanket statement, I find "Since HEAD is implicit in @{}" very
misleading.

As you and Felipe seem to be aiming for the same "Let's allow users
to say '@' when they mean HEAD", I'll let you two figure the best
approach out.

One productive way forward might be to come up with a common test
script pieces to document what constructs that spell @ in place of
HEAD should be supported, and much more importantly, what constructs
that happen to have @ in them should not mistakenly trigger the new
machinery.

Have fun ;-)
