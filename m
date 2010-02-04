From: Junio C Hamano <gitster@pobox.com>
Subject: Re: http getpass function in msysgit
Date: Wed, 03 Feb 2010 18:32:10 -0800
Message-ID: <7vfx5hybmd.fsf@alter.siamese.dyndns.org>
References: <1976ea661002021918m19d9b37fx1872557d3c810e3a@mail.gmail.com>
 <7vpr4mrijt.fsf@alter.siamese.dyndns.org>
 <1976ea661002022148s544be10bie912295e04189864@mail.gmail.com>
 <7vaavp3i2n.fsf@alter.siamese.dyndns.org>
 <1976ea661002031756j2c2699b0hf7deb8febdce841b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 03:32:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcrW5-0005Dx-UJ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 03:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079Ab0BDCcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 21:32:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab0BDCcU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 21:32:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A8D19968EC;
	Wed,  3 Feb 2010 21:32:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F/y8cxIsVzYGN6Q3RY0bv5XICgA=; b=dSDSEB
	QcphrHOVc9mgWYYWxH+ZlG2t9Fb5ZaN8xSsLSXNsHTSNlEZhqd+nHGyZQ9e4GLdM
	+BZ7wyKJe870E/hvpReAaMuVmj/VI3QzObQNyp2VSplYCa0YsvsE7bSAsFhzF3wV
	p+7B9UJAR/ufV/Za0QTyrEGbh1fnhXa4twVnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O7LOHBUz/wL5angx09r7oXiDYqJpaEqF
	/PbqhE8k7MNDCU5UPPlElnbkrRYjrA5LNXc3PFgFGHmIMDYgMNi2KxXgOZ0FlD2k
	MZ+Vy/mo+osLIKBqgdtevgE5Kl+W0psUiBFgLQtUoZQ8yBqjHNc82y4l/bXOjtUv
	hgYm74YW/uY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77D0A968E8;
	Wed,  3 Feb 2010 21:32:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F5D8968E4; Wed,  3 Feb
 2010 21:32:11 -0500 (EST)
In-Reply-To: <1976ea661002031756j2c2699b0hf7deb8febdce841b@mail.gmail.com>
 (Frank Li's message of "Thu\, 4 Feb 2010 09\:56\:57 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 827D289C-1135-11DF-AE3F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138939>

Frank Li <lznuaa@gmail.com> writes:

> Can we direct use SSH_ASKPASS for all getpass and don't use GIT_ASKPASS at all?
> The logic will be come simple.

If you _really_ have to ask me,...

I'd suspect people would feel it funny if the only advertised interface
were SSH_*, especially when they don't use OpenSSH at all and setting up
the prompter solely to use git over http.  If you use GIT_ASKPASS as the
advertised _primary_ interface to drive the prompter, while falling back
on SSH_ASKPASS as a mere end-user convenience measure, you wouldn't have
that problem.  Hence my suggestion.

But in the end it's up to you to decide.  I won't be writing this code
;-).
