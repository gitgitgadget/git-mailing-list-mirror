From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] assertion failure in builtin-mv.c with "git mv -k"
Date: Thu, 15 Jan 2009 11:53:40 +0100
Message-ID: <496F15B4.2040104@drmicha.warpmail.net>
References: <vpqwscy81o8.fsf@bauges.imag.fr> <496DFC75.2000904@drmicha.warpmail.net> <alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de> <496E0D1C.20807@drmicha.warpmail.net> <7vbpu91zjf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 11:55:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNPsS-0003z2-VG
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 11:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757825AbZAOKxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 05:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755288AbZAOKxp
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 05:53:45 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49323 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754645AbZAOKxo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 05:53:44 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 40D5B2120B4;
	Thu, 15 Jan 2009 05:53:43 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 15 Jan 2009 05:53:43 -0500
X-Sasl-enc: zKSWVS2KNY9CMzV2evFB1kdQ2iKIJ2ZJ/MyQwfz1sI5f 1232016822
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3F2B5447A;
	Thu, 15 Jan 2009 05:53:42 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <7vbpu91zjf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105780>

Junio C Hamano venit, vidit, dixit 14.01.2009 20:02:
...
> If "git mv" did not have adequate test coverage, then please add a test
> script with both expect_success (for cases that should have been there
> when somebody worked on "git mv" originally), and expect_failure to expose
> the bug you found in your first patch.  Again, the second patch would
> update the code and flip expect_failure to expect_success.
> 
> I see there is t7001-mv and even though it claims to concentrate on its
> operation from subdirectory, it has tests for more basic modes of the
> operation.
> 
> So my recommendation would be to have a single patch that:
> 
>  (1) retitles t7001;
>  (2) adds your new -k tests to it; and
>  (3) adds the 1-liner fix.
> 

Sorry to bother you again, even after your detailed reply, but I'm a bit
confused in multiple ways (I guess that makes for multiple bits...).
First, you replied to my post, not my patch v2, but (time-wise) after my
patch v2, so I'm not sure whether your reply applies to v2 as well or
that one is OK.

Second, I took the title of t7001 to mean "mv into subdir" or "mv in and
out subdir" in order to distiguish it from "mv oldname newname", albeit
in English that leaves room from improvement.

Third, various parts of that test are in vastly different styles, and I
haven't found any test writing directions other than "follow what is
there", which leaves several alternatives. (Some use the test-lib repo,
some create their own underneath, some make assumptions about the
contents of "$TEST_DIRECTORY"/../.)

Fourth, t7001-mv is missing any test for "mv -k", and 2 of my 3
additional tests cover cases which work (pass) without the fix, which is
why I kept it separate, being unrelated. Following all your arguments
lead to the conclusion I should squash 2+3 (fix + mark expect_pass) -
until I read your conclusion, which says squash all.

I'm happy to follow any variant ("1+2+3", "1 2+3", "1 2 3", in
increasing order of preference) so there's no need to discuss or explain
this further, just tell me "do x" ;)

Cheers,
Michael
