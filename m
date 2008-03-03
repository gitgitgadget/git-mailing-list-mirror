From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Redirect stderr to a pipe before redirecting stdout to stderr
Date: Mon, 3 Mar 2008 02:33:07 -0500
Message-ID: <20080303073307.GG8410@spearce.org>
References: <20080303082111.24d3ea73.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Xavier Maillard <xma@gnu.org>,
	git@vger.kernel.org, nanako3@bluebottle.com, pascal@obry.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:33:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW5BO-0004l8-7O
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 08:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbYCCHdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 02:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbYCCHdT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 02:33:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60669 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbYCCHdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 02:33:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JW5Aa-00056K-Pr; Mon, 03 Mar 2008 02:33:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 411B520FBAE; Mon,  3 Mar 2008 02:33:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080303082111.24d3ea73.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75902>

Christian Couder <chriscool@tuxfamily.org> wrote:
> With this patch, in the 'start_command' function after forking
> we now take care of stderr in the child process before stdout.
> 
> This way if 'start_command' is called with a 'child_process'
> argument like this:
> 
> 	.err = -1;
> 	.stdout_to_stderr = 1;
> 
> then stderr will be redirected to a pipe before stdout is
> redirected to stderr. So we can now get the process' stdout
> from the pipe (as well as its stderr).

I'm in favor of this patch.  My series to add sideband support
to send-pack/receive-pack (aka push) needed it for the hooks.

-- 
Shawn.
