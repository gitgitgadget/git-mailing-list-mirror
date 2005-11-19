From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Sat, 19 Nov 2005 12:42:01 -0800
Message-ID: <7vu0e84bfq.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	<Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>
	<cda58cb80511170236p4a7e2baay@mail.gmail.com>
	<Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>
	<cda58cb80511171347yef4f090g@mail.gmail.com>
	<Pine.LNX.4.64.0511171443000.13959@g5.osdl.org>
	<cda58cb80511190423w1e46bf5bu@mail.gmail.com>
	<437F1E67.8020302@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 21:42:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdZXF-0008Nq-9s
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 21:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVKSUmE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 Nov 2005 15:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVKSUmE
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 15:42:04 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:65203 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750819AbVKSUmD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 15:42:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119204125.LBRF20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Nov 2005 15:41:25 -0500
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
In-Reply-To: <437F1E67.8020302@etek.chalmers.se> (Lukas =?iso-8859-1?Q?San?=
 =?iso-8859-1?Q?dstr=F6m's?= message
	of "Sat, 19 Nov 2005 13:45:27 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12352>

Lukas Sandstr=F6m <lukass@etek.chalmers.se> writes:

> The "git-repack -a -d" case is fixed in Junios master, and I have sen=
t out
> a patch which lets you pipe git-fsck-objects --full --unreachable to
> git-pack-redundant in the other cases, so the problem should hopefull=
y
> be resolved shortly.

After thinking a bit about it, I tend to agree with what Linus
said, and would vote for the simplicity of the older way.  From
usage point of view, git-repack is primarily about repacking,
and the -d option is a funny exception applicable to -a case,
only because it is so obvious (i.e. after repacking everything
into one, it is obvious any other packs are unneeded).  We might
even want to make the "-a" flag to imply "-a -d" there.
