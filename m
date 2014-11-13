From: Jeff King <peff@peff.net>
Subject: Re: Git archiving only branch work
Date: Thu, 13 Nov 2014 16:33:18 -0500
Message-ID: <20141113213318.GA7563@peff.net>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
 <20141113133615.GA28346@lanh>
 <20141113200640.GB3869@peff.net>
 <xmqqvbmizu12.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:33:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp219-0003s6-2z
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934667AbaKMVdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:33:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:40116 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934290AbaKMVdU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:33:20 -0500
Received: (qmail 17270 invoked by uid 102); 13 Nov 2014 21:33:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 15:33:20 -0600
Received: (qmail 31971 invoked by uid 107); 13 Nov 2014 21:33:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 16:33:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 16:33:18 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvbmizu12.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 01:10:17PM -0800, Junio C Hamano wrote:

> > How about just adding --stdin, which matches other git commands?
> 
> How about doing nothing and use the correct $IFS instead?

Can you cover all cases with $IFS, including filenames with newlines?

I agree it is probably OK in practice and for the OP's question, but it
is nice to have "-z" variants so you do not have to worry about quoting
at all. I'd argue that a "--stdin -z" should probably also accept raw
filenames, not pathspecs, too (so you do not have to use
"--literal-pathspecs" elsewhere).

-Peff
