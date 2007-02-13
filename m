From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PU PATCH] Fix git fetch for very large ref counts
Date: Tue, 13 Feb 2007 09:58:45 -0800
Message-ID: <7vfy9ax7l6.fsf@assigned-by-dhcp.cox.net>
References: <11713297014015-git-send-email-julian@quantumfyre.co.uk>
	<7vd54e4ufk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702131031180.6435@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:58:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1vW-0005Gz-6H
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbXBMR6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbXBMR6r
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:58:47 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:55333 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbXBMR6q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:58:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213175845.SGTQ4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 12:58:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P5yl1W00Q1kojtg0000000; Tue, 13 Feb 2007 12:58:46 -0500
In-Reply-To: <Pine.LNX.4.64.0702131031180.6435@reaper.quantumfyre.co.uk>
	(Julian Phillips's message of "Tue, 13 Feb 2007 10:39:41 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39558>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> And there I was thinking 0.5m was fast ... given how long I've been
> reading this list I really should have know better. ;)

Well, the only thing we need to do in fetching between two
repositories that are already identical should be to compare
ls-remote output from both ends and immediately declare victory,
and it is unacceptable for such an obvious no-op to take 30
seconds.  At this point it really is the shell loop that is
killing us.

> I only really made the changes so I could try your improvements to
> fetch out - if they aren't necessary because you're making it even
> faster then I really don't have much cause to complain.

I've applied your fixes to jc/fetch topic and merged it back to
'pu'.  Thanks.
