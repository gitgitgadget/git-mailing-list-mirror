From: Junio C Hamano <gitster@pobox.com>
Subject: Re: PUSH_HEAD, was Re: disallowing push to currently checked-out 
 branch
Date: Tue, 17 Feb 2009 14:20:07 -0800
Message-ID: <7vy6w43duw.fsf@gitster.siamese.dyndns.org>
References: <7veixybw7u.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
 <76718490902161048i3c19bb43h30b1cfc62dd9a61e@mail.gmail.com>
 <alpine.DEB.1.00.0902162102180.6289@intel-tinevez-2-302>
 <76718490902161312j2aee999bga00d95231fa85647@mail.gmail.com>
 <alpine.DEB.1.00.0902162215200.6289@intel-tinevez-2-302>
 <76718490902161428k7d252a02i3e79e4f197608891@mail.gmail.com>
 <20090216225226.GB23764@sigill.intra.peff.net>
 <76718490902162153m6a524b2dv335be66a0f0294ca@mail.gmail.com>
 <alpine.DEB.1.00.0902171200250.6185@intel-tinevez-2-302>
 <76718490902170929v3ed9e3c2tb2f7fb1bfc01b3ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 23:22:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYK5-0005aJ-50
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 23:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbZBQWUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 17:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbZBQWUT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 17:20:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbZBQWUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 17:20:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 92D492B59C;
	Tue, 17 Feb 2009 17:20:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 81EA92B55C; Tue,
 17 Feb 2009 17:20:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26BBD0E8-FD41-11DD-8DD8-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110456>

Jay Soffian <jaysoffian@gmail.com> writes:

> So both you and Junio have changed your mind since that thread then.

At least I didn't.

I personally was not too worried about protecting either local branches
nor the current branch (and I do not lose sleep over them now either).
Either is about forbidding an end user who knows from doing an operation
we have allowed so far, only because an abuse of the feature by other end
users who either don't know what they are doing or are careless can result
in confusing the latter.  I do not particularly like that kind of safety
valve.

The current round of protecting only local branches is there because it is
of much lessor impact, with simpler code (and easier revertibility if
needed), than the full blown "protect these branches" one in which issues
in its design still has to be ironed out if we go that route (see my other
message from yesterday to Jeff --- we discuss exactly that in the context
of detached HEAD and other operations).  The need for "current branch
protection" this round implements also comes from an observed confusions
in real world users Dscho and others saw on #git and other places.  The
more general "protect these branches" is conceptually nicer but the need
for such safeguard is still under discussion as far as I understood what
was said in the recent discussions.
