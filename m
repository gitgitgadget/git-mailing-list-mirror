From: Jeff King <peff@peff.net>
Subject: Re: git fetch origin hanging in 1.7.0
Date: Tue, 16 Feb 2010 02:24:56 -0500
Message-ID: <20100216072456.GG2169@coredump.intra.peff.net>
References: <7e3605161002151608t44bd320cgcd589796a9ec902b@mail.gmail.com>
 <20100216063959.GC2169@coredump.intra.peff.net>
 <20100216151821.994ace31.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Menard <nirvdrum@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 08:25:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhHns-00024j-Bu
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 08:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650Ab0BPHY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 02:24:58 -0500
Received: from peff.net ([208.65.91.99]:41076 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932624Ab0BPHY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 02:24:57 -0500
Received: (qmail 30256 invoked by uid 107); 16 Feb 2010 07:25:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Feb 2010 02:25:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2010 02:24:56 -0500
Content-Disposition: inline
In-Reply-To: <20100216151821.994ace31.rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140080>

On Tue, Feb 16, 2010 at 03:18:21PM +0800, Tay Ray Chuan wrote:

> > That fixes the problem for me, but I am totally clueless about this
> > code. Do all transports have a git_transport_data (if so, then why is it
> > a void pointer?).
> 
> It is void so that it can be any struct - for example,
> git_transport_data, bundle_transport_data. That way, transport->data
> can point to any transport-specific data, while keeping the compiler
> satisfied at compile-time.

OK, I figured it was something like that. In that case, your fix looks
like the right thing to do (and it fixes my test case).

Thanks.

> -- >8 --
> Subject: [PATCH] transport: add got_remote_refs flag

Acked-by: Jeff King <peff@peff.net>

-Peff
