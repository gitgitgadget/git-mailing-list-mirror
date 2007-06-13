From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make git barf when an alias changes environment variables
Date: Tue, 12 Jun 2007 22:21:56 -0700
Message-ID: <7vejkgh1jf.fsf@assigned-by-dhcp.pobox.com>
References: <20070608205755.GA21901@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jun 13 07:22:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyLIu-0006KX-IA
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 07:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbXFMFV7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 01:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbXFMFV7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 01:21:59 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40997 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbXFMFV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 01:21:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613052157.XVBH2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Jun 2007 01:21:57 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AtMw1X00Q1kojtg0000000; Wed, 13 Jun 2007 01:21:57 -0400
In-Reply-To: <20070608205755.GA21901@moooo.ath.cx> (Matthias Lederhofer's
	message of "Fri, 8 Jun 2007 22:57:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50015>

What does this patch do when you do this?

	: Because I usually work with this repository...
	$ GIT_DIR=$some_repository
        $ export GIT_DIR

        : Then much later, I happen to visit another repository
        : to take a peek...
	$ cd $somewhere_else
        $ git --git-dir .git some-command

I think --git-dir request on the command line is primarily to
allow overriding whatever the user has in the environment as the
fallback default, so if the patch makes it barf that is not very
nice.


                
