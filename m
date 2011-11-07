From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Mon, 7 Nov 2011 12:22:18 -0500
Message-ID: <20111107172218.GB3621@sigill.intra.peff.net>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 18:22:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNStt-0007OI-3w
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 18:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727Ab1KGRWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 12:22:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35833
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932618Ab1KGRWU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 12:22:20 -0500
Received: (qmail 27982 invoked by uid 107); 7 Nov 2011 17:22:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 12:22:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 12:22:18 -0500
Content-Disposition: inline
In-Reply-To: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185002>

On Mon, Nov 07, 2011 at 06:07:12PM +0200, Felipe Contreras wrote:

> This is useful to mirror all the branches in the current repo to
> another.
> [...]
> +'sync'::
> +
> +Synchronizes local branches with certain remote. This is useful to backup all
> +the branches in a local repository to a remote one, regardless of what upstream
> +is configured for each branch.
> ++
> +With `--prune`, remote branches will be deleted if they are not also locally.
> ++
> +With `--new`, local branches that are not yet in the remote will be pushed too.
> ++
> +With `--all`, basically both `--prune` and `--new` will be selected.
> ++
> +With `--force`, existing branches will be forced to update, like `git push
> +--force`.
> ++
> +With `--dry-run`, all the changes will be reported, but not really happen.

Why is this in "git remote", and not "git push"?  The former is usually
about managing the configuration of remotes, not about actually doing
the ref transfer (the "-f" flag excepted, but that is clearly just
calling out to "fetch").

And how does this differ from "git push --mirror"? It looks like you
have more options for what pushing all versus pruning, but wouldn't it
be better for "git push" to grow those options?

-Peff
