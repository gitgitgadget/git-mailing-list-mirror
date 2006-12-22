From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fix vc git
Date: Thu, 21 Dec 2006 20:54:02 -0800
Message-ID: <7vvek47cph.fsf@assigned-by-dhcp.cox.net>
References: <8e745ecf0612210325m72a569d7k370dd5953ccf6f27@mail.gmail.com>
	<emdr6v$9ma$1@sea.gmane.org>
	<8e745ecf0612210359j3f895521r1fff497a512253d3@mail.gmail.com>
	<7vhcvo92fx.fsf@assigned-by-dhcp.cox.net>
	<8e745ecf0612212011q26f81d91uce143b4212fc5e8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 05:54:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxcQ8-0004RN-Kw
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 05:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945931AbWLVEyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 23:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945933AbWLVEyJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 23:54:09 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:51402 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945931AbWLVEyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 23:54:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222045403.ZFVB19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Dec 2006 23:54:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1gtL1W00X1kojtg0000000; Thu, 21 Dec 2006 23:53:21 -0500
To: "Duncan Mak" <duncan@a-chinaman.com>
In-Reply-To: <8e745ecf0612212011q26f81d91uce143b4212fc5e8b@mail.gmail.com>
	(Duncan Mak's message of "Thu, 21 Dec 2006 23:11:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35128>

"Duncan Mak" <duncan@a-chinaman.com> writes:

> I don't think vc-git-registered-file will ever be called with a
> filename without a directory, as it is used as a hook on
> vc-next-action, which works on a real file.

I am showing my ignorance, but

 (1) if it works on a real file then can it ever give you a file
     that is in nonexisting directory?

 (2) when it works on a file at the root level of the project
     tree, say, just "Makefile" wouldn't dir which is the result
     of (file-name-directory file) be sometimes nil?  I suspect
     that is the reason of the original (when dir ...)

In either case, your change would not break anything.  I am just
being curious.
