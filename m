From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't propagate SKIPPED warning to future commits.
Date: Fri, 10 Feb 2006 18:21:30 -0800
Message-ID: <7vpslutz2t.fsf@assigned-by-dhcp.cox.net>
References: <87r76avfhz.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 03:21:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7kOF-0006Sr-7q
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 03:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWBKCVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 21:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWBKCVc
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 21:21:32 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52669 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932085AbWBKCVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 21:21:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211021852.STUH26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 21:18:52 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87r76avfhz.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	10 Feb 2006 17:41:28 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15917>

Carl Worth <cworth@cworth.org> writes:

> Here's a simple bug fix for the (currently undocumented) -S flag to
> git-cvsimport.
>
> The -S flag allows an import to proceed in the face of a missing ,v
> file in the CVS repository. It marks this by adding a SKIPPED warning
> in the relevant commit.
>
> Without this patch, the SKIPPED warning propagates to all future
> commits, (and accumulates with future SKIPPED warnings).

I might be missing something fundamental, but isn't prapagating
the warning a good thing?  If an earlier commit is suspected to
lack some path that needs to be there (I think that is what
"missing ,v file" means), wouldn't later commits built on top of
that one be by definition missing that path?
