From: "Zorba" <cr@altmore.co.uk>
Subject: Re: is there an easier way to do this ?
Date: Tue, 30 Dec 2008 03:51:45 -0000
Message-ID: <gjc5t2$g02$4@ger.gmane.org>
References: <gjc52u$ehc$4@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 04:53:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHVfu-0008Cb-CV
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 04:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbYL3DwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 22:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbYL3DwS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 22:52:18 -0500
Received: from main.gmane.org ([80.91.229.2]:48531 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbYL3DwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 22:52:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHVeP-0001bD-Ga
	for git@vger.kernel.org; Tue, 30 Dec 2008 03:52:13 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 03:52:13 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 03:52:13 +0000
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104151>

The manual shows you can SHOW untracked files, but not add them as part of 
the commit -a jig

Seems a bit strange that git-add operates on both exisging and new files 
when used standalone, but its behaviour changes when encapsulated in 
commit -a...

So, I thought maybe $ git commit -a, then $ git add .
but then the files tracked have missed the commit boat they were meant to be 
on, haven't they,

hang on -
what about

$ git add .
$ git commit -a

I do believe I've cracked it
if so, it seems a bit wasteful, 2x adds (one explicti and one embedded 
in -a) ? shame on you linux kernel guys, i'd have expected better :-)

"Zorba" <cr@altmore.co.uk> wrote in message 
news:gjc52u$ehc$4@ger.gmane.org...
> ok, now I'm in this for real, archiving versions of our website project 
> (5k files approx)
>
> so here is the workflow:
>
> - copy version 1 files into GIT dir
>
> - open git bash
>
> $ git init
>
> $ git add .
>
> $ git commit -m "version1"
>
> all vanilla ? cool
> next job = store version 2, so delete version 1 files from GIT dir, copy 
> in version 2
> version2 has different files from 1 - which ones? Out of 5k files could be 
> 1% = 50 new ones, and same amount removed. Why should I care, with such a 
> powerful friend as git around, n'est pas?
> THIS TIME we are going to be CLEVER and use "-a" flag on commit to pick up 
> any files that have been REMOVED (or "deleted" in git-speak)
>
> $ git commit -a -m "version2"
>
> BUT this does not pick up any new ones that have been added,
>
> and when we run
>
> $ git status > ../git_status.txt
>
> these are referred to as "untracked files"
> only problem there are 50 ish
> is there not another flag on git commit to treat any untracked file as a 
> new file ?
> (would save me typing or creating a list out of these untracked ones and 
> feeding them into git add)
>
> I know, I realise now I should have looked up git-commit in the manual - 
> in case its not there, pls enlighten me !
>
>
> 
