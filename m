From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Documentation/git-gc: improve description of --auto
Date: Fri, 19 Oct 2007 00:45:17 -0400
Message-ID: <20071019044517.GA18354@coredump.intra.peff.net>
References: <20071019020510.GB7711@coredump.intra.peff.net> <20071019022909.GZ14735@spearce.org> <20071019023850.GD8298@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Grimm <koreth@midwinter.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 06:45:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iijjn-0001tv-ON
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 06:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbXJSEpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 00:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXJSEpU
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 00:45:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3885 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbXJSEpU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 00:45:20 -0400
Received: (qmail 9159 invoked by uid 111); 19 Oct 2007 04:45:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Oct 2007 00:45:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2007 00:45:17 -0400
Content-Disposition: inline
In-Reply-To: <20071019023850.GD8298@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61649>

On Thu, Oct 18, 2007 at 10:38:50PM -0400, Jeff King wrote:

> I am hunting this down right now. asciidoc _does_ generate
> XML <literal>foo</literal> for `foo`, but it looks like docbook is
> throwing that away when converting to manpages. Hopefully there is an
> easy tweak...

Ugh. Looks like Junio came up with a solution to this in 524e5ffc
(although it was for literallayout sections, I think the same technique
could be applied). However, it had problems with docbook 1.69, and was
reverted in 63c21c49.

Julian Phillips added monospacing of listingblocks in 281a53bb, but that
technique is only applicable to asciidoc "blocks", which I think won't
work in this instance.

It really seems silly that docbook doesn't monospace <literal>s when
converting to manpages. Perhaps somebody who knows more about docbook
than I do can say more.

-Peff
