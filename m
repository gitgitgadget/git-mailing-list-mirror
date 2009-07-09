From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3] quickfetch(): Prevent overflow of the rev-list command
 line
Date: Thu, 09 Jul 2009 16:42:05 +0200
Message-ID: <200907091642.05746.johan@herland.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
 <200907091552.44545.johan@herland.net> <4A55FCD5.2020908@viscovery.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 16:42:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOupF-00043Z-Eh
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 16:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760574AbZGIOmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 10:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760118AbZGIOmK
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 10:42:10 -0400
Received: from mx.getmail.no ([84.208.15.66]:56275 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759207AbZGIOmJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 10:42:09 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI006ENRI73GA0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 16:42:07 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI009JYRI51580@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 16:42:07 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.9.143320
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <4A55FCD5.2020908@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122979>

On Thursday 09 July 2009, Johannes Sixt wrote:
> But actually I meant you to make a test that triggers the SIGPIPE that
> would kill git-fetch if it were not ignored. This one doesn't trigger it,
> either.

AFAIU from earlier in this thread (and a mail from Peter linking to 
http://markmail.org/message/dbgdj4csafen65ye), SIGPIPE _never_ triggers on 
Windows, thus ignoring SIGPIPE is not needed for the fix per se. However, as 
a side-effect of the fix, we may now get SIGPIPE on Linux (and other POSIX 
platforms), so although it never triggers on Windows, it's still needed.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
