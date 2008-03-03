From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git rebase -s ours
Date: Mon, 3 Mar 2008 02:03:27 -0500
Message-ID: <20080303070327.GB22810@coredump.intra.peff.net>
References: <20080301111716.GA3263@glandium.org> <20080302010527.GB22843@coredump.intra.peff.net> <20080302124848.GB8696@glandium.org> <20080303054126.GB24210@coredump.intra.peff.net> <20080303065521.GA18152@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:04:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4iU-0006ev-VF
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 08:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYCCHDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 02:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbYCCHDa
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 02:03:30 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2201 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686AbYCCHD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 02:03:29 -0500
Received: (qmail 8574 invoked by uid 111); 3 Mar 2008 07:03:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Mar 2008 02:03:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Mar 2008 02:03:27 -0500
Content-Disposition: inline
In-Reply-To: <20080303065521.GA18152@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75895>

On Mon, Mar 03, 2008 at 07:55:21AM +0100, Mike Hommey wrote:

> Starting with a history like this:
> 
>                       G---H 
>                      /
>         A---B---C---D---E---F
> 
> Where A, B, C, ... are *trees*, not commits, the expected result would
> be
> 
>         A---B---C---D---E---F---G---H
> 
> This is what might happen with git-filter-branch if you graft G to F. (I
> don't know if it actually works in cases where the grafted commit had a
> parent, originally)

Ah, OK. That makes some sense, and I think would work if "git
merge-ours" actually did a "git read-tree && git checkout-index" on
the "us" parameter instead of just assuming that the working tree is
what is desired.

I'm still not sure it is all that useful in practice.

-Peff
