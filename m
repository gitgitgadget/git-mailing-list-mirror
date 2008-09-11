From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/2.5] Documentation: new upstream rebase recovery section in git-rebase
Date: Thu, 11 Sep 2008 17:38:43 +0200
Message-ID: <1221147525-5589-1-git-send-email-trast@student.ethz.ch>
References: <200809030738.09589.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 17:41:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdoHd-0005YK-D8
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 17:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbYIKPiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 11:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755484AbYIKPiy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 11:38:54 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24730 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbYIKPix (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 11:38:53 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Sep 2008 17:38:51 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Sep 2008 17:38:50 +0200
X-Mailer: git-send-email 1.6.0.1.470.g200b
In-Reply-To: <200809030738.09589.trast@student.ethz.ch>
X-OriginalArrivalTime: 11 Sep 2008 15:38:50.0752 (UTC) FILETIME=[7D21E000:01C91424]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95613>

So here's the follow-up I promised.

Junio C Hamano <gitster@pobox.com> wrote:
>
> Thomas Rast <trast@student.ethz.ch> writes:
> > - Is it perhaps too verbose, or in the wrong place?  I did not want to
> >   detract from the feature descriptions that the manpage should first
> >   and foremost contain.  Chances that a user will "accidentally" read
> >   the section at this position and length seem fairly low however.
> 
> It feels on a bit too repetitive side, but I think this is going in the
> right direction.  How about dropping the earlier part of the change to
> Notes section (but keep "See also" which is a good guide for understanding
> the said "implications")?

I rewrote it to include the actual rebase behaviour and some scenarios
that arise from 'rebase -i', 'commit --amend' etc., then tried to
shorten the section as far as I could.  Hopefully this cut down on the
repetitions.  Unfortunately it still grew longer due to the extra
content.  The second patch then includes references to that section in
the appropriate manpages.

The third patch is again RFC, and I made it regarding this section:

> The additions you made are all about why rebasing public history is bad
> from mechanisms [...] POV.
> While that description is all good, I think there should also be a
> discussion from the patchflow/workflow angle.
> 
> "Upstream has rebased" almost implies that it has its own upstream
> (i.e. "My upstream" is not the toplevel upstream, but is a subsystem tree
> or something).
> 
> Rebasing upstream is bad, but an upstream that backmerges from its own
> upstream too often is equally bad, and the reason of the badness, viewed
> from the workflow angle, shares exactly the same component.
> 
> It means that the mid-level upstream in question is not focused enough.

I noticed that there is no manpage in which we document such workflows
anyway.  There is a short definition of 'topic branch' in
glossary-content.txt, and a parenthetical definition in
user-manual.txt in a sort of "linux.git howto".  Nothing longer,
however.

  [I learned what I know from Linus's Google Tech Talk[1], Tv's more
  recent EuroPython talk[2], looking at git.git, and mail such as the
  ones you linked.  I recommended [2] to people who asked about topic
  branches on #git a few times.]

So this is an attempt to make a "workflow reference".  I tried to
strike a balance between "just" a reference (the Rule/Recipe blocks)
and more of a tutorial approach which explains the reasons.  I would
again greatly appreciate comments.

- Thomas


Thomas Rast (2+1):
  Documentation: new upstream rebase recovery section in git-rebase
  Documentation: Refer to git-rebase(1) to warn against rewriting
  Documentation: add manpage about workflows


[1] http://video.google.com/videoplay?docid=-2199332044603874737
[2] http://blip.tv/file/1114793/
