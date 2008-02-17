From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
Date: Sun, 17 Feb 2008 19:06:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802171816150.30505@racer.site>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802130003370.3870@racer.site> <alpine.LSU.1.00.0802130108060.3870@racer.site> <7v3arxzlke.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802131113360.30505@racer.site> <7vlk5mgm5y.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802151012380.3066@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 20:07:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQorh-0005un-Rh
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbYBQTG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 14:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbYBQTG4
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 14:06:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:35266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752007AbYBQTGz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 14:06:55 -0500
Received: (qmail invoked by alias); 17 Feb 2008 19:06:52 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.76]) [86.138.198.40]
  by mail.gmx.net (mp052) with SMTP; 17 Feb 2008 20:06:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Yf9ghG5FYMzpE8G0zJgwLlSlHJZHhYcFy5dTLf6
	EjY4yiBOokDElI
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802151012380.3066@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74166>

Hi,

On Fri, 15 Feb 2008, Linus Torvalds wrote:

> On Fri, 15 Feb 2008, Junio C Hamano wrote:
> > 
> > I think there is no excuse not to coalesce hunks separated by three 
> > lines or less
> 
> Well, I think the two line limit is the "unquestionable" one, since 
> that's the one that actually results in fewer lines over-all.

Well, I hit a problem.  It is visible in t7201-co.sh:

Suppose you have these files

new1	orig	new2
1	1	1
2	2	3
3	3	4
4	4	5
5	5	6
7	6	7
8	7	8
	8

In other words: if the "6" was removed in the first case, and the "2" in 
the second case, all of a sudden changes which were not really conflicting 
(if one side was unchanged, it is considered a resolvable "conflict") now 
_will_ conflict.

In the upcoming patch, I now restrict this merging of conflicts to 
non-resolvable conflicts only.

Will send it out shortly.

Ciao,
Dscho
