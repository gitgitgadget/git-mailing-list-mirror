From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less
 distracting.
Date: Mon, 16 May 2005 15:51:42 -0700
Message-ID: <7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net>
	<20050516220559.GC8609@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue May 17 00:53:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXoQz-0000O3-9w
	for gcvg-git@gmane.org; Tue, 17 May 2005 00:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVEPWvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 18:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVEPWvz
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 18:51:55 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:35974 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261956AbVEPWvo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 18:51:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516225143.BUZI1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 18:51:43 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050516220559.GC8609@pasky.ji.cz> (Petr Baudis's message of
 "Tue, 17 May 2005 00:05:59 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> What about just throwing away the newlines and just passing '@.'?

Let's just drop the patch altogether unless anybody else has
better justification and pressing needs.

The current one is tolerable, except I do not like the word
"mode" very much.

    --- a/frotz
    +++ b/frotz
    @@ xxx @@
    + asdfasdf
    # mode: 100644 100755 nitfol
    --- a/nitfol
    +++ b/nitfol
    @@ yyy @@
    - asdfasdf
    + asdfasdfasdf
    --- a/rezrov
    +++ b/rezrov
    @@ zzz @@
     ...

This is what we would have got with the patch, which as you say
gives an illusion as if there should exist an empty line in
"frotz" and "nitfol", after the lines the hunks are applied to.
I should not have pushed it to begin with.

    --- a/frotz
    +++ b/frotz
    @@ xxx @@
    + asdfasdf

    @. 100644 100755 nitfol
    --- a/nitfol
    +++ b/nitfol
    @@ yyy @@
    - asdfasdf
    + asdfasdfasdf

    --- a/rezrov
    +++ b/rezrov
    @@ zzz @@
     ...


