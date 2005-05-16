From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Mon, 16 May 2005 00:55:58 -0700
Message-ID: <7v4qd3pptd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505151129200.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 16 09:56:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXaSK-0002iY-2y
	for gcvg-git@gmane.org; Mon, 16 May 2005 09:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVEPH4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 03:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVEPH4M
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 03:56:12 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57077 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261466AbVEPH4A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 03:56:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516075558.PRZB22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 03:55:58 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505151129200.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Sun, 15 May 2005 11:40:52 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> On Sat, 14 May 2005, Junio C Hamano wrote:
>> I am having a bit hard time understanding how the end user uses
>> what you are trying to give them.  Is the basic idea to let them
>> say "I want to get Pasky's $GIT_DIR/refs/heads/master and store
>> it in my $GIT_DIR/refs/heads/git-pb, and then I want to start
>> the pull starting from the commit recorded in that ref"?

DB> Yes. This would be: git-http-pull -w heads/git-pb heads/master
DB> http://www.kernel.org/pub/scm/cogito/git-pb.git/

That would be quite handy.  IIRC, Pasky had a gripe about
limiting this under refs hierarchy (that's why you can write
"heads/master" in your example not "refs/heads/master", though),
and I am sympathetic to it.  Giving unlimited download access
anywhere under foobar.git/ would be fine.  About the receiving
side, letting things to be written anywhere the user wants would
also be fine.

Since this will all be scripted anyway, I do not mind if the
above example needs to be spelled as:

 $ git-http-pull -w ${GIT_DIR-.git}/refs/heads/git-pb refs/heads/master \
   http://www.kernel.org/pub/scm/cogito/git-pb.git/

