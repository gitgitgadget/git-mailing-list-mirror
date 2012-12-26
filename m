From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make __git_ps1 accept a third parameter in pcmode
Date: Wed, 26 Dec 2012 12:42:40 -0800
Message-ID: <7v7go4o88v.fsf@alter.siamese.dyndns.org>
References: <7vvcbpp846.fsf@alter.siamese.dyndns.org>
 <20121226191505.GA29210@simaj.xs4all.nl>
 <7vmwx0oavn.fsf@alter.siamese.dyndns.org> <20121226201944.GA15039@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: piotr.krukowiecki@gmail.com, git@vger.kernel.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Dec 26 21:43:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnxoc-0002od-Hi
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 21:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab2LZUmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 15:42:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab2LZUmn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 15:42:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF7D3AD97;
	Wed, 26 Dec 2012 15:42:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2UIOFlf08h0viFTF1Nd1b01JMbA=; b=hRr8p5
	JAaURRXYFKQw02K4x+WGfQft1ElOt6RexYytR0A5WY06kImxAYKzNBVt+HFzMJKR
	eZ7muJfHSD3HVdaifoJ3KWn4ige4iGD8FQPi3oBh7nJVQkSRtC8D03Xx3VrOkJY3
	VQWq9sfPGA1fQ7o+FJRAHtE77XVz0uV6JsFM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WVwghNalwPU156MwoDvhUAfnzdtIXMvU
	ZrRiwJB1EZrPFY4IQ6KGEJ8aY+tOdO36wzGYhVvh3VppKHBnDuBzFrpXuLg8twjG
	OZ7SA8tDtygwg93xISIt4hpqhqJCu7F0vecyfmdyfcs0ThZCZK92B8SHmYNreZKF
	F/49jOLjWzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBD4FAD96;
	Wed, 26 Dec 2012 15:42:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57F4FAD95; Wed, 26 Dec 2012
 15:42:42 -0500 (EST)
In-Reply-To: <20121226201944.GA15039@xs4all.nl> (Simon Oosthoek's message of
 "Wed, 26 Dec 2012 21:19:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB96C0B2-4F9C-11E2-887F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212152>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

>> Every time I looked at this line, I wondered why '*' state is
>> "bad".  Does a user go into any "bad" state by having a dirty
>> working tree?  Same for untracked ($u) and detached.  These are all
>> perfectly normal part of a workflow, so while choice of red may be
>> fine to attract attention, calling it "bad" sounds misguided.
>
> Well, I'm most often a really casual user of git and to make this
> function work the way I want to, I found out by trial-and-error
> that this was a way to test whether it's time to colour the string
> red or green ;-)
>
> I'm very open to better ways to determine the colour
> modes. Anyway, the colours are now more or less the same as what
> git itself uses when printing the status with colour hints in git
> status.

Oh, I am not opposed to the choice of colors; something that wants
an attention from the user may be better in red.

I was merely commenting on the choice of the variable name, the user
of word "bad" as if the conditions that use this color were "bad" in
some way.
