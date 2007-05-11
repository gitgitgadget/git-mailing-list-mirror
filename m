From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Fri, 11 May 2007 03:28:31 +0200
Organization: At home
Message-ID: <f20gjc$rne$1@sea.gmane.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com> <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org> <20070509134151.GT4489@pasky.or.cz> <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org> <873b26klkj.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 03:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmJrk-0002c1-NX
	for gcvg-git@gmane.org; Fri, 11 May 2007 03:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760835AbXEKBYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 21:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760347AbXEKBYM
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 21:24:12 -0400
Received: from main.gmane.org ([80.91.229.2]:38863 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759467AbXEKBYK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 21:24:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HmJrX-0001DV-00
	for git@vger.kernel.org; Fri, 11 May 2007 03:24:03 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 May 2007 03:24:02 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 May 2007 03:24:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46922>

Carl Worth wrote:

> This reminds me of a confusing semantic issue that came about with the
> "new" add. It can be quite natural to commit a single file in one step
> with:
> 
>       git commit some-file.c
> 
> or to do that in two steps with:
> 
>       git add some-file.c
>       git commit
> 
> (which is particularly useful if one wants to add multiple files).
> 
> I recently found myself wanting to do a similar thing with a directory
> path. I can commit a path with:
> 
>       git commit path/
> 
> but I don't get anything at all like the same semantics if I do:
> 
>       git add path/
>       git commit
> 
> (since "git add" will recursively add all untracked files under path/).
> 
> Now the "recursively add all files" behavior is older, and has been an
> essential part of git-add forever. But I found it to be not at all
> what I wanted in this case, (where I'm now trained to say "git add" to
> stage things into the index).
> 
> I don't know of any good fix for the problem now. Maybe I'll just need to
> remember to break out that old "git update-index" for a situation like
> this, but that sure feels clunky.

In the new version of git I *think* you can use "git add -u path/"

  'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...

  -u::
        Update all files that git already knows about. This is what
        "git commit -a" does in preparation for making a commit.

(in v1.5.2-rc0, documented in v1.5.2-rc3).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
