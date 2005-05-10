From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Renaming environment variables.
Date: Mon, 09 May 2005 19:16:03 -0700
Message-ID: <7vy8anu8po.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505091847050.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 04:10:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVKCL-0005Yu-Hk
	for gcvg-git@gmane.org; Tue, 10 May 2005 04:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVEJCRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 22:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVEJCRA
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 22:17:00 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:64958 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261449AbVEJCQb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 22:16:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510021604.SPUB16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 May 2005 22:16:04 -0400
To: Daniel Barkalow <barkalow@iabervon.org>, Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0505091847050.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Mon, 9 May 2005 19:08:20 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

DB> While we're at it, it would be useful to have one for what is normally
DB> ".git", rather than just ".git/objects".

PB> I think it would be nice to have something like GIT_BASEDIR, which would
PB> default to .git, and the objects directory would then default to
PB> $GIT_BASEDIR/objects and the index file would default to
PB> $GIT_BASEDIR/index.

Although what I pushed out at git-jc repository does not have
this, it does not mean I forgot this issue you two have raised,
nor would want to veto it or anything like that.  Just that,
unlike the one that I already committed, the proposed change
would touch rather many lines and I have not managed to
determine the extent of the damage yet.

I am willing to make (or take) a separate patch to do this one,
since I agree with Petr's "currently we happen to have just two
but it would still be better to be able to set just one than
having to change both of them in sync." argument.

I am currently waiting for community consensus, including the
final name of the variable.  I think the current consensus is
that this is a good idea, the semantics for it is to name what
corresponds to the current "$(pwd)/.git" directory, use it to
build the default for GIT_INDEX_FILE and SHA1_FILE_DIRECTORY,
and this directory does _not_ have anything to do with my
previous "the directory that corresponds to the root of the tree
structure GIT_INDEX_FILE describes".  I agree to all of the
above.

