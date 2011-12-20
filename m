From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-sh-setup: make require_clean_work_tree part of
 the interface
Date: Tue, 20 Dec 2011 11:25:01 -0800
Message-ID: <7vwr9rjbaq.fsf@alter.siamese.dyndns.org>
References: <c53feb0de8006c205fd26c2c07dcd78bd86b6c24.1324378986.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 20 20:25:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd5JG-0006Ea-92
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 20:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348Ab1LTTZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 14:25:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59187 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611Ab1LTTZE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 14:25:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D452A7C8D;
	Tue, 20 Dec 2011 14:25:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qQibWZMsGlAbcSjWc8q2H90QFg4=; b=NBr5PP
	OdCo9XYOoE2z17jVr/Pk2t1VECPoyfltEa6AlP9WDQRI3caNPzTjYtZ5rt2u/jXO
	ltzHFG7rNFm4exSitle6nSTyIRbU5lokv3ruPVpHof9AtcbI3R4GJ7WOhbbha2U/
	v2ZfcMht/ik3RqBkgD22Jqe5UxGekjxbrDK7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VZormVqPTLOP21ghKNdbDZtzvVgbNETU
	79k6zY30rC5bLZmYSoCmblcZ4OkFh7LiITW6ZkNWX8hrFMKgUZt/AJ+KKFZV6sd4
	T255KK47WBwWbH+U8m6PbJYi1yqR2ZJuU2tqwIUaUyTashv1+Cyp+6jOP48/PGxv
	s6EiF/jJ6nk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD1677C8C;
	Tue, 20 Dec 2011 14:25:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E4737C8A; Tue, 20 Dec 2011
 14:25:02 -0500 (EST)
In-Reply-To: <c53feb0de8006c205fd26c2c07dcd78bd86b6c24.1324378986.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 20 Dec 2011 12:09:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 505C952E-2B40-11E1-B181-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187518>

Thomas Rast <trast@student.ethz.ch> writes:

> 92c62a3 (Porcelain scripts: Rewrite cryptic "needs update" error
> message, 2010-10-19) refactored git's own checking to a function in
> git-sh-setup.  This is a very useful thing for script writers, so
> document it.

Can we avoid explaining "clean" with the same word "clean", which adds no
new information? IOW, what does "clean" mean in the context of this helper
shell function? No untracked cruft? No un-added changes? What are the kind
of dirtiness being checked?

> +require_clean_work_tree <action> [<hint>]::
> +	checks if the working tree associated with the repository is
> +	clean.  Otherwise it emits an error message of the form
> +	`Cannot <action>: <reason>. <hint>`, and dies.  Example:
> ++
> +----------------
> +require_clean_work_tree rebase "Please commit or stash them."
> +----------------
> +
>  get_author_ident_from_commit::
>  	outputs code for use with eval to set the GIT_AUTHOR_NAME,
>  	GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE variables for a given commit.
