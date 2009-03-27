From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 10:50:04 +0100
Organization: Universitaetsklinikum Regensburg
Message-ID: <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <20090327090554.5d6160f2@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Mar 27 10:52:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln8ja-0008Jf-3e
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 10:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758384AbZC0Juf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 05:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757111AbZC0Juf
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 05:50:35 -0400
Received: from rrzmta1.rz.uni-regensburg.de ([194.94.155.51]:29433 "EHLO
	rrzmta1.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756591AbZC0Jud (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 05:50:33 -0400
Received: from rrzmta1.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 18FEBABCAE;
	Fri, 27 Mar 2009 10:50:34 +0100 (CET)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta1.rz.uni-regensburg.de (Postfix) with ESMTP id F2AD3ABC8A;
	Fri, 27 Mar 2009 10:50:33 +0100 (CET)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20060824MT-1) with ESMTP id n2R9oIMn004036;
	Fri, 27 Mar 2009 10:50:24 +0100
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    27 Mar 09 10:50:23 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 27 Mar 09 10:50:10 +0100
In-reply-to: <20090327090554.5d6160f2@pc09.procura.nl>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589108@20090327.095018Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114875>

On 27 Mar 2009 at 9:05, H.Merijn Brand wrote:

> On Fri, 27 Mar 2009 08:21:36 +0100, "Ulrich Windl"
> <ulrich.windl@rz.uni-regensburg.de> wrote:
> 
> > What I'd like to see in git (My apologies if some were already discussed to 
> > death):
> > 
> > 1) The ability to use the file's time at the time of add/commit instead of
> >    the current time, and the ability tho check outfiles with the times stored
> >    in the repository.
> > 
> > 2) Keyword substitution. I know it's controverse (dealing with binary files),
> >    but I'd like to have some automatic version numbering keyword at least:
> >    Initial idea is that every commit with a change increments the number by
> >    one, and when merging numbers a and b, the resulting number is max(a, b) + 1.
> 
> impossible. Even with checkin- and checkout hooks, you won't get that
> SCCS behaviour. They have to be better in something too :)
> /me still misses that but got used to it

Hi,

what made me wonder is this (about item 1): I thought I've read that blobs store 
content and attributes, so very obviously I wondered why not store thr "right 
attributes" (i.e. the time of the file). My reasoning: You make some changes, then 
test them (which might last several hours or days). The if I'm happy I'll 
"commit". Naturally I want to see the time of change for each file when the change 
had been actually made, not when the change was committed. Likewise when checking 
out, I want to be able to see the time of modification, not the time of commit. 
I'm aware that many people don't care about such differences...

> 
> > 3) "git undo": If possible undo the effects of the last command.

If impossible, add confirmations for some "dangerous" (non-obvious) commands 
before doing possibly harmful things. Maybe adding a kind of "user-level setting" 
(novice, expert, guro) could control such confirmations.

> > 
> > Following are some random remarks from a first-time git user, regarding the 
> > buld/install:
> > 
> > Notes on building git-1.6.1.3 on openSUSE 11.0:
> > There is no "asciidoc"; the INSTALL should be more verbose on special
> > requirements (i.e. additional packages needed, and where to get them).
> 
> # zypper in asciidoc libcurl-devel

"asciidoc" doesn't seem a popular package on some distributions; mine lacks it...
> 
> (yes, 'make install-man' should stop soon after detecting asciidoc is
> not installed

Regards,
Ulrich
