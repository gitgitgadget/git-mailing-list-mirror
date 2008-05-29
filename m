From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 6/5] NUL hack to create_file()
Date: Thu, 29 May 2008 14:35:03 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805291428130.19665@iabervon.org>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com> <1212020246-26480-2-git-send-email-gitster@pobox.com> <1212020246-26480-3-git-send-email-gitster@pobox.com> <1212020246-26480-4-git-send-email-gitster@pobox.com> <1212020246-26480-5-git-send-email-gitster@pobox.com>
  <1212020246-26480-6-git-send-email-gitster@pobox.com> <1212020246-26480-7-git-send-email-gitster@pobox.com> <483E4E3C.90805@viscovery.net> <483E55C1.1000900@trolltech.com> <alpine.LNX.1.00.0805291157330.19665@iabervon.org> <483EED1D.58196FCF@dessent.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 20:36:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1mz9-0002aq-Fc
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 20:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbYE2SfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 14:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755363AbYE2SfH
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 14:35:07 -0400
Received: from iabervon.org ([66.92.72.58]:34907 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200AbYE2SfF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 14:35:05 -0400
Received: (qmail 7252 invoked by uid 1000); 29 May 2008 18:35:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 May 2008 18:35:03 -0000
In-Reply-To: <483EED1D.58196FCF@dessent.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83233>

On Thu, 29 May 2008, Brian Dessent wrote:

> Daniel Barkalow wrote:
> 
> > support it in git. Of course, people on Windows using projects with these
> > filenames will probably run into problems with other tools, but at least
> > git will behave properly.
> 
> I don't see how it would help to have core git using the Native syntax
> to bypass the Win32 layer's restrictions but none of the accompanying
> suite of tools, i.e. the dozens of various MSYS sh.exe, perl.exe,
> cat.exe, etc.  None of those would be able to open or even delete those
> files with the reserved filenames.
> 
> Users tend to get upset when software creates files that cannot be
> removed through conventional methods, e.g. Explorer is completely
> powerless to remove it.  Cygwin shipped with a bug several years ago
> that unintentionally allowed to create (but not unlink) reserved
> filenames.  Unless you knew the magical incantation of "del
> \\.\c:\path\to\nul" the file was immutable.

Well, "git rm <filename>" would work. Or "git mv <weird> <okay>", which is 
possibly more productive. Or checking out a version that doesn't contain 
it. It's a lot worse if the tool that created it can't remove it than if 
tools other than the one that created it can't deal with it.

	-Daniel
*This .sig left intentionally blank*
