From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Convert t6022 to use git-merge instead of git-pull
Date: Sun, 29 Apr 2007 00:17:46 -0700
Message-ID: <7vps5nejj9.fsf@assigned-by-dhcp.cox.net>
References: <20070425200718.GB30061@steel.home>
	<7vzm4wupew.fsf@assigned-by-dhcp.cox.net>
	<46332BFF.2050805@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 09:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi3fL-000402-E9
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 09:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbXD2HRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 03:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755009AbXD2HRs
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 03:17:48 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63625 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbXD2HRr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 03:17:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429071748.ZGEE1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 29 Apr 2007 03:17:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id svHm1W00N1kojtg0000000; Sun, 29 Apr 2007 03:17:47 -0400
In-Reply-To: <46332BFF.2050805@shadowen.org> (Andy Whitcroft's message of
	"Sat, 28 Apr 2007 12:11:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45822>

Andy Whitcroft <apw@shadowen.org> writes:

> Junio C Hamano wrote:
>> Is this really necessary?
>> 
>> I would rather want to leave some tests use "git merge" while
>> some others use "git pull ." to catch breakage of either form.
>
> If we are saying git pull . foo and git merge foo forms are the same
> then perhaps that whole bunch of tests should be converted such that
> they are in for cmd in "merge" "pull ." loop, so we test both always.

Not "whole bunch" needs to check they are the same.  Ideally we
would want to have a single separate test whose sole purpose is
to make sure they are the same, but if we do not have such a
test, the next best thing is to leave some test to use one way
while some others to use another.  In other words, consistency
is not necessarily better than diversity in tests.
