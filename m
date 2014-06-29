From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Trouble merging renamed but identical files - CONFLICT (rename/rename)
Date: Sun, 29 Jun 2014 17:13:07 -0400
Organization: PD Inc
Message-ID: <CBA6D67B4439423CB4F73F3DD3C08952@black>
References: <CABURp0rFCxxpiQhRYXmN5eBnKhyyOeuFSTj0V1tGZJSNea5iEA@mail.gmail.com> <66A60DA77398CD439FA676CEF593977D52477A@exchange.1.internal.pdinc.us> <CEAC9BE9F83B4CD0AFD73BBAC8A54232@black> <CABURp0okCDbwLOL3Osj2WtfQ_Qj3v=1FrAV28gJjPy1yzQU7Vg@mail.gmail.com> <CABURp0qZVMGMQ8X4P0P1OGF9gNqu__=Uk+Lr7GyBbscm5wL1=w@mail.gmail.com> <35E240FD8DD74A2F9B80FFCBD818A122@black> <CABURp0q1u_Hzz2ni63oHuinFpBTCzZ+=-6h5YpC0k_bQ_03TSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "'Phil Hord'" <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 23:13:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1MPT-0006fO-42
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 23:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbaF2VNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 17:13:11 -0400
Received: from mail.pdinc.us ([67.90.184.27]:60736 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbaF2VNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 17:13:10 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5TLD7S6010297;
	Sun, 29 Jun 2014 17:13:07 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac+T2IT2OqvIHfs3QA2PjYmlAVrM3gABa1Pg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
In-Reply-To: <CABURp0q1u_Hzz2ni63oHuinFpBTCzZ+=-6h5YpC0k_bQ_03TSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252650>

> -----Original Message-----
> From: Phil Hord
> Sent: Sunday, June 29, 2014 16:27
> 
> On Sun, Jun 29, 2014 at 4:20 PM, Jason Pyeron 
> <jpyeron@pdinc.us> wrote:
> >> -----Original Message-----
> >> From: Phil Hord
> >> Sent: Sunday, June 29, 2014 16:09
> >>
> >> On Sun, Jun 29, 2014 at 11:31 AM, Phil Hord
> >> <phil.hord@gmail.com> wrote:
> >> > On Fri, Jun 27, 2014 at 8:42 PM, Jason Pyeron
> >> <jpyeron@pdinc.us> wrote:
> >> >> Sorry for the http://pastebin.com/1R68v6jt (changes the merge to
> >> >> 1ca13ed2271d60ba93d40bcc8db17ced8545f172, and manually
> >> reconciles the merge),
> >> >> but it was too long to be readable in the email.
> >>
> >> Ok, I think I understand the issue you are trying to solve now.
> >>
> >> Git (rather famously[1]) does not record renames or copies.  It is
> >> expected instead that renames and copies will be detected 
> when it is
> >> important after the fact. This allows us to ignore rename detection
> >> and resolution when creating project history; in the future, better
> >> rename/copy detection will "just work" on existing repositories and
> >> the repos themselves will not need to be adjusted.
> >
> > Looking at http://pastebin.com/1R68v6jt , I have a work around.
> >
> > In summary, 7.git cherry-pick -x HEAD..rebranding , then
> >
> > git merge $(echo 'Merge of 
> 1ca13ed2271d60ba93d40bcc8db17ced8545f172 branch -
> > rebranding' |\
> >     git commit-tree -p HEAD -p rebranding \
> >          $(git cat-file -p HEAD | grep ^tree | sed -e 
> 's/^tree //') )
> >
> > Now it is perfect in the blame and log --graph.
> 
> Yes, but your workaround unnecessarily duplicates commits and
> complicates the history of your project. You are munging your project

But I want to avoid thet complicating, while still showing that line 42 was
modified by X. Should this be possible with a merge, without using cherry-pick?

> to compensate for git's current shortcomings.

Btw I am not able to pull up https://git.wiki.kernel.org/ or
http://git.wiki.kernel.org/ 

-Jason 

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
