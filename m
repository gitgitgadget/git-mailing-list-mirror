From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else
	fails.
Date: Mon, 22 Oct 2007 07:36:37 -0700
Message-ID: <20071022143637.GP16291@srparish.net>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net> <Pine.LNX.4.64.0710202258440.25221@racer.site> <20071021023614.GB14735@spearce.org> <Pine.LNX.4.64.0710212256270.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:37:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjyOh-0006YO-Ib
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 16:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbXJVOgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 10:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbXJVOgk
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 10:36:40 -0400
Received: from smtp-gw7.mailanyone.net ([208.70.128.55]:56056 "EHLO
	smtp-gw7.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbXJVOgj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 10:36:39 -0400
Received: from mailanyone.net
	by smtp-gw7.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjyOU-0005o5-3X; Mon, 22 Oct 2007 09:36:38 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Mon, 22 Oct 2007 07:36:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710212256270.25221@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62015>

On Sun, Oct 21, 2007 at 10:59:01PM +0100, Johannes Schindelin wrote:

> Earlier, we tried to find the git commands in several possible exec
> dirs.  Now, if all of these failed, try to find the git command in
> PATH.

I'm tempted to try a different approach. What if instead of looping
and building up strings of all the different absolute paths we want
to try we just prepend to PATH with the correct extra precedence,
and then call execvp on the command we want?

sRp

-- 
Scott Parish
http://srparish.net/
