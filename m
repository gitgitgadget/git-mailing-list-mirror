From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Sun, 31 Aug 2008 09:33:09 -0700
Message-ID: <7v1w05401m.fsf@gitster.siamese.dyndns.org>
References: <20080828171533.GA6024@blimp.local>
 <20080828212722.GF6439@steel.home>
 <7vsksm1pmd.fsf@gitster.siamese.dyndns.org>
 <81b0412b0808300944p29199600ie95c65404b6cb380@mail.gmail.com>
 <20080830171331.GA26932@steel.home>
 <7vprnqifd2.fsf@gitster.siamese.dyndns.org>
 <20080831135023.GA6616@blimp.local> <20080831135458.GB6616@blimp.local>
 <vpqk5dxqlya.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 31 18:34:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZpt6-0004PT-Kn
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 18:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbYHaQdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 12:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbYHaQdT
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 12:33:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYHaQdS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 12:33:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B1676EE92;
	Sun, 31 Aug 2008 12:33:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 03B576EE8D; Sun, 31 Aug 2008 12:33:11 -0400 (EDT)
In-Reply-To: <vpqk5dxqlya.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun, 31 Aug 2008 16:49:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 83C8A7D6-777A-11DD-8EFD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94492>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> It is off(0) by default, to avoid scaring people unless they asked to.
>> If set to a non-0 value, wait for that amount of deciseconds before
>> running the corrected command.
>
> Perhaps off should be -1 (or, say, anything negative), so that the
> value 0 can be used to mean "execute the corrected command without
> waiting".
>
> (not that I really care personnally, I'd probably keep it off anyway).

I do not want to suggest this because I do not think of a good way to
implement it myself, but it would be very nice if this feature can be
enabled by default for interactive session and disabled for scripts.

Well, actually I think I do ;-)

Perhaps have a bash alias that does:

	alias git="git --dwim"

only in interactive session (ensuring "only in interactive" is the
responsibility of the end user), with the global option similar to
the "--paginate" that "git" wrapper itself takes?
