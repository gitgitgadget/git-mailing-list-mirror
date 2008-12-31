From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-)
Date: Wed, 31 Dec 2008 01:43:42 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnglljie.kdq.sitaramc@sitaramc.homelinux.net>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org>
 <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com>
 <gjdh0r$n3c$4@ger.gmane.org> <gjdlcl$5no$4@ger.gmane.org>
 <gjdmm6$9oj$4@ger.gmane.org> <gje3ok$gnc$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 02:45:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHq9T-0001vQ-V4
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 02:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbYLaBn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 20:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbYLaBn5
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 20:43:57 -0500
Received: from main.gmane.org ([80.91.229.2]:57922 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbYLaBn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 20:43:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHq7m-0003D2-SE
	for git@vger.kernel.org; Wed, 31 Dec 2008 01:43:54 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 01:43:54 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 01:43:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104236>

On 2008-12-30, Zorba <cr@altmore.co.uk> wrote:
> ** REPRODUCING Possible bug

[long script using "git checkout tag ." removed...]

Conor,

As Stephen said, you're using an extra "." which changes the
meaning completely.

In addition, the weird behaviour you see, where AC.txt
appears to have sneaked in when you do a "git checkout
versionB .", even though versionB does not have that file,
is also correct -- read the second para of the DESCRIPTION
section in "git help checkout", and note the phrase "update
the index ... before updating the working tree".

In other words, the special form of git checkout you used is
updating not only the working tree but also the index.  So
when you checked out versionA in this manner, AC.txt got
into the index (as well as the working tree).

Your subsequent "rm *.*" only deeltes those files from the
working tree; they're still in the index.  To see this, run
"git ls-files -s" just after each "rm *.*".

You can also get the results you *want* to get by running a
"git reset --hard" instead of "rm *.*", since your top
commit in the current branch (which is what this would
default to) has no files in it anyway.

Happy New Year from India to Northern Ireland and everyone
else in the world :-)
