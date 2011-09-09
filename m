From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3200: test branch creation with -v
Date: Fri, 9 Sep 2011 15:43:57 -0400
Message-ID: <20110909194357.GA31446@sigill.intra.peff.net>
References: <20110909193033.GA31184@sigill.intra.peff.net>
 <49578782dd114220aa2562b5bd29755fc2bdd0fa.1315597137.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 21:44:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R26zd-00008c-I3
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481Ab1IIToA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:44:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37527
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759737Ab1IITn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 15:43:59 -0400
Received: (qmail 1527 invoked by uid 107); 9 Sep 2011 19:44:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 15:44:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 15:43:57 -0400
Content-Disposition: inline
In-Reply-To: <49578782dd114220aa2562b5bd29755fc2bdd0fa.1315597137.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181115>

On Fri, Sep 09, 2011 at 09:40:59PM +0200, Michael J Gruber wrote:

> +test_expect_success 'git branch -v t should work' '
> +	git branch -v t &&
> +	test .git/refs/heads/t &&

test -f ?

Also, don't we have test_path_is_file which yields slightly prettier
output (and maybe some portability benefits; I don't remember)?

> +	git branch -d t &&
> +	test ! -f .git/refs/heads/t

Ditto for 'test_path_is_missing' here.

-Peff
