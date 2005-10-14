From: Junio C Hamano <junkio@cox.net>
Subject: Peeling the onion
Date: Thu, 13 Oct 2005 23:03:13 -0700
Message-ID: <7voe5sws7y.fsf_-_@assigned-by-dhcp.cox.net>
References: <7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<7v3bnra20z.fsf@assigned-by-dhcp.cox.net> <43348086.2040006@zytor.com>
	<20050924011833.GJ10255@pasky.or.cz>
	<20050926212536.GF26340@pasky.or.cz>
	<7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<20050926222944.GG26340@pasky.or.cz>
	<7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net>
	<8764snyufn.fsf@ualberta.net>
	<7v4q875bbj.fsf@assigned-by-dhcp.cox.net>
	<20050927094029.GA30889@pasky.or.cz>
	<7v64sm30dh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509271020530.3308@g5.osdl.org>
	<7v64sm1hp3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509271414000.3308@g5.osdl.org>
	<7virwlumyo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Tom Prince <tom.prince@ualberta.net>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Oct 14 08:04:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQIfN-0003Mv-Ju
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 08:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVJNGDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 02:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVJNGDP
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 02:03:15 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:59899 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932187AbVJNGDP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 02:03:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051014060249.PUPS2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Oct 2005 02:02:49 -0400
To: git@vger.kernel.org
In-Reply-To: <7virwlumyo.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 28 Sep 2005 10:22:07 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10102>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>>> we could send phony entries like this:
>>> 
>>> b92c9c07fe2d0d89c4f692573583c4753b5355d2	deref/tags/junio-gpg-pub
>>> a3eb250f996bf5e12376ec88622c4ccaabf20ea8	deref/tags/v0.99
>>> 78d9d414123ad6f4f522ffecbcd9e4a7562948fd	deref/tags/v0.99.1
>>
>> Yes, it would work,..
>> in general, it's just a really ugly special case, I think.
>
> I think we could do this instead, to make it less ugly.
>
> ...
>
> The alternative would be what Pasky outlined in his message --
> bypassing git transport layer to fetch single object by hand,
> repeatedly dereferencing it until he gets a non-tag.  I think
> that is unnecessary misery for him.

I did not hear much from the people involved since this message,
but I have a bit less ugly solution along the lines outlined
above, in the proposed updates branch.  Incidentally this would
also simplify Martin's git-findtags, especially if we do not
worry about its '-t' option.

I'll be sending 3-patch series; the first two are preparatory
but what may be useful for Pasky and Martin is in the third
one.

    [PATCH] Ignore funny refname sent from remote.
    [PATCH] Introduce notation "ref^{type}".
    [PATCH] Show peeled onion from upload-pack and server-info.
