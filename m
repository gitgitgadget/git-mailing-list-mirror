From: Junio C Hamano <junkio@cox.net>
Subject: Re: Do "git add" as a builtin
Date: Thu, 18 May 2006 01:34:45 -0700
Message-ID: <7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
	<7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
	<7v64k3698l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 10:35:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgdy6-00086J-KX
	for gcvg-git@gmane.org; Thu, 18 May 2006 10:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWERIer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 04:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWERIer
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 04:34:47 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:21183 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750883AbWERIer (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 04:34:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518083446.EBMD18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 04:34:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v64k3698l.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 18 May 2006 01:13:46 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20275>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Wed, 17 May 2006, Junio C Hamano wrote:
>>> 
>>> By "not seeing the point", do you mean you do not agree with
>>> what bba319b5 and 45e48120 tried to do to help users?
>>
>> Naah, I just didn't see why, and didn't bother to go exploring.
>>
>> How about this patch on top of the previous one?
>
> Well, not good as-is.  This makes it barf on this sequence:
>...

Ouch, things are worse than I thought...

	$ mkdir foo
        $ date >bar
        $ git-add foo/../bar
	$ git ls-files
        foo/../bar

Huh?
