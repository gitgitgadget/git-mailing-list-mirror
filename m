From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/9] New option --force-delete for git-apply.
Date: Sun, 28 Aug 2005 14:06:44 -0700
Message-ID: <7vzmr1kbyz.fsf@assigned-by-dhcp.cox.net>
References: <11252426732064-git-send-email-robfitz@273k.net>
	<11252426793534-git-send-email-robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 23:09:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9UN9-0002S5-80
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 23:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVH1VGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 17:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVH1VGr
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 17:06:47 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40181 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750806AbVH1VGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 17:06:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828210646.QYWC12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 17:06:46 -0400
To: Robert Fitzsimons <robfitz@273k.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7887>

Robert Fitzsimons <robfitz@273k.net> writes:

> Allow the user to force a patch that deletes a file to succeed even
> though the file might still contain data.  Added a test case.

Why?

I've seen cases where git-apply incorrectly thinks a patch
leaves some data in a file to be deleted, when incomplete lines
are involved.  But I think that bug has been fixed, and the only
case where you would need this new flag should be dealing with a
corrupt/invalid patch.
