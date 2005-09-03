From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Moved files and merges
Date: Sun, 4 Sep 2005 00:03:56 +0200
Message-ID: <20050903220355.GA1895@mars.ravnborg.org>
References: <4318E754.9000703@zytor.com> <7vek87djat.fsf@assigned-by-dhcp.cox.net> <7vek867e29.fsf@assigned-by-dhcp.cox.net> <7vy86erntu.fsf@assigned-by-dhcp.cox.net> <20050903190500.GB8379@mars.ravnborg.org> <7voe7arlqk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 00:03:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBg5O-0003oI-6g
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 00:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVICWBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 18:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVICWBt
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 18:01:49 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:56845 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751142AbVICWBt
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Sep 2005 18:01:49 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepb.post.tele.dk (Postfix) with ESMTP id 6B7115EE021;
	Sun,  4 Sep 2005 00:01:46 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 409136AC01D; Sun,  4 Sep 2005 00:03:56 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voe7arlqk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8048>

On Sat, Sep 03, 2005 at 12:32:03PM -0700, Junio C Hamano wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> > As explained in another mail what we want to do is actually to
> > transpose the changes made to F to the now renamed file G.
> > So we end up with G containing the modifications made to F.
> >
> > Also we want to include the new file K.
> 
> Thanks for the clarification.  But the principles are the same.

Not the way I read your explanation.

Lets try to cook up an example:

Common ancestor looks like this:
foo/foo.c

Then we have two lines of parallel development
dev-line-0 modifes foo/foo.c
dev-line-1 moves foo/foo.c to bar/bar.c
In addition dev-line-1 adds a second file bar/Makefile

So what should happen when we merge the two dev-lines?
The resulting tree should look like this:
bar/bar.c (including the modifications down in dev-line-1 to foo.c
bar/Makefile as added in dev-line-2

If this fits into your longer description - then yes this is the same
principle. But I failed to see it fit, therefore this simple example.

If the problem is not fully understood it can be difficult to come up
with the proper solution. And with the example above the problem should
be really easy to understand.
Then we have the tree as used by hpa with a few more mergers in it. But
the above is what was initial tried to do with the added complexity of a
few more renames etc.

	Sam
