From: wa1ter@myrealbox.com
Subject: Re: http protocol, cloning git.git, fails (too many open files)
Date: Sun, 13 Nov 2005 16:42:33 -0800
Organization: none
Message-ID: <Pine.LNX.4.64.0511131625490.32662@x2.ybpnyarg>
References: <86acg9ijwa.fsf@blue.stonehenge.com>  <7vmzk9e9km.fsf@assigned-by-dhcp.cox.net>
 <1131926492.14637.5.camel@k9.localnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 14 01:46:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbSTW-0005Fw-Iq
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 01:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVKNAp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 19:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVKNAp1
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 19:45:27 -0500
Received: from main.gmane.org ([80.91.229.2]:26338 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750813AbVKNAp1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 19:45:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EbSRw-0004jv-SF
	for git@vger.kernel.org; Mon, 14 Nov 2005 01:43:56 +0100
Received: from adsl-69-234-227-15.dsl.irvnca.pacbell.net ([69.234.227.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 01:43:56 +0100
Received: from wa1ter by adsl-69-234-227-15.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 01:43:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-227-15.dsl.irvnca.pacbell.net
In-Reply-To: <1131926492.14637.5.camel@k9.localnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11758>



On Sun, 13 Nov 2005, walt wrote:

> On Sat, 2005-11-12 at 15:21 -0800, Junio C Hamano wrote:
> [...]
> > However, one thing puzzles me.  I just tried to reproduce it by
> > doing this:
> >
> > 	$ rm -fr git-http
> >         $ ulimit -n 16
> >         $ git clone http://www.kernel.org/pub/scm/git/git.git git-http
> >
> > and it did not fail on my Linux box...

> I've never seen it on Linux...

Aha!  I do indeed see it on linux with ulimit -n 64 but *only* when I
do the clone with cg-clone.  When I use 'git clone' it works just fine.

So, what does cogito do differently that accounts for more open files?
