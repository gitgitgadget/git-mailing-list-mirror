From: Jeff King <peff@peff.net>
Subject: Re: git config key bug or by design?
Date: Wed, 28 Nov 2012 15:21:58 -0500
Message-ID: <20121128202158.GB9249@sigill.intra.peff.net>
References: <20121127221446.7f2fbf71@Indy>
 <20121128033408.GE27772@sigill.intra.peff.net>
 <20121128071147.188a869e@Indy>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:22:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdo9A-0004pF-Fb
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 21:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993Ab2K1UWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 15:22:00 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34020 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896Ab2K1UWA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 15:22:00 -0500
Received: (qmail 11698 invoked by uid 107); 28 Nov 2012 20:22:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Nov 2012 15:22:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2012 15:21:58 -0500
Content-Disposition: inline
In-Reply-To: <20121128071147.188a869e@Indy>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210773>

On Wed, Nov 28, 2012 at 07:11:47AM -0500, Peter van der Does wrote:

> I am writing a tool, it needs to store branch names in a separate config
> file.
> 
> It's clear git doesn't respect those values, hence my question. I
> understand how to work around the problem, I would just prefix the key.
> I was just wondering if it was by design, which I guess it is as the
> parsing of the file will die if the key starts with a non-alpha
> character.

In that case, I would definitely say to use some prefix section like
"section.$branchname.key". That is how git stores per-branch information
(e.g., branch.master.merge), and it was always designed to let there be
arbitrary data in the "middle" section, whereas the section and key are
restricted and case-insensitive.

So no, I do not recall "cannot start with number" as a specific design
decision, but it is definitely a design decision that the section name
would not allow arbitrary content.

-Peff
