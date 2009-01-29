From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Something weird is happening...
Date: Thu, 29 Jan 2009 18:01:16 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901291731320.19665@iabervon.org>
References: <49814BA4.6030705@zytor.com> <7vr62mha7a.fsf@gitster.siamese.dyndns.org> <20090129113846.GA10645@elte.hu> <20090129120539.GA26975@elte.hu> <49822B91.6070303@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1541890049-1233270076=:19665"
Cc: Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Jan 30 00:02:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfuF-0000xI-VA
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 00:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbZA2XBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 18:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbZA2XBS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 18:01:18 -0500
Received: from iabervon.org ([66.92.72.58]:58757 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbZA2XBS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 18:01:18 -0500
Received: (qmail 10411 invoked by uid 1000); 29 Jan 2009 23:01:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jan 2009 23:01:16 -0000
In-Reply-To: <49822B91.6070303@lsrfire.ath.cx>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107749>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1541890049-1233270076=:19665
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 29 Jan 2009, René Scharfe wrote:

> Current master (a34a9dbbc) with the following patch should not
> segfault anymore (it doesn't here), but I don't know where the
> magic number six is coming from. :-/

Looks like octopus is using multiple merge bases directly, rather than 
combining them using merge-recursive. The merge-recursive concept turned 
out to be superior, and we kind of left multiple merge base support 
hanging. We should probably remove the old support and switch octopus to 
the better way.

My guess is that 6 is just that there happen to be 3 merge bases for this 
particular merge (plus the merge results and the two sides).

	-Daniel
*This .sig left intentionally blank*
--1547844168-1541890049-1233270076=:19665--
