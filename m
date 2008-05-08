From: Jeff King <peff@peff.net>
Subject: Re: mismatch between doc and program in git commit -u
	(--untracked-files)
Date: Thu, 8 May 2008 12:13:42 -0400
Message-ID: <20080508161342.GB28701@sigill.intra.peff.net>
References: <2e24e5b90805080310p2cb77814i45a418a0cfc8a2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 18:15:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju8ld-0001wY-Bl
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 18:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517AbYEHQNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 12:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756069AbYEHQNl
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 12:13:41 -0400
Received: from peff.net ([208.65.91.99]:3149 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483AbYEHQNk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 12:13:40 -0400
Received: (qmail 4199 invoked by uid 111); 8 May 2008 16:13:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 12:13:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 12:13:42 -0400
Content-Disposition: inline
In-Reply-To: <2e24e5b90805080310p2cb77814i45a418a0cfc8a2c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81535>

On Thu, May 08, 2008 at 03:40:14PM +0530, Sitaram Chamarty wrote:

> The doc for commit says "-u" is a suitable abbreviation for
> --untracked-files, but only the latter works.
> 
> I'll submit a patch, but being new, I thought I'd ask which is correct
> -- the doc or the code?

Looks like it got lost in the C rewrite of git-commit:

  $ git grep untracked-files builtin-commit.c
  builtin-commit.c:       OPT_BOOLEAN(0, "untracked-files", &untracked_files, "show all untracked files"),

  $ git grep -B2 contrib/examples/git-commit.sh
  contrib/examples/git-commit.sh- -u|--u|--un|--unt|--untr|--untra|--untrac|--untrack|--untracke|\
  contrib/examples/git-commit.sh- --untracked|--untracked-|--untracked-f|--untracked-fi|--untracked-fil|\
  contrib/examples/git-commit.sh: --untracked-file|--untracked-files)

So it should probably be supported. The patch is a one-liner, but I'll
leave it as an exercise for you. :)

-Peff
