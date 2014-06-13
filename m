From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 5/6] t7510: test verify-commit
Date: Fri, 13 Jun 2014 07:51:25 -0400
Message-ID: <20140613115125.GG14066@sigill.intra.peff.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
 <3aaf65288733117909150771cc62508f3236d107.1402655839.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 13:51:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQ14-0007sF-Nf
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 13:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbaFMLv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 07:51:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:43420 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750788AbaFMLv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 07:51:27 -0400
Received: (qmail 23573 invoked by uid 102); 13 Jun 2014 11:51:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 06:51:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 07:51:25 -0400
Content-Disposition: inline
In-Reply-To: <3aaf65288733117909150771cc62508f3236d107.1402655839.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251552>

On Fri, Jun 13, 2014 at 12:42:47PM +0200, Michael J Gruber wrote:

>  test_expect_success GPG 'detect fudged signature' '
>  	git cat-file commit master >raw &&
>  
>  	sed -e "s/seventh/7th forged/" raw >forged1 &&
>  	git hash-object -w -t commit forged1 >forged1.commit &&
> +	! git verify-commit $(cat forged1.commit) &&

Please use test_must_fail here (and further down), which will catch
things like signal death.

-Peff
