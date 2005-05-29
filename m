From: Junio C Hamano <junkio@cox.net>
Subject: Re: change of git-diff-tree and symlinks
Date: Sun, 29 May 2005 11:55:57 -0700
Message-ID: <7vwtphn9oi.fsf@assigned-by-dhcp.cox.net>
References: <20050525111711.GA27492@vrfy.org> <4299CED5.5070508@roemling.net>
	<20050529150656.GA27127@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jochen Roemling <jochen@roemling.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 20:54:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcSux-0003un-83
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVE2S4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 14:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVE2S4F
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:56:05 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:9621 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261228AbVE2Sz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 14:55:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529185556.RQBM23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 14:55:56 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050529150656.GA27127@vrfy.org> (Kay Sievers's message of
 "Sun, 29 May 2005 17:06:56 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

>> Also there is a new parameter '-p' that allows the output of a patch 
>> directly instead of creating it with the help of temporary files as you 
>> do it in gitweb.

KS> Sure, gitweb did the diffs before git was able to do that. And it does
KS> not really matter who is creating the temp-files, the cgi or the
KS> git-binaries. :)

I agree that you are doing the right thing here.  In a scripted
environment it usually is more sensible not to use '-p' unless
generating the diff is the _only_ thing you are doing.  '-p' is
primarily for people who ends up using the bare plumbing
interactively.

KS> If things are stable some day, I may switch that over and maybe even
KS> support the nice rename detection.

Sorry for being the primary culprit for the disruption ;-).

You do not have to use '-p' to be able to use rename detection
nor any other diffcore stuff.  If you are processing
"git-diff-tree -r" output right now, you can already process
"git-diff-tree -r -B -M -S'foo' -Oorder" output just fine and
leave your downstream processing the same as is.



