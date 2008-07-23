From: Eric Raible <raible@gmail.com>
Subject: RFC: git rebase -i and root commits
Date: Wed, 23 Jul 2008 01:58:41 +0000 (UTC)
Message-ID: <loom.20080723T013019-412@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 04:00:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLTe1-0005io-Qc
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbYGWB64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYGWB64
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:58:56 -0400
Received: from main.gmane.org ([80.91.229.2]:35796 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbYGWB64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:58:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KLTcx-0003kk-4I
	for git@vger.kernel.org; Wed, 23 Jul 2008 01:58:51 +0000
Received: from 12.96.234.114 ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 01:58:51 +0000
Received: from raible by 12.96.234.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 01:58:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9) Gecko/2008052906 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89597>

My normal workflow is to create a .gitignore in my initial commit.

When I later realize that I've forgotten something from that file
I could of course just commit the changes, but I'd rather use "git rebase -i"
in the normal way to make myself appear smarter than I am.
Especially since this realization usually comes early on
(and certainly before publishing).

But rebase can't go all the way to a root ("fatal: Needed a single revision").
The best I've found is:

1) git checkout -b temp <root commit>
2) echo '*.tmp' >> .gitignore
3) git commit --amend .gitignore
4) git rebase --onto temp <root commit> master

If there really is an asymmetry here and I haven't missed anything
(a large assumption), then what's the best way to think about it?

Is there a role for a default commit (e.g. the sha1 of "") here so that
'rebase -i' can update all commits and not just the ones with parents?

Or should I just get used to it and move on?

Thanks - Eric
