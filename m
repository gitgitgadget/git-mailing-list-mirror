From: Junio C Hamano <junkio@cox.net>
Subject: Re: getting rid of extra directories
Date: Sat, 15 Oct 2005 11:00:52 -0700
Message-ID: <7vu0fimzhn.fsf@assigned-by-dhcp.cox.net>
References: <20051015174103.GA2609@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 20:01:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQqLa-0001NR-5Q
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 20:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVJOSAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 14:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVJOSAy
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 14:00:54 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:60407 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751190AbVJOSAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 14:00:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051015180042.XUVN4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Oct 2005 14:00:42 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20051015174103.GA2609@tumblerings.org> (Zack Brown's message of
	"Sat, 15 Oct 2005 10:41:03 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10138>

Zack Brown <zbrown@tumblerings.org> writes:

> I've been using the latest Cogito. When I seek back and forth in a git repo,
> directories I've created tend to persist backward in time, cluttering up
> earlier versions.
>
> By the discussions on this list, I'm pretty sure there's a way to stop this,
> but I don't know clearly what it is, and I'm worried about trying things
> that might corrupt my repository. Could someone spell it out for me please?

I do not know exactly what Cogito "seek back and forth" does,
but updating to git-core "master" branch may help.

Specifically, this commit intends to remove empty directory from
the working tree, where previously checked out tree object had
files/directories inside while newly checked out tree does not.

    commit 340e4f88c083b0692e6554b1c2c27fd43c7cc8d3
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Mon Oct 10 17:34:08 2005 -0700

        Remove empty directories after read-tree -u.

        This fixes everybody's favorite gripe that switching branch
        with 'git checkout' leaves empty directories.

        Signed-off-by: Junio C Hamano <junkio@cox.net>
