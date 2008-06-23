From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: linux-x86-tip: pilot error?
Date: Mon, 23 Jun 2008 04:11:44 -0700
Message-ID: <20080623111144.GP22569@linux.vnet.ibm.com>
References: <20080622123620.GA9328@linux.vnet.ibm.com> <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com> <20080622132105.GD22569@linux.vnet.ibm.com> <20080623071441.GA28887@elte.hu> <20080623095732.GL22569@linux.vnet.ibm.com> <20080623102424.GA28192@elte.hu>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 23 13:12:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAjyc-0005Kk-1t
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 13:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbYFWLLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 07:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbYFWLLx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 07:11:53 -0400
Received: from E23SMTP04.au.ibm.com ([202.81.18.173]:48702 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbYFWLLw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 07:11:52 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m5NBAxVZ027556
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 21:10:59 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5NBBQKg4706384
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 21:11:26 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5NBBmsY031350
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 21:11:49 +1000
Received: from paulmck-laptop.localdomain (wecm-9-67-149-169.wecm.ibm.com [9.67.149.169])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m5NBBkl3031303;
	Mon, 23 Jun 2008 21:11:46 +1000
Received: by paulmck-laptop.localdomain (Postfix, from userid 1000)
	id F049B13E9DA; Mon, 23 Jun 2008 04:11:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080623102424.GA28192@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85852>

On Mon, Jun 23, 2008 at 12:24:24PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Mon, Jun 23, 2008 at 09:14:41AM +0200, Ingo Molnar wrote:
> > > 
> > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > > 
> > > > Trying "git-checkout -b tip-core-rcu 
> > > > tip-core-rcu-2008-06-16_09.23_Mon" acts like it is doing something 
> > > > useful, but doesn't find the recent updates, which I believe happened 
> > > > -before- June 16 2008.
> > > 
> > > finding the rcu topic branch in -tip can be done the following way:
> > > 
> > >  $ git-branch -a | grep rcu
> > >    tip/core/rcu
> > 
> > Ah!!!  Good, that does show me this branch.  I created a new branch
> > "paulmck-rcu-2008-06-23" just out of paranoia.
> 
> that's OK - having more branches never hurts.
> 
> if, while juggling branches, you lose some commit somewhere it makes 
> sense to check .git/logs/. [ Up until the point Git does a 
> garbage-collection run and zaps any orphaned commits ;-) ]

Thank you -- I have had some things disappear on me in the past.  ;-)

> > > if you check out that branch for your own use, you should also do:
> > > 
> > >  $ git-merge linus/master
> > > 
> > > To bring it up to latest upstream.
> > 
> > OK, that did pull in a number of changes.  The gitk tool then shows my 
> > "Merge commit 'linus/master' into paulmck-rcu-2008-06-23" at the head 
> > of the display, with parents as follows:
> > 
> > Parent: 31a72bce0bd6f3e0114009288bccbc96376eeeca (rcu: make rcutorture more vicious: reinstate boot-time testing)
> > Parent: bec95aab8c056ab490fe7fa54da822938562443d (Merge branch 'release' of git://lm-sensors.org/kernel/mhoffman/hwmon-2.6)
> > 
> > This means that the RCU-related changes show up discontinuously in the 
> > gitk display, but clicking on the left-most connector and selecting 
> > "parent" gets me to the rest of the tip/core/rcu branch, so should be 
> > OK, I guess.  ;-)
> 
> i have just talked to Thomas about it and we'll change our scripting so 
> that the tip/core/rcu branch will always be very recent and merged up to 
> latest -git.
> 
> As one of the goals of the tip/* structure is to distribute topics to 
> others (or as Linus has put it, Thomas and me needs to become more 
> managerial about maintenance ;), there's real value in having the topics 
> appear up-to-date when people try them out.

;-)

> ( it's possible to do this without criss-cross merge commits - it just
>   needs some more creative scripting in -tip. )

I am keeping the hints in a README file on my machine -- thank you!!!

> > I then applied my two patches from yesterday (EDT timezone), just for 
> > practice.
> > 
> > These show up after the merge.
> > 
> > But now when I do "git-log tip/core/rcu..linus/master", I get one very 
> > large pile of patches.  It apparently includes the stuff I merged from 
> > linus/master.  This is expected behavior, correct?
> 
> That would be expected behavior, yes. You can try a "test-pull" into 
> core/rcu:
> 
>   git-checkout -b test-rcu tip/core/rcu
>   git-merge paulmck-rcu-2008-06-23   # replace with git-pull and an URI
> 
> ... and then look at how "git-log test-rcu..linus/master" looks like. It 
> should show all the changes of the RCU topic, your two new commits 
> included.

The git-merge seemed to run normally, but the git-log command showed
no output.  Hmmm...

> > So, if I want to identify the RCU patches since some specific Linus 
> > release (for example, 2.6.26-rc7), I follow the RCU parents down until 
> > I find the desired release tag, then generate diffs from the ranges I 
> > find, right?
> > 
> > Hmmm, actually, no, this bypasses the v2.6.26-rcN tags.
> > 
> > One approach is apparently to use gitk to create a view that includes 
> > the patches touching the RCU-related files.  The git-log command also 
> > takes pathname arguments, so that allows me to get an approximation as 
> > well.
> > 
> > I will have to look more at git-log and gitk -- probably I should be 
> > paying more attention to patches adding or deleting the strings "RCU" 
> > or "rcu" to the kernel.  ;-)
> 
> You can use the filenames as a commit filter, for example:
> 
>    git-shortlog v2.6.25.. kernel/rcu* include/linux/rcu*

OK, this does seem to give a good list.

> Will give you a rather good view about what things changed in RCU land 
> in v2.6.26 so far.
> 
> To see what is queued up in -tip for v2.6.27 that affect RCU, you can 
> do:
> 
>    git-shortlog linus/master..tip/master kernel/rcu* include/linux/rcu*

This also looks good at first glance.

> This will show tip/core/rcu changes. Not unsurprisingly this will show 
> something quite similar to:
> 
>    git-shortlog linus/master..tip/core/rcu
> 
> ... as all RCU patches are supposed to be in that topic branch. [ But it 
> does not hurt to double check me on that :-) ]

This looks good at first glance.

> The widest search that doesnt involve the checking of around 100,000 
> commits is the tip-log-line utility you can find in the tip/tip branch. 
> Via that utility you can filter out all interesting RCU commits:
> 
>    tip-log-line kernel/rcu* include/linux/rcu*
> 
> it will output a tidy list of branches, sha1's and subject lines.

I will dig up the tip-log-line utility.

> (you'll probably first need to run tip-create-local-branches.sh to 
> create local branches out of all the tip topics.)
> 
> for example, to see RCU affecting changes not queued up in tip/core/rcu, 
> you can do:
> 
>  ~/tip> tip-log-line kernel/rcu* include/linux/rcu* | grep -v ' core/rcu:'
>  # core/softirq: 962cf36: Remove argument from open_softirq which is always NULL
>  # core/softirq: a60b33c: Merge branch 'linus' into core/softirq
>  # cpus4096: 363ab6f: core: use performance variant for_each_cpu_mask_nr
> 
> > Is there some way to determine whether a give patch has a tagged patch 
> > (e.g., v2.6.26-rc7) as a child?  It would be very cool to be able to 
> > dump only those patches that are not part of v2.6.26-rc7, as this 
> > would allow me to automatically generate the list of RCU-related 
> > patches from linux-2.6-tip to test against this RC.
> 
> if i understood you correctly, git-describe will do that for you 
> normally. If you have an sha1 you can do:
> 
>  $ git-describe 481c5346d0981940ee63037eb53e4e37b0735c10
>  v2.6.26-rc7-25-g481c534

So this shows the last linus/master commit -not- containing the patch,
correct?  Ah, the most recent -tag-.  So I have to be a bit careful
about creating tags if I want this to work for me.  Fair enough!

						Thanx, Paul
