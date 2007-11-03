From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Reuse previous annotation when overwriting a tag
Date: Sat, 3 Nov 2007 13:22:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031321320.4362@racer.site>
References: <1194082273-19486-1-git-send-email-mh@glandium.org>
 <Pine.LNX.4.64.0711031148460.4362@racer.site> <20071103122707.GA7227@glandium.org>
 <Pine.LNX.4.64.0711031236160.4362@racer.site> <20071103131030.GA18670@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 14:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoIyi-0003qH-1i
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 14:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbXKCNXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 09:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbXKCNXl
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 09:23:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:54051 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753792AbXKCNXl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 09:23:41 -0400
Received: (qmail invoked by alias); 03 Nov 2007 13:23:38 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp016) with SMTP; 03 Nov 2007 14:23:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19P+qRZge1PakrsvhwyW8R7Vd3m5N/Y+CJqNPLCJc
	wLp7gBIjm2WyXE
X-X-Sender: gene099@racer.site
In-Reply-To: <20071103131030.GA18670@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63266>

Hi,

On Sat, 3 Nov 2007, Mike Hommey wrote:

> On Sat, Nov 03, 2007 at 12:36:36PM +0000, Johannes Schindelin wrote:
> 
> > On Sat, 3 Nov 2007, Mike Hommey wrote:
> > 
> > > On Sat, Nov 03, 2007 at 11:54:38AM +0000, Johannes Schindelin wrote:
> > > > Why not teach write_annotations() (or write_tag_body() like I 
> > > > would prefer it to be called) to grok a null_sha1?  It's not like 
> > > > we care for performance here, but rather for readability and ease 
> > > > of use.
> > > 
> > > By the way, I think it would be much better if this function was 
> > > made more generic and would not write, but return an strbuf 
> > > containing the object body. It could also be used by e.g. git-commit 
> > > --amend.
> > > 
> > > What would be the best suited place for such a function ?
> > 
> > editor.c, I'd say.
> 
> On which topic is this ?

On none so far.  But the plan was to move some functions used by both 
builtin-tag and builtin-commit (such as launch_editor()) into the files 
editor.[ch].

Unfortunately, that plan has not been executed by anybody.  Yet.

Ciao,
Dscho
