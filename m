From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git Bug - diff in commit message.
Date: Fri, 9 Sep 2011 02:56:36 +0200
Message-ID: <201109090256.36306.trast@student.ethz.ch>
References: <1315493353942-6772145.post@n2.nabble.com> <CAMOZ1BtbpbG+19G6Hfau_2_F5L3Ad+x-Payd9aKajJxU_V_tyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: anikey <arty.anikey@gmail.com>, <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 02:56:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1pOe-0008K2-Cm
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 02:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248Ab1IIA4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 20:56:40 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:28217 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756852Ab1IIA4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 20:56:38 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 9 Sep
 2011 02:56:34 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 9 Sep
 2011 02:56:36 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CAMOZ1BtbpbG+19G6Hfau_2_F5L3Ad+x-Payd9aKajJxU_V_tyA@mail.gmail.com>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181013>

Michael Witten wrote:
> On Thu, Sep 8, 2011 at 14:49, anikey <arty.anikey@gmail.com> wrote:
> > Hi, peops. I'm pretty much sure that's a bug.
> >
> > What I did was putting git diff (i needed to tell people that for my changes
> > to start working they needed to aplly message-inline patch to some code
> > which was not under git) in commit message. Like adding:
> 
> It would appear that `git rebase' is in fact producing patches with
> `git format-patch' and then applying the resulting patches with `git
> am', which gets confused by your inline diff; this can be clearly seen
> in the `git-rebase--am[.sh]' file.
> 
> Perhaps `git rebase' should be reimplemented to use `git cherry-pick',
> or does that suffer from the same problem?

It doesn't, since it uses a three-way merge.  But there's no real
reason to reimplement anything; just use an interactive rebase, it
uses cherry-pick in a loop.


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
