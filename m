From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] give exclude mechanism a debug option
Date: Sat, 7 Feb 2009 06:44:44 -0500
Message-ID: <20090207114444.GB18079@coredump.intra.peff.net>
References: <20090207064221.GA14856@coredump.intra.peff.net> <20090207064454.GB14906@coredump.intra.peff.net> <7vljsizog1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 12:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVlgH-0002Yc-VP
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 12:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbZBGLos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 06:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbZBGLos
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 06:44:48 -0500
Received: from peff.net ([208.65.91.99]:35682 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbZBGLor (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 06:44:47 -0500
Received: (qmail 20608 invoked by uid 107); 7 Feb 2009 11:45:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Feb 2009 06:45:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Feb 2009 06:44:44 -0500
Content-Disposition: inline
In-Reply-To: <7vljsizog1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108842>

On Fri, Feb 06, 2009 at 11:38:38PM -0800, Junio C Hamano wrote:

> >   2. If you ask for "foo/bar", and "foo/" is ignored, the
> >      output will show only "foo: exclude: foo". This is an
> >      artifact of the calling interface: you don't ask "is
> >      foo/bar excluded", but rather while recursing through
> >      "foo/" you ask "should I bother even recursing into
> >      foo?". So the exclusion code never even knows that you
> >      might have cared about foo/bar in the first place.
> 
> I do not see why it is a problem.  It exactly is what you want to know,
> isn't it?

Because I would expect "git check-ignore foo/bar | grep ^foo/bar:" to
tell me if and how foo/bar is being excluded. But I have to instead
check for ^foo and ^foo/bar.

Not a big deal, perhaps. But it just seems like counter-intuitive output
for a query about how a specific path is excluded.

-Peff
