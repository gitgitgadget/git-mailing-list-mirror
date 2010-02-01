From: Jeff King <peff@peff.net>
Subject: Re: Problem listing GIT repository with accents
Date: Mon, 1 Feb 2010 12:40:45 -0500
Message-ID: <20100201174045.GA5756@coredump.intra.peff.net>
References: <7E88665723814E46BCBA1A39E84C27A5@elrond>
 <20100201113213.GA22663@coredump.intra.peff.net>
 <20100201121933.GA9995@coredump.intra.peff.net>
 <4B66CD81.3010005@viscovery.net>
 <20100201133903.GA923@coredump.intra.peff.net>
 <20100201134454.GA796@coredump.intra.peff.net>
 <7v3a1k50sw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?B?RWxsacOp?= Computing Open Source Program 
	<opensource@elliecomputing.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 18:40:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc0Gb-0003VB-JB
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 18:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab0BARks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 12:40:48 -0500
Received: from peff.net ([208.65.91.99]:60662 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870Ab0BARkr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 12:40:47 -0500
Received: (qmail 28753 invoked by uid 107); 1 Feb 2010 17:40:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 01 Feb 2010 12:40:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Feb 2010 12:40:45 -0500
Content-Disposition: inline
In-Reply-To: <7v3a1k50sw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138631>

On Mon, Feb 01, 2010 at 09:21:51AM -0800, Junio C Hamano wrote:

> Unless we document "this function is to C-quote a (portion of a) string,
> either to the end or up to the given length", however, future callers may
> incorrectly assume that with length the function can be fed anything and
> would C-quote that piece of memory.  The argument name "const char *name"
> already suggests that is not an arbitrary binary rubbish, changing that to
> "str" would probably make that a bit stronger documentation, or we could
> explicitly say "this is a (early part of a) NUL-terminated string" in a
> comment.
> 
> But your one-liner patch would actually be a smaller change than any of
> them and makes the whole problem disappear; wouldn't it be a far better
> solution?

Sure, if you are going to bother to document it to future-proof against
new callers, you might as well just make it more flexible with my
one-liner. I don't think it will impact the behavior of any existing
callers either way.

I was just going to not bother, but perhaps while we have spent some
brain cycles on it, it is better to just fix it. Either way is fine with
me.

-Peff
