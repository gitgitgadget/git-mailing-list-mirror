From: Pavel Roskin <proski@gnu.org>
Subject: Re: gitk shows an empty line between "Comments" and changed files
Date: Thu, 27 Oct 2005 21:36:29 -0400
Message-ID: <1130463389.2186.14.camel@dv>
References: <1130434230.19641.21.camel@dv>
	 <7vslum3l2w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 03:37:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVJAb-0008QN-Mp
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 03:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVJ1Bge (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 21:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVJ1Bge
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 21:36:34 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:62689 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965042AbVJ1Bgd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 21:36:33 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EVJAW-00076e-Ee
	for git@vger.kernel.org; Thu, 27 Oct 2005 21:36:32 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EVJAT-0004om-No; Thu, 27 Oct 2005 21:36:29 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslum3l2w.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10736>

Hi, Junio!

On Thu, 2005-10-27 at 10:51 -0700, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > Or maybe the SHA1 header should never be printed at all?  It looks like
> > it's not documented anywhere.  It doesn't break the tests.
> 
> AFAIK, its only user (except humans) is patch-id.

Thank you for reply!  git-patch-id is badly documented, and its output
is not documented at all.  It outputs two SHA1 hashes, and the second
one is taken from the line produced by git-diff-tree.  If there is no
such line, the second ID is 0.

git-patch-id is only used by git-cherry.  git-cherry writes the second
SHA1 to some files in a temporary directory, but it never reads those
files, it only checks that they exist.

I'm pretty confident now that the patch I posted in the last message was
correct.

Of course, more cleanup will be needed to remove the second ID from
git-patch-id, to adjust git-cherry accordingly and to remove "p"
assignments in gitk.

-- 
Regards,
Pavel Roskin
