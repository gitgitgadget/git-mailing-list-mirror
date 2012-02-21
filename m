From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how do you review auto-resolved files
Date: Tue, 21 Feb 2012 15:52:25 -0800
Message-ID: <7vobsreocm.fsf@alter.siamese.dyndns.org>
References: <ji0vik$e48$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 00:52:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzzVZ-0000le-0w
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 00:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674Ab2BUXw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 18:52:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755384Ab2BUXw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 18:52:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F25DF761C;
	Tue, 21 Feb 2012 18:52:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y98cO5fDmZH6VbmkuyQ+v4bquNU=; b=ohj1xD
	pbkfo1/wJW3fEG4B8u2hVB2hJ/CaLUrY8UZBUW2+hj/uk7GqCe2oZgee0BCRO9Uw
	eECa1e7F5/qlvbO+Zbd3FvpN1bG5ATnpyhEnPBD4tjGB/svKnYjahkiczybioR0u
	wHQQxbwILGqKQAoL8qMAQzK7lFXYf6Q6FVAJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NkysZCz1ijSayLtg0no0Z22IvZRf2u/B
	7Y3RBp+QTEbIVnyYaglfUX9ly/ST59Xnr1HCtCsNmORaX6RGWPL+0ziX4QNDAB15
	WrZupvPuwiIaMpSgDFa70sdoMYXFecX46TAPpH3Dq5jvpHrc7jfdizrD0i99KLuq
	mXyPjMUkKBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9022761B;
	Tue, 21 Feb 2012 18:52:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EDBF7619; Tue, 21 Feb 2012
 18:52:26 -0500 (EST)
In-Reply-To: <ji0vik$e48$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Tue, 21 Feb 2012 14:41:57 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B6F3D16-5CE7-11E1-BEFC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191199>

"Neal Kreitzinger" <neal@rsss.com> writes:

> If I expect/assume you are going to review the 
> auto-resolutions after-the-fact then you can neglect this because you:
>
>   - have become complacent that git usually does-what-you-want so "you don't 
>     really need to do it",
>   - are lazy and do it half-way,
>   - forget to do it,
>   - think "git magically does your work for you",
>   - don't know how to do it,
>   - don't even realize that anything auto-resolved or what auto-resolved,
>   - decide you don't have to do it because that is what testing if for,
>   - you think that your time is so valuable that an ounce-of-prevention on 
>     your part is not worth a pound-of-cure on the part of others.

A couple more bullet points I can think of off the top of my head, after
making sure that you do not count what "rerere" does as part of the
"auto-resolution", to add to the above list are:

 - know git is stupid and errs on the safe side, punting anything remotely
   complex;

 - know that textual non-conflicts that occur in the same file have the
   same risk of having semantic conflict across different files, so
   singling out "touched the same file but did not conflict" any special
   is pointless, but in either case, the chance of having such a conflict
   is small enough that completing the merge (and other merges) first and
   then checking the overall result is more efficient use of your time,
   because you have to eyeball the result at least once anyway before
   pushing it out.
