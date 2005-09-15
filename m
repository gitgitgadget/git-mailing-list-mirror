From: Junio C Hamano <junkio@cox.net>
Subject: Re: Shell quoting
Date: Thu, 15 Sep 2005 12:50:48 -0700
Message-ID: <7vll1yyusn.fsf@assigned-by-dhcp.cox.net>
References: <43290BB8.90501@zytor.com>
	<7vy85yahjk.fsf@assigned-by-dhcp.cox.net> <4329C11A.1040302@zytor.com>
	<Pine.LNX.4.58.0509151153140.26803@g5.osdl.org>
	<4329CC02.8090104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 21:54:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFzmS-0003GY-GR
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 21:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbVIOTuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 15:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbVIOTuv
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 15:50:51 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:44775 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965276AbVIOTuu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 15:50:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915195050.UQFO8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 15:50:50 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4329CC02.8090104@zytor.com> (H. Peter Anvin's message of "Thu,
	15 Sep 2005 12:31:14 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8634>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Linus Torvalds wrote:
>> Does anybody really still use tcsh? It's a broken mess.
>>
>
> Yes.

Yes to "still use", or yes to "broken mess" ;-)?

>> Junio's "sq_quote()" works wonderfully on any valid shells. The fact
>> that tcsh expands ! even inside single quotes is just pure
>> braindamage.
>
>> You could expand "sq_quote" to handle '!' and '\' characters the exact
>> same way it handles the single tick (end single-tick quoting, do \! or \\
>> and start single-tick quoting again) and that might be good enough for
>> tcsh.
>
> It seems easier to just \-escape any special characters.

I am sympathetic.  The beauty of sq_quote() comes directly from
the behaviour of single quoting rules of "any valid shells" --
there is no need to maintain a list of special characters.  Just
single quote itself is special and nothing else.
