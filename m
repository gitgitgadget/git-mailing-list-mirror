From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] git-send-email: Add --suppress-all-from option.
Date: Fri, 21 Dec 2007 11:21:20 -0800
Message-ID: <20071221192120.GA13171@mail.oracle.com>
References: <1198216860-487-1-git-send-email-git@davidb.org> <7vfxxw7xkb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <git@davidb.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 20:23:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5nTJ-0005QS-39
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 20:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbXLUTXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 14:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbXLUTXW
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 14:23:22 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:57577 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbXLUTXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 14:23:21 -0500
Received: from agmgw1.us.oracle.com (agmgw1.us.oracle.com [152.68.180.212])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id lBLJMtVG008997;
	Fri, 21 Dec 2007 12:22:56 -0700
Received: from acsmt356.oracle.com (acsmt356.oracle.com [141.146.40.156])
	by agmgw1.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id lBKLecV4024388;
	Fri, 21 Dec 2007 12:22:54 -0700
Received: from ca-server1.us.oracle.com by acsmt356.oracle.com
	with ESMTP id 6501210631198264880; Fri, 21 Dec 2007 11:21:20 -0800
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.67)
	(envelope-from <joel.becker@oracle.com>)
	id 1J5nQu-0006F9-0u; Fri, 21 Dec 2007 11:21:20 -0800
Content-Disposition: inline
In-Reply-To: <7vfxxw7xkb.fsf@gitster.siamese.dyndns.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69084>

On Fri, Dec 21, 2007 at 09:43:48AM -0800, Junio C Hamano wrote:
> The option name feels as if it is somehow affecting From: but
> this is all about recipients.  It needs to be named better.
> 
> Even more importantly, git-send-email has too many places that
> pick up additional recipients.  I doubt --suppress-foo to
> suppress one such source "foo" is sustainable.  We should try to
> clean up the mess, not adding to it.

	Yay, even better that we're going to evaluate the sucker (I was
just complaining about this yesterday to someone, so how apropos that it
comes up on-list).
	First and foremost, I think git-send-email should not default to
anything.  It was quite a surprise, the first time I tried to use it, to
discover I had to add two options to ~/.gitconfig just for sane
behavior.  Never mind that I couldn't suppress the author-cc.  I think
that a naive "git send-email --to bob@bob.com foo.patch" should only go
to bob, period.
	We can then add ways to auto-cc.  I don't mind typing the extra
bits.  Heck, we could even define a --review that does what is currently
the default - cc-everyone-who-might-care-as-we-go-upstream.

Joel

-- 

Life's Little Instruction Book #99

	"Think big thoughts, but relish small pleasures."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
