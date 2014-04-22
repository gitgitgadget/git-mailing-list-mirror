From: Jeff King <peff@peff.net>
Subject: Re: Project idea: github-like diff view
Date: Tue, 22 Apr 2014 11:59:01 -0400
Message-ID: <20140422155901.GA13663@sigill.intra.peff.net>
References: <CACsJy8CQxPrqs31nBvr_oPRD3EJ6Hu-Lq=++7nWpxx5BQZYi8Q@mail.gmail.com>
 <20140420144620.GA16596@sigill.intra.peff.net>
 <CACsJy8DnJeZ-43Ydg_j00CO6=6NOA1wdzQ+EwCX6idrUOLn8gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 17:59:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcd6M-0002fu-2a
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 17:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757153AbaDVP7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 11:59:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:36147 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757257AbaDVP7D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 11:59:03 -0400
Received: (qmail 2563 invoked by uid 102); 22 Apr 2014 15:59:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Apr 2014 10:59:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2014 11:59:01 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DnJeZ-43Ydg_j00CO6=6NOA1wdzQ+EwCX6idrUOLn8gA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246743>

On Tue, Apr 22, 2014 at 04:59:17PM +0700, Duy Nguyen wrote:

> On Sun, Apr 20, 2014 at 9:46 PM, Jeff King <peff@peff.net> wrote:
> > On Sun, Apr 20, 2014 at 04:58:28PM +0700, Duy Nguyen wrote:
> >
> >> - --color-words within unified diff format, using background color to
> >> show what part of the line has changed. This is only enabled for
> >> 1-line changes.
> >
> > See contrib/diff-highlight.
> 
> Thanks. I'd rather have it built in core git still. I'll try to see if
> I can rewrite it in C. Else, any objection to promote it to a core
> helper and setup pager automatically? We can have a config key to turn
> it off, but if git diff is colored, then it could be on by default.

If you are going to write it as part of git, it would be interesting to
try using a real word-diff to find the inter-line changes, instead of
the "front and back match" heuristic that the script uses. I know there
are some cases that would look better, like:

  -foo(buf, len);
  +foo(obj->buf, obj->len);

but I suspect some cases would also look worse. It would be interesting
to experiment with, though.

-Peff
