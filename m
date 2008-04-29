From: Jeff King <peff@peff.net>
Subject: Re: reflog/show question
Date: Tue, 29 Apr 2008 16:12:14 -0400
Message-ID: <20080429201214.GB20509@sigill.intra.peff.net>
References: <93c3eada0804271859p1b4d8b52i811bdc5e42672822@mail.gmail.com> <20080428092410.GD16153@sigill.intra.peff.net> <93c3eada0804281847q267611aeke51b482cfbe100d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 22:13:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqwCF-00049b-Ip
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 22:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbYD2UMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 16:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbYD2UMQ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 16:12:16 -0400
Received: from peff.net ([208.65.91.99]:1411 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbYD2UMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 16:12:15 -0400
Received: (qmail 11123 invoked by uid 111); 29 Apr 2008 20:12:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Apr 2008 16:12:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2008 16:12:14 -0400
Content-Disposition: inline
In-Reply-To: <93c3eada0804281847q267611aeke51b482cfbe100d6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80725>

On Tue, Apr 29, 2008 at 11:17:09AM +0930, Geoff Russell wrote:

> >  >      git show HEAD@{"3 minutes ago"}
> >  >
> >  > works as I expect, but
> >  >
> >  >      git show HEAD@{"3 minutes ago"}:data/node/node.data
> >  >
> >  > gives me a message:
> >  >
> >  >        warning: Log for 'HEAD' only goes back to Mon, 28 Apr 2008
> >  >        10:18:37 +0930.
> >  >
> >
> I think its something to do with the filename and my commit comments.
> The command works as expected on other files.  The HEAD file is
> attached.

Hmm. Are you sure that the commit you got from HEAD@{"3 minutes ago"}
actually _has_ the file data/node/node.data? If it doesn't, then you get
the error message you saw. And it may be that the reflog warning happens
in _both_ cases, only you don't see it in the first because it is masked
by the pager. In v1.5.5, that output is now sent to the pager, instead.

-Peff
