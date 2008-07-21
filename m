From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix git-shell build error when NO_SETENV is defined
Date: Mon, 21 Jul 2008 03:23:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807210321190.3305@eeepc-johanness>
References: <g60la4$diu$1@ger.gmane.org> <1216601017-7871-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: SungHyun Nam <namsh@posdata.co.kr>, git@vger.kernel.org,
	gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 03:23:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKk7M-00054d-3e
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 03:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467AbYGUBWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 21:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756319AbYGUBWM
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 21:22:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:47602 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756068AbYGUBWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 21:22:10 -0400
Received: (qmail invoked by alias); 21 Jul 2008 01:22:09 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp030) with SMTP; 21 Jul 2008 03:22:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/zhZiVKB/+h5kGDlvbITav/XcEMT5vLPzxZ9ANY
	D139j4chfWu2g+
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1216601017-7871-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89288>

Hi,

On Mon, 21 Jul 2008, Stephan Beyer wrote:

> If NO_SETENV is defined, git-shell could not be built.
> 
> Thanks to SungHyun Nam for the hint.
> 
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
> 
> This was my mistake. I haven't tested with several build options.
> Now I've tested with
> 	NO_SETENV=1 NO_EXPAT=1 NO_MEMMEM=1 NO_STRTOUMAX=1 NO_MKDTEMP=1
> 	NO_SYS_SELECT_H=1 NO_SYMLINK_HEAD=1
> and compat/setenv.o seems to be the only one that was missing.

Funny.  It was not 24 hours ago that Hannes reported a related issue.  And 
he was testing with different options.

His fix to include COMPAT_OBJECTS made much more sense, too, than to pick 
selectively a file here and a file there and then hoping that you catch 
all.

Ciao,
Dscho
