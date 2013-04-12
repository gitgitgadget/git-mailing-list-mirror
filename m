From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (Apr 2013, #02; Fri, 5)
Date: Fri, 12 Apr 2013 11:56:11 +0200
Message-ID: <87ppy0gjic.fsf@linux-k42r.v.cablecom.net>
References: <7vip40bolc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 11:56:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQaiX-0006At-Cj
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 11:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab3DLJ4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 05:56:14 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39108 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215Ab3DLJ4N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 05:56:13 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Apr
 2013 11:56:09 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 12 Apr 2013 11:56:11 +0200
In-Reply-To: <7vip40bolc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 05 Apr 2013 15:27:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220973>

Junio C Hamano <gitster@pobox.com> writes:

> * tr/line-log (2013-04-05) 7 commits
>   (merged to 'next' on 2013-04-05 at 5afb00c)
>  + log -L: fix overlapping input ranges
>  + log -L: check range set invariants when we look it up
>   (merged to 'next' on 2013-04-01 at 5be920c)
>  + Speed up log -L... -M
>  + log -L: :pattern:file syntax to find by funcname
>  + Implement line-history search (git log -L)
>  + Export rewrite_parents() for 'log -L'
>  + Refactor parse_loc
>
>  Will merge down to 'master'

I did some fuzz-testing, choosing random commits and ranges from files
and running log -L on them.

While the good news is that I couldn't break ordinary log -L, there's a
rather embarassing pair of bugs: -M is completely broken (at least when
it would do any good) and the tests that claim to look at move support
actually don't pass -M.

So please hold off merging, I'll try to get this fixed this weekend.

Sorry for the trouble!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
