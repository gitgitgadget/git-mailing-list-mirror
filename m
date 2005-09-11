From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-clone seems dead
Date: Sun, 11 Sep 2005 12:04:07 -0700
Message-ID: <7vd5nfs9y0.fsf@assigned-by-dhcp.cox.net>
References: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 21:04:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEX7m-0002fV-Hy
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 21:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVIKTEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 15:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVIKTEM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 15:04:12 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:12935 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750706AbVIKTEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 15:04:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911190408.NET20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 15:04:08 -0400
To: Peter Eriksen <s022018@student.dtu.dk>
In-Reply-To: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk> (Peter Eriksen's message of
	"11 Sep 2005 20:13:24 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8321>

Peter Eriksen <s022018@student.dtu.dk> writes:

> All commands works fine except "git clone" which prints:
>
> <cite>
> defaulting to local storage area
> * git clone [-l [-s]] [-q] [-u <upload-pack>] <repo> <dir>
> </cite>
>
> and leaves my-git/.git empty.  So the problem is, that I can't
> get "git clone" to work, and I think, I am making correct steps.

Hmph.  All your steps seem sane, and after removing my git
installation on one of my machines I tried the exact steps as
above but did not get this.

The message 'defaulting to local storage area' comes from git-init-db,
and '* git clone ...' comes from usage.

    dir="$2"
    mkdir "$dir" &&
    D=$(
            (cd "$dir" && git-init-db && pwd)
    ) &&
    test -d "$D" || usage

If you had my-git directory you would get the usage but not
'defaulting...', so that is not it.  The only possibility I
could think of is your 'pwd' says something different than the
working directory name?  I am very confused..
