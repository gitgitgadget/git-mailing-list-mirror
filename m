From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: linux-x86-tip: pilot error?
Date: Sun, 22 Jun 2008 06:21:05 -0700
Message-ID: <20080622132105.GD22569@linux.vnet.ibm.com>
References: <20080622123620.GA9328@linux.vnet.ibm.com> <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@elte.hu, git@vger.kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 15:22:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAPWF-0003ny-9F
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 15:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbYFVNVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 09:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYFVNVM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 09:21:12 -0400
Received: from E23SMTP06.au.ibm.com ([202.81.18.175]:38741 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbYFVNVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 09:21:11 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m5MDKaEP014790
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 23:20:36 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5MDKiEq4673578
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 23:20:46 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5MDL6vr000395
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 23:21:06 +1000
Received: from paulmck-laptop.localdomain (wecm-9-67-149-169.wecm.ibm.com [9.67.149.169])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m5MDL5rF000392;
	Sun, 22 Jun 2008 23:21:06 +1000
Received: by paulmck-laptop.localdomain (Postfix, from userid 1000)
	id B500C13E9DA; Sun, 22 Jun 2008 06:21:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85768>

On Sun, Jun 22, 2008 at 02:48:35PM +0200, Mikael Magnusson wrote:
> 2008/6/22 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> > Hello, Ingo,
> >
> > I took the precaution of rebuilding my linux-2.6-tip from scratch as follows:
> >
> >  544  mkdir linux-2.6-tip
> >  545  cd linux-2.6-tip
> >  546  git-init-db
> >  547  git-remote add linus git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> >  548  git-remote add tip git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
> >  549  git-remote update
> >  550  git-checkout tip-core-rcu-2008-06-16_09.23_Mon
> 
> When checking out remote branches, you have to specify the remote:
> git checkout tip/tip-blabla
> (it'll warn about detaching HEAD, this is normal).

Thank you, Mikael!

But when I try "git-checkout tip/tip-core-rcu-2008-06-16_09.23_Mon",
it says:

	error: pathspec 'tip/tip-core-rcu-2008-06-16_09.23_Mon' did not match any file(s) known to git.
	Did you forget to 'git add'?

Trying "git-checkout tip/tip-core-rcu" gets me:

	error: pathspec 'tip/tip-core-rcu' did not match any file(s) known to git.
	Did you forget to 'git add'?

Trying "git-checkout -b tip-core-rcu tip/tip-core-rcu" gets me:

	git checkout: updating paths is incompatible with switching branches/forcing
	Did you intend to checkout 'tip/tip-core-rcu' which can not be resolved as commit?

Trying "git-checkout -b tip-core-rcu tip/tip-core-rcu-2008-06-16_09.23_Mon"
gets me:

	git checkout: updating paths is incompatible with switching branches/forcing
	Did you intend to checkout 'tip/tip-core-rcu-2008-06-16_09.23_Mon' which can not be resolved as commit?

Trying "git-checkout -b tip-core-rcu tip-core-rcu-2008-06-16_09.23_Mon"
acts like it is doing something useful, but doesn't find the recent updates,
which I believe happened -before- June 16 2008.

Help???

							Thanx, Paul
