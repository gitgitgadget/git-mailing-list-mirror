From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase --onto might "loose" commits
Date: Tue, 19 Feb 2008 11:05:40 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191102440.30505@racer.site>
References: <20080219072359.GA752@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-297099034-1203419142=:30505"
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 12:06:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRQIy-0000iS-4N
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 12:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbYBSLF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 06:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbYBSLF4
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 06:05:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:41681 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752468AbYBSLFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 06:05:55 -0500
Received: (qmail invoked by alias); 19 Feb 2008 11:05:53 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp056) with SMTP; 19 Feb 2008 12:05:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BtbtL5MeB3c07fORR/+WWL3zE8R9JeqKe2KBm3h
	zSMqSC0JiBK4sE
X-X-Sender: gene099@racer.site
In-Reply-To: <20080219072359.GA752@atjola.homenet>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74393>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-297099034-1203419142=:30505
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 19 Feb 2008, Björn Steinbrink wrote:

> when there's nothing to rebase (ie. upstream..branch is empty), rebase 
> fails to find any commits to rebase and correctly says "Nothing to do", 
> but when --onto is given, we already did a "reset --hard" to newbase, so 
> it already _did_ something.

Yes, it did something.  But if you had that:

A - B - C - D - E
  \
    F

your HEAD was E, and you said "git rebase --onto F E" what exactly do you 
want it to do?  There is no commit between E and E, so it rebases 
_nothing_ onto F.  Which means that F should be your new state.

Unless I am missing something critical in your mail.

> As rebase also shows a "fatal: Not a range", during the operation, I 
> assume that this is an actual bug and not just a plain user error.

That message is probably a bug, then.

Ciao,
Dscho

P.S.: I was being corrected some time ago on the same typo: "to lose" 
means to get rid of something unintentionally, "to loose" does not exist, 
and "to loosen" means to make something less tight.
---1463811741-297099034-1203419142=:30505--
