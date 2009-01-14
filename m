From: Jeff King <peff@peff.net>
Subject: Re: [PATCH next v2] git-notes: add test case for multi-line notes
Date: Wed, 14 Jan 2009 12:13:15 -0500
Message-ID: <20090114171315.GA16063@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901141627440.3586@pacific.mpi-cbg.de> <496E129B.3020502@trolltech.com> <20090114165633.GC15758@coredump.intra.peff.net> <200901141109.56580.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tor Arne =?utf-8?Q?Vestb=C3=B8?= <tavestbo@trolltech.com>,
	git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:14:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9KD-00032I-Em
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762290AbZANRNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 12:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761753AbZANRNR
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:13:17 -0500
Received: from peff.net ([208.65.91.99]:55957 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756687AbZANRNR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 12:13:17 -0500
Received: (qmail 2076 invoked by uid 107); 14 Jan 2009 17:13:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Jan 2009 12:13:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2009 12:13:15 -0500
Content-Disposition: inline
In-Reply-To: <200901141109.56580.bss@iguanasuicide.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105665>

On Wed, Jan 14, 2009 at 11:09:52AM -0600, Boyd Stephen Smith Jr. wrote:

> >  printf %s "$MSG" ?
> 
> On my box
> $ printf '%s\n' '\n'
> \n
> $
> 
> He wants '\n' in $MSG to be expanded, and what you gave doesn't do that.

Oh, sorry. That's what I get for not reading his patch carefully.

It looks like all of the input is statically included in the test
script. While I think it is nice to be defensive, it is probably
simplest to just assume there is no '%' in this case (which we can
verify by reading the script).

-Peff
