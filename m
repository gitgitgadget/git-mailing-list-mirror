From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git checkout effect on ls-files --others, how to merge partially?
Date: Sat, 7 Feb 2009 01:28:26 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngopotq.his.sitaramc@sitaramc.homelinux.net>
References: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADCBD@ELON17P32001A.csfb.cs-group.com>
 <slrngooent.om3.sitaramc@sitaramc.homelinux.net>
 <loom.20090206T163626-457@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 02:30:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVc1F-00037Y-IF
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 02:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbZBGB2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 20:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbZBGB2i
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 20:28:38 -0500
Received: from main.gmane.org ([80.91.229.2]:44906 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbZBGB2h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 20:28:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVbzm-000887-Jz
	for git@vger.kernel.org; Sat, 07 Feb 2009 01:28:34 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 01:28:34 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 01:28:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108805>

On 2009-02-06, Bisani  Alok <alok.bisani@credit-suisse.com> wrote:
>> git checkout branch -- filename

> This is exactly what I was looking for, thank you! I
> wonder why it is the checkout command which does this,
> rather than the pull/merge. What is the reason that we
> cannot pull/merge a specific file from a branch?

Pull is to pull commits between repos, not files between
commits.  (The special case of using "." as the repo is just
that -- a special case; ignore it for now).

Merge is to merge commits within a repo.

Both operate on entire commits, and both *create* a new
commit to record their action (ignore the --no-commit option
in merge for now; that too is a special case IMO, and its
purpose does not detract from the overall sense of what I am
saying anyway)

What you want is an individual file in a commit.  'git show'
is a good way of getting that, as is 'git cat-file blob'
(by the way I prefer 'git cat-file -p').  For blob objects,
all of them seem to do the same thing.

But all of them are geared to putting the file onto stdout,
and you deal with it how you want.  They're all basically
just 'cat', with a couple of extra whiskers perhaps :-)

'git checkout' is meant to 'checkout a branch or paths to
the working tree' -- as it says on the tin, which is what
you want.

Sita
