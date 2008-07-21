From: Jeff King <peff@peff.net>
Subject: Re: git pull versus fetch/merge
Date: Mon, 21 Jul 2008 07:09:00 -0400
Message-ID: <20080721110900.GA8550@sigill.intra.peff.net>
References: <488452D6.1060508@keyaccess.nl> <20080721102320.GA19776@atjola.homenet> <48846BC2.4090407@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Mon Jul 21 13:10:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKtHI-0004Bt-6c
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 13:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbYGULJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 07:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYGULJE
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 07:09:04 -0400
Received: from peff.net ([208.65.91.99]:4087 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbYGULJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 07:09:03 -0400
Received: (qmail 12078 invoked by uid 111); 21 Jul 2008 11:09:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 21 Jul 2008 07:09:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jul 2008 07:09:00 -0400
Content-Disposition: inline
In-Reply-To: <48846BC2.4090407@keyaccess.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89344>

On Mon, Jul 21, 2008 at 12:58:10PM +0200, Rene Herman wrote:

> Thank you. Also due to a reply on the ALSA list by Mark brown I now get  
> this. Yes, the remote was rebased while I had it setup as a remote here  
> it seems; only recently have it under this name, so I didn't think that  
> was the case. After a "git remote rm tiwai, git remote add tiwai <url>"  
> things work fine again as it fetched a completely new branch.

Not that adding the remote with "git remote add" will add a fetchspec
line like this:

[remote "tiwai"]
  fetch = +refs/heads/*:+refs/remotes/tiwai/*

where the '+' means to force fetching rewound branches instead of
rejecting them (this is safe, since you are just overwriting tracking
branches, not your local work). So this should not come up again;
presumably your previous remote configuration was set up differently.

-Peff
