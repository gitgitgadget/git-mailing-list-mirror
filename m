From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH v2] Quote ' as \(aq in manpages
Date: Wed, 21 Oct 2009 17:42:46 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0910211733310.5105@dr-wily.mit.edu>
References: <alpine.DEB.2.00.0910211357160.5105@dr-wily.mit.edu> <7a3e6c8c5a11e14c19bc1a27608dcc78171c9feb.1256151199.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	bill lam <cbill.lam@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 21 23:43:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ixw-0001rz-0U
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 23:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbZJUVnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 17:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbZJUVnW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 17:43:22 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:40518 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754762AbZJUVnV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2009 17:43:21 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n9LLgepo026174;
	Wed, 21 Oct 2009 17:42:40 -0400 (EDT)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n9LLgmpI005787;
	Wed, 21 Oct 2009 17:42:48 -0400 (EDT)
In-Reply-To: <7a3e6c8c5a11e14c19bc1a27608dcc78171c9feb.1256151199.git.trast@student.ethz.ch>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130973>

On Wed, 21 Oct 2009, Thomas Rast wrote:
> Unfortunately, as Anders Kaseorg kindly pointed out, this is not 
> portable beyond groff, so we add an extra Makefile variable GNU_ROFF 
> which you need to enable to get the new quoting.

Note that GNU_ROFF is a property of the target system on which the 
manpages will be read, unlike the existing variables (ASCIIDOC8, 
DOCBOOK_XSL_172, ASCIIDOC_NO_ROFF) which are properties of the host system 
on which they are built.

> To save you the effort of clicking the links, the header definitions 
> would be
>
> .ie \n(.g .ds Aq \(aq
> .el .ds Aq '
>
> and you then have to change the template to quote to \(Aq instead.

If someone knows how to get this definition into the header, that would be 
preferable, because then you could read the same manpage on both GNU and 
non-GNU systems instead of building separately for each.

It would be even better if someone would work with the Docbook developers 
to get this fixed upstream.  (Unfortunately, there has been no reply to my 
comment in their bug tracker.)

Anders
