From: Junio C Hamano <junkio@cox.net>
Subject: Re: qgit reports errors in the git repository
Date: Fri, 16 Dec 2005 22:55:31 -0800
Message-ID: <7virto9pr0.fsf@assigned-by-dhcp.cox.net>
References: <1134433440.3798.27.camel@dv>
	<Pine.LNX.4.64.0512121700010.15597@g5.osdl.org>
	<1134624477.5360.6.camel@dv>
	<e5bfff550512150501v48bb65abwf44b3fc21f33bdf6@mail.gmail.com>
	<1134665095.27212.22.camel@dv>
	<e5bfff550512151100k33a66db5tdb2eb1ff2da10a59@mail.gmail.com>
	<1134693349.22652.22.camel@dv>
	<e5bfff550512152258t3f7b2eb1i1c709572b18fe3f7@mail.gmail.com>
	<1134757942.2248.11.camel@dv>
	<e5bfff550512161247v4c187cc0gedae8234d454c3b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 07:56:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnVz7-000551-6H
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 07:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVLQGzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 01:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVLQGzj
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 01:55:39 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:59379 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751281AbVLQGzj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2005 01:55:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051217065435.PZVN20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Dec 2005 01:54:35 -0500
To: Marco Costalba <mcostalba@gmail.com>
Importance: high
In-Reply-To: <e5bfff550512161247v4c187cc0gedae8234d454c3b6@mail.gmail.com>
	(Marco Costalba's message of "Fri, 16 Dec 2005 21:47:58 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13772>

Marco Costalba <mcostalba@gmail.com> writes:

>> > So perpahs this assumption is broken and works only on my box.
>> >
>> > Can you please send me also the git-ls-remote ./.git output?
>>
>> Attached.  Apparently my sort (coreutils 5.2.1) thinks that caret
>> follows period in C locale, so v0.99^{} goes after v0.99.9n^{}.  Since
>> there should be a reason for sort in git-ls-remote.sh, I assume it's the
>> script that should be fixed.
>>
>> Not that I would object against qgit being more robust :-)

Somehow I am getting your message without the message your
message is a reply to, but anyway, guessing without having
access to qgit source [*1*], you seem to be running ls-remote
against the local repository, reading its output and deciding if
"xyzzy" is followed immediately by "xyzzy^{}" then it is a tag
otherwise it is a non tag object?

If you are always doing that against the local repository, then
peek-remote would be more efficient, does not sort, and
"xyzzy^{}" comes immediately after "xyzzy", which I do not see
an immediate need of changing.


[Footnote]

*1* Why is that http:// URL does not work is mystery to me which
I do not particularly interested in figuring out myself.  Maybe
the site is trying to be too helpful and showing "Oh where do
you want to go" page with status 200 which confuses the h*ck out
of downloaders?
