From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-options.txt: document --[no]-textconv
Date: Tue, 24 May 2011 15:43:23 -0400
Message-ID: <20110524194322.GC584@sigill.intra.peff.net>
References: <1306196874-64687-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 21:43:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOxVr-00059L-HA
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 21:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab1EXTn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 15:43:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41201
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628Ab1EXTnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 15:43:25 -0400
Received: (qmail 21078 invoked by uid 107); 24 May 2011 19:43:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 15:43:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 15:43:23 -0400
Content-Disposition: inline
In-Reply-To: <1306196874-64687-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174336>

On Mon, May 23, 2011 at 08:27:54PM -0400, Jay Soffian wrote:

> textconv also seems to be supported by blame, it isn't clear to me whether
> it respects --no-textconv.

Yeah, it should, via the regular diff option parser.

> +--textconv::
> +	Text conversion of binary files is enabled by default if configured
> +	according to "Performing text diffs of binary files" in
> +	linkgit:gitattributes[5], but may be disabled with `--no-textconv`.
> +	This option overrides a previously given `--no-textconv`.

It's only on by default for porcelain commands (log, show, diff).
Plumbing commands do not allow textconv unless --textconv is given.

I don't offhand recall whether it is on by default for blame.

-Peff
