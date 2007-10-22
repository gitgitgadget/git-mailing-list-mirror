From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH] "git help -a" should search all exec_paths and PATH
Date: Sun, 21 Oct 2007 23:32:01 -0700
Message-ID: <20071022063201.GN16291@srparish.net>
References: <20071021214846.GI16291@srparish.net> <20071022053016.GN14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 08:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijqpm-0000D8-Vb
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 08:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbXJVGcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 02:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbXJVGcG
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:32:06 -0400
Received: from smtp-gw6.mailanyone.net ([208.70.128.57]:53483 "EHLO
	smtp-gw6.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbXJVGcF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 02:32:05 -0400
Received: from mailanyone.net
	by smtp-gw6.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjqpW-0004LQ-Lm; Mon, 22 Oct 2007 01:32:03 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 21 Oct 2007 23:32:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071022053016.GN14735@spearce.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61954>

On Mon, Oct 22, 2007 at 01:30:17AM -0400, Shawn O. Pearce wrote:

> fchdir() isn't as portable as Git currently is.  Thus far we have
> avoided using fchdir().  Requiring it here for something as "simple"
> as listing help is not a good improvement as it will limit who can
> run git-help.  Why can't you stat the individual entries by joining
> the paths together?

I hadn't realized it wasn't portable, but i do see that there's no POSIX
entry in its man page. I was actually looking to use getcwd, but its
man page had suggested using this open()/fchdir() method.

Anyway, is there a reason to avoid changing the directory? If not
i'm tempted to take the approach that j.sixt suggested--not restoring
the cwd since we're exiting anyway. I don't have any good reason
to not do the string manipulation, but why do something more
complicated then necessary?

sRp

-- 
Scott Parish
http://srparish.net/
