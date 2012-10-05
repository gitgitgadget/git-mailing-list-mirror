From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: erratic behavior commit --allow-empty
Date: Fri, 5 Oct 2012 08:15:12 +0000 (UTC)
Message-ID: <loom.20121004T190952-797@post.gmane.org>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com> <506AA51E.9010209@viscovery.net> <7vzk449449.fsf@alter.siamese.dyndns.org> <CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com> <CABURp0pbX4Fk4sNWCicfF7Gm52-KTMBrasdi_XHnjtE2zmSBFg@mail.gmail.com> <CAB9Jk9CdYXZzPcM=YiwOUyKNQ=4uKpfs+HY7WpWBmqgQRw4SyA@mail.gmail.com> <CAJsNXTm5uhWYB+oiz=3WQQKFQ=i=+oO0L6cgGBB+2cm5BgfFCg@mail.gmail.com> <CAB9Jk9D5c-7QKkUFtur4rxBfiaPFzGaMi-+m=Owje_Aaoc6XJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 11:40:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK4OI-0005FF-H4
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 11:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab2JEJkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 05:40:06 -0400
Received: from plane.gmane.org ([80.91.229.3]:50203 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755058Ab2JEJkF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 05:40:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TK4O4-00053v-27
	for git@vger.kernel.org; Fri, 05 Oct 2012 11:40:04 +0200
Received: from host-188-174-201-193.customer.m-online.net ([188.174.201.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 11:40:03 +0200
Received: from lars by host-188-174-201-193.customer.m-online.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 11:40:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.174.201.193 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207092>

Angelo Borsotti <angelo.borsotti <at> gmail.com> writes:
> take a git commit without --allow-empty: if the trees are equal, it
> creates no commit,
> and if the trees are different it creates one.
> Take then a git commit --allow-empty: if the trees are equal it may
> create a commit or
> not depending on the parent, message, author and date; if the trees
> are different it
> creates a commit.
> So, the statement does not apply to commits in general.

It does (as already shown to you). The ID of a commit object depends on
the author, the time, the tree, and the commit message (did I forget
something?). If all these are equal, no new physical object will be
created.

Independent of this: If you are on a branch "foo" pointing to a commit A
and successfully do a commit (with --allow-empty or not), "foo" will
afterwards point to a commit B different from A. So, a successful
"git commit (--allow-empty)" will always add a commit to the branch
you are on.

  -- Lars.
