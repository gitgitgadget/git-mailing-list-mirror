From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git init: activate rerere by default
Date: Fri, 6 Jul 2007 13:03:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707061303260.4093@racer.site>
References: <200707061112.l66BCb6w017186@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1156740302-1183723387=:4093"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 14:10:47 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6me5-0003em-4V
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 14:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759710AbXGFMKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 08:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759686AbXGFMKk
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 08:10:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:44681 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759656AbXGFMKj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 08:10:39 -0400
Received: (qmail invoked by alias); 06 Jul 2007 12:10:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 06 Jul 2007 14:10:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+mJF7AMR+gLNS9lMkY9xkmYlxfKkBgi5FjAMUf5
	vzT52szQ5tXm1L
X-X-Sender: gene099@racer.site
In-Reply-To: <200707061112.l66BCb6w017186@mi1.bluebottle.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51740>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1156740302-1183723387=:4093
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 6 Jul 2007, しらいしななこ wrote:

> I am sorry, but I can't understand how [git rerere] works and how it is 
> useful, after reading the manual page of git-rerere three times.  Are 
> there "rerere tutorial for stupid newbies" document somewhere?  I 
> earlier created .git/rr-cache folder but I have not seen anything 
> interesting happened in my repository.

There is no tutorial. In fact, it should help your workflow seemlessly.

Suppose that you rebase a lot, on top of an upstream who has conflicting 
changes, and refuses (at least for a long time) to merge your work.

What you usually do is work out the conflicts over and over again, often 
identically. Basically for many conflicts (but not necessarily all!), you 
say: "Yes, I have seen that. My version is better."

When rerere is enabled, it records the conflicting hunks (i.e. the parts 
between <<<<<<< ... ======= ... >>>>>>>) together with how you resolved 
it, and next time it sees the same conflicting hunks, it automatically 
applies your resolution.

You should still inspect if it makes sense, and therefore the merge will 
still fail, even if all conflicts were automatically resolved.

Hth,
Dscho

--8323584-1156740302-1183723387=:4093--
