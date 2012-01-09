From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitignore: warn about pointless syntax
Date: Mon, 9 Jan 2012 11:28:02 -0500
Message-ID: <20120109162802.GA2374@sigill.intra.peff.net>
References: <1326123647-18352-1-git-send-email-jengelh@medozas.de>
 <1326123647-18352-2-git-send-email-jengelh@medozas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Mon Jan 09 17:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkI51-0003ah-Jk
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 17:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261Ab2AIQ2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 11:28:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60661
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932170Ab2AIQ2H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 11:28:07 -0500
Received: (qmail 358 invoked by uid 107); 9 Jan 2012 16:34:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jan 2012 11:34:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2012 11:28:02 -0500
Content-Disposition: inline
In-Reply-To: <1326123647-18352-2-git-send-email-jengelh@medozas.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188176>

On Mon, Jan 09, 2012 at 04:40:47PM +0100, Jan Engelhardt wrote:

> +static inline void check_bogus_wildcard(const char *file, const char *p)
> +{
> +	if (strstr(p, "**") == NULL)
> +		return;
> +	warning(_("Pattern \"%s\" from file \"%s\": Double asterisk does not "
> +		"have a special meaning and is interpreted just like a single "
> +		"asterisk.\n"), file, p);

Wouldn't this also match the meaningful "foo\**"?

-Peff
