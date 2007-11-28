From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Replace instances of export VAR=VAL with VAR=VAL;
	export VAR
Date: Wed, 28 Nov 2007 18:02:03 -0500
Message-ID: <20071128230203.GA13964@coredump.intra.peff.net>
References: <7v1waa7lcv.fsf@gitster.siamese.dyndns.org> <1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com> <Pine.LNX.4.64.0711281355460.27959@racer.site> <474D7956.8050401@viscovery.net> <Pine.LNX.4.64.0711281428180.27959@racer.site> <474D7D92.2000106@viscovery.net> <Pine.LNX.4.64.0711281552440.27959@racer.site> <85ve7m8iix.fsf@lola.goethe.zz> <7vzlwy2dkm.fsf@gitster.siamese.dyndns.org> <85sl2q6kyu.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:02:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVvf-00040r-HY
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbXK1XCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754383AbXK1XCJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:02:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4288 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbXK1XCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:02:08 -0500
Received: (qmail 15000 invoked by uid 111); 28 Nov 2007 23:02:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 18:02:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 18:02:03 -0500
Content-Disposition: inline
In-Reply-To: <85sl2q6kyu.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66454>

On Wed, Nov 28, 2007 at 11:53:13PM +0100, David Kastrup wrote:

> dak@lola:~$ ash
> $ export JUNK=woozle
> $ sh -c 'echo $JUNK'
> woozle
> $ exit
> dak@lola:~$ dash
> $ export JUNK=woozle
> $ sh -c 'echo $JUNK'
> woozle
> $ exit
> 
> What problem are we talking about exactly, and with what shell?

$ uname -sr
FreeBSD 6.1-RELEASE-p17-jc1
$ /bin/sh
$ FOO='with spaces'
$ echo $FOO
with spaces
$ OK=$FOO; export OK
$ sh -c 'echo $OK'
with spaces
$ export BAD=$FOO
$ sh -c 'echo $BAD'
with
$ echo $BAD
with

-Peff
