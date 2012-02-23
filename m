From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] mingw: work around stat-limitation
Date: Thu, 23 Feb 2012 15:26:14 -0600 (CST)
Message-ID: <alpine.DEB.1.00.1202231525320.3340@s15462909.onlinehome-server.info>
References: <1330028744-5280-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
	msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 22:26:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0gBB-0005Kt-Hz
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 22:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152Ab2BWV0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 16:26:17 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:40007 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752207Ab2BWV0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 16:26:16 -0500
Received: (qmail invoked by alias); 23 Feb 2012 21:26:14 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp010) with SMTP; 23 Feb 2012 22:26:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YFrMqzYOYCrUtIzwAz3ttpy8aZGFGHLm3REbFn4
	JcVvOIpfVNzw9n
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1330028744-5280-1-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191400>

Hi,

On Thu, 23 Feb 2012, Erik Faye-Lund wrote:

> Our stat implementation for Windows always sets st_ino to 0. This
> means that checking if isatty(0) and comparing the reported inodes
> of stdout and stdin is not sufficient to detect that both are
> pointing to the same TTY.
> 
> Luckily, there's only one console on Windows, so adding a check for
> isatty(1) should do the trick. For platforms where inodes are
> reported correctly, this should still be correct.

Sorry to ask so stupidly, but why does isatty(1) work and isatty(0) does
not? Should they not access the very same console object?

Thanks,
Dscho
