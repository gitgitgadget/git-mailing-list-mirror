From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Thu, 8 Sep 2011 21:08:32 -0400
Message-ID: <20110909010832.GA4809@sigill.intra.peff.net>
References: <20110825175301.GC519@sigill.intra.peff.net>
 <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net>
 <7vfwkodq5s.fsf@alter.siamese.dyndns.org>
 <4E5A5290.4050005@drmicha.warpmail.net>
 <20110907195611.GD13364@sigill.intra.peff.net>
 <4E6889DF.7030404@drmicha.warpmail.net>
 <7vr53qwxtz.fsf@alter.siamese.dyndns.org>
 <7vmxeewx7f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 03:08:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1paC-0003jh-7A
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 03:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256Ab1IIBIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 21:08:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55130
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757080Ab1IIBIe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 21:08:34 -0400
Received: (qmail 18906 invoked by uid 107); 9 Sep 2011 01:09:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Sep 2011 21:09:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2011 21:08:32 -0400
Content-Disposition: inline
In-Reply-To: <7vmxeewx7f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181015>

On Thu, Sep 08, 2011 at 02:17:24PM -0700, Junio C Hamano wrote:

> "branch -v" without other options or parameters still works in the list
> mode, but that is not because there is "-v" but because there is no
> parameter nor option.
> [...]
> +test_expect_success 'git branch -v pattern does not show branch summaries' '
> +	test_must_fail git branch -v branch*
> +'

You might also want to affirm that it does not just fail, but still
creates a branch, like:

  test_expect_success 'git branch -v <name> creates a branch' '
         git rev-parse HEAD >expect &&
         git branch -v foo &&
         git rev-parse foo >actual &&
         test_cmp expect actual
  '

-Peff
