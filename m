From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Branch relationships
Date: Mon, 15 May 2006 00:01:48 +0200
Message-ID: <200605150001.48548.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org> <200605142249.17508.Josef.Weidendorfer@gmx.de> <7vr72w2thu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 00:02:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfOfN-0003R5-LP
	for gcvg-git@gmane.org; Mon, 15 May 2006 00:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWENWCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 18:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWENWCJ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 18:02:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:63910 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750760AbWENWCI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 18:02:08 -0400
Received: (qmail invoked by alias); 14 May 2006 22:02:06 -0000
Received: from p54968B53.dip0.t-ipconnect.de (EHLO noname) [84.150.139.83]
  by mail.gmx.net (mp039) with SMTP; 15 May 2006 00:02:06 +0200
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7vr72w2thu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19985>

On Sunday 14 May 2006 23:20, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> >>   ; my private build areas on the kernel.org machines
> >>    [remote "ko-private"]
> >>         url = "x86-64-build.kernel.org:git"
> >>         url = "i386-build.kernel.org:git"
> >>         push = master:origin
> >> ...
> >
> > specifies that "git push" should push to both URLs?
> 
> Exactly.  I would _want_ to push to both with single action when
> I say "git push ko-private".  Actually I have _never_ felt need
> to, but Linus wanted it first and I think it makes sense.

Hmmm. Isn't this a solution for a very special use-case?
You even can not specify different push lines for the 2 URLs.
I think you want an alias name for a group of remotes here?
Why not

 [remotealias "ko-private"]
   remote = "ko-private-x86-64"
   remote = "ko-private-i386"

Neverless, this wasn't the thing I was after.

> That is what "branch.foo.remote = this-remote" is about.

OK. Sorry, I somehow missed this.

> When 
> working on foo branch, use what is described in
> remote."this-remote" section for "git pull".
> remote."this-remote" would have url and one or more fetch lines,
> and as usual the first fetch line would say "merge this thing".
> This gives the continuity in semantics while migrating from
> .git/remotes/foo to [remote "foo"] section of the config file.

The only thing I wanted to discuss in this thread is exactly the
limitation of "as usual the first fetch line..." by the branch
attribute "origin", which lead me to the alternative "tracksremote"
attribute. Sorry about any confusion.

I suppose "branch.<branch name>.origin" is still the way to go for
specifying the upstream?

Josef
