From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin/commit.c: set status_format _after_ option
 parsing
Date: Thu, 26 May 2011 17:17:23 -0400
Message-ID: <20110526211723.GE31340@sigill.intra.peff.net>
References: <vdMu20HxiNaWL_IogfamtfZCd6xRyKanIqTSw0k4f2SrbLfUYHDzKT2EGkwdFRlaLzX-5vGGtDCZRGu84HrJzw@cipher.nrlssc.navy.mil>
 <vdMu20HxiNaWL_IogfamtflLupHrDNZVtQH5MK7obj8IjaOAuDtj-EwLzysKLoeGXYfBRtJqF-hgEQF5bfRzsQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 26 23:17:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhvy-0001eX-87
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758252Ab1EZVR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:17:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34394
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756699Ab1EZVR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:17:28 -0400
Received: (qmail 17764 invoked by uid 107); 26 May 2011 21:17:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 17:17:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 17:17:23 -0400
Content-Disposition: inline
In-Reply-To: <vdMu20HxiNaWL_IogfamtflLupHrDNZVtQH5MK7obj8IjaOAuDtj-EwLzysKLoeGXYfBRtJqF-hgEQF5bfRzsQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174572>

On Thu, May 26, 2011 at 01:43:21PM -0700, Brandon Casey wrote:

> 'git status' should use --porcelain output format when -z is given.
> It was not doing so since the _effect_ of using -z, namely that
> null_termination would be set, was being checked _before_ option parsing
> was performed.
> 
> So, move the check so that it is performed after option parsing.

Wow, that's an embarrassing bug. I was about to own up to it, but it
actually looks like it is Junio's bug from 173e6c8 (git stat -s: short
status output, 2009-08-04). Of course, I _twice_ modified the
conditional afterwards and failed to notice that it was doing absolutely
nothing. So I'm not sure which one of us deserves the brown paper bag. :)

Your fix looks obviously correct.

Acked-by: Jeff King <peff@peff.net>

-Peff
