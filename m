From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Trial git RPM's..
Date: Mon, 11 Jul 2005 18:55:02 -0600
Message-ID: <m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 03:03:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds9Bc-00079h-1y
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 03:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVGLA6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 20:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGLAzX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 20:55:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64656 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261837AbVGLAzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 20:55:16 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6C0t4vL020788;
	Mon, 11 Jul 2005 18:55:04 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6C0t2rS020787;
	Mon, 11 Jul 2005 18:55:02 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org> (Linus
 Torvalds's message of "Mon, 11 Jul 2005 10:06:06 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 11 Jul 2005, Eric W. Biederman wrote:
>
>> Are you still up for a patch that records who and when made a tag?
>> I sent one but it seems to have been lost.
>
> I'd really actually prefer for the code to be shared with the commit code, 
> so that the user info (name, email, date) would not just be exactly the 
> same, but would share the same code so that we don't end up having them 
> ever get out of sync. 

Sounds fair.

> That would imply moving parts of "git-tag-script" into mktag.c.

Actually I was looking at doing a git-ident thing that will
just compute who git thinks you are.  And then git-commit-tree can
just popen it to share code.  That looks like how the logic has
been accomplished in other places.

Moving parts of git-tag-script into mktag is hard because you
have to generate a flat file to pass to gpg.  And I don't think
I am ready to hard code the call to gpg into mktag, as some other
signing method may come along.  Although that may be the saner
choice.

Anyway the git-ident thing is easy and informative for debugging
so I will finish coding that up as soon as I get home.

Eric
