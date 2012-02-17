From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff
 and Git
Date: Fri, 17 Feb 2012 09:25:36 -0800
Message-ID: <7vwr7ltlrj.fsf@alter.siamese.dyndns.org>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
 <20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
 <7v8vk2zghl.fsf@alter.siamese.dyndns.org> <vpqty2px4l5.fsf@bauges.imag.fr>
 <7vmx8hvb69.fsf@alter.siamese.dyndns.org> <vpqobsx7d9s.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Haga <timhaga@ebene6.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 17 18:25:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyRZ4-0002tW-HZ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 18:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab2BQRZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 12:25:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402Ab2BQRZl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 12:25:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 937AD7DCA;
	Fri, 17 Feb 2012 12:25:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zCwMHrDo67p09UC11IH+W7EPan4=; b=FhqgME
	u0H7b61BQR095vDjkGDWLaQWqc5acPgLegNHzJ9gLjOvfKT1Shkr0OgYRDh4sc2o
	x83TaQDHT2NqU9fAdyziiu0gRS+zEE/UkW0euWBoS9cac/Dke+IlBdiIjnYZpX6B
	XTIhzk3xpPnFJXpkN9vVUjonHlKlJ5gXJMngA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uK4EOfYuiF04huOAf8suFPG0jNWMQPsr
	gR5CKRDF7TXlLHWU824WiLWj7DhlOLkLWcph4hXTbfQcGcew1mvPUTiB3EC6Ld1v
	YRuzsQyiEoWUT5Of5jFHsYZE8Wi3V6mK7fMNy4zXdVkbgY8m5xdGlAwE4kpzozhr
	A8CHYj/dqyQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B2C07DC9;
	Fri, 17 Feb 2012 12:25:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B6C37DC8; Fri, 17 Feb 2012
 12:25:39 -0500 (EST)
In-Reply-To: <vpqobsx7d9s.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 17 Feb 2012 15:19:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69A5AE10-598C-11E1-B588-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190966>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> Look at what we have in the contrib/ area.  I think what is common among
>> them is that their primary benefit is to enrich user's Git experience.
>
> ... and many of them is to enrich the user experience using Git with
> another tool (shell, text editor, foreign VCS).

... where the amount of the benefit they get does not change regardless of
the payload.  That is what makes them tool in Git users' toolbox, not
shell scripters' or p4 users' toolbox.

> Git's _core_ already has some code to show diff hunks for various
> languages,...

I would have to say that it is an oranges vs squirrels comparison.  I do
not see a justification to reject an addition of an entry to an array that
adds a few strings of regexp to drive the mechanism that is already in
core, when it gets compiled in, and it is useless by itself outside Git.
Unless the language is something obscure, that is.

Read git-latexdiff that is a free-standing 200+ line script again
yourself. The use of Git in the script is not more than how you would
emulate what you would use "cp -r" in order to populate the old/ and new/
directories if the two versions were stored in the file system outside
Git. If you rip the part that deals with "the two versions happen to be
stored in Git" out, the remainder deals with parsing the command line,
interfacing with latex and reporting the result, none of which is in any
way Git specific.  That is much larger part of the script, which I view as
a clear sign that it is an application to serve the need for LaTeX users
better, which happens to be written for the subset of LaTeX users who have
their contents in Git.

Aren't there LaTeX tools archives that would be a much better home for
this tool?
