From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] In Examples, explain option -r and refer to
	git-rev-list[1]
Date: Mon, 27 Aug 2007 04:44:23 -0400
Message-ID: <20070827084423.GA19230@coredump.intra.peff.net>
References: <r6lqfgnp.fsf@cante.net> <46D28502.3030003@etek.chalmers.se> <7vy7fxl7hx.fsf@gitster.siamese.dyndns.org> <7vbqctl6ky.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>,
	Git Mailing List <git@vger.kernel.org>,
	Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:44:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPaCy-00007h-VM
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbXH0Io0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 04:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbXH0Io0
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:44:26 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4963 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbXH0IoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 04:44:25 -0400
Received: (qmail 29471 invoked by uid 111); 27 Aug 2007 08:44:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 27 Aug 2007 04:44:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2007 04:44:23 -0400
Content-Disposition: inline
In-Reply-To: <7vbqctl6ky.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56784>

On Mon, Aug 27, 2007 at 01:33:49AM -0700, Junio C Hamano wrote:

> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -258,6 +258,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
>  	git_config(git_log_config);
>  	init_revisions(&rev, prefix);
>  	rev.always_show_header = 1;
> +	rev.diffopt.recursive = 1;
>  	cmd_log_init(argc, argv, prefix, &rev);
>  	return cmd_log_walk(&rev);
>  }

This should perhaps rather go in cmd_log_init (and be removed from
cmd_show and cmd_whatchanged). I think this is semantically a little
more clear, and the change will affect other log porcelains (right now
just "git-reflog --name-status", but also new ones if they are added).

But yes, this is post-1.5.3, so I will shut up rather than nitpicking
your "not meant to be applied now" patches.

-Peff
