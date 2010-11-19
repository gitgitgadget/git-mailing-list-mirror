From: Jeff King <peff@peff.net>
Subject: Re: groff .ft command use in asciidoc
Date: Fri, 19 Nov 2010 15:40:10 -0500
Message-ID: <20101119204010.GA18342@sigill.intra.peff.net>
References: <20101117095233.GA23817@basil.fritz.box>
 <20101117101516.GA12416@burratino>
 <20101117143855.GA1987@sigill.intra.peff.net>
 <20101117154829.GE23656@basil.fritz.box>
 <20101119175424.GA13276@sigill.intra.peff.net>
 <1290198893.13785.68.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andi Kleen <andi@firstfloor.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Nov 19 21:40:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJXkq-0000ci-Bx
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 21:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab0KSUkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 15:40:14 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33473 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754438Ab0KSUkN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 15:40:13 -0500
Received: (qmail 28324 invoked by uid 111); 19 Nov 2010 20:40:13 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 19 Nov 2010 20:40:12 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Nov 2010 15:40:10 -0500
Content-Disposition: inline
In-Reply-To: <1290198893.13785.68.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161782>

On Fri, Nov 19, 2010 at 03:34:53PM -0500, Drew Northup wrote:

> > RHEL5 has asciidoc8, but docbook-xsl 1.69, which means it still needs
> > ASCIIDOC_ROFF enabled. RHEL6 is just out last week. So we are
> > technically breaking at least RHEL5 people (along with anybody with
> > ancient systems) until they tweak their knobs.
> 
> Once I imported the DocBook XML XSL 4.5 files into my local cache it
> seemed to make the man pages just fine on my RHEL5 machine even with the
> posted patch applied.
> 
> [root@host ~]# rpm -qi asciidoc
> Name        : asciidoc                     Relocations: (not relocatable)
> Version     : 8.6.3                             Vendor: Dag Apt Repository, http://dag.wieers.com/apt/
> Release     : 1.el5.rf                      Build Date: Thu 18 Nov 2010 08:35:22 AM EST
> ...
> [root@host ~]# rpm -qi docbook-utils
> Name        : docbook-utils                Relocations: (not relocatable)
> Version     : 0.6.14                            Vendor: Red Hat, Inc.
> Release     : 5.1                           Build Date: Wed 12 Jul 2006 03:55:00 AM EDT
> 
> I didn't inspect each and every one for errors, but I didn't see any
> problems in the ones I did look at.

I think the updated XSL files are what's making it work. The stock
docbook xsl files are:

  $ yum list | grep docbook-style-xsl
  docbook-style-xsl.noarch   1.69.1-5.1 rhel-x86_64-server-5

and I don't know that we can assume anyone has updated them. However, I
don't actually build git on my RHEL machines, so I could might be wrong.

All that being said, I am willing to accept RHEL5 as collateral damage
if the new defaults Just Work for the majority of other platforms.

-Peff
