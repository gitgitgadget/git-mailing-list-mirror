From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] commit.c - provide commit-type to the
 hooks/pre-commit script
Date: Sun, 6 Jun 2010 18:10:37 -0400
Message-ID: <20100606221037.GE6993@coredump.intra.peff.net>
References: <1275759590-16342-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:10:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLO3I-0005NM-CT
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363Ab0FFWKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:10:39 -0400
Received: from peff.net ([208.65.91.99]:35667 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755063Ab0FFWKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:10:39 -0400
Received: (qmail 12464 invoked by uid 107); 6 Jun 2010 22:10:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Jun 2010 18:10:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jun 2010 18:10:37 -0400
Content-Disposition: inline
In-Reply-To: <1275759590-16342-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148552>

On Sat, Jun 05, 2010 at 01:39:50PM -0400, Mark Levedahl wrote:

> -	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
> +	if (!no_verify && run_hook(index_file, "pre-commit", amend ? "amend" : "normal", NULL))
> [...]
> -	against=HEAD
> +	if test "$1" = "amend"
> +	then
> +		against=HEAD~1
> +	else
> +		against=HEAD
> +	fi

Is there a reason to use the magic "amend" and "normal" words, if
scripts are just going to end up changing them back into HEAD~1 and HEAD
anyway?

-Peff
