From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according
	to git-log rules.
Date: Wed, 22 Oct 2008 04:20:17 -0400
Message-ID: <20081022082016.GA18473@sigill.intra.peff.net>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 10:21:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsYyG-0001Qa-7Z
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 10:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbYJVIUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 04:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYJVIUW
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 04:20:22 -0400
Received: from peff.net ([208.65.91.99]:1392 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbYJVIUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 04:20:21 -0400
Received: (qmail 31316 invoked by uid 111); 22 Oct 2008 08:20:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 22 Oct 2008 04:20:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 04:20:17 -0400
Content-Disposition: inline
In-Reply-To: <1224622557-6669-1-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98840>

On Wed, Oct 22, 2008 at 12:55:57AM +0400, Alexander Gavrilov wrote:

> +test_expect_success \
> +	'blame respects i18n.commitencoding' '
> +	git blame --incremental file | \
> +		grep "^\(author\|summary\) " > actual &&
> +	test_cmp actual expected

Even though it is POSIX, using backslashed grouping in 'grep' isn't
portable. It fails at least on Solaris 8, and you have to do:

  egrep "^(author|summary) "

instead. Of course, I can't get your test to pass even with that change,
but I think that is just a broken iconv on Solaris.

-Peff
