From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] diff.c: locate_size_cache() fix.
Date: Sun, 5 Jun 2005 22:40:47 +0200
Message-ID: <20050605204047.GQ17462@pasky.ji.cz>
References: <7vwtpairlm.fsf@assigned-by-dhcp.cox.net> <7v64wuk694.fsf@assigned-by-dhcp.cox.net> <7vekbik6c0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 22:38:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df1sB-0006tv-Rz
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 22:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVFEUk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 16:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVFEUk7
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 16:40:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32417 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261610AbVFEUkt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 16:40:49 -0400
Received: (qmail 30816 invoked by uid 2001); 5 Jun 2005 20:40:47 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <7vwtpairlm.fsf@assigned-by-dhcp.cox.net> <7v64wuk694.fsf@assigned-by-dhcp.cox.net> <7vekbik6c0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> This fixes two bugs.
> 
>  - declaration of auto variable "cmp" was preceeded by a
>    statement, causing compilation error on real C compilers;
>    noticed and patch given by Yoichi Yuasa.
> 
>  - the function's calling convention was overloading its size
>    parameter to mean "largest possible value means do not add
>    entry", which was a bad taste.  Brought up during a
>    discussion with Peter Baudis.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

> This fixes a bug that was preventing non-default parameter to -B
> option to be passed correctly; you could not give more than 50%
> break score.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

> This fixes three bugs in the -B heuristics.
> 
>  - Although it was advertised that the initial break criteria
>    used was the same as what diffcore-rename uses, it was using
>    something different.  Instead of using smaller of src and dst
>    size to compare with "edit" size, (insertion and deletion),
>    it was using larger of src and dst, unlike the rename/copy
>    detection logic.  This caused the parameter to -B to mean
>    something different from the one to -M and -C.  To compensate
>    for this change, the default break score is also changed to
>    match that of the default for rename/copy.
> 
>  - The code would have crashed with division by zero when trying
>    to break an originally empty file.
> 
>  - Contrary to what the comment said, the algorithm was breaking
>    small files, only to later merge them together.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

  Hello,

  what's up with those three fixes? Were they pointed out to be wrong
and thrown away in another thread, are they on hold or just dropped?
Should I just apply them to git-pb?

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
