From: Junio C Hamano <junkio@cox.net>
Subject: Re: Remove "historical" objects from repository to save place
Date: Sat, 21 Jan 2006 13:46:20 -0800
Message-ID: <7vbqy5l0er.fsf@assigned-by-dhcp.cox.net>
References: <200601212218.51055.arvidjaar@mail.ru>
	<7v1wz1mjy8.fsf@assigned-by-dhcp.cox.net>
	<20060121200615.GM28365@pasky.or.cz>
	<7virsdl44q.fsf@assigned-by-dhcp.cox.net>
	<86slrhe270.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 22:46:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0QYz-00050V-Aq
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 22:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWAUVqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 16:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWAUVqX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 16:46:23 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12182 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932387AbWAUVqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 16:46:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121214506.YAIE6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 16:45:06 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86slrhe270.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "21 Jan 2006 12:49:39 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15023>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>
> Junio> Most likely what the original requestor cloned from Linus has
> Junio> been already packed so git-prune would not do much.
>
> Wait.  Does that mean that:
>
> $ git-checkout -b playground
> $ work work work
> $ git-commit -m 'snapshot'
> $ git-checkout -b master
> $ git-repack -a -d
>
> means that even if I do
>
> $ git-branch -d playground
> $ git-repack -a -d
>
> I still have the commit from playground as objects inside my one big pack?

Repack retraces from all the available refs, so that is fine.

Pasky was talking about prune, which is a different animal.
