From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: merge confusion
Date: Fri, 31 Jul 2009 09:29:44 -0700
Message-ID: <BLU0-SMTP58E44ED78547385BC3A82BAE100@phx.gbl>
References: <24755682.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thepurpleblob <howardsmiller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:29:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWuzU-0003HC-Hd
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 18:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbZGaQ3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 12:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbZGaQ3s
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 12:29:48 -0400
Received: from blu0-omc3-s36.blu0.hotmail.com ([65.55.116.111]:22150 "EHLO
	blu0-omc3-s36.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751404AbZGaQ3r (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 12:29:47 -0400
Received: from BLU0-SMTP58 ([65.55.116.72]) by blu0-omc3-s36.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Jul 2009 09:29:48 -0700
X-Originating-IP: [69.104.164.24]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from hobo ([69.104.164.24]) by BLU0-SMTP58.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Jul 2009 09:29:47 -0700
In-Reply-To: <24755682.post@talk.nabble.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.2; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 31 Jul 2009 16:29:47.0572 (UTC) FILETIME=[1E90D740:01CA11FC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124578>

On Fri, 31 Jul 2009 06:41:32 -0700 (PDT)
thepurpleblob <howardsmiller@googlemail.com> wrote:

Howard,

> I had some unexpected behaviour doing a merge today. I wonder if anybody can
> tell me where I have gone wrong. This is the sequence...
[...]

Not sure i'm following your question, will take a crack at it though.
I believe this is what you did:

 1. cloned a remote repo
 2. created a local branch B and committed some changes onto it
 3. created another local branch F
 4. committed some changes on F
 5. pulled in additional changes from a remote repo into F
 6. committed additional local changes on F
 7. merged F into B

> What I didn't expect is that all the subsequent changes on the tracked
> remote branch got merged in too. Which I didn't want.

When you merged the feature branch(F) you merged all the new commits made on
it.  By design this includes any commits you pulled in from any remote; you
don't just get the subset of commits that you made locally.

> So the question is - is that what's supposed to happen (ie. if you do any
> merge the tracked branch 'fast forwards' the remote) and, if so, if I want a
> branch that stays a branch (doesn't ever merge with the remote) how would I
> do that?

There's nothing forcing you to merge with a remote, you just need to find a
workflow that accomplishes what you want.  As far as i can tell without knowing
the actual commands you used, it appears you explicitly asked Git to merge in
changes from the remote when you merged the feature branch.

So to hopefully answer your question, don't merge remote changes into your
feature branch if you want your feature branch to only contain local changes
when you merge it with other local branches.

HTH,
Sean
