From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Commit template
Date: Sun, 08 May 2005 23:09:16 +0200
Message-ID: <1115586556.8949.65.camel@pegasus>
References: <1965.10.10.10.24.1115579256.squirrel@linux1>
	 <1115579764.8949.15.camel@pegasus>
	 <2003.10.10.10.24.1115580031.squirrel@linux1>
	 <1115580630.8949.27.camel@pegasus>
	 <2095.10.10.10.24.1115582244.squirrel@linux1>
	 <1115582601.8949.31.camel@pegasus>
	 <2159.10.10.10.24.1115582791.squirrel@linux1>
	 <20050508201723.GH9495@pasky.ji.cz> <1115584617.8949.51.camel@pegasus>
	 <20050508204043.GJ9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 23:02:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUsua-0005d7-Cp
	for gcvg-git@gmane.org; Sun, 08 May 2005 23:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbVEHVJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 17:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVEHVJA
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 17:09:00 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:3502 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262931AbVEHVIy
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 17:08:54 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48LABWX005593
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 23:10:11 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508204043.GJ9495@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > > > > my argument is; not to mess up with the CG: lines created by cg-commit.
> > > > > If you wanna insert a warning then you can of course add additional CG:
> > > > > lines to the commit template.
> > > > 
> > > > Well, i'd argue that anyone making their own commit should be responsible
> > > > for making it look however they like.  Maybe they want to only use only 60
> > > > character wide lines and are tired of seeing the notice about CG: being
> > > > ignored.  Gives the power user a tad more flexibility.   But I really
> > > > don't care much either way.
> > > 
> > > I'm with Sean on this one - implemented (with current cg-commit, and I
> > > used .git/commit-template file instead), committed, pushed out.
> > 
> > then please do a "touch .git/commit-template" and call cg-commit. Now
> > you will see what I mean. It is too easy to screw up.
> 
> So don't touch .git/commit-template. It's not like it stops working, you
> just don't get the top stuff. Which you probably wanted, why would you
> touch .git/commit-template otherwise?

maybe I am the only one who sees a problem here and thinks that it is a
mis-design. Let me try one last time to explain it. We speak here about
end users of Cogito, right? They don't know what is inside the scripts
and how they work. So you tell them that they can create a commit
template that will be presented at every commit time. So lets do it.

---snip---
[PATCH]

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---snip---

I would create a file like this and save it as .git/commit-template,
because I don't really know about the CG: lines and actually I don't
really care, because they get deleted anyway. Stupid as I am, I am
expecting now something like this:

---snip---
[PATCH]

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
CG: -----------------------------------------------------------------------
CG: Lines beginning with the CG: prefix are removed automatically
CG:
CG: Modified files:
CG:    Makefile
CG: -----------------------------------------------------------------------
---snip---

But instead I am getting this:

---snip---

[PATCH]

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
CG:
CG: Modified files:
CG:    Makefile
CG: -----------------------------------------------------------------------
---snip---

As an end user, what would you say?

> > Why not leave the list of modified files in the hand of the cg-commit
> > and people that wanna extra text inside their commit-template add
> > something like:
> > 
> > CG: ---
> > CG: This is my testing tree, don't commit
> > 
> > This will look much prettier and gives people the same possibilities to
> > change everything.
> 
> But you have extra stuff both before and after the list of modified
> files.

Adding extra CG: lines in a commit template is only good for reminding
you of something, right? Why else would you add them?

> > If you wanna make the modified files list into a full configurable
> > template, then I think you must introduce place holders.
> 
> That's what I was thinking about, actually - @@MODIFIED@@ and such, and
> it replaces _all_ the CG: stuff. Just decided that I have better things
> to do now personally.

I understand that :)

Regards

Marcel


