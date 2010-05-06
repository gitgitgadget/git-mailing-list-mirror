From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: Any way to get complete diff up to a tag?
Date: Thu, 6 May 2010 11:27:40 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 06 11:27:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9xN2-0003iq-It
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 11:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275Ab0EFJ1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 05:27:47 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:42083 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab0EFJ1q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 05:27:46 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o469RhbA028732
	for <git@vger.kernel.org>; Thu, 6 May 2010 11:27:43 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 6 May 2010 11:27:43 +0200
Thread-Topic: Any way to get complete diff up to a tag?
Thread-Index: Acrs/l+gI+T1jA6AR6GvEgH4qhEqGQ==
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: Adt0 AiSJ CcwQ Dejh Dj/a DkKI GhOL HUER H1Qy ISFB IWEV
 IqI4 Jmee J4WA KreL
 LOlJ;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{350F925C-57E8-49C0-98D2-D46F56447E4C};cABlAHQAZQByAC4AawBqAGUAbABsAGUAcgBzAHQAZQBkAHQAQABhAHgAaQBzAC4AYwBvAG0A;Thu,
 06 May 2010 09:27:40
 GMT;QQBuAHkAIAB3AGEAeQAgAHQAbwAgAGcAZQB0ACAAYwBvAG0AcABsAGUAdABlACAAZABpAGYAZgAgAHUAcAAgAHQAbwAgAGEAIAB0AGEAZwA/AA==
x-cr-puzzleid: {350F925C-57E8-49C0-98D2-D46F56447E4C}
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146468>

If I use

$ git diff v1.7.1..

I get a diff for everything that has happened after the v1.7.1
release (up to HEAD). Is there a way to do the opposite, i.e.,
get everything (including the initial commit) up to and including 
v1.7.1? I first tried  

$ git diff ..v1.7.1

but it gave me the reverse of the above, which I later found out 
was due to it being the same as

$ git diff HEAD..v1.7.1

which of course does not yield the result I want. 

If I use

$ git diff $(git rev-list --reverse v1.7.1 |head -1)..v1.7.1

I almost get what I want, but the initial commit is still missing.
Is there any way to get that initial commit included in the diff?

Basically, what I think I am asking for is a way to specify the 
empty parent of the initial commit, i.e., where v1.7.1~1000000 would
end up. I can see this being useful in at least one other case as 
well, namely when doing an interactive rebase to allow the initial
commit to be rebased (something I have wanted to do a couple of 
times...)

//Peter
