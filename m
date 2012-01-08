From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Sun, 8 Jan 2012 23:19:48 +0100
Message-ID: <20120108221946.GA22680@ecki.lan>
References: <20120108213134.GA18671@ecki.lan>
 <m3r4z9eu36.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 23:28:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk1Dq-0000ob-D9
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 23:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645Ab2AHW2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 17:28:06 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:57018 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754602Ab2AHW2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 17:28:05 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 5FAAD2C4003;
	Sun,  8 Jan 2012 23:28:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3r4z9eu36.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188147>

On Sun, Jan 08, 2012 at 01:57:03PM -0800, Jakub Narebski wrote:
> 
> > In order to determine a suitable range automatically, it is a reasonable
> > heuristic to rebase onto the most recent merge commit.
> 
> Why not additionally / instead take into account remote-tracking
> branches for "push" remotes?

For me personally, remote-tracking does not work. I frequently branch
locally, and even if I do branch from a remote branch, it's often not
from a public branch, but rather my own private branch that I
synchronize between repos and machines. So my remote-tracking
configuration is usually an awful mess, and it does not feel like fixing
it up manually would be worth the trouble.

As a result, I don't trust remote-tracking and I do not use any of the
features associated with it. For my uses of rebase --fix it would
therefore be counter-productive to consider remote-tracking information.

What I did consider was adding a comment to the list of "pick <commit>"
that interactive rebase offers saying:

# older commits are already contained in the current upstream branch

Also, I often rewrite commits that are also contained in other branches.
That typically happens when I am reworking a topic that has already been
tested extensively. In that case I like to keep the original branch
around for reference, even if I end up not using it eventually.
