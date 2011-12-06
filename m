From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] userdiff: allow * between cpp funcname words
Date: Tue, 6 Dec 2011 14:02:17 -0500
Message-ID: <20111206190217.GD9492@sigill.intra.peff.net>
References: <a639d328e15bce3057de9238ee31097d15850de1.1323189110.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 06 20:02:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY0HY-0000Dn-Cu
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 20:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365Ab1LFTCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 14:02:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41456
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab1LFTCT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 14:02:19 -0500
Received: (qmail 7173 invoked by uid 107); 6 Dec 2011 19:08:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 14:08:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 14:02:17 -0500
Content-Disposition: inline
In-Reply-To: <a639d328e15bce3057de9238ee31097d15850de1.1323189110.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186370>

On Tue, Dec 06, 2011 at 05:35:08PM +0100, Thomas Rast wrote:

> The cpp pattern, used for C and C++, would not match the start of a
> declaration such as
> 
>   static char *prepare_index(int argc,
> 
> because it did not allow for * anywhere between the various words that
> constitute the modifiers, type and function name.  Fix it.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
> 
> This is a really sneaky one-character bug that I cannot believe went
> unnoticed for so long, seeing as there are plenty of instances within
> git itself where it matters.

Looks reasonable to me. You can see the difference, for instance, with:

  git show -U1 3c73a1d

(The -U1 is because of the annoying "we will start looking for the
header at the top of context, not the top of changes" behavior I
mentioned last week).

-Peff
