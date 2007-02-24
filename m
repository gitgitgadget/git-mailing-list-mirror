From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Fri, 23 Feb 2007 20:58:07 -0800
Message-ID: <7vbqjk17a8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702232046300.29426@xanadu.home>
	<Pine.LNX.4.63.0702240314250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702232123110.29426@xanadu.home>
	<Pine.LNX.4.63.0702240336130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702232141040.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 24 05:58:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKozF-0004R1-By
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 05:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933383AbXBXE6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 23:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933387AbXBXE6J
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 23:58:09 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57018 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933383AbXBXE6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 23:58:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224045808.UGAP2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Feb 2007 23:58:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TGy71W00B1kojtg0000000; Fri, 23 Feb 2007 23:58:07 -0500
In-Reply-To: <alpine.LRH.0.82.0702232141040.29426@xanadu.home> (Nicolas
	Pitre's message of "Fri, 23 Feb 2007 21:47:46 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40502>

Nicolas Pitre <nico@cam.org> writes:

> And it is not like if the whole thing was thrown away.  For example I 
> think messages like
>
> 	remote: Writing 1234 objects.
>
> are good messages to have in a log file even when progress display is 
> filtered out.  So the sideband demultiplexing is useful in that case as 
> well.

In that case, maybe we should define a separate sideband for
progress display?  Currently #1 (payload) and #3 (emergency
exit) are distinct but #2 corresponds to stderr which has info
messages and progress noise all mixed up.
