From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Thu, 13 Sep 2012 10:57:09 -0400
Message-ID: <20120913145708.GA32523@sigill.intra.peff.net>
References: <20120913132847.GD4287@sigill.intra.peff.net>
 <1347545786-936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 16:57:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCAr3-0002wA-86
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 16:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865Ab2IMO5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 10:57:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43505 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598Ab2IMO5L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 10:57:11 -0400
Received: (qmail 3759 invoked by uid 107); 13 Sep 2012 14:57:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 10:57:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 10:57:09 -0400
Content-Disposition: inline
In-Reply-To: <1347545786-936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205382>

On Thu, Sep 13, 2012 at 09:16:26PM +0700, Nguyen Thai Ngoc Duy wrote:

> This reverts the i18n part of 7f81463 (Use correct grammar in diffstat
> summary line - 2012-02-01) but still keeps the grammar correctness for
> English. It also reverts b354f11 (Fix tests under GETTEXT_POISON on
> diffstat - 2012-08-27). The result is diffstat always in English
> for all commands.
> 
> This helps stop users from accidentally sending localized
> format-patch'd patches.

Yeah, this is exactly what I had in mind for now. Thanks.

>  The "for now" sounds reasonable. Minimum annoyance is always good
>  especially in a (largely?) volunteer-driven development environment
>  like git. So I revert the i18n effect. Note that I don't optimize the
>  changes for English only. The i18n might come back some day if we
>  find a good way to do it.
> 
>  Git is still partly i18n-ized, turning a few strings back does not
>  seem a big regression.

I wonder if it would ever be fully so. Diffs will always have "diff" in
them.  Git-checkout will always be called "checkout". It seems like
learning a little bit of the original language is always necessary for
command-line tools and machine-readable formats.

>  >   2. If people on non-English projects find that too cumbersome, then we
>  >      can switch the "English/C" above for `i18n.projectlang` or
>  >      something. But it should not be per-command, but per-message, and
>  >      should include all output that is not diagnostic and is not
>  >      machine-parseable (e.g., what I mentioned above, request-pull
>  >      output, etc). If it is the project's language, then the team
>  >      members will need to know it anyway, so it should not be too big a
>  >      burden to have a potentially different language there than in the
>  >      diagnostic messages.
> 
>  If you mean projectlang vs a local language, I looked into that and I
>  don't think we could support two non-C languages using standard
>  gettext interface. So it's either "C vs another", or make use of
>  unofficial gettext features, or roll your own.

Yeah, I saw in your original message that it gets hairy. My statement
was more about what we would want if there were no implementation
obstacles. I'd leave it to later to decide the details.

-Peff
