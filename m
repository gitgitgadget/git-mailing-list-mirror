From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk graph routing problem
Date: Wed, 12 Dec 2007 09:26:10 +1100
Message-ID: <18271.3714.731136.272491@cargo.ozlabs.ibm.com>
References: <20071104104618.GA3078@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 00:14:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2EIf-00029a-0f
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 00:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbXLKXNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 18:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbXLKXNo
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 18:13:44 -0500
Received: from ozlabs.org ([203.10.76.45]:43762 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472AbXLKXNn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 18:13:43 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9CFE8DDECA; Wed, 12 Dec 2007 10:13:42 +1100 (EST)
In-Reply-To: <20071104104618.GA3078@steel.home>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67966>

Alex Riesen writes:

> To reproduce, try running in git repo:
> 
>     gitk 02f630448e5d48e..06ea6ba9cf46ef5
> 
> Than go some pages (around 5) forward. You should notice system load
> going up rapidly. Now try paging back - and graph starts stretching
> to the right, to the point nothing fits on the screen anymore.

I finally got back to look at this.  The problem is not so much the
layout algorithm per se as the fact that I haven't worked out a good
way to pack lots of downward-pointing arrows in without using up
arbitrarily large amounts of horizontal space.  You have managed to
find an example where just about every commit is a merge needing one
or more downward-pointing arrows.

Incidentally, gitk from the dev branch of my gitk.git repo does much
better on this example, since it is able to hoist the open-circle
(excluded) commits up to the row below their merge children, which
looks much nicer.

Paul.
