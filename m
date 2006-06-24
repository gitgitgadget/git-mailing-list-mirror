From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: filter out log message lines only when editor was run.
Date: Fri, 23 Jun 2006 17:21:12 -0700
Message-ID: <7vveqr769z.fsf@assigned-by-dhcp.cox.net>
References: <20060623220405.1915.28636.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 02:22:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtvvD-0003p9-RL
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 02:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933070AbWFXAVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 20:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWFXAVY
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 20:21:24 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8092 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932295AbWFXAVO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 20:21:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624002113.EKBV22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 20:21:13 -0400
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060623220405.1915.28636.stgit@gandelf.nowhere.earth> (Yann
	Dirson's message of "Sat, 24 Jun 2006 00:04:05 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22460>

Yann Dirson <ydirson@altern.org> writes:

> The current behaviour strips out lines starting with a # even when fed
> through stdin or -m.  This is particularly bad when importing history from
> another SCM (tailor 0.9.23 uses git-commit).  In the best cases all lines
> are stripped and the commit fails with a confusing "empty log message"
> error, but in many cases the commit is done, with loss of information.

I agree with this in principle but we would need to make sure
that our own scripts do not expect that the message is cleaned
up when feeding a commit log message via stdin, -m or -F, and if
they do fix them before applying this patch.
 
