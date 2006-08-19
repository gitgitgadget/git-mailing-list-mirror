From: Junio C Hamano <junkio@cox.net>
Subject: Re: git refuses to switch to older branches
Date: Sat, 19 Aug 2006 15:39:20 -0700
Message-ID: <7vac601hbb.fsf@assigned-by-dhcp.cox.net>
References: <20060819202558.GE30022@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 00:39:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEZTd-0004Oj-Rc
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 00:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWHSWjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 18:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWHSWjX
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 18:39:23 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:23278 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751582AbWHSWjW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 18:39:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060819223921.OTTX6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Aug 2006 18:39:21 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060819202558.GE30022@admingilde.org> (Martin Waitz's message
	of "Sat, 19 Aug 2006 22:25:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25740>

Martin Waitz <tali@admingilde.org> writes:

> This safety measure is quite useful normally, but for files that are
> explicitly marked as to-be-ignored it should not be neccessary.
>
> But all the code that handles .gitignore is only used by ls-files now.
> Does it make sense to add exclude handling to unpack-trees.c, too?

In principle, I am not opposed to the idea of making read-tree
take the ignore information into consideration.

But I would suggest you to be _extremely_ careful if you want to
try this.  I do not have an example offhand, but I would not be
surprised at all if there is a valid use case where it is useful
to have a pattern that matches a tracked file in .gitignore
file.
