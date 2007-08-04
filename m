From: Junio C Hamano <gitster@pobox.com>
Subject: Re: possible bug in git apply?
Date: Sat, 04 Aug 2007 13:00:06 -0700
Message-ID: <7v7iobjcjd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rob@landley.net
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Aug 04 22:00:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHPnI-0003Ay-RD
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 22:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765360AbXHDUAK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 16:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762892AbXHDUAJ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 16:00:09 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35913 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761513AbXHDUAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 16:00:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804200006.BLQL14885.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 4 Aug 2007 16:00:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Xw061X0071kojtg0000000; Sat, 04 Aug 2007 16:00:07 -0400
In-Reply-To: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
	(david@lang.hm's message of "Sat, 4 Aug 2007 12:45:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54900>

david@lang.hm writes:

> since git doesn't track directories, only content (per the big
> discussion recently) I beleive that doing a checkout would leave Rob
> without the directories that he emptied out, so shouldn't git apply
> also clear the directories to end up in the same state?

It should and it does, unless you have untracked files in that
directory that you haven't told git about.  Then removing the
directory along with these files will lose the files there,
which is a wrong thing to do.

A simple "rm -fr this/directory/is/no/longer/interesting/to/me"
would be all that is needed.
