From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: Files different for me
Date: Wed, 25 Feb 2009 14:01:09 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709E048A8@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com> <7E43550E-68B7-4B22-A83C-F840A7037CA9@silverinsanity.com> <450196A1AAAE4B42A00A8B27A59278E709E0486D@EXCHANGE.trad.tradestation.com> <013B8F55-FBCC-4D3B-9EA4-13C05FFE986B@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 20:02:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcP1l-0006W7-D5
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 20:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbZBYTBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 14:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbZBYTBN
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 14:01:13 -0500
Received: from mail5.tradestation.com ([63.99.207.76]:59808 "EHLO
	mail5.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbZBYTBN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 14:01:13 -0500
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Feb 2009 14:01:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <013B8F55-FBCC-4D3B-9EA4-13C05FFE986B@silverinsanity.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Files different for me
thread-index: AcmXeER7LkQrZHOMQ/6o4jKXS/aUJQAAX7aw
X-OriginalArrivalTime: 25 Feb 2009 19:01:10.0887 (UTC) FILETIME=[6C33B770:01C9977B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111479>

Thanks for the clarification, and thanks all on the thread for
explaining things to me.
It appears that fetching with my local changes is not a problem.  For
going the other way, you suggest:

	For pushing, I'd suggest either working on new features in a
different
	branch ("topic" and "local" for example), or using "rebase -i"
to move
	your local changes to the top and using "push HEAD^".

I get the idea of floating "that" change to the top and using "push
HEAD^", though I've never tried --interactive so I'll have to play
around with that on a backup first.

I think if those changes are not committed, it won't be an issue.  

So, my plan at this point is to "stash" my Local Change, and then apply
it.  Then just keep it out of the index.  If I do get a conflict, I can
re-apply my change from the stashed copy.  


Ordinarily, I'll all about working on a feature on a branch, exposing a
"task based" system to other developers.  But, this particular change is
not isolated, and I'm adding parameter to functions and such (I'm
changing the way configuration works and making more things
configurable) all over the place.  I want to push stable work frequently
so other changes don't get too far away making a merge nightmare.

<rant>
Last time, I was careful to publish stable code frequently to the
official "dev" branch, but when another major feature was finished, they
just declared that branch to be the new main-line official branch.
</rant>


-----Original Message-----
From: Brian Gernhardt [mailto:benji@silverinsanity.com] 

You can set branch.master.rebase with

   git config branch.master.rebase true

It actually works the other way.  Your changes will be rebased on top of
the work from other developers.

A--B--E--F  origin/master
     \
      C--D master

will become

A--B--E--F  origin/master
           \
            C'--D' master

I share most of my changes using format-patch and e-mail instead of
pushes, so I just don't generate patches for my unimportant changes.
For pushing, I'd suggest either working on new features in a different
branch ("topic" and "local" for example), or using "rebase -i" to move
your local changes to the top and using "push HEAD^".

~~ Brian
