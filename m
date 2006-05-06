From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Git wiki
Date: Sat, 06 May 2006 00:14:06 -0700
Message-ID: <7v7j4zvd4x.fsf@assigned-by-dhcp.cox.net>
References: <20060505005659.9092.qmail@science.horizon.com>
	<20060505181540.GB27689@pasky.or.cz>
	<Pine.LNX.4.64.0605051123420.3622@g5.osdl.org>
	<20060505185445.GD27689@pasky.or.cz>
	<7vr738w8t4.fsf@assigned-by-dhcp.cox.net>
	<46a038f90605052353m2d2aca11weac7efee80c6fb35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 06 09:14:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcGzU-0003v0-Fz
	for gcvg-git@gmane.org; Sat, 06 May 2006 09:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWEFHOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 03:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWEFHOJ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 03:14:09 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36086 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751253AbWEFHOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 03:14:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060506071407.UXLQ25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 May 2006 03:14:07 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605052353m2d2aca11weac7efee80c6fb35@mail.gmail.com>
	(Martin Langhoff's message of "Sat, 6 May 2006 18:53:36 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19651>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> I agree here with Pasky that after a while the automated
> renames/copy/splitup detection will miss the operation in cases where
> it would be interesting to note it to the user. IIRC git-rerere is the
> tool that knows about this (still voodoo to me how) and could be used
> to help here. At what (runtime) cost, I don't know, but that kind of
> walking history to tell me more interesting things about the diff is
> something that is usually worthwhile.

FYI rerere is a totally unrelated voodoo.

It remembers the conflict marker pattern <<< === >>> immediately
after it runs "merge" (ah, that reminds me -- I should replace
them with diff3), and then remembers the result of the manual
resolution just before the user makes a commit.  Then, when next
time it runs "merge" for something and notices <<< === >>>
pattern it has seen before, it runs a three-way merge between
the previous resolution result and the current conflicted state,
using the previous conflicted state as the common origin.
