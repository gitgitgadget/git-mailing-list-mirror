From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] branch: allow pattern arguments
Date: Thu, 25 Aug 2011 13:54:05 -0400
Message-ID: <20110825175405.GD519@sigill.intra.peff.net>
References: <cover.1314259226.git.git@drmicha.warpmail.net>
 <00847b8ee77129433a5d908ad25c9ebaf7fa7130.1314259226.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Schubert <mschub@elegosoft.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 19:54:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwe86-0002Nh-Jw
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 19:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab1HYRyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 13:54:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40477
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755070Ab1HYRyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 13:54:08 -0400
Received: (qmail 16850 invoked by uid 107); 25 Aug 2011 17:54:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 13:54:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 13:54:05 -0400
Content-Disposition: inline
In-Reply-To: <00847b8ee77129433a5d908ad25c9ebaf7fa7130.1314259226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180093>

On Thu, Aug 25, 2011 at 10:30:17AM +0200, Michael J Gruber wrote:

> -	else if (argc == 0)
> -		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
> +	else if (argc == 0 || (verbose && argc == 1))
> +		return print_ref_list(kinds, detached, verbose, abbrev, with_commit, argc ? argv[0] : NULL);

Note that "git tag -l" takes multiple patterns these days (it used to
silently ignore everything after the first one!). "git branch" should
probably do the same.

-Peff
