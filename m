From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [RFC] git-publish
Date: Sun, 13 Aug 2006 21:42:56 +0200
Message-ID: <20060813194256.GB5205@c165.ib.student.liu.se>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org> <20060813191346.GA21487@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 21:43:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCLrT-0006oM-HG
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 21:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWHMTm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 15:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWHMTm6
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 15:42:58 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:2813 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751377AbWHMTm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 15:42:58 -0400
Received: from c165 ([213.114.27.85] [213.114.27.85])
          by mxfep02.bredband.com with ESMTP
          id <20060813194256.PKKO11843.mxfep02.bredband.com@c165>;
          Sun, 13 Aug 2006 21:42:56 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GCLrM-0003hl-00; Sun, 13 Aug 2006 21:42:56 +0200
To: Sam Ravnborg <sam@ravnborg.org>
Content-Disposition: inline
In-Reply-To: <20060813191346.GA21487@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25290>

On Sun, Aug 13, 2006 at 09:13:46PM +0200, Sam Ravnborg wrote:
> On Sun, Aug 13, 2006 at 12:34:49PM -0400, Daniel Barkalow wrote:
> > 
> > Actually, I'm also curious as to how other people generate the series of 
> > commits for a patch series, when they've actually got a working directory 
> > that contains the end result. I doubt that people actually do their 
> > modifications in patch order, committing each time, without writing 
> > and testing the end result.
> hack hack
> git commit -a
> test <= ohh crap a trivial bug
> git format-patch HEAD^..HEAD
> git reset HEAD^ --hard
> patch -p1 0001*
> hack hack
> git commit -a <= reading in old changelog from 0001*
> 
> The above is easier if you know git I expect.
> If I find bugs in older patches I just go back more steps.

If it is the top commit you want to change it is possible to do so
with the '--amend' option to git commit. Instead of the sequence of
commands above you can just do:

    hack hack
    git commit -a
    test <= trivial bug
    hack hack
    git commit -a --amend

It wont work if you find bugs in older patches though.

> 
> I often (twice or more for each kernel release) throw away my kbuild.git
> tree and start all over.
> That gives me a recent kernel to work with and still providing Linux
> with a linar history.
> 
> I have considered stgit - but have not tried it. The above works pretty
> well for me (my fingers and my logic i accused to it now) so the
> incentive to shift is small.

I really like stgit. IMHO it is much easier to use stgit when preparing
a patch series compared to git itself. Maybe it is because I never got
used to the sequence of commands you described above.


- Fredrik
