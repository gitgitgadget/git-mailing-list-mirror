From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 18:28:30 -0700
Message-ID: <7vr4rut4u9.fsf@alter.siamese.dyndns.org>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
 <7vehnvvyta.fsf@alter.siamese.dyndns.org>
 <20120729142458.GB16223@paksenarrion.iveqy.com>
 <CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
 <7vvch6uw89.fsf@alter.siamese.dyndns.org>
 <7vr4ruuu2e.fsf@alter.siamese.dyndns.org>
 <CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 03:28:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svemm-0000bB-RR
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 03:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab2G3B2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 21:28:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753377Ab2G3B2e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 21:28:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69C218372;
	Sun, 29 Jul 2012 21:28:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZqTfzK9EqFGd5otLqJUipJBPAbo=; b=lqDtTv
	HZne7hNo1mYUavgZuZRu7QEK0wzGiLfSOIwXtkJwnTkLjmVcyycug9YgCctWgL/U
	a7fOExEnqJB7g/B/9jnruM7BseysZAE0O3FCw6IoZvUGCyFaZmJ1EUZyc4qmesGY
	aVfFPKWjDIaiQCAFh0GinGgJuGzY3szZOqSH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fLG4G1mj1FCDAvkKNAePi630DeZVd/jW
	iAY2I0AesgqESx4hp0A46WFZlEXU1X4iFyXKphV/DRdt6Wb6klzQ29ILAi2Y/3kR
	q4/mpxCq2Ix4UscpbggUnMmiVDG9sbleS29UmRYiA5iyhdIs/B2IaQDemu2+8m4q
	EtdMPdu1GfU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 578888371;
	Sun, 29 Jul 2012 21:28:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEC6D8370; Sun, 29 Jul 2012
 21:28:32 -0400 (EDT)
In-Reply-To: <CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com> (Sitaram
 Chamarty's message of "Mon, 30 Jul 2012 06:34:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E008CEE6-D9E5-11E1-83EB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202516>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> As I may have said earlier, this interaction is far too site-specific
> to be rolled into git itself.
>
> How about a new hook instead?  A pre-pack-protocol hook that acts as
> if it was called by the remote user as a command, and if it exit's
> with 0, then the real pack protocol starts else it gets aborted.  Let
> him do whatever he wants in there.  Arguments to the hook will be repo
> name and command (git-upload-pack mainly).

Not very interested.  If it is _known_ to happen before Git protocol
proper happens, why not give the user something like the gitolite
command "D", that is interpreted by gitolite-shell without bothering
Git at all?

After all, at least you and I share the understanding that once the
conversation in Git protocol proper starts, there is no place for
such a random hook to affect further behaviour of the protocol, so
the approach "hook" can only solve narrow "before gitolite-shell (or
git-shell or whatever-shell) decides it is time to call Git" cases,
and the only way it can affect the outcome of the main conversation
is to abort it without graceful degradation, or let the main
conversation continue as if nothing happened.  I think we agree
between us that "a new hook", while it may be _a_ way to do
something new, is _not_ a good way to do so.  Why add such a wart?

> And even then, all we are doing is rolling into git something that he
> can very easily do outside right now on his own environment ...

Yes, that is a repeat of what you told him already, to which I said
"thanks for sanity", I think ;-).

I am not opposed to protocol enhancements, but a new feature that
has to change what either end does should be added properly at the
protocol level as a protocol capability, not added out of band with
band-aid, leaving the main conversation oblivious to what is going
on ouside.
