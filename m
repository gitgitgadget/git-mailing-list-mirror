From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-status too verbose?
Date: Tue, 07 Mar 2006 01:46:29 -0800
Message-ID: <7v3bhumvt6.fsf@assigned-by-dhcp.cox.net>
References: <38b80e980603040952j15152a21h2c903bd011d7e905@mail.gmail.com>
	<7vacc36r4v.fsf@assigned-by-dhcp.cox.net> <440D503E.8090007@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Jaffe <jaffe.eric@gmail.com>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 10:46:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGYm4-0002Zt-5L
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 10:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbWCGJqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 04:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbWCGJqc
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 04:46:32 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45018 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1752132AbWCGJqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 04:46:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060307094324.KOLW26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Mar 2006 04:43:24 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <440D503E.8090007@op5.se> (Andreas Ericsson's message of "Tue, 07
	Mar 2006 10:19:58 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17329>

Andreas Ericsson <ae@op5.se> writes:

>> I agree that it would be useful if we had a tool that showed the
>> two status that matter for each file, grouped together on one
>> line, e.g.
>> 			HEAD->index	index->files
>> 	------------------------------------------------
>> 	hello.c		unmodified      modified
>>         world.c		modified	unmodified
>> 	frotz.c		new		unmodified
>>         ...
>> 	garbage.c~	???		n/a
>> for the current index file and the current HEAD commit.
>
> Could we have 'same' or some such instead of 'unmodified'? It's a bit
> close to 'modified' for the eye to find it quickly.
>
>> You obviously need to learn how to read it though.  The first
>> column means what you _would_ commit if you just said "git
>> commit" without doing anything else now; the second column is
>> what you _could_ commit if you did some update-index and then
>> said "git commit" (or ran "git commit" with paths arguments).
>
> Pretty-printing will be easier if the filename is last, and it will
> look a lot neater if all columns are aligned.

Somebody who feels strongly about this can propose a design.
Although I am not particularly fond of the current output, I am
not volunteering ;-).

It would be nicer if the proposal was accompanied by a patch,
but that is not a requirement for discussion.

The points that design would address should include:

 - set of labels (full list)
   modified, same, renamed?, untracked, ...
 - field ordering (good point by Andreas)
   - what to do _if_ we choose to do rename detection?  you need
     two pathnames.
 - alignment (good point by Andreas)
