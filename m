From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Test suite
Date: Thu, 12 May 2005 12:48:03 -0700
Message-ID: <7vll6kfcp8.fsf@assigned-by-dhcp.cox.net>
References: <118833cc05050911255e601fc@mail.gmail.com>
	<7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
	<20050510230357.GF26384@pasky.ji.cz>
	<7vsm0us5p5.fsf@assigned-by-dhcp.cox.net>
	<118833cc050511113122e2d17d@mail.gmail.com>
	<7vpsvxqwab.fsf@assigned-by-dhcp.cox.net>
	<7vd5rxquo5.fsf@assigned-by-dhcp.cox.net>
	<20050511224044.GI22686@pasky.ji.cz>
	<7vu0l9nwgx.fsf_-_@assigned-by-dhcp.cox.net>
	<20050512192941.GC324@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 21:41:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWJXz-0007X6-Ty
	for gcvg-git@gmane.org; Thu, 12 May 2005 21:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVELTsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 15:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVELTsR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 15:48:17 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36268 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261523AbVELTsF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 15:48:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512194804.QCNH26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 15:48:04 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050512192941.GC324@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 12 May 2005 21:29:41 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

>> --- /dev/null
>> +++ b/t/test-lib.sh
>> +# For repeatability, reset the environment to known value.
>> +export LANG C
>> +export TZ UTC

These are just "Duh".  Sorry.

>> +
>> +test_description () {
>> +	while case "$#" in 0) break;; esac

PB> Duh. This looks mysterious - why not a simple test?

Because I am old fashioned and am used to this kind of Bourne
shell idioms.

PB> This branch makes no sense, I think.

Because...?

PB> Again, why not a simple test?

Again using case when test is not needed is a good old Bourne
shell idiom.

PB> [ "$debug" ] && eval "$*"

PB> (Actually, eval will do the wrong thing here - it just concatenates the
PB> arguments. Just "$@" would do, I guess.)

No, I wrote "$*" because that was what I wanted and not "$@".  I
wanted to give eval a _single_ string.

PB> Please clean up after yourself in this case.

I would not mind, but I'd mildly disagree.  The next test will
start by cleaning up test-repo/ anyway.  What we are lacking is
t/Makefile that drives all the tests and clean-up can be done
there.

>> +git-init-db 2>/dev/null || error "cannot run git-init-db"

PB> But there's no 'error' thing.

Yes, and that way you can get an error message ;-).  Simple
oversight.

PB> The testcases currently utterly fail,

That is something I told you in the cover letter (or commit log).

