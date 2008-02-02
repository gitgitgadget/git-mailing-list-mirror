From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sat, 2 Feb 2008 18:19:18 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802021815510.7372@racer.site>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 19:20:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLMyr-00022r-BR
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 19:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbYBBSTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 13:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbYBBSTy
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 13:19:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:41449 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752676AbYBBSTx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 13:19:53 -0500
Received: (qmail invoked by alias); 02 Feb 2008 18:19:51 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp042) with SMTP; 02 Feb 2008 19:19:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+GKYdfEsKGycS8BWvL5MG941ux+cHbxDAfMryqrd
	kxCzvB8Q9aSELi
X-X-Sender: gene099@racer.site
In-Reply-To: <1201975757-13771-1-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72295>

Hi,

On Sat, 2 Feb 2008, Lars Hjemli wrote:

> +	if (len < 10 || buf[len - 1] != '\n' || strncmp(buf, "GITDIR: ", 8))

Sorry, missed that earlier: How about

	if (!len || buf[len-1] != '\n' || prefixcmp(buf, "GITDIR: "))

instead?  (buf does not need be NUL terminated for the prefixcmp(), since 
we just made sure it is LF terminated)

Thanks,
Dscho
