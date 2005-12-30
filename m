From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [PATCH] Stgit - gitmergeonefile.py: handle removal vs. changes
Date: Fri, 30 Dec 2005 18:59:50 +0100
Message-ID: <200512301859.51000.blaisorblade@yahoo.it>
References: <20051113194225.20447.57910.stgit@zion.home.lan> <b0943d9e0511150154y2d2af24ck@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 19:00:18 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsOXo-0006qn-RF
	for gcvg-git@gmane.org; Fri, 30 Dec 2005 19:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVL3R75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 12:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVL3R75
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 12:59:57 -0500
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:31614 "HELO
	smtp010.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750852AbVL3R74 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2005 12:59:56 -0500
Received: (qmail 81529 invoked from network); 30 Dec 2005 17:59:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=40LjAjVvt6lRb3gx1+3entb63bhLrw9MnWDCsECtSanTMXsGke5gVL2nAq5E6QiIYbRcUspuYAuDALcReUVnWFr9RQrDuMvUyMVZ2ZR7NzEPQ4RH0w7zljpJ5HeJNnc/X28vNSPuMt470d1FNhi9qpMRQtGI2MWeO6CaoIspjGs=  ;
Received: from unknown (HELO host214-43.pool8259.interbusiness.it) (blaisorblade@82.59.43.214 with login)
  by smtp010.mail.ukl.yahoo.com with SMTP; 30 Dec 2005 17:59:55 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: KMail/1.8.3
In-Reply-To: <b0943d9e0511150154y2d2af24ck@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14114>

On Tuesday 15 November 2005 10:54, Catalin Marinas wrote:
> On 13/11/05, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> wrote:
> > I just got a "removal vs. changed" conflict, which is unhandled by StGit.
> > That is taken from git-merge-one-file resolver, but is bad, as stg
> > resolved does not handle unmerged entries (and probably it should be
> > fixed too).
>
> I think it 'stg resolved' should be fixed as well (in case there are
> unmerged entries for other reasons). My initial idea was to make
> gitmergeonefile not to leave any unmerged entries in the index. As you
> could see, there are cases where it failed.

The original patch hasn't been merged, nor (for what I see) anything else to 
fix this problem has been done.

I assume the patch was lost waiting for the discussion to settle down, but the 
patch can be merged, even changing the default choices in any way (see 
below).

Also, another note: I just found Bruce Eckel mentioning pychecker, which is a 
static code checker for Python (to perform the checks a compiler would 
normally do). I've not the time to investigate more myself, but I hope it can 
be useful to you.

> I can see the following scenarios for a file:

> 1. deleted in the base and modified by the patch. It should leave the
> file in the tree together with file.older. Another option would be to
> remove the file and leave both file.older and file.remote in the tree
> (here .remote means the version in the patch) but I would prefer the
> first one.
>
> 2. changed in the base but deleted by the patch. It should remove the
> file from the tree but leave file.older and file.local. The other
> option is to leave the file in the tree but, as above, I prefer the
> first one.
>
> Maybe StGIT should try to track the renaming as well but I haven't
> played with this feature in GIT at all.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
