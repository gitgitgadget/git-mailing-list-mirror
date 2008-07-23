From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Wed, 23 Jul 2008 18:22:51 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231817460.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:23:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLi47-0002da-8a
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 19:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYGWRWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 13:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbYGWRWw
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 13:22:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:34191 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751089AbYGWRWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 13:22:51 -0400
Received: (qmail invoked by alias); 23 Jul 2008 17:22:49 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp064) with SMTP; 23 Jul 2008 19:22:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+R0UcNnHCRGXEvdt3fKV7uplkfl9KGKaD6nHl0Ud
	QuyFG53btN+nOV
X-X-Sender: gene099@racer
In-Reply-To: <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89721>

Hi,

On Wed, 23 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > However, if you want to avoid CRs to _enter_ the repository, when you 
> > have a lot of binary files tracked, you _do_ want to force all 
> > repositories to crlf=input.
> 
> If you are on a sane system, you do not even want to pay the price of 
> conversion.  Only people on systems with CRLF line endings should pay 
> the price (because your aim is to convert on such systems).  Are we 
> throwing that out of the window when the project decides to use 
> gitattributes?

Well, if you do not want that, why do you set crlf in the gitattributes to 
begin with?

> How about setting autocrlf automatically on mingw/msys/cygwin versions, 
> perhaps via templates or a patch to init-db?  Would that, combined with 
> user education, be a viable alternative?

On msys we do that.  A few users decided they know better and switched it 
off.  Me for example.  But I wouldn't do something as stupid as editing a 
file with an editor that tries to be helpful and adds CR/LFs.

However, Cygwin?  No, they don't.  I don't see them change it, either.

The _only_ way we could do that is by setting auto_crlf in environment, 
depending on the platform.

HOWEVER: as you can see from the git-svn post this morning, there are 
known issues with autocrlf.

We also had much fun (not!) with a lot of users who were really happy to 
insult us for the change to set autocrlf to true by default (via 
/etc/gitconfig) in msysGit.

Ciao,
Dscho
