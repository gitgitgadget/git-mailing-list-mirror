From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Don't create the $GIT_DIR/branches directory on init
Date: Sat, 31 Oct 2009 11:24:16 -0700
Message-ID: <20091031182416.GO10505@spearce.org>
References: <1256923228-18949-1-git-send-email-robin.rosenberg@dewire.com> <200910311011.31189.trast@student.ethz.ch> <7vr5sj8m5f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org, sasa.zivkov@sap.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 19:24:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Icm-0006UZ-9o
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 19:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867AbZJaSYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 14:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932816AbZJaSYM
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 14:24:12 -0400
Received: from george.spearce.org ([209.20.77.23]:39867 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932733AbZJaSYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 14:24:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 22A17381FF; Sat, 31 Oct 2009 18:24:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vr5sj8m5f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131849>

Junio C Hamano <gitster@pobox.com> wrote:
> Modern git Porcelains write remote definitions solely to .git/config, but
> still reads from .git/{branches,remotes}.
...
> Andrew Morton explicitly asked for this to be kept a few years
> ago and I do not see a reason to deprecate this.
...
>     Shawn and other wants to stop JGit from creating this directory on

I probably said something like this.  I won't bother denying it,
because list archives are more accurate than my own fallible memory.

But I didn't know the Andrew Morton part above.  After hearing it
from you, I'm reversing my (apparent) direction here.  We should
continue to create the branches directory within a new repository.

Sorry Robin, but Andrew Morton matters.  Its one stupid unused
directory in a repository that will chew through thousands of inodes
as loose objects.  Its a drop in the bucket in terms of resource
cost used by Git.  And Andrew is someone whose workflow we don't
want to break if we can avoid it.  He's a long time Git user who is
also high up in the kernel food chain.  Interrupting him disrupts
a fair chunk of kernel work while he grumbles about the Goddamn
Idiotic Truckload of s**t that Linus begat.

> This patch alone breaks tests in the t55?? series quite a lot,

Drop the patch.

-- 
Shawn.
