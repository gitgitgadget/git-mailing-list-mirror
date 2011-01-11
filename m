From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: explain diff.*.binary option
Date: Tue, 11 Jan 2011 01:11:14 -0500
Message-ID: <20110111061114.GE10094@sigill.intra.peff.net>
References: <vpqy670brcb.fsf@bauges.imag.fr>
 <20110105051807.GB5884@sigill.intra.peff.net>
 <vpqr5clsy8g.fsf@bauges.imag.fr>
 <20110109201003.GA4406@sigill.intra.peff.net>
 <7vpqs463o4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 07:11:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcXRz-0000Gd-74
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 07:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab1AKGLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 01:11:18 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47598 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab1AKGLR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 01:11:17 -0500
Received: (qmail 11527 invoked by uid 111); 11 Jan 2011 06:11:16 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 06:11:16 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 01:11:14 -0500
Content-Disposition: inline
In-Reply-To: <7vpqs463o4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164912>

On Mon, Jan 10, 2011 at 09:59:07AM -0800, Junio C Hamano wrote:

> Thanks.  I take it that this documents 122aa6f (diff: introduce
> diff.<driver>.binary, 2008-10-05) where you said...
> 
>     This patch introduces a "binary" config option for a diff
>     driver, so that one can explicitly set diff.foo.binary. We
>     default this value to "don't know". That is, setting a diff
>     attribute to "foo" and using "diff.foo.funcname" will have
>     no effect on the binaryness of a file. To get the current
>     behavior, one can set diff.foo.binary to true.
> 
> I am scratching my head about the last sentence, though.  Shouldn't that
> be "false"?  In the olden days, setting diff.foo.funcname made it text but
> with this change it no longer is the case and instead binaryness is
> determined by content inspection, so forcing "text" needs to be done by
> saying "this is _not_ binary", no?

Yeah, that definitely should be "false". I think it was simply a think-o
when typing the commit message (and I just did a quick test to double
check that the behavior described by the message is in fact what
happens).

Reading that thread, too, I think I was a little confused at first back
then about how diff.*.binary would be used with respect to textconv, but
between some thinking and JSixt beating some sense into me, it came out
with at least the correct semantics, if not an accurate commit message.
:)

-Peff
