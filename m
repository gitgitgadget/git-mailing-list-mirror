From: Junio C Hamano <gitster@pobox.com>
Subject: Re: who's on first? - following first parent and merge-management
Date: Wed, 07 Mar 2012 23:38:05 -0800
Message-ID: <7v8vjbfspu.fsf@alter.siamese.dyndns.org>
References: <jj6s47$m98$1@dough.gmane.org>
 <7vwr6woo8p.fsf@alter.siamese.dyndns.org>
 <7vty1zfwmd.fsf@alter.siamese.dyndns.org>
 <20120308071403.GE7643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 08:38:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5XvU-0007Qb-7k
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 08:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab2CHHiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 02:38:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab2CHHiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 02:38:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9DE9447E;
	Thu,  8 Mar 2012 02:38:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SUPc/XjKIhrkBmkf8/Do1DpzD+k=; b=dCAT5Q
	EFfGhCHu0cM50X4w7rTfp7ASOWO9VK1+uz5a8sxPRD+0v8SGGqRU4TDFnn0qQGCu
	DKssbz1P+bWY1sxhJM6gs4ktlJofwpK0rcha6hBFCLH/Vdve9orhHd0JN4k3sn2i
	k7NMGrJIXGLm7OxJQeC9K+Xmb8K6AzOrqoja4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bm2XLLTZf8ImLps4RMd+dcUnWnfb4jTP
	PybQvm0hkCzhBT5C9mBQfgSc710THjmPm6bvK7Bzc+WWZ8RQuZZ86n/1cApwjMKW
	mJwu76N91GBYLeIOOVqQEksFYOPPIUd/Kegu0IsWa8rm7BmtxBgyFdvMGYQFuVQP
	LoFWjQ3WfD0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFED1447D;
	Thu,  8 Mar 2012 02:38:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48A08447C; Thu,  8 Mar 2012
 02:38:07 -0500 (EST)
In-Reply-To: <20120308071403.GE7643@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 8 Mar 2012 02:14:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5A1EA68-68F1-11E1-9465-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192533>

Jeff King <peff@peff.net> writes:

> This gave me an idea that I think is probably crazy, but that I hadn't
> seen mentioned before.
> ...
> You could extend it to topic branches, too ("refs/heads/master >
> refs/heads/jk/*"). Of course, depending on your workflow, you might
> _want_ to have them flipped. I.e., when it is not just laziness or lack
> of understanding, and you really are making a merge commit to say "topic
> XYZ depends on something that is now in master, so let's merge that in
> before continuing topic development".

It certainly is *fun* to think about, and in a way it is sort-of in
line at least in spirit with the -m option to the "revert" command
to give the user run-time control over the order of the parents when
creating a new merge commit object.

But I agree that people are overly and needlessly interested in
first parenthood.

> So I think the primary audience would be people doing clueless
> centralized-repo development. Of course you'd perhaps want to flip the
> merge message, too. And I do think people are overly-interested in
> --first-parent in the first place, so the effort of specifying the
> parent ordering like this is probably not worth it.

As I already said in my first message in this thread, using shared
central repository workflow does not make one a bad person, let
alone clueless.  It just means that the first parenthood is not a
suitable tool for summarlizing their histories, and there are more
suitable ones such as shortlog that would apply equally well to all
workflows regardless of the parent order.
