From: Junio C Hamano <junkio@cox.net>
Subject: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 16:16:33 -0700
Message-ID: <7vr7hbfx66.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
	<7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.61.0504151617170.27637@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 01:13:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMZzs-0006LX-Vb
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 01:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVDOXQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 19:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVDOXQl
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 19:16:41 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:29411 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262135AbVDOXQf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 19:16:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415231635.PSCU7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 19:16:35 -0400
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504151617170.27637@cag.csail.mit.edu> (C. Scott
 Ananian's message of "Fri, 15 Apr 2005 16:58:10 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "CSA" == C Scott Ananian <cscott@cscott.net> writes:

CSA> On Fri, 15 Apr 2005, Junio C Hamano wrote:
>> to yours is no problem for me.  Currently I see your HEAD is at
>> 461aef08823a18a6c69d472499ef5257f8c7f6c8, so I will generate a
>> set of patches against it.

CSA> Have you considered using an s/key-like system to make these hashes
CSA> more human-readable?  Using the S/Key translation (11-bit chunks map
CSA> to a 1-4
CSA> letter word), Linus' HEAD is at:
CSA>    WOW-SCAN-NAVE-AUK-JILL-BASH-HI-LACE-LID-RIDE-RUSE-LINE-GLEE-WICK-A
CSA> ...which is a little longer, but speaking of branch "wow-scan" (which
CSA> gives 22 bits of disambiguation) is probably less error-prone than
CSA> discussing branch '461...' (only 12 bits).

I understand monotone folks have the same issue and they let you
use unambiguous prefix string.  And why do you stop counting at
"461" in your example?  To my eyes, "461aef" in this particular
string stands out and is easily typable, which gives me 24 bits
;-).

But seriously I doubt the hex format is needed to be shown to
humans very often.  E-mail communications like this one being a
very special exception.  I do not expect for people to be
talking about "Hey, Junio's patch against 461aef... from Linus
is a total crap" like that.

The only reason I mentioned his then-HEAD by hex is because I do
not have a public archive for him to pull from, and I wanted to
make it easy for him to do:

 $ export SHA1_FILE_DIRECTORY
 $ mkdir junk && cd junk && mkdir .git &&
   read-tree `cat-file commit 461aef... | sed -e 's/^tree //;q'`
 $ patch < ../stupid-patch-from-junio-01
 $ show-diff

(it might have been better if I used the tree ID for this purpose).

For Cogito users the hex format does not matter.  "git pull"
will get whatever HEAD recorded in the file on the sending end
and the end user does not even have to know about it.

CSA> This is obviously a cogito issue, rather than a git-fs thing.

Yes.

