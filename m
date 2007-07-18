From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 16:34:41 -0700
Message-ID: <7vy7hd5lri.fsf@assigned-by-dhcp.cox.net>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<7v8x9ea1rg.fsf@assigned-by-dhcp.cox.net>
	<85d4yqz24s.fsf@lola.goethe.zz>
	<7vhco28aoq.fsf@assigned-by-dhcp.cox.net>
	<867ioyqhgc.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 01:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBJ3Y-0000uv-JO
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 01:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbXGRXex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 19:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbXGRXev
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 19:34:51 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48445 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964923AbXGRXer (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 19:34:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070718233443.GJUY1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Jul 2007 19:34:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RBag1X00i1kojtg0000000; Wed, 18 Jul 2007 19:34:41 -0400
In-Reply-To: <867ioyqhgc.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Wed, 18 Jul 2007 09:49:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52911>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Having made it sound so easy, here are the issues I would expect
>> to be nontrivial (but probably not rocket surgery either).
>> ...
> This would seem to imply that the index does not need to be
> upwards-compatible: simplifying the code means that old indexes won't
> be treated all too well.

I did not imply any such thing, by the way.  These are off the
top of my head technical issues and there probably are more, but
I limited the list to technical side of the things.

You of course have social side to take care of.  If you are
breaking everybody else's index, you would need to tell
everybody: "I am sorry but if you upgrade your git to this
version that does what I want, you have to nuke your index and
start over, so commit all changes first, and then update the
git.  Sorry for causing you a minor inconvenience".  Everybody
at this point involves (obviously) the kernel folks, wine,
x.org, among many others.

I suspect your saying that to them is probably not good enough
for them to forgive the minor inconveniences, which means you
need to convince _me_ to join you in defending, in the release
notes, that this is a feature worth having even though there is
a minor inconvenience to redo everybody's index files.  Which I
suspect is quite unlikely to happen at this moment, though...

A much less troublesome approach might be to do things
differently from what I outlined, to keep the index compatible
as long as it does not contain an empty directory, which is what
we did for subprojects support.
