From: Junio C Hamano <junkio@cox.net>
Subject: Re: killing a branch
Date: Tue, 10 Jan 2006 02:25:55 -0800
Message-ID: <7vr77g8jm4.fsf@assigned-by-dhcp.cox.net>
References: <20060110102207.GP3389@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 11:26:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwGhT-00045R-OR
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 11:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWAJKZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 05:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWAJKZ5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 05:25:57 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:29439 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751040AbWAJKZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 05:25:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110102323.CPFK20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 Jan 2006 05:23:23 -0500
To: Jens Axboe <axboe@suse.de>
In-Reply-To: <20060110102207.GP3389@suse.de> (Jens Axboe's message of "Tue, 10
	Jan 2006 11:22:07 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14415>

Jens Axboe <axboe@suse.de> writes:

> $ rm .git/refs/heads/branch-name
> $ git prune
>
> to rid myself of the branch and associated objects. Is there a faster
> approach?

Perhaps the "official" way is

	$ git branch -d branch-name ;# you may need -D
        $ git prune

but that essentially is the same as what you are doing.  Note
that having dangling objects in your repository is not a crime,
and you do not have to religiously do "git prune" every time.
