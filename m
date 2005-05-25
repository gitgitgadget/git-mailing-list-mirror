From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: change of git-diff-tree and symlinks
Date: Wed, 25 May 2005 20:35:46 +0200
Message-ID: <20050525183546.GA4241@vrfy.org>
References: <20050525111711.GA27492@vrfy.org> <Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 20:46:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db0tE-0006Oz-Ta
	for gcvg-git@gmane.org; Wed, 25 May 2005 20:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVEYSrR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 14:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVEYSiq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 14:38:46 -0400
Received: from soundwarez.org ([217.160.171.123]:6567 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262405AbVEYSfu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 14:35:50 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 4BA3B39DA9; Wed, 25 May 2005 20:35:46 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2005 at 11:08:54AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 25 May 2005, Kay Sievers wrote:
> >
> > I'm catching up with gitweb.cgi to parse the changed output. Works fine
> > so far and is really much easier to parse. Here is something that does
> > not work anymore. See the difference between:
> > 
> >    http://www.kernel.org/git/?p=linux/hotplug/udev.git;a=commit;h=49cedafaf893bfe348eb7598227f1a11ae24bfd6
> >    http://ehlo.org/~kay/gitweb.cgi?p=linux/hotplug/udev.git;a=commit;h=49cedafaf893bfe348eb7598227f1a11ae24bfd6
> 
> Yes, the new diff-tree thing doesn't show symlinks.
> 
> The problem seems to be that we just don't have a "status" flag for it. I 
> think we should call it "T" for "Type change" or something, but in the 
> meantime let's just have the rule that instead of ignoring unknown state 
> changes, we always print them out as "?" instead.
> 
> Ie something like this..
> 
> (And I'd suggest you make gitweb flexible enough that it does something 
> sane if it sees an unknown reason code - let's see what Junio thinks about 
> what status code we should use for this).

Ok, works again. Any reason not to mark it as 'M'? It's easyly to
distinguish between a content change and a mode change by looking if
the sha has changed.

Kay
