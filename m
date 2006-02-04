From: Junio C Hamano <junkio@cox.net>
Subject: Re: 2 questions/nits about commit and config
Date: Sat, 04 Feb 2006 14:24:11 -0800
Message-ID: <7vhd7evk38.fsf@assigned-by-dhcp.cox.net>
References: <20060204212337.GA8612@blinkenlights.visv.net>
	<7voe1mvkls.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Feb 04 23:24:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5VpZ-0005p6-JZ
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 23:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWBDWYQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 17:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWBDWYQ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 17:24:16 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:7358 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964841AbWBDWYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 17:24:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204222310.TTTX15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 17:23:10 -0500
To: git@vger.kernel.org
In-Reply-To: <7voe1mvkls.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 04 Feb 2006 14:13:03 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15605>

Junio C Hamano <junkio@cox.net> writes:

> An example of such semantic change would be: if I am in
> subdirecotry foo/, commit changes to files in that subdirectory
> and subdirectory alone.  But that is actively _encouraging_
> partial commits (commits that records a state that never existed
> in your working tree as a whole) so I personally am not so
> enthused to buy such a _feature_.

Before people start complaining about it, I take this part
back.  "git commit -a" inside a subdirectory "foo" is not much
different from "git commit foo/a foo/b foo/c" from the toplevel
directory to explicitly say "Don't worry about what I told the
index so far; I want to check in changes only to these paths",
and making a partial commit out of the current HEAD and the
specified working tree files using a temporary index (while
updating the main index at the same time), so I am inclined to
say we should support it that way, since during the previous
discussion we have pretty much settled how we would want "git
commit paths..." and "git commit --include paths..." commands to
behave.
