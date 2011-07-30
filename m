From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] commit: allow partial commits with relative paths
Date: Sat, 30 Jul 2011 19:00:45 +0200
Message-ID: <20110730170045.GA9900@toss.lan>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
 <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net>
 <20110729133551.GA8707@toss.lan>
 <4E343534.8000604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Reuben Thomas <rrt@sc3d.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Jul 30 19:00:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnCuE-000728-2y
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 19:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab1G3RAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 13:00:50 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:28436 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752134Ab1G3RAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 13:00:49 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 82BE22C400E;
	Sat, 30 Jul 2011 19:00:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E343534.8000604@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178214>

On Sat, Jul 30, 2011 at 06:45:40PM +0200, Michael J Gruber wrote:
> 
> > With your permission I am stealing your commit message.
> 
> I don't care about the message but don't see the point of this patch.
> Using the same message certainly won't explain the difference...

Well, to be fair I did add to your message, explaining what I did.

The point of providing a prefix at all is performance optimization.
If you say there is no common prefix for the files of interest,
then you cannot leave any files out and you have to read the entire
tree into the index.

But even if we cannot use the working directory as a prefix, we can
still figure out if there is a common prefix for all given paths,
and use that instead. I merely copied that idea from ls-tree.

And considering that most of my patch the almost verbatim move of a
function from one file to another, I think my change is not that
big:

> >  4 files changed, 39 insertions(+), 38 deletions(-)

Clemens
