From: Jeff King <peff@peff.net>
Subject: Re: Inheritance of files for parent/child branches
Date: Sat, 16 Feb 2008 13:39:25 -0500
Message-ID: <20080216183925.GA20914@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0802161110310.32252@an.sumeria> <20080216180903.GB19506@sigill.intra.peff.net> <alpine.DEB.1.00.0802161224160.32252@an.sumeria>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Flott <adam@npjh.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 19:40:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQRxC-0005EY-Vc
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 19:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbYBPSj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 13:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbYBPSj2
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 13:39:28 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1461 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496AbYBPSj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 13:39:27 -0500
Received: (qmail 12560 invoked by uid 111); 16 Feb 2008 18:39:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 16 Feb 2008 13:39:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Feb 2008 13:39:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0802161224160.32252@an.sumeria>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74057>

On Sat, Feb 16, 2008 at 12:33:42PM -0600, Adam Flott wrote:

> Your example is basically the only solution I could think of that would work
> with git. This repository will be for configuration files, where I want the
> parent to always "win" with conflicts.

Ah. That's much easier then. Instead of doing a real merge, you can just
checkout from the parent every file that has changed between the merge
base and the parent, and then make a new merge commit based on those
contents. And then the "merge" always succeeds.

-Peff
