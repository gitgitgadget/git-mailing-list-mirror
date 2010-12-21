From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: 'show' pretty %B without a diff
Date: Tue, 21 Dec 2010 14:04:47 +0300
Organization: '
Message-ID: <20101221104641.GA8600@external.screwed.box>
References: <20101220073842.GC10354@external.screwed.box>
 <7vmxo0ddbm.fsf@alter.siamese.dyndns.org>
 <20101220111214.GD10354@external.screwed.box>
 <7v4oa8cobn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 12:05:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV01f-00047L-O1
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 12:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908Ab0LULE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 06:04:57 -0500
Received: from ns1.skyriver.ru ([89.108.118.221]:57176 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab0LULE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 06:04:56 -0500
Received: from localhost (p57AB671A.dip.t-dialin.net [87.171.103.26])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id F0AD65A8C;
	Tue, 21 Dec 2010 13:46:54 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7v4oa8cobn.fsf@alter.siamese.dyndns.org>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164028>

You know St. Peter won't call my name, Junio!
2010/12/20 10:05:16 -0800 Junio C Hamano <gitster@pobox.com> => To Peter Vereshagin :

JCH> > JCH> Especially if you are doing a script, you probably should be using
JCH> > JCH> "cat-file commit" anyway, no?
JCH> >
JCH> > cat-file doesn't seem to support formatting option?
JCH> 
JCH> That is exactly why I suggested "cat-file", as you are scripting.  We
JCH> reserve the right to change the human-visible formatting output from
JCH> Porcelain commands like "show" any time to make it "prettier" (we may
JCH> start coloring strings that look like object names in the commit log
JCH> message in "git show" output, for example), while giving scripts more
JCH> stable output through the plumbing commands like "cat-file" so that they
JCH> can parse and process without having to worry about the output format
JCH> changing under them.

IMHO there is a difference between coloring the output and digging the data
from the storage, the what is the %B is about for me.
In a context of a script I believe every scriptwriter should expect a function
like get_comment_raw( $commitId ) than to worry about command output stability.
This is just where I believe the Git.pm will get closer to. One day.
No matter if such a function should look more like this: $gitObject->newById(
$commitId )->showDetails( '%B' ); . The I/O operations for this I believe
should be the storage files opening and reading, thus the piping from commands
like 'cat-file' is only the temporary solution.
Isn't it?
For the applications such an API approach is just more expectable than
porcelain versus plumbing commands. Although this requires care about features
like the particular (e.g., Perl) bindings, it is a must for the applications
efficiency which is a sense for a modern web at least.

JCH> If your script is _not_ parsing the git command output, but is just
JCH> blindly spewing it out to the invoking user, it is Ok to use "show",
JCH> though.  Check "-s" option to the "show" command in that case.

"show" command doesn't seem to have "-s" switch. Skip it up though ;-)

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
--
http://vereshagin.org
