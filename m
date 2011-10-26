From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git merge successfully however this is still issue from logical perspective
Date: Wed, 26 Oct 2011 14:39:10 +0200
Message-ID: <201110261439.10751.trast@student.ethz.ch>
References: <CAPgpnMSSOss=YxsMUZJ3E5TynDfHJG1i6PKitLBo_Tm7f=_+fQ@mail.gmail.com> <201110261427.03585.trast@student.ethz.ch> <CAPgpnMR6_pRxMSLcdS=M4Cfj=dqk6KTXr3VGhk3LrnPHyv2waA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 14:39:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ2lO-00048g-QY
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 14:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938Ab1JZMjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 08:39:15 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:41021 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932751Ab1JZMjO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 08:39:14 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 26 Oct
 2011 14:39:11 +0200
Received: from thomas.inf.ethz.ch (129.132.210.217) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 26 Oct
 2011 14:39:11 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.6-44-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CAPgpnMR6_pRxMSLcdS=M4Cfj=dqk6KTXr3VGhk3LrnPHyv2waA@mail.gmail.com>
X-Originating-IP: [129.132.210.217]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184259>

Lynn Lin wrote:
> On Wed, Oct 26, 2011 at 8:27 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> > Lynn Lin wrote:
> >> Hi all,
> >>    Do this case can happen? When I do merge from one branch to master
> >> branch,merge successfully however from code logical perspective it
> >> fails and It cause code compile (our project is using C++ language)
> >
> > Sure.  The easiest example is when one side of a merge renames foo()
> > to bar(), while the other side introduces another call to foo() in an
> > unrelated part of the code.
> Does this mean we shouldn't trust merge result  ?

Depends what you mean by "trust".

If you expected a merge to understand what the changes on each side
were about, and then patch the code accordingly, no it can't do
that.[*] You are in no way guaranteed that the result of a merge is
correct or even compiles even if both sides of the merge were.

But after all git-merge is just a tool doing a well-defined operation:
textually merging the changes from both sides.  AFAIK it could so far
always be trusted with doing *that* correctly.



[*] darcs can go half of the way by having more expressive
"changesets", but this can also fail.  I think the general problem is
AI-complete.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
