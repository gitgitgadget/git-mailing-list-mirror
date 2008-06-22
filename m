From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: linux-x86-tip: pilot error?
Date: Sun, 22 Jun 2008 05:36:20 -0700
Message-ID: <20080622123620.GA9328@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mingo@elte.hu
X-From: git-owner@vger.kernel.org Sun Jun 22 14:37:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAOpG-00089V-65
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 14:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbYFVMgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 08:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbYFVMgY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 08:36:24 -0400
Received: from E23SMTP01.au.ibm.com ([202.81.18.162]:37384 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYFVMgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 08:36:24 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m5MCarP6015005
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 22:36:53 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5MCZxia3137668
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 22:35:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5MCaL63015819
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 22:36:21 +1000
Received: from paulmck-laptop.localdomain (wecm-9-67-149-169.wecm.ibm.com [9.67.149.169])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m5MCaK0p015816;
	Sun, 22 Jun 2008 22:36:20 +1000
Received: by paulmck-laptop.localdomain (Postfix, from userid 1000)
	id 5382013E9DA; Sun, 22 Jun 2008 05:36:20 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85764>

Hello, Ingo,

I took the precaution of rebuilding my linux-2.6-tip from scratch as follows:

  544  mkdir linux-2.6-tip
  545  cd linux-2.6-tip
  546  git-init-db
  547  git-remote add linus git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
  548  git-remote add tip git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
  549  git-remote update
  550  git-checkout tip-core-rcu-2008-06-16_09.23_Mon

The "git-checkout" command complained as follows:

	warning: You appear to be on a branch yet to be born.
	warning: Forcing checkout of tip-core-rcu-2008-06-16_09.23_Mon.
	Checking 24254 files out...
	 100% (24254/24254) done
	fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
	Use '--' to separate paths from revisions
	Cannot detach HEAD

In addition, the kernel/rcutorture.c file does not have the "stutter"
changes in it after doing this checkout.

Did I mess something up?  Am I working with a too-old version of git
(git version 1.5.2.5)?  Or has git simply taken a deep and personal
disliking to me?  ;-)

My next step will be to try a more recent version of git.  In parallel,
I will just re-do the patch on top of my patch stack.

							Thanx, Paul

PS.  I am assuming that the repeated messages from git-update of
     the following form are expected behavior when there are tags:

     * refs/tags/tip-x86-xsave-2008-05-26_08_54_Mon: storing tag 'tip-x86-xsave-2008-05-26_08_54_Mon' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip
       commit: d40ace0
