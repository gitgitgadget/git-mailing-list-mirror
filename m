From: "Neal Kreitzinger" <neal@rsss.com>
Subject: rebase planning:  determining blobs changed by multiple branches
Date: Mon, 7 Feb 2011 18:41:44 -0600
Message-ID: <iiq3kb$aiv$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 01:44:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmbgo-0003YV-0w
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 01:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438Ab1BHAoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 19:44:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:60373 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755396Ab1BHAoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 19:44:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pmbgh-0003VZ-FI
	for git@vger.kernel.org; Tue, 08 Feb 2011 01:44:11 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 01:44:11 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 01:44:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166317>

We have 15 branches that are unmerged, but are based on the same published 
history.  They branched off at different points in the history.  Each branch 
is comprised of a single squashed commit (except for master).  How can I 
compare all 15 branches with the tip of master to see which file merges 
(blobs) they have in common?

a-------b-------c-------d-------e-------f-------g-------i-------j-------k-------l
|           |            |           |           |                      | 
|          |           |---k1
|           |            |           |           |                      | 
|          |---j1
|           |            |           |           |                      | 
|---i1
|           |            |           |           | 
|---g1
|           |            |           |           |---e1
|           |            |           |           |---e2
|           |            |           |           |---e3
|           |            |           |---d1
|           |            |           |---d2
|           |            |           |---d3
|           |            |---c1
|           |            |---c2
|           |---b1
|           |---b2
|---a1

The goal is to create a sane plan for rebasing.  If the question is insane 
as it is stated, then please advise on any sane ways to approach this 
besides just rebasing one-by-one and making the last poor branch wait till 
the end to rebase with a ton of conflicts.  I'm dealing with users who 
refuse to do frequent rebases, so a plan the minimizes rebases while getting 
the most out of each rebase is desired, if practical.

v/r,
Neal 
