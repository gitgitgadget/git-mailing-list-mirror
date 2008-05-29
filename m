From: Brian Dessent <brian@dessent.net>
Subject: Re: [PATCH 6/5] NUL hack to create_file()
Date: Thu, 29 May 2008 10:51:25 -0700
Organization: My own little world...
Message-ID: <483EED1D.58196FCF@dessent.net>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com> <1212020246-26480-2-git-send-email-gitster@pobox.com> <1212020246-26480-3-git-send-email-gitster@pobox.com> <1212020246-26480-4-git-send-email-gitster@pobox.com> <1212020246-26480-5-git-send-email-gitster@pobox.com>
	 <1212020246-26480-6-git-send-email-gitster@pobox.com> <1212020246-26480-7-git-send-email-gitster@pobox.com> <483E4E3C.90805@viscovery.net> <483E55C1.1000900@trolltech.com> <alpine.LNX.1.00.0805291157330.19665@iabervon.org>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 29 20:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1mns-0006fZ-Jx
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 20:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736AbYE2SXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 14:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756152AbYE2SXu
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 14:23:50 -0400
Received: from dessent.net ([69.60.119.225]:44672 "EHLO dessent.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbYE2SXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 14:23:49 -0400
X-Greylist: delayed 1919 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 May 2008 14:23:49 EDT
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1K1mHf-0003uR-Cn; Thu, 29 May 2008 17:51:27 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83230>

Daniel Barkalow wrote:

> support it in git. Of course, people on Windows using projects with these
> filenames will probably run into problems with other tools, but at least
> git will behave properly.

I don't see how it would help to have core git using the Native syntax
to bypass the Win32 layer's restrictions but none of the accompanying
suite of tools, i.e. the dozens of various MSYS sh.exe, perl.exe,
cat.exe, etc.  None of those would be able to open or even delete those
files with the reserved filenames.

Users tend to get upset when software creates files that cannot be
removed through conventional methods, e.g. Explorer is completely
powerless to remove it.  Cygwin shipped with a bug several years ago
that unintentionally allowed to create (but not unlink) reserved
filenames.  Unless you knew the magical incantation of "del
\\.\c:\path\to\nul" the file was immutable.

Brian
