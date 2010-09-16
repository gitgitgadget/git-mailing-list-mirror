From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/t7300: workaround ancient touch by rearranging
 arguments
Date: Wed, 15 Sep 2010 20:31:17 -0400
Message-ID: <20100916003117.GA2527@sigill.intra.peff.net>
References: <i6Vnwbi85zvoD6Nzpw2lc1cAb4fZRJiU13x2r3wnIFnHDZWo9gkMwp9pRXJjgiXl4Ce-ERc-tvc@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Sep 16 02:30:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow2NJ-00038S-Mw
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 02:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab0IPAao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 20:30:44 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54248 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab0IPAao (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 20:30:44 -0400
Received: (qmail 25451 invoked by uid 111); 16 Sep 2010 00:30:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 16 Sep 2010 00:30:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Sep 2010 20:31:17 -0400
Content-Disposition: inline
In-Reply-To: <i6Vnwbi85zvoD6Nzpw2lc1cAb4fZRJiU13x2r3wnIFnHDZWo9gkMwp9pRXJjgiXl4Ce-ERc-tvc@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156283>

On Wed, Sep 15, 2010 at 03:58:22PM -0500, Brandon Casey wrote:

> From: Brandon Casey <drafnel@gmail.com>
> 
> The ancient touch on Solaris 7 thinks that a decimal number supplied as
> the first argument specifies a date_time to give to the files specified by
> the remaining arguments.  In this case, it fails to parse '1' as a proper
> date_time and exits with a failure status.  Workaround this flaw by
> rearranging the arguments supplied to touch so that a non-digit appears
> first and touch will not be confused.

Hmm, this seemed eerily familiar, and sure enough:

  http://article.gmane.org/gmane.comp.version-control.git/101270

I don't _think_ I had Solaris 7 anytime recently, so the issue may be
even more widespread (I would guess that my patch was a result of
Solaris 8). Anyway, good catch.

-Peff
