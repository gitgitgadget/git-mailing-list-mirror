From: Albert Astals Cid <aacid@kde.org>
Subject: Re: Making git push output quieter
Date: Wed, 5 Aug 2009 21:13:06 +0200
Message-ID: <200908052113.06373.aacid@kde.org>
References: <200908042327.10912.aacid@kde.org> <3af572ac0908041520l327482f1u45121b6b991a3673@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 21:13:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYlvN-0002Je-EA
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 21:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbZHETNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 15:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbZHETNN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 15:13:13 -0400
Received: from enginyeriainformatica.cat.224.160.195.in-addr.arpa ([195.160.224.245]:47225
	"EHLO enterprise.coeic.org" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750706AbZHETNM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 15:13:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by enterprise.coeic.org (Postfix) with ESMTP id 55373781939;
	Wed,  5 Aug 2009 23:27:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 3.621
X-Spam-Level: ***
X-Spam-Status: No, score=3.621 tagged_above=-10 required=6.6
	tests=[AWL=-0.702, BAYES_20=-0.74, FH_HOST_EQ_DYNAMICIP=4.058,
	RCVD_IN_PBL=0.905, RDNS_DYNAMIC=0.1]
Received: from enterprise.coeic.org ([127.0.0.1])
	by localhost (enterprise.coeic.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XlInZb6XosBj; Wed,  5 Aug 2009 23:26:59 +0200 (CEST)
Received: from bluebox.localnet (79.Red-79-144-33.dynamicIP.rima-tde.net [79.144.33.79])
	by enterprise.coeic.org (Postfix) with ESMTP id 6321878194B;
	Wed,  5 Aug 2009 23:26:59 +0200 (CEST)
User-Agent: KMail/1.12.0 (Linux/2.6.28-14-generic; KDE/4.3.0; x86_64; ; )
In-Reply-To: <3af572ac0908041520l327482f1u45121b6b991a3673@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124953>

A Dimecres, 5 d'agost de 2009, Pau Garcia i Quiles va escriure:
> On Tue, Aug 4, 2009 at 11:27 PM, Albert Astals Cid<aacid@kde.org> wrote:
> > Hi, at KDE we are starting to try to use git and one of the things that's
> > bothering me is that git push is too verbose for our scripts.
> >
> > We have some scripts that commit things and i get the diff of previous
> > runs, if there is no diff it means all worked fine, a diff means
> > something i have to look at.
> >
> > Now i'm getting diffs like
> >
> > -Counting objects: 23, done.
> > +Counting objects: 53, done.
> >  Delta compression using up to 2 threads.
> > -Compressing objects:   8% (1/12)   Compressing objects:  16% (2/12)
> > Compressing objects:  25% (3/12)   Compressing objects:  33% (4/12)
> > Compressing objects:  41% (5/12)   Compressing objects:  50% (6/12)
> > Compressing objects:  58% (7/12)   Compressing objects:  66% (8/12)
> > Compressing objects:  75% (9/12)   Compressing objects:  83% (10/12)
> > Compressing objects:  91% (11/12)   Compressing objects: 100% (12/12)
> > Compressing objects: 100% (12/12), done.
> > -Writing objects:   8% (1/12)   Writing objects:  16% (2/12)   Writing
> > objects:  25% (3/12)   Writing objects:  33% (4/12)   Writing objects:
> >  41% (5/12)   Writing objects:  50% (6/12)   Writing objects:  58% (7/12)
> >   Writing objects:  66% (8/12)   Writing objects:  75% (9/12)   Writing
> > objects:  83% (10/12)   Writing objects:  91% (11/12)   Writing objects:
> > 100% (12/12) Writing objects: 100% (12/12), 1.05 KiB, done.
> > -Total 12 (delta 11), reused 0 (delta 0)
> > +Compressing objects:   3% (1/29)   Compressing objects:   6% (2/29)
> > Compressing objects:  10% (3/29)   Compressing objects:  13% (4/29)
> > Compressing objects:  17% (5/29)   Compressing objects:  20% (6/29)
> > Compressing objects:  24% (7/29)   Compressing objects:  27% (8/29)
> > Compressing objects:  31% (9/29)   Compressing objects:  34% (10/29)
> > Compressing objects:  37% (11/29)   Compressing objects:  41% (12/29)
> > Compressing objects:  44% (13/29)   Compressing objects:  48% (14/29)
> > Compressing objects:  51% (15/29)   Compressing objects:  55% (16/29)
> > Compressing objects:  58% (17/29)   Compressing objects:  62% (18/29)
> > Compressing objects:  65% (19/29)   Compressing objects:  68% (20/29)
> > Compressing objects:  72% (21/29)   Compressing objects:  75% (22/29)
> > Compressing objects:  79% (23/29)   Compressing objects:  82% (24/29)
> > Compressing objects:  86% (25/29)   Compressing objects:  89% (26/29)
> > Compressing objects:  93% (27/29)   Compressing objects:  96% (28/29)
> >  Compressing objects: 100% (29/29)   Compressing objects: 100% (29/29),
> > done. +Writing objects:   3% (1/29)   Writing objects:   6% (2/29)  
> > Writing objects:  10% (3/29)   Writing objects:  13% (4/29)   Writing
> > objects:  17% (5/29)   Writing objects:  20% (6/29)   Writing objects:
> >  24% (7/29)   Writing objects:  27% (8/29)   Writing objects:  31% (9/29)
> >   Writing objects:  34% (10/29)   Writing objects:  37% (11/29)   Writing
> > objects:  41% (12/29) Writing objects:  44% (13/29)   Writing objects:
> >  48% (14/29)   Writing objects:  51% (15/29)   Writing objects:  55%
> > (16/29)   Writing objects:  62% (18/29)   Writing objects:  65% (19/29)  
> > Writing objects:  68% (20/29) Writing objects:  72% (21/29)   Writing
> > objects:  75% (22/29)   Writing objects:  79% (23/29)   Writing objects:
> >  82% (24/29)   Writing objects:  86% (25/29)   Writing objects:  89%
> > (26/29)   Writing objects:  93% (27/29) Writing objects:  96% (28/29)  
> > Writing objects: 100% (29/29)   Writing objects: 100% (29/29), 4.46 KiB,
> > done.
> > +Total 29 (delta 23), reused 0 (delta 0)
> >  => Syncing Gitorious... [OK]
> >  To git@gitorious.org:amarok/amarok.git
> > -   f7863f9..f4370ae  HEAD -> master
> > +   1a1b30f..670cb0e  HEAD -> master
> >
> > That really are not a problem and are filling my diffs for no reason. We
> > could redirect to > /dev/null the git push command but then i would not
> > see if anything failed.
> >
> > Is it possible to make git push just output data when failing? And if not
> > do you think it's a worthwhile feature i can ask for? Do you have a
> > formal way for feature requests?
>
> Have you tried redirecting only stdout to /dev/null, and keeping
> stderr to yourself ?

Everything goes to stderr.

> In addition to that, exit code != 0 means
> something went wrong.

I could make something with this, but is it really not something that should 
happen that errors go to stderr and regular text to stdout?

Albert
