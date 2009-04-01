From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 08:59:16 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49D32CE5.21780.391D18@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49CCE72E.20081.258EE61F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <m3fxgz2h2n.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 09:01:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LouRp-0002p3-M7
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 09:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbZDAG7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 02:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758877AbZDAG7q
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 02:59:46 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([194.94.155.53]:1085 "EHLO
	rrzmta2.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758811AbZDAG7p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 02:59:45 -0400
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 6C2AFC4761;
	Wed,  1 Apr 2009 08:59:44 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTP id 68805C3ACC;
	Wed,  1 Apr 2009 08:59:43 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n316xZ4q031132;
	Wed, 1 Apr 2009 08:59:35 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    1 Apr 09 08:59:34 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 1 Apr 09 08:59:18 +0100
In-reply-to: <m3fxgz2h2n.fsf@localhost.localdomain>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589357@20090401.064840Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115343>

On 27 Mar 2009 at 7:09, Jakub Narebski wrote:

> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
> > On 27 Mar 2009 at 13:49, Michael J Gruber wrote: 
> > > Ulrich Windl venit, vidit, dixit 27.03.2009 08:21:
> > 
> > [...]
> > 
> > > Keyword substitution and cvs/svn style version numbers are independent
> > > issues. The sha1 describes a commit uniquely, one could use that as a
> > > keyword.
> > 
> > However version numbers and time stamps have the property of being at least 
> > partially ordered in respect of "newer/older". That property does not hold for 
> > SHA-1 checksums. Just imagine suggesting users to upgrade from Microsoft 
> > Word/004765c2a1e9771e886f0dbe87d4f89643cd6f70 to Microsoft 
> > Word/00b7e6f51130f234a969c84ee9231a5ff7fc8a82 ;-)
> 
> That is why people use output of git-describe and _tag_ their releases,
> and make embedding version number in released version (tarball / binary)
> the job of make: see GIT-VERSION-GEN script in git sources, and how it
> is used in Makefile.

OK, but imaginge someone sends you some file that originated from some git 
version, maybe with minor modifications. Is there a way to find out from what git 
version that file was derived? IMHO that's where "automatically replaced 
placeholders" (like $id$) make sense.

> 
> > 
> > > 
> > > Increasing version numbers are meaningless in a true DVCS world. What is
> > > your 100th commit may not be someone else's, even if both your master's
> > > heads are the same! This is why hg version numbers are a local thing.
> > > They are merely a local shortcut for specifying a revision and serve the
> > > same purpose as git's "backward" counts like HEAD~3 etc. Neither of them
> > > work permanently, not even in a local repo, if you allow rebasing.
> > 
> > Maybe I didn't fully understand, but having a version number that is larger than 
> > any parent's version numbers when doing a merge/commit doesn't look wrong to me.
> 
> I'm sorry to dissapoint you, but without central server assigning
> numbers to commits it wouldn't simply work in distributed version
> control world.  Take for example the following situation: somebody
> clones your repository, and creates new commit on 'master' (trunk) and
> it gets version number N.  Meanwhile you also independently create new
> commit on 'master'... and without central authority it would also get
> version number N.  Then you would merge (pull) his/her changes, and
> you would have two commits with the same number; not something you want.

Anyway the result would have number "N+1". Maybe you misunderstood: I'm not 
proposing to replace git's internal version numbering (SHA-1), but so introduce 
some more comprehensible, primitive user-level numbering.

> 
> Not to mention that you can have multiple roots (multiple commits with
> no parent) in git repository; besides independent branches (like
> 'man', 'html' or 'todo') it is usually result of absorbing or
> subtree-merging other projects.  In 'master' branch there are 5 roots
> or more: joined 'git-tools' (mailinfo / mailsplit), absorbed gitweb,
> and subtree-merged gitk and git-gui.  And here you would again have
> multiple commits with the same number...

Which would not harm, because it would be version N from committer X. Any if 
committer X merges from anything else, the next number would be > N. I did not 
claim that my method makes a total ordering of commits and merges possible.

I truly believe in unique IDs, but they are just not handy in every situation.

[...]

Regards,
Ulrich
