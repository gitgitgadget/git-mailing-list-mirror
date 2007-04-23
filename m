From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 23 Apr 2007 10:15:16 -0700
Message-ID: <7vvefnf1wb.fsf@assigned-by-dhcp.cox.net>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	<7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
	<7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	<7vejmdq63w.fsf@assigned-by-dhcp.cox.net>
	<7v647ninbq.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 19:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg28I-00040W-QW
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 19:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030760AbXDWRPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 13:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030765AbXDWRPT
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 13:15:19 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46202 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030760AbXDWRPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 13:15:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423171516.BMVE1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 13:15:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qhFG1W00C1kojtg0000000; Mon, 23 Apr 2007 13:15:17 -0400
In-Reply-To: <81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com>
	(Alex Riesen's message of "Mon, 23 Apr 2007 19:07:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45338>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 4/23/07, Junio C Hamano <junkio@cox.net> wrote:
>> * jc/attr (Sat Apr 21 03:14:13 2007 -0700) 2 commits
>>  - Add 'filter' attribute and external filter driver definition.
>>  - Add 'ident' conversion.
>>
>> As 'ident' conversion is stateless, I do not mind too much
>> including it in v1.5.2-rc1.  On the other hand, the arbitrary
>> 'filter' is quite contentious, although the character-code
>> conversion example I gave myself might be a good enough reason
>> for people to want it.  Undecided.
>
> Can I suggest a config option to completely disable content
> munging code? So that people who really care about the
> real content, or just don't have the tools for the filters still
> can checkout the repos depending on the filters.

The code may have bugs, but the intent is that you can have this
line in your $GIT_DIR/info/attributes to override whatever
attribute settings used in .gitattributes files that are
in-tree:

	*	!ident !filter
