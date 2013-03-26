From: Junio C Hamano <gitster@pobox.com>
Subject: Re: patch series vs. multiple files changed in a commit;
 storytelling history vs. literal creation history
Date: Tue, 26 Mar 2013 15:03:29 -0700
Message-ID: <7vli99stse.fsf@alter.siamese.dyndns.org>
References: <CAJELnLE0FLrSYGHgS-cZmyQWO122-MuN7AeczUUVVposUg+qjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 23:04:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKbyL-00032V-Cv
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 23:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab3CZWDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 18:03:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62716 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab3CZWDd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 18:03:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 049CBB0C0;
	Tue, 26 Mar 2013 18:03:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J6dbxHNcXlM9w3K61GvcNZBg8Zw=; b=MzF4v0
	wt/qhTi8GWzBtqtTYdP1hIqrtckdWaRBg4zZdIunglmx8bIuyiSGTq7ZeaVKSdn/
	DY+9i5PU5forXEM/qXuQbW0xxXwi68iKj1MaumrZ/gvTPJtO2Va5sf/fDGsVKc5O
	/4kfroDXCDMEEX8h9jdZsLcxAhZUX/DXYOWPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AhcmRA6+wJ2S2ki92Qhm1nbuQnaHWLj3
	YCUp8yNF9pOZ/N1HZ3qagLPKgrzK6BkUvIy6buvwfB4Ql82j4zq9B2hAUVUoYya3
	jXa8i9qAjR3YSjqUWnC0OBek7McXK2XvAGTL3E/2mB6mDdxzOVAHkDxH5TSsJ5OA
	4az4p96HJxU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED412B0BE;
	Tue, 26 Mar 2013 18:03:30 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71440B0BA; Tue, 26 Mar 2013
 18:03:30 -0400 (EDT)
In-Reply-To: <CAJELnLE0FLrSYGHgS-cZmyQWO122-MuN7AeczUUVVposUg+qjw@mail.gmail.com> (Matt
 McClure's message of "Tue, 26 Mar 2013 17:21:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE760F5A-9660-11E2-AC6A-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219220>

Matt McClure <matthewlmcclure@gmail.com> writes:

> I've read Documentation/SubmittingPatches, followed some of the
> discussion on this list, and looked over some of the recent commit
> history. I'm impressed by the strong culture of review that produces
> readable patches and commit messages, but I think there are some gaps
> in my understanding of the prevailing process here.
>
> Most of the code I've worked on has been closed source, and the commit
> histories tend to reflect what I'd call the literal "creation
> history". Reading the Git history, my impression is that it reflects a
> different "storytelling" history. In some cases, that might be the
> same as the creation history, but in general the emphasis is on
> telling a coherent story of the changes to the other developers rather
> than communicating all the messy details of how you arrived at the
> order of that story. Is that right?

We do not try to keep records of "oops, the previous was wrong" when
we can easily tell the previous was wrong.  Usually such a shallow
mistake that can be spotted during the review is not worth keeping.

For example, the 4 patch series I posted today had three iterations
of botched attempts that were never even published.  I am sure other
people do the same for their initial round for their patches, and
any message on this list whose subject begins with "[PATCH vN X/Y]"
for N > 2 are rewritten betterment based on list feedback.

Our history tends to become a coherent story because of this.

It is a different story for more involved changes that cook in
'next' for a while and then later turns out to have flaws. We update
them with follow-up fixes and at that point, we do have records of
mistakes. They often are tricky cases that are worth recording, as
people can later make similar kinds of mistakes in other parts of
the codebase.

The early part of the history back when Linus was running the show
is somewhat different; you see more reverts and rewrites. But even
back then, there were more experimental changes that were rewritten
than the changes that were finally committed to the history.
