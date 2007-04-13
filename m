From: Junio C Hamano <junkio@cox.net>
Subject: Re: Ignore BASE extension
Date: Fri, 13 Apr 2007 12:43:20 -0700
Message-ID: <7vslb4awmf.fsf@assigned-by-dhcp.cox.net>
References: <200704131233.13979.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 21:43:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcRgL-0000ZR-Qo
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 21:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbXDMTna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 15:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbXDMTn3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 15:43:29 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60216 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932184AbXDMTnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 15:43:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413194320.CONX1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Apr 2007 15:43:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id mjjL1W00l1kojtg0000000; Fri, 13 Apr 2007 15:43:21 -0400
In-Reply-To: <200704131233.13979.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 13 Apr 2007 12:33:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44425>

Andy Parkins <andyparkins@gmail.com> writes:

> Hello,
>
> $ git --version
> git version 1.5.1.1.83.g2bfe3
>
> I've just compiled the latest version from master; and started getting 
> this message
>
> $ git add foo.c
> Ignore BASE extension
>
> What does that mean?  Should I be concerned?

The message would have said "ignoring BASE extension", but this
means you used git from 'next' to update your index and HEAD and
then are now running 'git add' from 'master' or older that does
not have the support for BASE extension.

For description of what BASE extension does, look at log
messages between master..a640e62, especially 0679f9ac.

The notice is harmless.  Any extension data section that the
index file can have, whose name begins with a capital letter
(like 'B'), is meant to be ignorable.  They enhance
functionality or improve performance if understood, but an older
tool that does not understand them can safely ignore and
correctly operate.

Another extension, by the way, is TREE extension, which holds
the cache-tree to speed up write-tree operation.  I think
everybody's git would understand them by now.
