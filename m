From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC] git integrated bugtracking
Date: Mon, 11 Jun 2007 13:51:32 -0500
Message-ID: <1181587892.3380.37.camel@ld0161-tx32>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis>
	 <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
	 <7v4plgb6t6.fsf@assigned-by-dhcp.cox.net>
	 <20070610085044.GD4084@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:53:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxp0v-0003Ff-4f
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 20:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbXFKSxF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 14:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755147AbXFKSxF
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 14:53:05 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:38489 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbXFKSxD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 14:53:03 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l5BIpXE5001424;
	Mon, 11 Jun 2007 11:51:33 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5BIpWLa020673;
	Mon, 11 Jun 2007 13:51:33 -0500 (CDT)
In-Reply-To: <20070610085044.GD4084@efreet.light.src>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49868>

On Sun, 2007-06-10 at 03:50, Jan Hudec wrote:

> 
> It would be really useful to have a tool, that could link a bug report to
> a test case demonstrating it and reporting whenever output of that test case
> changes. This would make it much easier for developer to see which bugs he
> might have fixed when doing a refactoring.

I think the inverse is interesting too.  That is, applying
keywords to tests and then making the test database
keywords searchable.

I used to work for a company that had a huge collection
of test cases for its product.  It would take days to run
a validation run for some of the simplest of changes that
were introduced during development.

Often what I wanted, and what was needed, was a simple
sanity check that verified that the proposed change was
not brain-dead from the start.

Over time, I found that certain tests proved to be good
at detecting failures in particular portions of the code.
Often, that test was not necessarily directly related to
the concept it was _supposed_ to be designed to test, but
incidentally was good at some _other_ concept too.

The developer who made the change, and ran the tests,
then was able to state "Test t42 from suite Frotz is good
at detecting changes to the <SomeModule>."

The trick is to now associate with that test the keyword
"SomeModule" so that in the future, another developer
could ask:  "Say, I just modified <SomeModule>, are there
any tests that are good at proving my changes sound?"
A test driver could then focus some test cycles quickly.

Now, for git, it's not likely a problem to just run
through all of its tests.  At ${PriorCompany} it was
essential to pare down the test suites to a manageable
size, yet still have assurance that your coverage was
reasonably good.

jdl
