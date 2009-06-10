From: Harry Duin <hduin@optionshouse.com>
Subject: RE: branch management
Date: Wed, 10 Jun 2009 09:02:54 -0500
Message-ID: <08614AC584A6ED42BD836DE9286376E12A211FA9D0@spswchi6mail1.peak6.net>
References: <7vfxe9udln.fsf@alter.siamese.dyndns.org>
 <4A2E0C88.70805@gmail.com> <20090609080612.GG9993@laphroaig.corp>
 <7viqj5nzgz.fsf@alter.siamese.dyndns.org>
 <20090609172302.GH9993@laphroaig.corp>
 <08614AC584A6ED42BD836DE9286376E12A211FA9CA@spswchi6mail1.peak6.net>
 <20090609195018.GA17848@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: 'Alex Riesen' <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEOOf-0007Q9-FG
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 16:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbZFJODP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 10:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbZFJODO
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 10:03:14 -0400
Received: from smtp.peak6.com ([38.98.137.6]:35700 "EHLO
	svachi1psmtp1.peak6.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754604AbZFJODN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 10:03:13 -0400
X-AuditID: c0a80b1e-b7b18ae000000b12-9f-4a2fbd0e37dc
Received: from spswchi6mail1.peak6.net (Unknown_Domain [192.168.11.14])
	by svachi1psmtp1.peak6.net (Symantec Mail Security) with SMTP id 75.F6.02834.E0DBF2A4; Wed, 10 Jun 2009 09:02:55 -0500 (CDT)
Received: from spswchi6mail1.peak6.net ([10.2.4.25]) by
 spswchi6mail1.peak6.net ([10.2.4.25]) with mapi; Wed, 10 Jun 2009 09:02:54
 -0500
Thread-Topic: branch management
Thread-Index: AcnpjY2k/5s3yK4DTtueA1RnCfhUQwARS+hw
In-Reply-To: <20090609195018.GA17848@blimp.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121275>

Yes, I am aware that branching is different in git than what I have used so far with SVN. But apart from the implementation, I have some information that I want to gather about work done on a branch. Here are a few questions/scenarios that I want to make sure we can handle. Remember that our branches are mapped one to one to a Jira ticket.

1. show all code changes performed on a branch (for code review)
2. show list of files/directories touched by a branch (useful when looking for past fixes, but are unsure where the fix was done)

So far I have not found the exact syntax to get this information, but am convinced that git can provide it!

-Harry

-----Original Message-----
From: Alex Riesen [mailto:raa.lkml@gmail.com] 
Sent: Tuesday, June 09, 2009 2:50 PM
To: Harry Duin
Cc: git@vger.kernel.org
Subject: Re: branch management

Harry Duin, Tue, Jun 09, 2009 19:35:24 +0200:
> My questions are on branch management. 

You seem to think about branches as they are in CVS or SVN (just
directories with in-system metadata). You'll find the Git's branching
different (being more about history, not at all about directory
structure).

> 1. We have different repos for doing the integration merging. In
> addition to that we have a golden repos, containing what is in
> production. The branch history gets pushed by developers to the
> integration repos, but not to the golden repos. Since our integration
> repos are created for each integration, this means I have lost my
> branch history when an integration repos gets deleted..

No. As long as there is something, basing its history on the history
of the integration repos (and I assume that your "golden", aka
"release" or "maintenance" elsewhere, do just that) the history is
there. Forever. As it is on every developers machine with a
distributed VCS.

> 2. What command do I use to display only the list of files updated by/for a
> branch?

Do you mean the files changed since the branch (presumably "development")
diverged from some other branch (presumably "golden")?
What for?

> This means I want to exclude files that were merged in from say
> master - these files are not part of the branch development.

You better not exclude files (and while at it, stop thinking about
files when working with _history_).

Try describing the problem on _change_ (aka "commit", or point in time
or history) level.

P.S. Your (re?)mailer seems to be broken. This mail is not very
correct base64 and gmail does not even decode it.

_______________________________________________________

www.peak6.com

The  information in this email or in any file attached
hereto is intended only for the personal and confiden-
tial  use  of  the individual or entity to which it is
addressed and may contain information that is  propri-
etary  and  confidential.  If you are not the intended
recipient of this message you are hereby notified that
any  review, dissemination, distribution or copying of
this message is strictly prohibited.  This  communica-
tion  is  for information purposes only and should not
be regarded as an offer to sell or as  a  solicitation
of an offer to buy any financial product. Email trans-
mission cannot be guaranteed to be  secure  or  error-
free. P6070214
