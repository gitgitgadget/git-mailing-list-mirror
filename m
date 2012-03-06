From: "David A. Greene" <dag@cray.com>
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Tue, 6 Mar 2012 16:12:31 -0600
Message-ID: <87hay1fkfk.fsf@smith.obbligato.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
	<1330903437-31386-2-git-send-email-greened@obbligato.org>
	<87aa3vzdoc.fsf@thomas.inf.ethz.ch>
	<nngy5re29zn.fsf@transit.us.cray.com>
	<878vje86cy.fsf@thomas.inf.ethz.ch>
	<87mx7tiyhh.fsf@smith.obbligato.org>
	<7vaa3ttvj1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@inf.ethz.ch>, "David A. Greene" <dag@cray.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 23:15:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S52fI-0007lj-VB
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 23:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030790Ab2CFWPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 17:15:24 -0500
Received: from exprod6og117.obsmtp.com ([64.18.1.39]:49551 "EHLO
	exprod6og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965262Ab2CFWPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 17:15:23 -0500
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob117.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT1aMeIkYwvSIKDiDZl2WGHlnbSU5+i7C@postini.com; Tue, 06 Mar 2012 14:15:23 PST
Received: from smith.obbligato.org (192.168.233.145) by
 CFWEX01.americas.cray.com (172.30.88.25) with Microsoft SMTP Server (TLS) id
 14.1.355.2; Tue, 6 Mar 2012 16:15:20 -0600
In-Reply-To: <7vaa3ttvj1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 6 Mar 2012 10:49:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192404>

Junio C Hamano <gitster@pobox.com> writes:

> greened@obbligato.org (David A. Greene) writes:
>
>>> Don't we, right now, get stuff as follows:
>>>
>>>   item                   path
>>>   --------------------------------------------
>>>   test-lib.sh            $TEST_DIRECTORY
>>
>> Right now, yes, but it breaks for out-of-tree tests.  In the out-of-tree
>> case, TEST_DIRECTORY doesn't contain test-lib.sh.  For exmaple, in
>
> Could it be that the reason for the breakage is because you are
> setting TEST_DIRECTORY to the directory that contains out-of-tree
> tests, instead of $GIT_BUILD_DIR/t/ directory?

Well, yes.  I thought that's what out-of-tree tests are supposed to do.
They don't live in $GIT_BUILD_DIR/t/ after all.

Perhaps I've misunderstood how the test system is supposed to work.  A
table as you described in README would be most helpful.  I thought
TEST_DIRECTORY is supposed to point to where the tests to run are
located.

> Shouldn't TEST_DIRECTORY merely a short-hand for GIT_BUILD_DIR/t?
> What do you find relative to $TEST_DIRECTORY that cannot be found
> relative to GIT_BUILD_DIR/t?

If that's what TEST_DIRECTORY is supposed to be, always, then it should
be stated in the comments and README.  I had no idea this was an
invariant.

Thanks for clarifying!

                        -Dave
