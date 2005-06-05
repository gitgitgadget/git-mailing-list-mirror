From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon server
Date: Sat, 04 Jun 2005 23:48:57 -0700
Message-ID: <7vzmu5b8o6.fsf@assigned-by-dhcp.cox.net>
References: <7vk6l9flzr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.21.0506050132590.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 08:46:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Deots-0003v5-5D
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 08:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVFEGt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 02:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFEGtY
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 02:49:24 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14979 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261265AbVFEGtD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 02:49:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605064857.BUGQ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 02:48:57 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506050132590.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Sun, 5 Jun 2005 01:38:17 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> On Sat, 4 Jun 2005, Junio C Hamano wrote:

>> BTW, don't we want to have them renamed to git-ssh-pull (and
>> git-ssh-push) for consistency with other transports, before 1.0
>> happens?

DB> I think that would be good, but I'm still using a really old version of
DB> git for my development, so I don't have your diff rename support; could
DB> you send a patch to do it?

I am sorry, but you lost me.  I am afraid that I do not
understand what you are asking me to send you: a patch to do
what?  Tell your old git how to do -M/-C?  That would be "the
tip of Linus repository"...

Ah (lightbulb!), are you asking me to send the patch in the
git-extended rename diff format, like this?

    $ git-diff-cache -p -B -C HEAD
    diff --git a/Documentation/git-rpull.txt b/Documentation/git-ssh-pull.txt
    similarity index 89%
    rename old Documentation/git-rpull.txt
    rename new Documentation/git-ssh-pull.txt
    --- a/Documentation/git-rpull.txt
    +++ b/Documentation/git-ssh-pull.txt
    @@ -1,20 +1,20 @@
    -git-rpull(1)
    -============
    +git-ssh-pull(1)
    +===============
     v0.1, May 2005
    ...

I am not sure if this is suitable for patch submission.  I did
the rename/copy stuff mostly for software archaeology purposes
(meaning, you examine what is in your repository), not to
generate patches for submission via e-mail.

It certainly is a good test for the git-apply stuff Linus has
been working on, and in addition it would have a good amusement
value to see how well it would work (or how badly it would barf
;-), but I suspect Linus (or, rather, his "dotest" script) would
appreciate it more if it came in the traditional diff format
that does not use the rename stuff.  I dunno.  Let's ask Linus
first.

Linus, can your workflow grok things like this, or do you prefer
patch submission to use traditional diff format without renames?

