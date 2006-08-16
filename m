From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] remove inline iteration variable
Date: Wed, 16 Aug 2006 13:16:54 -0700
Message-ID: <7vzme4307d.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608151022340.26891@chino.corp.google.com>
	<81b0412b0608160027l2ac53c10gd9a75525ca144f1d@mail.gmail.com>
	<Pine.LNX.4.63.0608161011100.20470@chino.corp.google.com>
	<20060816201019.GA6083@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Rientjes <rientjes@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 16 22:17:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDRox-0006Ri-V4
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 22:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWHPUQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 16:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWHPUQ4
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 16:16:56 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:56027 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751018AbWHPUQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 16:16:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060816201655.UCFH29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Aug 2006 16:16:55 -0400
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060816201019.GA6083@steel.home> (Alex Riesen's message of
	"Wed, 16 Aug 2006 22:10:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25525>

fork0@t-online.de (Alex Riesen) writes:

> David Rientjes, Wed, Aug 16, 2006 19:14:44 +0200:
>> > > Remove unnecessary iteration variable in inline.
>> > > -       for (i = 0; i < in; i++) putchar(' ');
>> > > +       for (; in > 0; in--)
>> > 
>> > while(in--) putchar(' ');
>> > 
>> 
>> That goes into an infinite loop if the argument is negative because
>> it emits a cmpl $0, x(%ebp).  Should never happen, but there's no
>> reason not to prevent it with a for loop.
>
> while (in-- > 0) putchar(' ');
>
> still shorter :)

Why do we keep talking about a usually ifdef'ed out debugging
section?

I'll be removing that section altogether ;-).
