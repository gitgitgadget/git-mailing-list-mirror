From: Junio C Hamano <junkio@cox.net>
Subject: Re: git clone rsync:... ?
Date: Mon, 11 Jul 2005 15:11:23 -0700
Message-ID: <7v4qb1ouwk.fsf@assigned-by-dhcp.cox.net>
References: <20050711213050.GA18693@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 00:13:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds6Wt-0004r5-NB
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 00:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVGKWMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 18:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVGKWMo
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 18:12:44 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46214 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262756AbVGKWL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 18:11:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711221122.DZU8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 18:11:22 -0400
To: Marc Singer <elf@buici.com>
In-Reply-To: <20050711213050.GA18693@buici.com> (Marc Singer's message of "Mon, 11 Jul 2005 14:30:50 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marc Singer <elf@buici.com> writes:

>   elf@florence /git > git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
>   defaulting to local storage area
>   ssh: rsync: Name or service not known
>   fatal: unexpected EOF

Hmph.  "git clone rsync://rsync.kernel.org/pub/scm/git/git.git git.git"
seems to work so does the exact command you show above.  Is it
possible that you are running git-clone-script from an older Git?

> Moreover, I'd like to be able to
> keep one repo that is just pulling from the net and then clone it for
> different working directories.

That is a sane thing to ask.  Assuming you have solved the above
problem:

    $ ls
    linux-2.6
    $ git clone -l linux-2.6 linux-ms
    $ git clone -l linux-2.6 linux-ms-net
    $ git clone -l linux-2.6 linux-ms-ide
    $ git clone -l linux-2.6 linux-ms-usb

would make local clones of vanilla linux-2.6 repo you locally
have ("-l" knows to use hardlinks when possible).
