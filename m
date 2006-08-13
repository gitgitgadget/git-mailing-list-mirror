From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] git-publish
Date: Sun, 13 Aug 2006 21:13:46 +0200
Message-ID: <20060813191346.GA21487@mars.ravnborg.org>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 21:14:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCLPS-00026u-1v
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 21:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWHMTNx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 15:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWHMTNx
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 15:13:53 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:53481 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751364AbWHMTNw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Aug 2006 15:13:52 -0400
Received: from mars.ravnborg.org (0x535d98d8.hrnxx9.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtp.tele.dk (Postfix) with ESMTP id 9CFD0E3084D;
	Sun, 13 Aug 2006 21:13:47 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id B220243C01F; Sun, 13 Aug 2006 21:13:46 +0200 (CEST)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25289>

On Sun, Aug 13, 2006 at 12:34:49PM -0400, Daniel Barkalow wrote:
> 
> Actually, I'm also curious as to how other people generate the series of 
> commits for a patch series, when they've actually got a working directory 
> that contains the end result. I doubt that people actually do their 
> modifications in patch order, committing each time, without writing 
> and testing the end result.
hack hack
git commit -a
test <= ohh crap a trivial bug
git format-patch HEAD^..HEAD
git reset HEAD^ --hard
patch -p1 0001*
hack hack
git commit -a <= reading in old changelog from 0001*

The above is easier if you know git I expect.
If I find bugs in older patches I just go back more steps.

I often (twice or more for each kernel release) throw away my kbuild.git
tree and start all over.
That gives me a recent kernel to work with and still providing Linux
with a linar history.

I have considered stgit - but have not tried it. The above works pretty
well for me (my fingers and my logic i accused to it now) so the
incentive to shift is small.

But important note is that publishing is something I defer until some
limited test has been done. And when I omit that I have always ended u
pushing some crappy stuff that needs to be dealt with.

	Sam
