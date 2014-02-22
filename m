From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] demonstrate git-commit --dry-run exit code behaviour
Date: Sat, 22 Feb 2014 03:34:23 -0500
Message-ID: <20140222083423.GF1576@sigill.intra.peff.net>
References: <1393010214-32306-1-git-send-email-rctay89@gmail.com>
 <xmqqa9dk43pi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 09:34:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH82X-00076B-JW
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 09:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbaBVIe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 03:34:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:54946 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750736AbaBVIeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 03:34:25 -0500
Received: (qmail 16679 invoked by uid 102); 22 Feb 2014 08:34:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Feb 2014 02:34:25 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Feb 2014 03:34:23 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa9dk43pi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242508>

On Fri, Feb 21, 2014 at 12:21:13PM -0800, Junio C Hamano wrote:

> Tay Ray Chuan <rctay89@gmail.com> writes:
> 
> > In particular, show that --short and --porcelain, while implying
> > --dry-run, do not return the same exit code as --dry-run. This is due to
> > the wt_status.commitable flag being set only when a long status is
> > requested.
> 
> I am not sure if --short/--porcelain should even be accepted by "git
> commit" in the first place.  It used to be that "git status" and
> "git commit" were the same program in a different guise and "git
> status <anything>" were merely a "git commit --dry-run <anything>",
> but the recent push is in the direction of making them totally
> separate in the end-user's minds.  So if we want a proper fix, I
> would actually think that these options should *error out* at the
> command line parser level, way before checking if there is anything
> to commit.

I do not think they are any less useful than "git commit --dry-run" in
the first place. If you want to ask "what would happen if I ran commit
with these arguments", you can get the answer in any of several formats
(and --porcelain is the only machine-readable one).

I have never found "commit --dry-run" to be useful, but I assumed that
somebody does.

-Peff
