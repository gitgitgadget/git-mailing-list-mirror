From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 16:44:49 -0700
Message-ID: <7v8vpqsn7y.fsf@alter.siamese.dyndns.org>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <vpqfwjzxu6i.fsf@bauges.imag.fr>
 <CA+55aFyGRM132OzoJR7wZ8wETvxrFWSmSMjMJnVOKP+6vys-Sw@mail.gmail.com>
 <201109141814.04752.johan@herland.net>
 <E9E05FA85D0F4461BAE9ECAFE25CD84E@PhilipOakley>
 <CA+55aFxFnAjpSAd+uB25BuZXBJGvN59qNMmF3fzvky8XK_DP0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Johan Herland <johan@herland.net>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 01:44:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3z8T-0006by-A6
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 01:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab1INXow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 19:44:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819Ab1INXov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 19:44:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 666334CC2;
	Wed, 14 Sep 2011 19:44:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hk3oPIOxcTc+pv6Zpo7q0cdAo2k=; b=L6z/sB
	ADOeHHg304ito7eeoGl/EwhrUi6S8/sNas0SbWHyXC6ZvnBFiU7CAEUSJxHaoPV4
	XHFSigFIrG7mLiZJaojvoa41YpZQP4IoqbAuytRq060r72NMvxWTMoJgXN8+Jl9Y
	YymtcxMwAFNRbQK56cVBY3WMHZi6aDGwXA0+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bTjYqiO9LQqOjdIjILdIBsapGk+4nZRs
	iDN40Bmp6QIs6G8Bk8QwKL5QYwzPT3nfM9rnj9tIsS0xOb72jWj8rtJOKDWg84gT
	2TwjmVvnGKRxgBNZQ91CLQIBATtIJXIUpw6DlVxC2lZjNUXYZyZuDN9w4QqlXhgx
	aVBmqX9MdoY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DB1D4CC1;
	Wed, 14 Sep 2011 19:44:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E14EB4CC0; Wed, 14 Sep 2011
 19:44:50 -0400 (EDT)
In-Reply-To: <CA+55aFxFnAjpSAd+uB25BuZXBJGvN59qNMmF3fzvky8XK_DP0A@mail.gmail.com> (Linus
 Torvalds's message of "Wed, 14 Sep 2011 16:30:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89CBE3DE-DF2B-11E0-AADD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181414>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Sep 14, 2011 at 3:51 PM, Philip Oakley <philipoakley@iee.org> wrote:
>>
>> Is one option to store the branch description (if any) on line two of the
>> <branch name> file in .git\refs\heads.
>
> Or even on line one.
>
> We already basically do that for the magic FETCH_HEAD branch, and use
> it to populate the merge commit. Extending that kind of thing to all
> branches might be a nice idea.
>
> Of course, then the question becomes "what about packed refs"? Do you
> just leave the unpacked ref in place for those?

Seriously, storage format is not an issue at all and you know it.  The
semantics is.

What commands use the description and for what purpose, how it is updated
when the branch is repurposed, how it is propagated to other repositories,
if there is a situation where two descriptions need to be merged, and if
so how that merge happens, etc., etc.

We could store it in unused part of loose refs. We could add [branch
"master"] description = ...  in the .git/config. The latter would even be
easier for humans to edit by hand.

If we want to use the description when merging locally, for example,
fmt-merge-msg needs to be taught to read it, which would mean we would
need an internal API "read_branch_description()", regardless of what
storage format we choose to use. If we want to use it for "git pull", then
the transport layer needs to become aware of it.
