From: Leif Gruenwoldt <leifer@gmail.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Sat, 10 Dec 2011 05:50:59 +0000 (UTC)
Message-ID: <loom.20111210T062013-538@post.gmane.org>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org> <20111129220854.GB2812@sandbox-rc.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 06:55:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZFuA-0000Vy-GI
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 06:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945Ab1LJFzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 00:55:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:55432 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815Ab1LJFzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 00:55:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RZFtp-0000Ql-5x
	for git@vger.kernel.org; Sat, 10 Dec 2011 06:55:05 +0100
Received: from d67-193-162-18.home3.cgocable.net ([67.193.162.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 06:55:05 +0100
Received: from leifer by d67-193-162-18.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 06:55:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.193.162.18 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186722>

Heiko Voigt <hvoigt <at> hvoigt.net> writes:

> 
> Hi,
> 
> On Wed, Nov 09, 2011 at 10:01:33AM -0800, Junio C Hamano wrote:
> > Heiko Voigt <hvoigt <at> hvoigt.net> writes:
> > 
> > > This is almost ready but I would like to know what users of the
> > > "floating submodule" think about this.
> > 
> > Thanks for working on this.
> > 
> > I do like to hear from potential users as well, because the general
> > impression we got was that floating submodules is not a real need of
> > anybody, but it is merely an inertia of people who (perhaps mistakenly)
> > thought svn externals that are not anchored to a particular revision is a
> > feature when it is just a limitation in reality. During the GitTogether'11
> > we learned that Android that uses floating model does not really have to.
> 
> Since we did not get any reply from potential floating submodule users I
> do not mind to drop this patch for now. It is archived in the mailing list
> and it should be easy to revive once there is real world need for it.
> 
> Once we have the "exact" model support for checkout and friends this
> might be a handy tool to update submodules before releases and such. But
> currently I would like to focus on the "exact" front first.
> 
> Cheers Heiko
> 

If I understand the description of "floating submodules", it's something I have 
been wanting for a while now! The lack of it is currently a deal breaker for 
using submodules within my organisation.

Our use case is as follows. We have several repositories for our common code 
(commonA.git, commonB.git, etc) and a few different products that leverage these 
common repos (productA.git, productB.git, etc). When one of the products is in 
heavy development we often need to do a lot of work in the common repos. Having 
to increment the sha1 of the submodules to track the latest tip would be overly 
arduous. (Obviously when development of the product stabilizes we would want to 
change to anchoring to a specific sha1 in the common repos).
