From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] do not open editor in dumb terminal
Date: Fri, 03 Feb 2006 11:56:54 -0800
Message-ID: <7vu0bgdxmh.fsf@assigned-by-dhcp.cox.net>
References: <20060203114133.GA11499@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, boutcher@cs.umn.edu
X-From: git-owner@vger.kernel.org Fri Feb 03 20:57:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F573i-0002jh-Su
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 20:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422906AbWBCT5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 14:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422921AbWBCT5E
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 14:57:04 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:35814 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1422899AbWBCT44 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 14:56:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203195701.DXLN25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 14:57:01 -0500
To: Amos Waterland <apw@us.ibm.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15544>

Amos Waterland <apw@us.ibm.com> writes:

> Many people run git from a shell in emacs (obtained by M-x shell).  When
> they try to do a commit without specifying a log message on the command
> line with -m, git opens vi inside emacs, with unpleasant results.  I
> think the right answer is to just refuse to open an editor in any dumb
> terminal.

No, please don't.

I run 'git commit' from M-x shell or M-x compile.  My EDITOR is
set to 'emacsclient' while inside Emacs.

As a matter of fact, I do almost all my work inside Emacs and
this setting works rather well for not only git but for other
people's commands (like 'cvs commit').

It might be an option not to fall back on vi and instead to fall
back on ed/ex when neither EDITOR nor VISUAL is specified and
the terminal is dumb.  But the patch as-is is unacceptable.
