From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Fri, 22 Oct 2010 17:46:28 -0400
Message-ID: <1287783988.819.19.camel@drew-northup.unet.maine.edu>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	 <vpq8w1v5gce.fsf@bauges.imag.fr> <buopqv6kcsd.fsf@dhlpc061.dev.necel.com>
	 <8B950268-7F6E-40E5-9D6C-F150EBEA4F0C@wincent.com>
	 <AANLkTinb0149C88Mzx6m4_2BdhpW12OwQ+uP6XzQ5yLx@mail.gmail.com>
	 <6FCE62E3-A27E-43D6-9FDF-0133ABD851C2@wincent.com>
	 <AANLkTinGuVm8gib9r7omVV9hHw8B-iBQGgsv+b6wb5=Q@mail.gmail.com>
	 <1287778585.2025.14.camel@localhost.localdomain>
	 <AANLkTinUc2BW+BOTNMOC1t=3=rYzYgedyS5LFu37J+Yo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Paul Bolle <pebolle@tiscali.nl>,
	Wincent Colaiuta <win@wincent.com>,
	Miles Bader <miles@gnu.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 23:46:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9PRu-0005bK-NT
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 23:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346Ab0JVVqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 17:46:49 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:56927 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab0JVVqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 17:46:49 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9MLkZ4A019203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 17:46:35 -0400
In-Reply-To: <AANLkTinUc2BW+BOTNMOC1t=3=rYzYgedyS5LFu37J+Yo@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=7 Fuz1=7
	Fuz2=7
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9MLkZ4A019203
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288388795.80887@u/yDvQK2NBYN1s26LFLx3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159754>


On Fri, 2010-10-22 at 17:00 -0400, Eugene Sajine wrote:
> On Fri, Oct 22, 2010 at 4:16 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> > On Tue, 2010-10-19 at 11:09 -0400, Eugene Sajine wrote:
> >> There should be some different consistent and not inter-crossing
> >> naming for the origin's master branch (on the remote side), for the
> >> local origin/master and for local master that is a tracking branch.
> >> The only way i found so far to explain this is actually via the naming
> >> syntax where having / in the name of the branch means remote branch. I
> >> was a bit surprised that i can create a local branch with a slash in
> >> the name - probably it should be prohibited.
> >
> > Allowing local branches with a slash in their name is a feature I use
> > heavily. Ie, in general my local repositories use this scheme:
> >
> > $ git branch
> > * master
> >  $BRANCH_F00
> >  $USER/$TOPIC_FOO
> >  $USER/$TOPIC_BAR
> >  [...]
> >  $USER/$TOPIC_BAZ
> >
> > This makes it trivial to quickly distinguish my (local) work from other
> > people's (remote) work. Does the benefit of naming clarity justify
> > prohibiting that scheme?
> >
> >
> > Paul Bolle
> >
> >
> 
> Well, my approach is to use:
> master - local
> mybranch - local
> 
> remote from user
> $ git remote add jdoe ~jdoe/project/.git
> 
> Then remote-tracking branches will be
> jdoe/master
> jdoe/featurex
> 
> my local branches tracking remote-tracking branches (automatic push, pull)
> jd_master
> jd_featurex
> 
> in this case there is no confusion between jdoe/master that is a
> remote-tracking branch checkout to which will lead to detached HEAD
> state and jd_master that is a local branch.
> 
> As in this syntax the slash is that meaningful, i think that reserving
> this syntax "remote/branch" to the remote-tracking branches only makes
> sense.

I think that leaving it as is, wherein the "/" is not a special
character that SPECIFICALLY means remote is just fine. If people choose
to use that by convention that's dandy as well, but I don't see any
point in forcing it.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
