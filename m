From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/7] strbuf: introduce strbuf_read_cmd helper
Date: Sun, 22 Mar 2015 19:36:53 -0400
Message-ID: <20150322233653.GB21518@peff.net>
References: <20150322095924.GA24651@peff.net>
 <20150322100724.GC11615@peff.net>
 <xmqqsicwbos5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:37:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZpQS-0002f5-Lx
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 00:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbbCVXg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 19:36:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:36942 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752117AbbCVXg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 19:36:56 -0400
Received: (qmail 2797 invoked by uid 102); 22 Mar 2015 23:36:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 18:36:56 -0500
Received: (qmail 11018 invoked by uid 107); 22 Mar 2015 23:37:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 19:37:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 19:36:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsicwbos5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266108>

On Sun, Mar 22, 2015 at 04:22:50PM -0700, Junio C Hamano wrote:

> > +/**
> >   * Read a line from a FILE *, overwriting the existing contents
> >   * of the strbuf. The second argument specifies the line
> >   * terminator character, typically `'\n'`.
> 
> It is an unfortunate tangent that this is a bugfix that may want to
> go to 'maint' and older, but our earlier jk/strbuf-doc-to-header
> topic introduces an unnecessary merge conflicts.

Yeah, that is the worst part of refactoring and cleanup. Even when you
make sure you are not hurting any topics in flight, you cannot know when
a new topic will take off in your general area.

> I've wiggled this part and moved the doc elsewhere, only to remove
> that in the merge, which may not be optimal from the point of view
> of what I have to do when merging this topic down from pu to next
> to master to maint, but I do not see a good way around it.

I'd suggest just dropping the documentation in the "maint" version
(i.e., make it a moral cherry-pick of the function declaration only).

-Peff
