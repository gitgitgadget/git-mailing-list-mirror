From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix mishandling of $Id$ expanded in the repository copy in convert.c
Date: Sat, 26 May 2007 12:05:27 -0700
Message-ID: <7vveefiex4.fsf@assigned-by-dhcp.cox.net>
References: <200705251150.09439.andyparkins@gmail.com>
	<7vlkfcm2eu.fsf@assigned-by-dhcp.cox.net>
	<200705261012.50530.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 21:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs1aF-0000uq-NS
	for gcvg-git@gmane.org; Sat, 26 May 2007 21:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbXEZTFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 15:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbXEZTFj
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 15:05:39 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:35075 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557AbXEZTFi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 15:05:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526190538.ENFL22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 26 May 2007 15:05:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3v5U1X00J1kojtg0000000; Sat, 26 May 2007 15:05:36 -0400
In-Reply-To: <200705261012.50530.andyparkins@gmail.com> (Andy Parkins's
	message of "Sat, 26 May 2007 10:12:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48483>

Andy Parkins <andyparkins@gmail.com> writes:

> I had to jump through quite a few hoops to get the expanded $Id$ into a 
> repository (originally it was because I used an older version of git in 
> one place, and a newer one in another).
>
> I'll see what I can do to make a test case though.

Wouldn't it be sufficient to:

 (1) prepare a file with "$Id$", use ident in .gitattributes,
     check it in and commit;

 (2) remove it from the working tree, check it out with
     "checkout -f";

 (3) temorarily move away .gitattributes, modify the file, and
     check it in;

 (4) move .gitattributes back into its place, and commit.
