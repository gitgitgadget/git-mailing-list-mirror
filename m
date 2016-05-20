From: enrico <enrico.guiraud@gmail.com>
Subject: more novice-friendly behaviour of =?utf-8?b?YGdpdA==?= add =?utf-8?b?LXBg?=
Date: Fri, 20 May 2016 13:06:15 +0000 (UTC)
Message-ID: <loom.20160520T150517-391@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 15:10:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3kCJ-000226-TT
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 15:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842AbcETNKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 09:10:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:43308 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755798AbcETNKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 09:10:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1b3kBp-0001gg-5W
	for git@vger.kernel.org; Fri, 20 May 2016 15:10:05 +0200
Received: from nancy.w2kroot.uni-oldenburg.de ([134.106.116.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2016 15:10:05 +0200
Received: from enrico.guiraud by nancy.w2kroot.uni-oldenburg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2016 15:10:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.106.116.48 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:44.0) Gecko/20100101 Firefox/44.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295162>

Hello all,
I have encountered a couple of non-necessary difficulties when editing a
patch during a `git add -p`.

Firstly, the help message says
"To remove '-' lines, make them ' ' lines (context)."
which is a bit confusing because that "them" refers to '-', not to 'lines'.
I spent a good half hour changing '-' lines to lines containing a single
white space but git was not very happy about it.
I would suggest to change that line with
"To remove '-' lines, change '-' into ' ' (for context)"

Secondly, as discussed here
(http://git.661346.n2.nabble.com/git-add-patch-bug-with-split-edit-td2171634.html)
and in numerous stackoverflow questions, the behaviour of the "edit" (e)
option during an interactive add is a bit...bizarre: it requires the user to
do a lot of gymnastic if (s)he is editing a hunk after having used the split
(s) option, and nine times out of ten the patch will not apply cleanly.
I would suggest to change the behaviour of the interactive add to only allow
edits when the hunk has not been split (possibly with a one-line explanation
for why editing is not possible appearing when inside a split hunk). Since
editing is more powerful than splitting this would not result in a loss of
generality, but, in my humble opinion, in a much nicer experience for
novices and experts alike.

Best regards,
enrico
