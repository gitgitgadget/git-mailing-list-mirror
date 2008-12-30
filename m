From: "Zorba" <cr@altmore.co.uk>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 17:22:13 -0000
Message-ID: <gjdlcl$5no$4@ger.gmane.org>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org> <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com> <gjdh0r$n3c$4@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 18:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHiK4-0001iO-U3
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 18:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbYL3RWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 12:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYL3RWn
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 12:22:43 -0500
Received: from main.gmane.org ([80.91.229.2]:49718 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbYL3RWn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 12:22:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHiIf-00030n-KI
	for git@vger.kernel.org; Tue, 30 Dec 2008 17:22:37 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 17:22:37 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 17:22:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Response
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.1 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.1 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104195>

Ok, when I do

$ rm *.*
$ git checkout versionA .

I'm getting ABC.txt, AC.txt, BC.txt

which is wrong as only the first two files went into version A

Paradoxically

$ rm *.*
$ git reset --hard versionA

produces the desired result!

I picked up a few cases like this with git-checkout today. Usually a file or 
two gets copied into the working tree that shouldn't have been (and I'm 
clearing the working tree before each checkout, so its not "leftovers", its 
defo git-checkout doing it)

Its coming back to me now - when I was writing my "warm-up" I tried both 
git-checkout and git-reset, to do my "rollbacks" and git-checkout produced a 
few inconsistent results like above, so I decided to stick with git-reset 
(this was before I knew the dangers of git-reset of course!) for "safety".

Could it be that all the "vandalism" I've perpetrated to the history by 
resetting in a FORWARD direction could have corrupted the history somehow ?

Even so, you'd expect something vanilla like $ git checkout  not to be 
affected.

I'm gonna try the checkouts without doing any resetting beforehand (i.e. no 
messing with the history) to see if I can reproduce this.



"Zorba" <cr@altmore.co.uk> wrote in message 
news:gjdh0r$n3c$4@ger.gmane.org...

** have now promoted git-checkout as the way to review older versions
I've left git-reset in there, for my own notes as much as anything, but not
suggesting it be used as some sort of cursor to move the HEAD up and down
the branch

NB getting some funny results with git-checkout near the head of the branch
- will investigatge and report
