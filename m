From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Sat, 29 Mar 2008 04:49:48 -0400
Message-ID: <20080329084947.GB19200@coredump.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803290819.07280.robin.rosenberg.lists@dewire.com> <20080329072203.GA17625@coredump.intra.peff.net> <200803290941.54091.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 09:50:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfWlj-0005Ks-Qr
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 09:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbYC2Itu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 04:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753895AbYC2Itu
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 04:49:50 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2473 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787AbYC2Itu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 04:49:50 -0400
Received: (qmail 19689 invoked by uid 111); 29 Mar 2008 08:49:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 04:49:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 04:49:48 -0400
Content-Disposition: inline
In-Reply-To: <200803290941.54091.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78456>

On Sat, Mar 29, 2008 at 09:41:53AM +0100, Robin Rosenberg wrote:

> > OK. Do you have an example function that guesses with high probability
> > whether a string is utf-8? If there are non-ascii characters but we
> > _don't_ guess utf-8, what should we do?
> 
> Any test for valid UTF-8 will do that with a very high probability. The
> perl UTF-8 "api" is a mess. I couldn't find such a routine!?. Calling 
> decode/encode and see if you get the original string works, but that is too
> clumsy, IMHO.

Does that work? I would think you would have to compare the normalized
versions of each string, since decode(encode($x)) is not, AIUI,
guaranteed to produce $x.

-Peff
