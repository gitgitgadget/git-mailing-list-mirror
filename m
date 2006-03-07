From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-unpack-objects < pack file in repository doesn't work!
Date: Mon, 06 Mar 2006 19:09:36 -0800
Message-ID: <7vlkvn54sv.fsf@assigned-by-dhcp.cox.net>
References: <200603070213.02805.blaisorblade@yahoo.it>
	<20060307022926.GB29180@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 04:09:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGSZy-0006GG-D5
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 04:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWCGDJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 22:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWCGDJj
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 22:09:39 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43932 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932636AbWCGDJi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 22:09:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060307030804.TUHD20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Mar 2006 22:08:04 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060307022926.GB29180@spearce.org> (Shawn Pearce's message of
	"Mon, 6 Mar 2006 21:29:26 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17316>

Shawn Pearce <spearce@spearce.org> writes:

> I totally didn't expect that behavior.  But I should have.  It makes
> perfect sense.

Good to hear that you two did not lose any data.  I think the
command should be documented as "not for interactive use without
understanding what it does" ;-).

What was the reason you wanted to use it?  I think we should
have a wrapper command to do what you wanted to achieve, so that
people do not have to run unpack-objects by hand.

One thing I _could_ think of is to explode a contaminated pack
so that you can repack.  For example, every time I do "git
repack -a -d", the resulting pack ends up containing a couple of
commits from my "pu" branch that will become dangling when I
redo "pu" the next time.  But then "git repack -a -d" is so
inexpensive these days, without unpacking things first, I do not
see the point of exploding a pack using unpack-objects in the
first place.
