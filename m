From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Sun, 30 Sep 2007 00:40:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709300039430.28395@racer.site>
References: <11911047823308-git-send-email-jean.guyader@linkea.org>
 <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jean.guyader@linkea.org, git@vger.kernel.org,
	Jean Guyader <jean.guyader@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 01:42:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iblwe-0001rm-8b
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 01:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbXI2Xlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 19:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbXI2Xlx
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 19:41:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:58824 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751297AbXI2Xlw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 19:41:52 -0400
Received: (qmail invoked by alias); 29 Sep 2007 23:41:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 30 Sep 2007 01:41:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+EJgwJNQCEviCoBFVcM1X+Pmxq9M+Am38TMHGUqo
	0N8F9zBDjjZIgR
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59513>

Hi,

On Sat, 29 Sep 2007, Junio C Hamano wrote:

> jean.guyader@linkea.org writes:
> 
> > From: Jean Guyader <jean.guyader@gmail.com>
> >
> > Curl uses the option -u user:passwd and not the user:password
> > given in the url.
> > The solution was to extract user:password from the url and set
> > the option.
> >
> > Here the regex used :
> >         sed -re 's-.*http://([^:]*):([^@]+)@.*-\1:\2-g'
> 
> This is more like "allowing embedded authentication credentials
> in URL for http transport".
> 
> We never supported URLs with embedded credentials (see
> Documentation/urls.txt), partly because nobody asked for it, but
> more importantly because giving -n to curl to have it read from
> user's .netrc is generally much more preferred approach.

To elaborate on that: if you fetch from somewhere, your url, username and 
password can be read from the output of "ps ax | grep http" very easily.

Ciao,
Dscho
