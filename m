From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle - bundle objects and references for disconnected
   transfer.
Date: Fri, 16 Feb 2007 01:40:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702160137330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D398F9.6070205@verizon.net> <Pine.LNX.4.63.0702150054210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D3C62D.6090609@verizon.net> <Pine.LNX.4.63.0702151629130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D4F6D4.9070703@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 01:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHr9M-0002ER-9D
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 01:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422911AbXBPAkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 19:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422912AbXBPAkW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 19:40:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:38978 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422911AbXBPAkV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 19:40:21 -0500
Received: (qmail invoked by alias); 16 Feb 2007 00:40:19 -0000
X-Provags-ID: V01U2FsdGVkX1/i1bUtLs7isabRZY0zHMsrADaJt4eRJ6m0BU2lMv
	bhqg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D4F6D4.9070703@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39873>

Hi,

On Thu, 15 Feb 2007, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> > Why not force unmixing? I.e. first the options for git-bundle, _then_ the
> > rest? (In that case, you would leave out the "-*)" clause).
> >   
> This would just trade one usability issue for another.

It is not a usability issue if you are cleanly separating things which do 
not belong together.

> > It does not have to be tar. There is no good reason that the parts you 
> > put into the bundle have to be files, rather than header and body.
> >   
> sh does not handle binary files: there is no way to split header from 
> binary payload.

Example:

#!/bin/sh

(echo Hallo; echo Bello; echo; echo blabla) | \
(
	while read line; do
		echo "$line"
		if [ -z "$line" ]; then
			break
		fi
	done
	echo "xxx"
	cat
)

In this case, shell reads the header until an empty line is encountered. 
The rest is piped through cat. And it does not matter if "blabla" is text 
or binary.

Ciao,
Dscho
