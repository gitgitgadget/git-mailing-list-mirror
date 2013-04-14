From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] t/test-lib.sh: fix TRASH_DIRECTORY handling
Date: Sun, 14 Apr 2013 21:44:36 +0200
Message-ID: <87d2twzyl7.fsf@hexa.v.cablecom.net>
References: <11cf45ad9779240b588da4b25c8ae5b6cc61b427.1365957201.git.john@keeping.me.uk>
	<20130414193821.GC4599@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 21:44:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URSr1-0001Vu-Qu
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 21:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727Ab3DNTon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 15:44:43 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:59632 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106Ab3DNTom (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 15:44:42 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 14 Apr
 2013 21:44:38 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 14 Apr
 2013 21:44:40 +0200
In-Reply-To: <20130414193821.GC4599@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 14 Apr 2013 15:38:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221158>

Jeff King <peff@peff.net> writes:

> On Sun, Apr 14, 2013 at 05:34:56PM +0100, John Keeping wrote:
>
>> After the location of $TRASH_DIRECTORY is adjusted by
>> $TEST_OUTPUT_DIRECTORY, we go on to use the $test variable to make the
>> trash directory and cd into it.  This means that when
>> $TEST_OUTPUT_DIRECTORY is not "." and an absolute --root has not been
>> specified, we do not remove the trash directory once the tests are
>> complete (remove_trash is set to $TRASH_DIRECTORY).
>> 
>> Fix this by always referring to the trash directory as $TRASH_DIRECTORY.
>
> Thanks, this seems to date back all the way to my f423ef5 (tests: allow
> user to specify trash directory location, 2009-08-09), although I think
> at that time it was not even possible to run the tests from any other
> directory. So I am happy to blame Thomas's later patches for violating
> my assumptions. :)
>
> Definitely:
>
>   Acked-by: Jeff King <peff@peff.net>

Indeed, your blame assignment seems correct :-)

Acked-by: Thomas Rast <trast@inf.ethz.ch>

> -- >8 --
> Subject: [PATCH] t/test-lib.sh: drop "$test" variable
>
> The $test variable is used as an interim buffer for
> constructing $TRASH_DIRECTORY, and is almost compatible with
> it (the exception being that $test has not been converted to
> an absolute path). Let's get rid of it entirely so that
> later code does not accidentally use it, thinking the two
> are interchangeable.

Agreed.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
