From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2nd try] runstatus: do not recurse into subdirectories if not needed
Date: Wed, 27 Sep 2006 21:40:50 -0700
Message-ID: <7v64f861t9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609271315470.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vac4k97if.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609280216350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0609280240060.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 06:41:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSnhf-0005Dc-L6
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 06:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWI1Ekw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 00:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWI1Ekw
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 00:40:52 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:2302 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751409AbWI1Ekv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 00:40:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928044050.YAUC16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 00:40:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Tggs1V01t1kojtg0000000
	Thu, 28 Sep 2006 00:40:53 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609280240060.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 28 Sep 2006 02:44:30 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27985>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This speeds up the case when you run git-status, having an untracked
> subdirectory containing huge amounts of files.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> ---
>
> 	On Thu, 28 Sep 2006, Johannes Schindelin wrote:
>
> 	Okay, so no more dir_is_empty(). Instead, read_directory_recursive()
> 	gets a flag. With this flag, "check_only", it exits as soon as it
> 	found valid entries, but does not add any. Way easier.

Yeah, the logic is a lot easier to follow.
