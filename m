From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Fri, 3 Feb 2012 18:27:55 -0500
Message-ID: <20120203232755.GA11953@sigill.intra.peff.net>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120202200240.GC9246@sigill.intra.peff.net>
 <7vr4ycu3ty.fsf@alter.siamese.dyndns.org>
 <20120203120657.GB31441@sigill.intra.peff.net>
 <7v7h03odyo.fsf@alter.siamese.dyndns.org>
 <20120203212604.GA1890@sigill.intra.peff.net>
 <7vr4ybmvrq.fsf@alter.siamese.dyndns.org>
 <20120203215507.GB3472@sigill.intra.peff.net>
 <7vipjnmt8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 00:28:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtSY6-0008AB-3g
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 00:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab2BCX16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 18:27:58 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56086
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502Ab2BCX15 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 18:27:57 -0500
Received: (qmail 3641 invoked by uid 107); 3 Feb 2012 23:35:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 18:35:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 18:27:55 -0500
Content-Disposition: inline
In-Reply-To: <7vipjnmt8a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189829>

On Fri, Feb 03, 2012 at 02:45:25PM -0800, Junio C Hamano wrote:

> Let's not over-engineer this and stick to the simple-stupid-sufficient.

Fair enough.

> Something like this?
> [...]
> +# Prepare a script to be used in the test
> +write_script () {
> +	{
> +		echo "#!${2-"$SHELL_PATH"}"
> +		cat
> +	} >"$1" &&
> +	chmod +x "$1"
> +}

Looks good to me (it probably doesn't matter, but you may want to
connect the echo and cat via &&).

-Peff
