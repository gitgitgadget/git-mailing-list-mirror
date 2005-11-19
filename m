From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git email submissions
Date: Sat, 19 Nov 2005 13:08:13 -0800
Message-ID: <7vlkzk4a82.fsf@assigned-by-dhcp.cox.net>
References: <437B4472.1080401@pobox.com>
	<Pine.LNX.4.64.0511160847250.13959@g5.osdl.org>
	<437B7213.2020406@zytor.com> <437B73E2.3080903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 19 22:09:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdZwY-0007lO-9M
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 22:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVKSVIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 16:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVKSVIP
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 16:08:15 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57549 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750808AbVKSVIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 16:08:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119210717.SQVB17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Nov 2005 16:07:17 -0500
To: git@vger.kernel.org
In-Reply-To: <437B73E2.3080903@pobox.com> (Jeff Garzik's message of "Wed, 16
	Nov 2005 13:01:06 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12353>

Jeff Garzik <jgarzik@pobox.com> writes:

> I would presume an email body would look like
>
> overall description of changes
> git log master..HEAD | git shortlog
> git diff master..HEAD | diffstat -p1
> git diff master..HEAD
> <pack file MIME attachment>

As Smurf commented, the delta data is sent twice if you sent a
pack of "^his mine" -- once as a textual diff and then the delta
data in the pack.  You can slightly do better than that.
Because you are sending the diff, the pack you send does not
have to include the post-image of patch application, and I
suspect your pack would not have to contain anything other than
commit objects.
