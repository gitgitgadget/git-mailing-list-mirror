From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: can git reset or checkout be reverted?
Date: Fri, 6 Feb 2009 16:03:32 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngoonqk.urh.sitaramc@sitaramc.homelinux.net>
References: <20090206141940.GB7231@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 17:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVTDG-0002s7-46
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbZBFQDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbZBFQDu
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:03:50 -0500
Received: from main.gmane.org ([80.91.229.2]:35052 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbZBFQDt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 11:03:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVTB9-0005CX-Tj
	for git@vger.kernel.org; Fri, 06 Feb 2009 16:03:44 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 16:03:43 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 16:03:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108747>

On 2009-02-06, bill lam <cbill.lam@gmail.com> wrote:
> If I want to recall a old version of testing by
>
> git reset --hard sha1
> or
> git checkout sha1
>
> then git log does not show anything beyond that commit. It does give
> some warning and recommend -b switch next time.  If I only do that by
> accident or ignorance.  How to revert to the original HEAD?

As others have said: reflog.

I just wanted to add, I've had a lot of luck using reflog's
@{now} feature:

    git reflog show @{now}

Coupled with a vague recollection of what action I did at
what time, this has saved me a few times, and if I've been
jumping around branches as well, then:

    git reflog show HEAD@{now}

Another good one is:

    git show-branch --sha1-name -g=5

(or some larger value depending on how big your xterm is.)
This is particularly useful when I've done a lot of 'git
commit --amend' or rebases; the top most '+' sign in each
column, starting from the left, is your reflog -- I don't
know who came up with this design but it's amazing how much
useful information is condensed into that display.
