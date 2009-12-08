From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add commit.status, --status, and --no-status
Date: Tue, 8 Dec 2009 02:55:17 -0500
Message-ID: <20091208075517.GC12049@coredump.intra.peff.net>
References: <20091206131217.GA12851@sigill.intra.peff.net>
 <1260225927-33612-1-git-send-email-jh@jameshoward.us>
 <20091208060415.GC9951@coredump.intra.peff.net>
 <7vr5r6ndkz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "James P. Howard, II" <jh@jameshoward.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 08:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHuvn-0006jI-8O
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 08:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750AbZLHHzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 02:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbZLHHzT
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 02:55:19 -0500
Received: from peff.net ([208.65.91.99]:49979 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755411AbZLHHzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 02:55:13 -0500
Received: (qmail 9313 invoked by uid 107); 8 Dec 2009 07:59:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Dec 2009 02:59:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Dec 2009 02:55:17 -0500
Content-Disposition: inline
In-Reply-To: <7vr5r6ndkz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134834>

On Mon, Dec 07, 2009 at 11:13:00PM -0800, Junio C Hamano wrote:

> >> This commit provides support for commit.status, --status, and
> >> --no-status, which control whether or not the git status information
> >> is included in the commit message template when using an editor to
> >> prepare the commit message.  It does not affect the effects of a
> >> user's commit.template settings.
> >
> > Thanks, this looks very cleanly done. The only complaint I would make is
> > that it should probably include a simple test case.
> 
> Yes.  Also I am a _bit_ worried about the name "status", as the longer
> term direction is to make "status" not "a preview of commit", may confuse
> people who do read Release Notes.

I thought about that, but what other name does it have? That text has
always been called "status", and we will continue to support that output
format as "git status" _and_ as "commit --dry-run". So I think
explaining it as "usually we stick the output of 'git status' into the
commit message, but this suppresses it" is not that hard (and that was
how I read the documentation in his patch).

The only trick is that it is not a vanilla "git status", but rather
"status after we have staged things for commit". But I think that is
fairly obvious since you are, after all, calling "commit".

But then again, I am probably way too deep in this topic to provide a
regular git user's perspective of what is obvious.

-Peff
