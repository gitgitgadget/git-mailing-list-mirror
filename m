From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git stash" is not known to git
Date: Mon, 30 Jul 2007 10:52:54 -0700
Message-ID: <7vtzrlkccp.fsf@assigned-by-dhcp.cox.net>
References: <86bqduutz4.fsf@lola.quinscape.zz>
	<vpqwswi2pkw.fsf@bauges.imag.fr>
	<20070730100408.GA8829@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:54:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFZRY-0004cQ-FL
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 19:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966175AbXG3RxG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 13:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966130AbXG3RxF
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 13:53:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:56100 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967298AbXG3RxD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 13:53:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070730175254.XDHM1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Jul 2007 13:52:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vtsu1X0061kojtg0000000; Mon, 30 Jul 2007 13:52:55 -0400
In-Reply-To: <20070730100408.GA8829@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 30 Jul 2007 06:04:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54246>

Jeff King <peff@peff.net> writes:

> On a related note, is it just me, or is the following comment and related code
> in git.c (introduced by Linus in 231af832) totally bogus:
>
>   /*
>    * We search for git commands in the following order:
>    *  - git_exec_path()
>    *  - the path of the "git" command if we could find it
>    *    in $0
>    *  - the regular PATH.
>    */
>
> We never actually look in the regular PATH since we call execv_git_cmd
> (although we do still munge the PATH, apparently so shell scripts can
> use git-foo syntax; see 77cb17e9). This means you can't drop "git-foo"
> into your PATH and have it work as "git foo".
>
> What is the desired behavior?

I failed to spot patches to the area without updating the
comment.  What the code does is fine, the comment is stale.
