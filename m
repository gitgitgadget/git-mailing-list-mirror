From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 04 Jun 2006 03:06:50 -0700
Message-ID: <7vbqt9ck05.fsf@assigned-by-dhcp.cox.net>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	<7vodx9cm3g.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606040254n1449b62ta70c209ad8e1a0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 12:06:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmpVX-0006vn-Aw
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 12:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWFDKGw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 06:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWFDKGw
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 06:06:52 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:47000 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751389AbWFDKGv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 06:06:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604100651.DEEF18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 06:06:51 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550606040254n1449b62ta70c209ad8e1a0c@mail.gmail.com>
	(Marco Costalba's message of "Sun, 4 Jun 2006 11:54:25 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21259>

"Marco Costalba" <mcostalba@gmail.com> writes:

> In a less corner case, just to better explaing my idea, consider this:
>
>          a---b---d---e---f---g---h
>          t1   \ /              t3
>             ---c
>                t2
>
> Where our sha1 is still "e", in this case
>
> git-rev-list  --topo-order <e>  ^a  ^c   ^g
>
> gives, as last revision in output list, "f"
> Then parentOf(<f>) is <g> and our looked for tag is t3

Sorry, in the example time flows from left to right.  If you
exclude g then you are excluding everything that is reachable
from g so you would not see "f".

Even if your example is different from what I gave (which had
"a" as the root commit) and h is the root commit, your ^a and ^c
would exclude everything that is reachable from either a or c,
so you would get an empty set.  So your "last revision in
output" would not be "f" either.
