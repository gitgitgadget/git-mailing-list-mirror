From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-completion.bash for use in zsh
Date: Tue, 20 Mar 2012 11:20:08 -0700
Message-ID: <7vpqc75e3r.fsf@alter.siamese.dyndns.org>
References: <4E5F8CF3.3060304@randomguy3.me.uk>
 <4F686FA2.8070803@randomguy3.me.uk> <7vr4wn6y2k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Alex Merry <kde@randomguy3.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 20 19:20:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA3fQ-0001Tg-Fr
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 19:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299Ab2CTSUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 14:20:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45947 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab2CTSUL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 14:20:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E0A569C4;
	Tue, 20 Mar 2012 14:20:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iYN+aW7T6E3ZNSPxoGm52Ce9+2s=; b=oBAod1
	uO+lyqHhkInXgUocbIlPuxJCNJvUf/fR3JbtzE9uk8eh7E2YoVp6Cy3jFvuPWEoo
	cS+/Tj09vhRqapFcKwYV7hZvnWULmLAThaRGJ1E2aH3uzPPgIhhgSwSLVcQHsHgx
	5urxDI/vmoTHfWrRddge/dsTbDkILYIWs4Two=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nBHpjnF0Ydj/RFhv9lq6ZMEUY9z4cQSB
	GdtDJ4GfyaCM6w2c/EVfQ+AotXI/lul7xa/Snbj7rbnVrsnv63sfyCu6LJXQaRA/
	C638CohHoimkJHQJbESYtHZRoEKEUTPmzL7J98XPjWzrUQk4zseHsG+ZZ9fCH1ev
	eBMPAWTD4kc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5542269C3;
	Tue, 20 Mar 2012 14:20:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9FD669C2; Tue, 20 Mar 2012
 14:20:09 -0400 (EDT)
In-Reply-To: <7vr4wn6y2k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 20 Mar 2012 09:23:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53CE9D2C-72B9-11E1-BBC8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193529>

> Alex Merry <kde@randomguy3.me.uk> writes:
> ...
>> On 01/09/11 14:47, Alex Merry wrote:
>>> Certain versions (or option combinations) of zsh appear to treat
>>> things like
>>> local some_var=()
>>> as a function declaration.  This makes errors appear when using it in
>>> combination with the GIT_PS1_SHOWUPSTREAM option.

The change in this patch itself may be innocuous, but we would point at
the log message of the commit this patch would create to the next person
who would write "local var=()" in contrib/completion/git-completion.bash
file and tell him to fix his patch.

And for that purpose, the above log message is way too vague.  It is
unclear how the problem can be reproduced ("Certain versions"??? "option
combinations"???  Even if you do not exhaustively enumerate the condition,
you at least should be able to say which *one* version you observed the
problem with, and with what option combinations).  It does not even say
what symptom to expect ("errors appear"???  What error message would one
get?).  We would need a more useful explanation to help people who make
further changes to the code.

Also, the original patch was whitespace damaged IIRC.
