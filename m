From: Mike Galbraith <efault@gmx.de>
Subject: Re: failure doing massive revert
Date: Fri, 19 Sep 2008 11:35:41 +0200
Message-ID: <1221816941.4914.145.camel@marge.simson.net>
References: <1221728946.8516.14.camel@marge.simson.net>
	 <32541b130809181126v4ba4acd7pc5bda085740ab6ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 11:40:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgcTJ-0001lX-MV
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 11:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbYISJfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 05:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbYISJfp
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 05:35:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:54410 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750836AbYISJfo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 05:35:44 -0400
Received: (qmail invoked by alias); 19 Sep 2008 09:35:42 -0000
Received: from p54B5A91F.dip0.t-ipconnect.de (EHLO [192.168.178.27]) [84.181.169.31]
  by mail.gmx.net (mp066) with SMTP; 19 Sep 2008 11:35:42 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX19CIJxfpddCTICeL335IVptwHYcw7yD9dCPiKrbAA
	6L6q025BoWZbCU
In-Reply-To: <32541b130809181126v4ba4acd7pc5bda085740ab6ba@mail.gmail.com>
X-Mailer: Evolution 2.22.1.1 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96270>

On Thu, 2008-09-18 at 14:26 -0400, Avery Pennarun wrote:
> On Thu, Sep 18, 2008 at 5:09 AM, Mike Galbraith <efault@gmx.de> wrote:
> > For reasons I'd rather not go into, I decided to create a merge free
> > tree to try to bisect.  I did this yesterday for a smaller range, and it
> > worked fine, and I was able to revert the reverts to re-apply.  Trying
> > to revert everything from v2.6.26..today croaked.
> >
> > for i in `git rev-list --no-merges v2.6.26..HEAD`; do git revert $i < /dev/null; done
> 
> Hmm, I don't think you can revert every single patch on a merged tree
> that way for the same reason you can't just rebase it: history wasn't
> linear.

Ok, nothing is broke, I just tripped over my white git-fu belt.

> I think something involving 'git rev-list --first-parent' and some
> variant of "git diff $i $i^ | git apply" might work better, as it
> would inherently squash merge commits, thus making them linearly
> reversible (although throwing away large parts of history).
> 
> Throwing away history might not be what you want, but then again,
> maybe it is.  It's the only way I know of to 100% reliably linearize
> the history, anyway.

Thanks, I'll save this reply in case I decide to resume hunt.

	-Mike 
