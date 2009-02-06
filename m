From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git checkout effect on ls-files --others, how to merge partially?
Date: Fri, 6 Feb 2009 13:28:29 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngooent.om3.sitaramc@sitaramc.homelinux.net>
References: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADCBD@ELON17P32001A.csfb.cs-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 14:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVQmj-0008Fr-Ed
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 14:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbZBFN2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 08:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753639AbZBFN2s
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 08:28:48 -0500
Received: from main.gmane.org ([80.91.229.2]:52849 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432AbZBFN2r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 08:28:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVQl9-0007PX-3b
	for git@vger.kernel.org; Fri, 06 Feb 2009 13:28:43 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 13:28:43 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 13:28:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108703>

On 2009-02-06, Bisani, Alok <alok.bisani@credit-suisse.com> wrote:

> 	I found a feature that was a bit surprising. Basically, a file
> exist on master as untracked (git-ls-files --others). It is git-add'ed
> on a branch. Now switching back to master, removes the file from
> master's working directory as well.

How would git know that you had such an untracked file in
master?  As far as git knows, at the point you switch back
from branch to master, the file (a) is clean,
exists/committed on branch and (b) does not exist on master.
So it needs to be deleted.

If you really want to do this, you can "git stash" before
switching to the branch and "git stash pop" when you come
back to master.

> 	Is there a way to pull in changes from a branch but only limited
> to a file/files? I ended up doing a manual restore using git-cat-file
><branch>@{0}:/file. And checked in.

git checkout branch -- filename
