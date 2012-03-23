From: Junio C Hamano <gitster@pobox.com>
Subject: Re: howto handle name clashes
Date: Fri, 23 Mar 2012 11:25:55 -0700
Message-ID: <7vlimrtbrg.fsf@alter.siamese.dyndns.org>
References: <4F6C7539.3080607@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Mar 23 19:26:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB9Br-0001xi-NK
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 19:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758693Ab2CWSZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 14:25:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756028Ab2CWSZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 14:25:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C818E7546;
	Fri, 23 Mar 2012 14:25:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=76FhPkc+rnwDOcglyJURyGP7NIE=; b=Ik7/35
	8xWwJ2qlM6qwpHpHmU//HiK/CTkP0qlyoIG+6sM3zrMp3koPAnTWmSCBvmWu+Dqi
	EPv60tOdAUuVYbO4i+GGSyezO1/qW3eNKCF3VVkqdLHFtGdlk0JskZMNU94i9ogW
	RK2/MJBs5RT+HnOZ8l95kIkKKZbLVO2NS0XT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D+02KYofbgDHdGsf0yH6paBrVfZCyzRd
	uyKTl2vqVilj5I1Y2lj+y428McFlZ8lyS8Jp0SxBgRJ8Vk1q9pCZeosb6eYtClZY
	x641p3rbm4JpL73adeaw6FOu8mNDnn0D580b4/DUmxyDj3KRLHQOFGhzXXHWMu3o
	NNMG30MLONQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFEA07545;
	Fri, 23 Mar 2012 14:25:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 564527544; Fri, 23 Mar 2012
 14:25:57 -0400 (EDT)
In-Reply-To: <4F6C7539.3080607@tu-clausthal.de> (Sven Strickroth's message of
 "Fri, 23 Mar 2012 14:06:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A22FFB2E-7515-11E1-9AFD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193786>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> how to handle name clashes for branches and tags? Is there anything I
> can add to the refspec to make the name unique?
>
> E.g.
> - for merging "git merge --no-ff refs/branches/test" works, but
> generates a not so nice default merge message. ("merged  commit
> refs/branches/test" instead of "merged branch test")

That's the price you pay for naming different things the same and having
to disambiguate it.

> - how to drop a remote tag/branch ("git push origin :test" does not work)

"git push origin :refs/tags/test"

It is sad that some people teach new people shorthand without telling them
that what they are teaching are merely shorthand and cause confusion like
this.
