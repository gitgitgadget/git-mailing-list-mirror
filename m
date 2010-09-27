From: Martin Pettersson <martin@siamect.com>
Subject: Re: Multiple checkouts active for the same repository
Date: Mon, 27 Sep 2010 18:53:53 +0700
Message-ID: <201009271853.53564.martin@siamect.com>
References: <4C9C6F8B.3090806@tech.2degreesnetwork.com> <14b089955184bbb677b6434993682403@212.159.54.234> <4CA072FC.3020004@tech.2degreesnetwork.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 14:03:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0CQN-0006pB-TD
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 14:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758821Ab0I0MDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 08:03:09 -0400
Received: from smtp5.34sp.com ([80.82.115.204]:33490 "EHLO smtp5.34sp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753549Ab0I0MDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 08:03:08 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Sep 2010 08:03:08 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp5.34sp.com (Postfix) with ESMTP id 6127FEF01D3
	for <git@vger.kernel.org>; Mon, 27 Sep 2010 12:53:59 +0100 (BST)
Received: from smtp5.34sp.com ([127.0.0.1])
	by localhost (smtp5.34sp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DKRDTlsTfFjJ for <git@vger.kernel.org>;
	Mon, 27 Sep 2010 12:53:59 +0100 (BST)
Received: from our-server.localnet (ppp-124-120-240-129.revip2.asianet.co.th [124.120.240.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: controlcentres.com)
	by smtp5.34sp.com (Postfix) with ESMTP id EDDB7F13E37
	for <git@vger.kernel.org>; Mon, 27 Sep 2010 12:53:58 +0100 (BST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-22-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <4CA072FC.3020004@tech.2degreesnetwork.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157326>

On Monday, September 27, 2010 05:33:32 pm Gustavo Narea wrote:
> Hello,
> 
> Thanks! I've given git-new-workdir a try and it seems to be what I was
> searching for.
> 
>  - Gustavo.
> 
> On 24/09/10 16:33, Julian Phillips wrote:
> > On Fri, 24 Sep 2010 10:29:47 +0100, Gustavo Narea
> > 
> > <gnarea@tech.2degreesnetwork.com> wrote:
> >> Hello.
> >> 
> >> We're currently migrating from another DVCS, which allows us to have
> >> working copies of each branch in separate directories, so that their
> >> code can be used simultaneously. However, I haven't found a way to do
> >> this with Git, at least not an easy way. Can you please help me?
> > 
> > The git-new-workdir script to be found in contrib/workdir allows multiple
> > working copies to share the same repository - though there are some
> > 
> > caveats:
> >  1) uses symbolic links, so doesn't work on Windows
> >  2) the working copies are not aware of each other, so if you change a
> > 
> > checked out branch from another working copy you have to remember to git
> > reset your working copy before doing anything with it to get it back in
> > sync with the branch
> > 
> >  3) you have to remember not to delete the actual clone
> >  4) the working copies are not aware of each other, so it is possible for
> > 
> > objects needed by one working copy to get pruned from another one
> > 
> > Personally, I use this script all the time to checkout multiple branches
> > at the same time taking care to stay away from the issues above, and
> > everything hums along nicely.
> > 
> >> We are a team of Web developers and testers working on an application.
> >> There are always a few development branches and a stable branch, and
> >> testers need all the branches with the very latest code available at all
> >> times.
> >> 
> >> The way we handle it at the moment is very simple because the server
> >> hosting the remote repository is the same that hosts the deployed
> >> instances of each branch, so when we push to the remote repository, the
> >> code for each site is automatically updated.
> >> 
> >> We use the following structure:
> >> /srv/repositories/project/branch1
> >> /srv/repositories/project/branch2
> >> /srv/repositories/project/branch3
> >> 
> >> Is there any simple way to do this with Git? I can only think of two
> >> 
> >> options that involve hooks:
> >>     * Have a hook that exports each branch to a directory like
> >>     
> >>       /srv/repositories/project/branchN
> >>     
> >>     * Have one Git repository per branch, so that each repository have a
> >>     
> >>       different checkout active. Then the main remote repository will
> >>       have post-receive hooks that trigger a pull on each individual
> >> 
> >> I'm not particularly happy with either way. Is there a better solution?
just check out the branch you need... If you are absolutely in big need of 
reaching multiple branches at the same time just make a couple of clones...
Martin
