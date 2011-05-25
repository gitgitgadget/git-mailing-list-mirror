From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: t7810.94 (git-grep -E -F -G) never passed
Date: Wed, 25 May 2011 08:48:08 -0400
Message-ID: <1AEF57D5-49E0-4F37-BE8D-DEBD25965D83@gernhardtsoftware.com>
References: <BE19630B-8E48-4CA8-B956-A4DC767BFFDD@gernhardtsoftware.com> <4DDCD845.1030800@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 25 14:48:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPDVb-0003AB-KN
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 14:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454Ab1EYMsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 08:48:13 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:41559 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207Ab1EYMsM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 08:48:12 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id E81BB1FFC146; Wed, 25 May 2011 12:48:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 042001FFC135;
	Wed, 25 May 2011 12:48:06 +0000 (UTC)
In-Reply-To: <4DDCD845.1030800@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174389>


On May 25, 2011, at 6:21 AM, Michael J Gruber wrote:

> "Never" is a strong statement when this test always passed for everyone
> else running tests, assuming they would have reported otherwise. What's
> your system?

My apologies.  It was late and I wasn't explicit enough.  What I meant was:

"This test has failed on my system ever since the commit that introduced it."

My system is running OS X 10.6.7.

> reg-ex.info says:
> 
> "The other BRE metacharacters require a backslash to give them their
> special meaning."
> 
> "Some implementations support \? and \+... but \? and \+ are not part of
> the POSIX standard."
> 
> So I guess we're going with "some".

Some would be right.  I tend to find that the BSD (and BSD-like) libraries on OS X are more strict and have less features than the GNU equivalents.  (The fact that OS X's libreadline is actually the only mostly compatible libedit drives me batty sometimes.)

This does leave us with the question of what to do with the test.  Perhaps a pattern like "a*+b" to match "aa+b"?  Plain + should always match just + in a BRE, even if \+ is special, and the * makes sure that it is a regex instead of plain string matching.

~~ Brian
