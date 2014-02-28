From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] lifting upload-archive restrictions
Date: Fri, 28 Feb 2014 04:56:19 -0500
Message-ID: <20140228095619.GA11803@sigill.intra.peff.net>
References: <20140227040504.GA2242@sigill.intra.peff.net>
 <xmqqtxbkz9jp.fsf@gitster.dls.corp.google.com>
 <20140228090709.GB11709@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Scott J. Goldman" <scottjg@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 10:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJKBF-0001fo-SN
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbaB1J40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:56:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:58646 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751157AbaB1J4V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:56:21 -0500
Received: (qmail 23193 invoked by uid 102); 28 Feb 2014 09:56:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 03:56:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 04:56:19 -0500
Content-Disposition: inline
In-Reply-To: <20140228090709.GB11709@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242933>

On Fri, Feb 28, 2014 at 04:07:09AM -0500, Jeff King wrote:

> > As this does not affect local use of "git archive", "requested by
> > refnames" may need to be clarified further.  Perhaps "remote
> > archives can be requested only for published refnames" or something.
> 
> I was hoping to be vague. If we really want to get into specifics, we
> should probably document the current rules (refnames, and sub-trees of
> refnames). It might be a good thing to document that anyway, though. And
> by doing so, it would become obvious why one would want to set this
> option. I'll see what I can come up with.

Here's a series to handle this; I think the end result is much nicer. I
ended up calling the option "uploadarchive.allowUnreachable". By moving
it there instead of under "archive", it is more clear that this is about
the _serving_ end of the remote connection, and the word "remote"
becomes redundant.

  [1/2]: docs: clarify remote restrictions for git-upload-archive
  [2/2]: add uploadarchive.allowUnreachable option

-Peff
