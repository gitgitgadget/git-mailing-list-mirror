From: Junio C Hamano <junkio@cox.net>
Subject: Re: Clean up sha1 file writing
Date: Wed, 24 May 2006 13:46:58 -0700
Message-ID: <7vslmz5ewt.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 22:47:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj0G1-0005Ie-Jh
	for gcvg-git@gmane.org; Wed, 24 May 2006 22:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWEXUrB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 16:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWEXUrB
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 16:47:01 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:17614 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932381AbWEXUrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 16:47:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524204659.VVGH19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 16:46:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 24 May 2006 08:30:54 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20704>

Linus Torvalds <torvalds@osdl.org> writes:

> ... On the other hand, from a longer-term 
> maintenance standpoint and from a "be much more careful when doing file 
> writes" standpoint, I think it's worth it.
>
> The re-write is "obviously correct" (famous last words) and is mostly 
> just moving code around and getting rid of a few temporaries that become 
> unnecessary as a result.
>
> The patch looks a bit messy: the changes aren't actually that big, but the 
> split-up and the resulting re-indentation makes the patch fairly 
> unreadable, so the cleanups are more obvious when you look at the 
> before-and-after side by side rather than when looking at the unified 
> diff..)

I usually work in text-only terminal, but with the above
warning, I did this:

	git cat-file -p HEAD^:sha1_file.c >/var/tmp/1
        xxdiff /var/tmp/1 sha1_file.c
        
with ignorespace and stuff enabled.  It was very pleasant to
read the changes that way, especially around write_sha1_to_fd()
vs repack_object().  xxdiff is my new friend.
