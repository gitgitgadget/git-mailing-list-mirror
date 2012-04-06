From: Jeff King <peff@peff.net>
Subject: Re: Status shows untracked directory without any untracked file in it
Date: Fri, 6 Apr 2012 17:59:56 -0400
Message-ID: <20120406215956.GA31207@sigill.intra.peff.net>
References: <CAGAhT3n3hHV+UhT+D1o60OAS23WFmx+Lxg=aqYMGC=U-LR1QUA@mail.gmail.com>
 <4F7F3CBB.8030805@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Kostikov <alex.kostikov@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 00:00:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGHCQ-0004sq-Nw
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 00:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757791Ab2DFV77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 17:59:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52796
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755281Ab2DFV77 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 17:59:59 -0400
Received: (qmail 12504 invoked by uid 107); 6 Apr 2012 22:00:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 18:00:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 17:59:56 -0400
Content-Disposition: inline
In-Reply-To: <4F7F3CBB.8030805@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194915>

On Fri, Apr 06, 2012 at 08:58:03PM +0200, Johannes Sixt wrote:

> Am 06.04.2012 07:19, schrieb Alexander Kostikov:
> >How that is possible? Is it a bug?
> 
> I don't think so. git status normally does not look inside
> directories that do not contain any tracked files.

I think it does:

  $ git init tmp && cd tmp
  $ echo content >tracked
  $ git add tracked
  $ mkdir untracked

  $ git status --untracked-files=normal
  # On branch master
  #
  # Initial commit
  #
  # Changes to be committed:
  #       new file:   tracked
  #

  $ >untracked/file
  $ git status --untracked-files=normal
  # On branch master
  #
  # Initial commit
  #
  # Changes to be committed:
  #       new file:   tracked
  #
  # Untracked files:
  #       untracked/

-Peff
