From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Renaming environment variables.
Date: Mon, 09 May 2005 18:02:02 -0700
Message-ID: <7vk6m7vqph.fsf@assigned-by-dhcp.cox.net>
References: <7vis1vc27f.fsf@assigned-by-dhcp.cox.net>
	<2721.10.10.10.24.1115425962.squirrel@linux1>
	<7vbr7nbl89.fsf@assigned-by-dhcp.cox.net>
	<7vacn6ak7r.fsf@assigned-by-dhcp.cox.net> <427F6693.2080707@zytor.com>
	<7vll6oz755.fsf@assigned-by-dhcp.cox.net>
	<3087.10.10.10.24.1115656919.squirrel@linux1>
	<427FA5FD.1050000@zytor.com> <7vfywwz11t.fsf@assigned-by-dhcp.cox.net>
	<7vhdhcxj0z.fsf_-_@assigned-by-dhcp.cox.net>
	<20050510002548.GI15712@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 02:55:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVJ1f-0006fW-HI
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVEJBCN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 21:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVEJBCN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 21:02:13 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1437 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261470AbVEJBCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 21:02:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510010203.BAMM23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 May 2005 21:02:03 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050510002548.GI15712@pasky.ji.cz> (Petr Baudis's message of
 "Tue, 10 May 2005 02:25:48 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Could I please have s/COMMIT_AUTHOR/COMMITTER/ and
PB> s/OBJECTS/(OBJDIR|OBJECT_DIR)/?

The former sounds much better.  The latter how about
GIT_OBJECT_DIRECTORY?  Not much longer than the original
SHA1_FILE_DIRECTORY anyway.

PB> (Cogito needs its own git-merge-cache so that the merge goes properly
PB> anyway, and it already (or still) carries its Git around, so I think
PB> it's not applicable to it. Yes, I want and plan to start publishing the
PB> Git changes, I'm already making some steps for that and I hope I have
PB> something to show by tomorrow.)

Sounds good.  BTW, what happened to the plan of merging with my
tip you sent a message earlier about?

PB> Yes, I think couple of weeks is too long. :-) I'd say one or two
PB> releases is enough.

I'd leave that to community and Linus to decide when he returns.

PB> Pretty please, add copyright notices at the top of files.

Thanks for pointing it out.

>> +char *gitenv_bc(const char *e)
>> +{
>> +	int first, last;
>> +	char *val = getenv(e);
>> +	if (val)
>> +		/* inefficient.  caller should use gitenv() not gitenv_bc() */
>> +		return val;

PB> Can this ever happen? If doing it at all, I'd expect gitenv_bc() to
PB> rather freak out and die(), the caller is broken.

Point taken.

I've pushed out an updated version that addresses all of the
above issues to git-jc repository [*1*].  Please take a look.

[References]
*1* http://members.cox.net/junkio/


