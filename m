From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git config: do not create .git/ if it does not exist
 yet
Date: Wed, 24 Feb 2016 12:31:11 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602241230120.3152@virtualbox>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de> <20160224082657.GD12511@sigill.intra.peff.net> <20160224101403.GN1766@serenity.lan> <20160224103152.GA21448@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 12:31:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYXfI-00069U-Js
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 12:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbcBXLb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 06:31:29 -0500
Received: from mout.gmx.net ([212.227.17.22]:64630 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbcBXLb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 06:31:28 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lu7ty-1ZpxSu2bgs-011Vki; Wed, 24 Feb 2016 12:31:14
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160224103152.GA21448@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:vwvAJiR66GDjHUaizr9arxN2NyX0uIFwicfodghtML3oJJ3vUoi
 +lpQ+JKVUYoN5ep5n6Q1GQPuKw5gi1aSRTcdBTZ6vAYu402nNxPvrBRpga1Z47AQZSTg1Du
 3a/9udewV5IUxM+gIFJdtFXnJ+5T3fThtICcNjeLiBsNXaHlSxQwRQPK76MiWbOvbi58Kfm
 qpZQBpyvUtQ2S9j3e5lyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dVPpVpykpGc=:jXI6OB/hZRFQjRM4wSeVfK
 lUvk2pza92MtiV5GqaHt/gHdtLAZqbUB1P9rT6LHoKEYVwGq8Mf1XjPvmpuSZ1nbhk8xXzR9c
 Ok2KxXSqz8231gSzf8aUhmeiDyB1L/WYOJTfCXYNCX3JgbCTr5PG94m5T7hbRaiqqMSbi6IX5
 CwoP3x+9R0ul2lLZZaIuHWoO5VErbSB8DJ1rZyXkkjSn97mAJjZUIVnQw9aCVl8iBT8Ass4zO
 u0zV8wIwE1iHkrR5tqgyiXBAy/c3h6hkGSG/HoAfptWPBzYSvhP6MgDcFn6FttMOeUGltqPdn
 RKs3OBXqsIkIkBkOamMbM7wGDIeTQIWuy0S3yrPIXKQP6miMAt5rbP6/vIm02TlLd1h6rfuuv
 rSl1HqY0Agfyckul58YPLtNMqZnwTKaUt75J4mFy2+QzBqelzbIDrK8lYrHBx6eyxbv8ltBHx
 /Z/UXl196CBzbsdblCBsCHWdEAIRBbQt4gYkM6s+E3xLiqnVkWUtQb2/h/GnShTyQOUFLDsbL
 GDcmAWjjutL8ZSipfhWPCGQm1hwait47J8sAOqOmoo1tgph89hMWVvZINBd2MX9eJckm9JY/I
 SLz+lh1PPw3aHXL9pTdCRKOvipcbAp5f4PLhSSg11ZXcrN+xW0wQdABv8ZcpV8WAIJlQl+ct9
 SyKhxCKdIoDhQQOOEBO6m5TUS2j9xm6AiCTfHXQhZdaW0qAlhzI4E2tJzxsFrn8u2PC5w+zg7
 j8uoWGTzH+Nc413bDW1lhx+TsDt3/4pwCHge0PvAd2WetdeUcg4WstQl/D1clJ9qNQIeU2zp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287200>

Hi Peff, John & Junio (who recommended GIT_CEILING_DIRECTORIES first,

On Wed, 24 Feb 2016, Jeff King wrote:

> On Wed, Feb 24, 2016 at 10:14:03AM +0000, John Keeping wrote:
> 
> > On Wed, Feb 24, 2016 at 03:26:57AM -0500, Jeff King wrote:
> > > On Wed, Feb 24, 2016 at 08:47:00AM +0100, Johannes Schindelin wrote:
> > > 
> > > > 	I cannot think of a way how to test this: all of the regression
> > > > 	tests run inside Git's own worktree, and we cannot even assume
> > > > 	that /tmp/ is outside of a worktree (or that it exists).
> > > 
> > > We could make the test conditional on whether we are in a repo. Anybody
> > > who builds from a tarball, or who uses --root would then run the test.
> > 
> > Could we use GIT_CEILING_DIRECTORIES for this?

Absolutely. I created a test and essentially duplicated Peff's finding:
this is a Windows-only issue.

Will keep you posted,
Dscho
