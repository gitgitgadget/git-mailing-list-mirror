From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG?] "git rebase --interactive" forces me to edit message.
Date: Sat, 7 Jun 2008 05:57:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806070556030.1783@racer>
References: <alpine.DEB.1.00.0806050536380.21190@racer> <200806050358.m553wgK9013230@mi0.bluebottle.com> <200806062147.m56LlCOe030269@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-552689539-1212814652=:1783"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 07:00:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4qX5-0006ca-2q
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 07:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbYFGE6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 00:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbYFGE6u
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 00:58:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:48136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753387AbYFGE6s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 00:58:48 -0400
Received: (qmail invoked by alias); 07 Jun 2008 04:58:45 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp045) with SMTP; 07 Jun 2008 06:58:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kaX0/6AokLSWau37KRwYOt3quPJIlMVHDpQg1Ii
	uX/7Gj80xejhBU
X-X-Sender: gene099@racer
In-Reply-To: <200806062147.m56LlCOe030269@mi0.bluebottle.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84173>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-552689539-1212814652=:1783
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 7 Jun 2008, しらいしななこ wrote:

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> 
> > On Thu, 5 Jun 2008, しらいしななこ wrote:
> >
> >> When an interactive rebase stops because of conflicts in a commit 
> >> marked with pick, the user must edit the file to resolve them, run 
> >> "git add", and run "git rebase --continue".  It then opens vi and 
> >> asks the user to edit the message.  If I told the command to edit, I 
> >> think it is OK to start vi, but when I am just picking the commit, I 
> >> should be able to use the message from the original commit without 
> >> having to view nor edit nor save it first. Is this a bug?
> >
> > No, it is intentional.
> >
> > If you have to edit, because of conflicts, it may be because _part_ of 
> > the commit ended up in upstream already.
> >
> > To remind the user that the commit message may need to be adjusted, 
> > rebase --interactive fires up the editor.
> >
> > Yes, it happened to me.  Yes, the reminder was helpful.
> 
> Thank you very much.  I think I understand the problem better with your 
> explanation (and much more detailed explanation from Junio).
> 
> But I started wondering (especially after read Junio's example) if you 
> might have to stop and force edit the message even for commits you 
> "pick", once you have a conflict.  The patch might not conflict, but 
> with your logic shouldn't you be given a chance to amend messages, now 
> it was discovered that the upstream did change that overlaps what you 
> did?

You do.  With a conflict, it stops.  If you do not commit, but only 
resolve the conflicts and add them to the index, then continue the rebase 
-i, it will ask you to commit.  Interactively.  (IOW an editor is fired 
up.)

Ciao,
Dscho

--8323329-552689539-1212814652=:1783--
