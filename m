From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some git performance measurements..
Date: Fri, 7 Dec 2007 08:07:14 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712070800370.7274@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>  <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org>  <alpine.LFD.0.99999.0711282244190.9605@xanadu.home>  <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
  <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>  <finmvm$da8$1@ger.gmane.org>  <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>  <alpine.LFD.0.99999.0711292131350.9605@xanadu.home>  <B161871F-E812-44B4-A699-44341B5783D3@zib.de>
 <e2b179460712070535x2eb10710s75a581664139e0cf@mail.gmail.com> <Pine.LNX.4.64.0712071348100.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 07 17:09:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0flB-0001vI-KD
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 17:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbXLGQIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 11:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXLGQIo
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 11:08:44 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36000 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbXLGQIn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 11:08:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB7G7KOp028566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Dec 2007 08:07:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB7G7Eu4025110;
	Fri, 7 Dec 2007 08:07:15 -0800
In-Reply-To: <Pine.LNX.4.64.0712071348100.27959@racer.site>
X-Spam-Status: No, hits=-2.726 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67431>



On Fri, 7 Dec 2007, Johannes Schindelin wrote:
> 
> How is "You may use it in anything you like;" funky licensing?  It is 
> effectively public domain.

No, it has a long list of requirements that my not be onerous, but they 
aren't compatible with GPL (ie they require that you make changes in 
certain ways).

That said, if somebody wants to use that qsort, the thing to do is to ask 
Gareth for permission, maybe he just says "sure". For example, for git, 
you might as well remove the whole unaligned case, and quite frankly, that 
#ifdef DEBUG_QSORT is some of the ugliest I've ever seen and should be 
cleaned up (why didn't he just use a "dbg_printf()" macro like everybody 
else? Even if it requires double parenthesis for ols-style C portability, 
it's cleaner than what is there now).

			Linus
