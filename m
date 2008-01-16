From: Jeff King <peff@peff.net>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 08:54:20 -0500
Message-ID: <20080116135420.GA21588@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <alpine.LSU.1.00.0801161113170.17650@racer.site> <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 14:54:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF8jD-0007rC-SV
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 14:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYAPNyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 08:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbYAPNyX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 08:54:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3521 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504AbYAPNyX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 08:54:23 -0500
Received: (qmail 24010 invoked by uid 111); 16 Jan 2008 13:54:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 16 Jan 2008 08:54:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2008 08:54:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70672>

On Wed, Jan 16, 2008 at 03:39:06PM +0200, Petko Manolov wrote:

> What i am trying to suggest is that there might be cases when you need  
> something in the repository, but you don't want GIT to keep it's history  
> nor it's predecessors.  Leaving it out breaks the atomicity of such  
> repository and makes the project management more complex.

But not versioning some files while versioning others breaks the
atomicity of project version, which is at the core of git's model. There
is no such thing as "this file is at revision X, but that one is at
revision Y." There is only "the project is at revision X."

> There's a few examples out there that shows how to solve this, but it  
> seems inconvenient and involves branching, cloning, etc.  Isn't it  
> possible to add something like:
>
> 	"git nohistory firmware.bin"
>
> or
> 	"git nohistory -i-understand-this-might-be-dangerous firmware.bin"

Not easily. It goes against the underlying data model at the core of
git.

How big are your firmware files? How often do they change, and how large
are the changes? IOW, have you confirmed that repacking does not produce
an acceptable delta, meaning you get versioning for very low space cost?

-Peff
