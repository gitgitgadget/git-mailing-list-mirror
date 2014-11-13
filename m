From: Jeff King <peff@peff.net>
Subject: Re: Git archiving only branch work
Date: Thu, 13 Nov 2014 16:39:38 -0500
Message-ID: <20141113213937.GD7563@peff.net>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
 <20141113133615.GA28346@lanh>
 <20141113200640.GB3869@peff.net>
 <xmqqvbmizu12.fsf@gitster.dls.corp.google.com>
 <20141113213318.GA7563@peff.net>
 <xmqqa93uzssv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:39:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp27E-000752-Be
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934678AbaKMVjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:39:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:40139 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934250AbaKMVjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:39:40 -0500
Received: (qmail 17560 invoked by uid 102); 13 Nov 2014 21:39:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 15:39:40 -0600
Received: (qmail 32165 invoked by uid 107); 13 Nov 2014 21:39:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 16:39:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 16:39:38 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa93uzssv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 01:36:48PM -0800, Junio C Hamano wrote:

> > I agree it is probably OK in practice and for the OP's question, but it
> > is nice to have "-z" variants so you do not have to worry about quoting
> > at all. I'd argue that a "--stdin -z" should probably also accept raw
> > filenames, not pathspecs, too (so you do not have to use
> > "--literal-pathspecs" elsewhere).
> 
> I agree "--stdin -z" is a good thing but what makes you think that
> the producer of the data is _always_ walking the directory hierarchy
> and showing the pathnames it sees?  I think use of literal-pathspecs
> should not be tied to the use of either --stdin or -z.

I agree they are technically orthogonal, but I cannot think of a case
where I have ever generated actual _pathspecs_, which might have
wildcards, and needed to use "-z". The point of using "-z" is that you
do not know what crap you are feeding.

Normally I'm in favor of keeping things as flexible as possible, but it
seems very likely that somebody would forget pathspecs in such a case
(the OP did in his example, and I know I have many times in the past).
I don't feel too strongly about it, though.

-Peff
