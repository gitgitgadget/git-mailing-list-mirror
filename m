From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Add support for GIT_CEILING_DIRS
Date: Thu, 15 May 2008 21:34:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805152131390.30431@racer>
References: <482C85C8.90804@facebook.com> <7vej83gxjm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 22:35:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwkAT-0006KK-GV
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 22:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbYEOUeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 16:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbYEOUeW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 16:34:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:34221 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751840AbYEOUeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 16:34:21 -0400
Received: (qmail invoked by alias); 15 May 2008 20:34:19 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp050) with SMTP; 15 May 2008 22:34:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uYctD5iZuPZwIG5uO3zIwVG/Z4mvW62ZLQzB+yw
	O6jk9QHMymT/Hg
X-X-Sender: gene099@racer
In-Reply-To: <7vej83gxjm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82231>

Hi,

On Thu, 15 May 2008, Junio C Hamano wrote:

> David Reiss <dreiss@facebook.com> writes:
> 
> > + * ....  Paths must
> > + * be in a canonical form: empty components, or "." or ".." components
> > + * are not allowed.  prefix_list may be null, which is like "".
> 
> The caller starts from cwd[] and chomps, so you can safely assume that 
> it would not feed anything problematic.  But prefix_list comes from 
> user's environment, and it is easy to make mistakes like doubled slashes 
> (which you seem to take care) and also is tempting to use ".." when 
> specifying the ceiling (e.g. "CEIL=$HOME/..").  Perhaps canonicalizing 
> the ceiling would make this easier to use for end users?

Is this not going too far?  I mean, CEILING_DIRECTORIES is already a very 
special case.

> How well would this colon separated list work with msys folks?

Not well at all.  At least for the moment, I think setting this variable 
would fail (since it would be rewritten into a Windows-PATH-style string).  
Though honestly, I have no idea what getcwd() does on MinGW.

Steffen is working on that rewriting stuff, so maybe it will be a 
non-issue, eventually.

Ciao,
Dscho
