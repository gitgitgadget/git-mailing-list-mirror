From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/10] prompt.c: remove git_getpass() nobody uses
Date: Thu, 15 Jan 2015 01:47:34 -0500
Message-ID: <20150115064734.GC11028@peff.net>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
 <1421278855-8126-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 07:47:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBeDY-00029V-1v
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 07:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbbAOGri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 01:47:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:34811 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751079AbbAOGrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 01:47:37 -0500
Received: (qmail 20403 invoked by uid 102); 15 Jan 2015 06:47:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 00:47:37 -0600
Received: (qmail 10423 invoked by uid 107); 15 Jan 2015 06:47:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 01:47:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 01:47:34 -0500
Content-Disposition: inline
In-Reply-To: <1421278855-8126-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262460>

On Wed, Jan 14, 2015 at 03:40:48PM -0800, Junio C Hamano wrote:

> -char *git_getpass(const char *prompt)
> -{
> -	return git_prompt(prompt, PROMPT_ASKPASS);
> -}

Yay. This was whittled down to a compatibility wrapper around the more
flexible git_prompt, waiting for the final callers to go away. That
happened in 791643a8, when imap-send learned to use the credential
interface.

-Peff
