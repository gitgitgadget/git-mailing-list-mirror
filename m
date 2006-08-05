From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Fri, 4 Aug 2006 23:21:35 -0400
Message-ID: <20060805032135.GA11244@coredump.intra.peff.net>
References: <20060805031418.GA11102@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 05 05:21:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9CjM-0006qA-As
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 05:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbWHEDVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 23:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWHEDVh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 23:21:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:40618 "HELO
	peff.net") by vger.kernel.org with SMTP id S1422727AbWHEDVh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 23:21:37 -0400
Received: (qmail 16878 invoked from network); 4 Aug 2006 23:21:01 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 4 Aug 2006 23:21:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri,  4 Aug 2006 23:21:35 -0400
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060805031418.GA11102@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24878>

On Fri, Aug 04, 2006 at 11:14:19PM -0400, Jeff King wrote:

> The idea is that red things indicate a potential mistake on the part of the
> user (e.g., forgetting to update a file, forgetting to git-add a file).

I actually wanted to do this because I started syntax-highlighting the
git-commit message in vim. I found myself catching simple mistakes in
commits, like the ones I mentioned above, before committing, saving me
from doing an --amend. Then I got so hooked on it I wanted the
colorization everytime I ran git-status.

If anyone is interested in the vim syntax highlighting, it is below.
Copy the file to $HOME/.vim/syntax/gitcommit.vim and add the following
line to your .vimrc:
  autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit

-Peff

-- >8 --
syn region gitLine start=/^#/ end=/$/
syn region gitCommit start=/^# Updated but not checked in:$/ end=/^#$/ contains=gitHead,gitCommitFile
syn region gitHead contained start=/^#   (.*)/ end=/^#$/
syn region gitChanged start=/^# Changed but not updated:/ end=/^#$/ contains=gitHead,gitChangedFile
syn region gitUntracked start=/^# Untracked files:/ end=/^#$/ contains=gitHead,gitUntrackedFile

syn match gitCommitFile contained /^#\t.*/hs=s+2
syn match gitChangedFile contained /^#\t.*/hs=s+2
syn match gitUntrackedFile contained /^#\t.*/hs=s+2

hi def link gitLine Comment
hi def link gitCommit Comment
hi def link gitChanged Comment
hi def link gitHead Comment
hi def link gitUntracked Comment
hi def link gitCommitFile Type
hi def link gitChangedFile Constant
hi def link gitUntrackedFile Constant
