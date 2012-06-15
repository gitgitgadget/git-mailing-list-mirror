From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-http-fetch: remove unused cmd_http_fetch
Date: Fri, 15 Jun 2012 12:21:36 -0400
Message-ID: <20120615162136.GC4572@sigill.intra.peff.net>
References: <20120614202336.GA3755@w500.iskon.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Luka Perkov <lists@lukaperkov.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 18:21:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfZHL-0005ut-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 18:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314Ab2FOQVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 12:21:39 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:56447
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932218Ab2FOQVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 12:21:39 -0400
Received: (qmail 826 invoked by uid 107); 15 Jun 2012 16:21:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 12:21:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 12:21:36 -0400
Content-Disposition: inline
In-Reply-To: <20120614202336.GA3755@w500.iskon.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200066>

On Thu, Jun 14, 2012 at 10:23:37PM +0200, Luka Perkov wrote:

> It was left out from commit 1088261f6fc90324014b5306cca4171987da85ce

This commit message left me scratching my head. Did we get rid of
http-fetch? If not, then don't we still need cmd_http_fetch? Or did we
just make it not a builtin, in which case we wouldn't be getting rid of
cmd_http_fetch, but rather converting it to main?

Reading the 1088261, I find the answer: we did make it not a builtin,
and it was indeed converted into "main". But its _declaration_ hung
around.

So maybe a better commit message would be:

  Subject: builtin.h: drop cmd_http_fetch declaration

  This was converted from a builtin into a stand-alone program by
  1088261f6fc90324014b5306cca4171987da85ce, but that commit forgot to
  drop the declaration.

Other than that, the patch looks obviously correct.

-Peff

PS There seem to be some other similar declarations: at least
   cmd_upload_tar and cmd_pickaxe.
