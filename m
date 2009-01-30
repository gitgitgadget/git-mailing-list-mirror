From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 11:28:45 -0500
Message-ID: <20090130162845.GA6963@sigill.intra.peff.net>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwFy-0004P0-Gf
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbZA3Q2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbZA3Q2t
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:28:49 -0500
Received: from peff.net ([208.65.91.99]:43419 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbZA3Q2s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:28:48 -0500
Received: (qmail 2906 invoked by uid 107); 30 Jan 2009 16:28:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 30 Jan 2009 11:28:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 11:28:45 -0500
Content-Disposition: inline
In-Reply-To: <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107844>

On Fri, Jan 30, 2009 at 11:17:49AM -0500, Jay Soffian wrote:

> I wonder if it might be helpful to teach clone to setup a push line in
> the cloned repo. i.e.:
> 
> [remote "origin"]
> 	url = ...
> 	fetch = +refs/heads/*:refs/remotes/origin/*
> 	push = refs/heads/*:refs/remotes/origin/*

That refspec doesn't make sense, since the downstream is not the
"origin" to the upstream repo. But I don't think this is a good
solution; it is fundamentally changing the layout of pushed branches in
the upstream repo, which is going to cause a lot of confusion.

> This could be a configurable default behavior when cloning from a
> non-bare repo (can that be determined?) and/or as a switch
> (--satellite perhaps?).

I don't think you can tell whether a repo you are cloning is bare.

-Peff
