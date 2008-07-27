From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/7] builtin-help: change the current directory back in
 list_commands_in_dir()
Date: Sun, 27 Jul 2008 22:21:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807272219350.5526@eeepc-johanness>
References: <cover.1217037178.git.vmiklos@frugalware.org> <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org> <1217073292-27945-1-git-send-email-vmiklos@frugalware.org> <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
 <7vwsj7yu1q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 22:21:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNCju-0005QG-4q
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 22:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662AbYG0UUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 16:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758673AbYG0UUB
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 16:20:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:58472 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758662AbYG0UUA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 16:20:00 -0400
Received: (qmail invoked by alias); 27 Jul 2008 20:19:58 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp056) with SMTP; 27 Jul 2008 22:19:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/v9UPpfU/D+JBiyXPLjl0XT3++Sw8So0EmApfgg
	mB5yeeEVFwsBKT
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vwsj7yu1q.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90366>

Hi,

On Sun, 27 Jul 2008, Junio C Hamano wrote:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > That function used to do a chdir() without switching back to the 
> > original directory. That was not a problem till this function was used 
> > only inside builtin-help, but once other builtins use it as well, this 
> > is a problem, for example when the object database path is relative.
> 
> Why does it even need to chdir() around to begin with?  Doesn't 
> opendir() work just fine with relative path as an input?

It is a consequence of list_commands_in_dir() trying to be cute, and not 
having to construct the full path for the is_executable() check.

Will post a fix in a few minutes.

Ciao,
Dscho
