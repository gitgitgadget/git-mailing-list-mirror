From: Junio C Hamano <junkio@cox.net>
Subject: Re: branch.pu.forcefetch
Date: Wed, 27 Dec 2006 13:14:44 -0800
Message-ID: <7vfyb159dn.fsf@assigned-by-dhcp.cox.net>
References: <1167251519.2247.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 22:14:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzg6r-0006Yo-Nt
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 22:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWL0VOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 16:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbWL0VOq
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 16:14:46 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42695 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663AbWL0VOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 16:14:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227211444.HMWY7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 16:14:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3xEy1W0031kojtg0000000; Wed, 27 Dec 2006 16:14:58 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1167251519.2247.10.camel@dv> (Pavel Roskin's message of "Wed, 27
	Dec 2006 15:31:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35481>

Pavel Roskin <proski@gnu.org> writes:

> For example, I clone the git repository anew, and I try to update it by
> git-fetch a few days later.  I get an error:
>
> * refs/remotes/origin/pu: not updating to non-fast forward branch 'pu'
> of git://www.kernel.org/pub/scm/git/git

Perhaps you would want something like this?

if you are using separate remote layout:

[remote "origin"]
	fetch = +refs/heads/pu:refs/remotes/origin/pu
	fetch = refs/heads/*:refs/remotes/origin/*

Or traditional layout:

[remote "origin"]
	fetch = refs/heads/master:refs/heads/origin
	fetch = refs/heads/next:refs/heads/next
	fetch = refs/heads/maint:refs/heads/maint
	fetch = +refs/heads/pu:refs/remotes/pu
