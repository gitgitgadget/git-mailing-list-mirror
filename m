From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moved files and merges
Date: Sat, 03 Sep 2005 11:53:30 -0700
Message-ID: <7vslwmrnit.fsf@assigned-by-dhcp.cox.net>
References: <4318E754.9000703@zytor.com>
	<7vek87djat.fsf@assigned-by-dhcp.cox.net>
	<7vek867e29.fsf@assigned-by-dhcp.cox.net>
	<20050903180654.GB2314@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 20:54:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBd99-0006aN-Jb
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 20:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVICSxc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 14:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVICSxc
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 14:53:32 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:24741 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751182AbVICSxc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2005 14:53:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050903185332.IYZH17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Sep 2005 14:53:32 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050903180654.GB2314@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sat, 3 Sep 2005 20:06:54 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8043>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> Maybe I am missing something... but why should the merge operation
> ignore renames? Is there a merge case when ignoring renames is the
> Right Thing to do?
>
> Lets say the branches A and B has the common ancestor C which contains
> a file named "foo". If A has renamed "foo" to "foobar" and B has made
> some content changes to "foo" shouldn't the result be a file named
> "foobar" with the content changes B made to "foo" in it?

Our messages mostly crossed, but as I described in the longer
message I just sent out, the problem is that two lines of
development runs in parallel, each of them wants to pick
criss-cross nonstructural changes from the other, while keeping
their own tree structure.  If the goal of a 'merge' is to
converge into a single commit for both lines of development to
agree on a single tree structure to carry on from, then what you
said is right, but the problem at hand is slightly different.
