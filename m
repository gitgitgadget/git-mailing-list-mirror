From: Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: [PATCH] Don't use $author_name undefined when $from contains no /\s</.
Date: Thu, 19 Oct 2006 16:48:14 -0700
Message-ID: <87pscnj29t.fsf@penguin.cs.ucla.edu>
References: <87vemgn1s2.fsf@rho.meyering.net>
	<7vbqo8uvkn.fsf@assigned-by-dhcp.cox.net>
	<878xjckw7x.fsf@rho.meyering.net>
	<7vk62wruum.fsf@assigned-by-dhcp.cox.net>
	<87fydkj8q1.fsf@penguin.cs.ucla.edu>
	<7vr6x4q9b6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bug-gnu-utils@gnu.org,
	Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Oct 20 01:48:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gahce-0003yB-7r
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 01:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946677AbWJSXsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 19:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946679AbWJSXsV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 19:48:21 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:29614 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S1946677AbWJSXsU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 19:48:20 -0400
Received: from penguin.cs.ucla.edu (Debian-exim@Penguin.CS.UCLA.EDU [131.179.64.200])
	by kiwi.cs.ucla.edu (8.13.7+Sun/8.13.7/UCLACS-6.0) with ESMTP id k9JNmF7U027343;
	Thu, 19 Oct 2006 16:48:15 -0700 (PDT)
Received: from eggert by penguin.cs.ucla.edu with local (Exim 4.50)
	id 1GahcU-0008NC-QD; Thu, 19 Oct 2006 16:48:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6x4q9b6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 19 Oct 2006 14:34:21 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29389>

Junio C Hamano <junkio@cox.net> writes:

> If "trailing space" highlighting picks up the first column blank
> in "diff -u" output, that highlighting feature is *broken*.

If the buffer contains arbitrary text, some of which is diff -u output
and some of which is not, then it it isn't possible in general for the
highlighting mode to distinguish between the diff -u part and the
other part.  This sort of thing is fairly common among people who
email patches and code around, or who generate files containing a
combination of patches and other things.

If the change bothers you a lot, you might want to follow up to
<http://www.opengroup.org/austin/mailarchives/ag-review/msg02139.html>,
which proposes the change in question to the POSIX folks.  This change
is atop the earlier change I proposed to specify "diff -u" format in
the first place; see
<http://www.opengroup.org/austin/mailarchives/ag-review/msg02077.html>.
You can follow up by writing to austin-group-l@opengroup.org and
citing XCU ERN 103.  You can find a copy of XCU ERN 103 at
<http://www.opengroup.org/austin/aardvark/latest/xcubug2.txt>;
look for "Number 103".

Since git uses diff -u format, it would make sense to git to work with
the upcoming POSIX spec for diff -u, either by adjusting the spec or
by adjusting git.
