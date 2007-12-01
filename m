From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] builtin-commit: Add newline when showing which
	commit was created
Date: Sat, 1 Dec 2007 17:21:06 -0500
Message-ID: <20071201222106.GA27102@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site> <Pine.LNX.4.64.0711111736440.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 01 23:21:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyaiJ-0004hL-AB
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 23:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbXLAWVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 17:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXLAWVL
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 17:21:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2984 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbXLAWVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 17:21:11 -0500
Received: (qmail 17420 invoked by uid 111); 1 Dec 2007 22:21:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Dec 2007 17:21:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2007 17:21:06 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711111736440.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66740>

On Sun, Nov 11, 2007 at 05:36:52PM +0000, Johannes Schindelin wrote:

> The function log_tree_commit() does not break the line, so we have to
> do it ourselves.

Johannes,

Can you explain the rationale for this change in more detail?

When I run builtin-commit from the tip of next, I always get an extra
newline (as compared to the shell behavior):

-- >8 --
$ git version &&
  mkdir test && cd test && git init &&
  touch file && git add file && git commit -m added &&
  echo content >file && git commit -a -m updated &&
  echo done
git version 1.5.3.6.2090.g4ece0
Initialized empty Git repository in .git/
Created initial commit b3cbe63: added
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file

Created commit 7a6b446: updated
 1 files changed, 1 insertions(+), 0 deletions(-)

done
-- 8< --

where the shell behavior omits the extra newlines. Is there some other
input for which log_tree_commit actually needs the newline?

-Peff
