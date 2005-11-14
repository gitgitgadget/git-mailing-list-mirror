From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] GIT commit statistics.
Date: Mon, 14 Nov 2005 21:51:29 +1300
Message-ID: <46a038f90511140051o1fa5ef7cyb9dd723fb8161ef9@mail.gmail.com>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	 <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	 <43758D21.3060107@michonline.com>
	 <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
	 <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
	 <7vy83s95k0.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90511131242p4692c74fn20c015998620b9f4@mail.gmail.com>
	 <7vlkzr6gzz.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90511132001x6a9109fk17593b7ceaf3177e@mail.gmail.com>
	 <7vwtjb4vc4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 09:54:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eba4a-0001v1-JG
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 09:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVKNIva (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 03:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVKNIva
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 03:51:30 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:7668 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750998AbVKNIva convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 03:51:30 -0500
Received: by zproxy.gmail.com with SMTP id 40so1058927nzk
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 00:51:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gd2YaJoR7rV6VhpV6WmRaPdPeZBoTY1NWSxIIJiWimfgJcS+WIWVe34+/xBkuwGiSIILR4mW6BnK2vSEP1GFAhKRjCwJKyXIkX7Es0eJol4BxRTKthOsQuSuPwSbLaeJDfnH+Gl/9GX/rgDU9/25rEK5a5RC/inFv8Pusw6mndg=
Received: by 10.64.131.4 with SMTP id e4mr2491669qbd;
        Mon, 14 Nov 2005 00:51:29 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Mon, 14 Nov 2005 00:51:29 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vwtjb4vc4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11773>

On 11/14/05, Junio C Hamano <junkio@cox.net> wrote:
> It shouldn't be too tricky to enhance "git am" (git-apply called
> at around line 49 in it) to grok binary differences for this
> purpose, because you would have both pre- and post-image blob in
> your object database, because the patch is being used only to
> replay what you have in your reository, and it records their
> abbreviated SHA1 name.

I'm curious. What would be the advantages of this over git-read-tree
-m for use within a single repo? I keep thinking that I need an
intra-repo way of doing it (arguably faster and more reliable),
instead of git-format-patch|git-am, which is less reliable and slower.

OTOH,  if this is heading towards teaching git-am how to apply changes
to binary files based on known SHA1s, this will give birth to a type
of patch that applies only if you have the objects beforehand. Is that
enough to get by? Perhaps we need a format to fully describe binary
files?

> I've never felt need to "merge" the binary files myself and had
> never got around doing this, but if you are interested, it would
> go something like this:

That's quite a bit of C hacking... I'm game for all the Perl and shell
scripts in git, but I know better than start learning C in _this_
project with you, Linus and the whole list watching me make the fool
;-)

So noone hacks this bit of C you are proposing I'll eventually get
something done with cg-update and git-rebase.

In the meantime, the user experience of working with a small team and
a shared repo has improved significantly by switching from cg-update
to cg-fetch && git-rebase origin. So much so that I suspect that it'd
be a big win for cg-update to default to rebase on merges from
'origin'.

cheers,


martin
