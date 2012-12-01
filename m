From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH 0/5] ignore SIG{INT,QUIT} when launching editor
Date: Sat, 1 Dec 2012 13:34:37 +0100
Message-ID: <20121201123437.GA10287@shrek.podlesie.net>
References: <20121130223943.GA27120@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Paul Fox <pgf@foxharp.boston.ma.us>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 01 13:34:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TemHY-0005Ha-SN
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 13:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab2LAMel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 07:34:41 -0500
Received: from shrek-wifi.podlesie.net ([93.179.225.50]:60663 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab2LAMel (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 07:34:41 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id BDA279C; Sat,  1 Dec 2012 13:34:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121130223943.GA27120@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210967>

On Fri, Nov 30, 2012 at 05:39:43PM -0500, Jeff King wrote:
> This is a re-roll of the pf/editor-ignore-sigint series.
> 
> People mentioned some buggy editors which go into an infinite EIO loop
> when their parent dies due to SIGQUIT. That should be a non-issue now,
> as we will be ignoring SIGQUIT. And even if you could replicate it
> (e.g., with another signal) those programs should be (and reportedly
> have been) fixed. It is not git's job to babysit its child processes.
> 

Also some good editors printed error message after they got EIO,
confusing the user.

Looks good to me. I've tested this with ed (always ignores SIGINT
and SIGQUIT), vim (always ignores SIGINT, but dies after three
SIGQUIT) and "sleep" (dies after SIGINT and SIGQUIT) and git works now
as expected. Doing what editor does is probably the best thing to do. 

Tested-by: Krzysztof Mazur <krzysiek@podlesie.net>


Thanks,

Krzysiek
