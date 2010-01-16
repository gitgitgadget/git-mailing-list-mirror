From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Add push --set-upstream
Date: Sat, 16 Jan 2010 13:28:31 -0500
Message-ID: <20100116182829.GA27474@sigill.intra.peff.net>
References: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100116203557.95340c00.rctay89@gmail.com>
 <20100116134656.GA4504@Knoppix>
 <20100116233043.26a5636d.rctay89@gmail.com>
 <20100116155612.GA8383@Knoppix>
 <be6fef0d1001160813o674ed93dn33843813be6f45be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 19:29:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWDOP-0002Fq-Lv
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 19:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab0APS2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 13:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753466Ab0APS2h
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 13:28:37 -0500
Received: from peff.net ([208.65.91.99]:58382 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab0APS2g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 13:28:36 -0500
Received: (qmail 12946 invoked by uid 107); 16 Jan 2010 18:33:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 16 Jan 2010 13:33:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Jan 2010 13:28:31 -0500
Content-Disposition: inline
In-Reply-To: <be6fef0d1001160813o674ed93dn33843813be6f45be@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137246>

On Sun, Jan 17, 2010 at 12:13:20AM +0800, Tay Ray Chuan wrote:

> On Sat, Jan 16, 2010 at 11:56 PM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
> > Hmm... In what conditions ref->status is 'none' after push operation
> > has completed?
> 
> when a match between a local and remote ref is not found.
> 
> For example, the local ref 'master' will match the remote ref
> 'master', but not 'retsam' ('master' spelled in reverse).

How would it make any sense to set up a tracking branch, then? Not only
is it not desired (if I said "git push -u foo:bar", I don't expect it to
do _anything_ with some other local branch besides foo), but it wouldn't
work, since the peer_ref pointer would be NULL.

-Peff
