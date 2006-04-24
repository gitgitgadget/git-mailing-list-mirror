From: Junio C Hamano <junkio@cox.net>
Subject: Re: How do I quickly check what heads a particular commit is in?
Date: Sun, 23 Apr 2006 21:40:12 -0700
Message-ID: <7v4q0jd1sj.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90604232123r7f35660aufbb9da0f561f8ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 06:40:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXss6-0008Ts-CV
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 06:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWDXEkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 00:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWDXEkR
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 00:40:17 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:8870 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751508AbWDXEkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 00:40:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060424044015.USYW24255.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Apr 2006 00:40:15 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90604232123r7f35660aufbb9da0f561f8ea@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 24 Apr 2006 16:23:24 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19086>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> In the middle of a merge of 2 of a bunch of closely related heads, I
> found a few odd things, so I've pickaxe'd and found the (potentially
> bogus) commits. I am using gitk, and while I do find the commit, it's
> not very clear what heads have the dodgy commit. They've probably been
> for a few months in there <sigh>.
>
> Is there a practical way to ask in what heads they are?

git merge-base $broken_commit "master"

would show $broken_commit if "master" is a fast-forward of
$broken_commit (i.e. "master" is a descendant).  I think that is
what you are calling "$broken_commit is in master".
