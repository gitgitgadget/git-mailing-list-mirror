From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] pickaxe: allow -i to search in patch
 case-insensitively
Date: Wed, 29 Feb 2012 03:35:34 -0500
Message-ID: <20120229083534.GC14181@sigill.intra.peff.net>
References: <1330474831-9030-1-git-send-email-gitster@pobox.com>
 <1330474831-9030-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 09:35:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2f0h-0007Hf-15
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 09:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab2B2Ifi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 03:35:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32821
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754246Ab2B2Ifh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 03:35:37 -0500
Received: (qmail 20342 invoked by uid 107); 29 Feb 2012 08:35:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Feb 2012 03:35:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Feb 2012 03:35:34 -0500
Content-Disposition: inline
In-Reply-To: <1330474831-9030-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191819>

On Tue, Feb 28, 2012 at 04:20:31PM -0800, Junio C Hamano wrote:

> "git log -S<string>" is a useful way to find the last commit in the
> codebase that touched the <string>. As it was designed to be used by a
> porcelain script to dig the history starting from a block of text that
> appear in the starting commit, it never had to look for anything but an
> exact match.
> 
> When used by an end user who wants to look for the last commit that
> removed a string (e.g. name of a variable) that he vaguely remembers,
> however, it is useful to support case insensitive match.
> 
> When given the "--regexp-ignore-case" (or "-i") option, which originally
> was designed to affect case sensitivity of the search done in the commit
> log part, e.g. "log --grep", the matches made with -S/-G pickaxe search is
> done case insensitively now.

I can't imagine anybody would want to have different case-sensitivity
options for grepping the commit message versus pickaxe. But even if they
do, and we later add options to control them individually, we would
still want the short-and-sweet "-i" to cover the common case of setting
both. So I think the approach is good.

The patch itself looks fine to me.

-Peff
