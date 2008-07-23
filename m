From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Wed, 23 Jul 2008 20:44:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807232041570.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer>  <7vy73tihl6.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807230203350.8986@racer>  <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807231817460.8986@racer>  <488772BC.80207@workspacewhiz.com>
 <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:45:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLkH4-0008BL-FX
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbYGWToV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753599AbYGWToV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:44:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:33075 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753577AbYGWToV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:44:21 -0400
Received: (qmail invoked by alias); 23 Jul 2008 19:44:19 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp045) with SMTP; 23 Jul 2008 21:44:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FJ5o3TruFY20YGsFN75rWMte1EpH6eC4KVzpVG+
	AOh2d3pL5ZRaky
X-X-Sender: gene099@racer
In-Reply-To: <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89759>

Hi,

On Wed, 23 Jul 2008, Eyvind Bernhardsen wrote:

> On 23. juli. 2008, at 20.57, Johannes Schindelin wrote:
> 
> >On Wed, 23 Jul 2008, Avery Pennarun wrote:
> >
> > >1. always CRLF on all platforms (eg. for .bat files)
> > >2. always LF on all platforms (eg. for shell scripts and perl scripts)
> > >3. just leave it alone no matter what (eg. for binary files)
> >
> >These are not different, but equal.  "Do no harm to the contents of this
> >file".
> 
> That is only true until someone edits the file in an editor which 
> prefers the wrong end-of-line marker, and converts to it when saving.  
> It will be obvious that this has happened if the user does a "git diff" 
> before committing, but I think the intent of nos. 1 and 2 is for git to 
> automatically convert the line endings back instead of kicking up a 
> fuss.
> 
> Might be too magical, though.

I deem it not, uhm, magical.  By your reasoning there should be a way for 
Git to convert a file to UTF-8 when some entertaining person converted the 
working directory file to ISO-8859-15.

Really, either it is CR/LF on all platforms (and then the project members 
have to live by it), or it is not.  You cannot have both.

If it is CR/LF on all platforms, you just _commit_ it as CR/LF.  No 
conversion, not even a brain required.

Ciao,
Dscho
