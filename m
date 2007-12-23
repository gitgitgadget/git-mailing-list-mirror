From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: sane, stable renames; when a commit should commit twice
Date: Sun, 23 Dec 2007 17:29:09 +0100
Organization: At home
Message-ID: <fkm2ck$o8j$1@ger.gmane.org>
References: <20071223020310.GA22450@freedbms.net> <ee77f5c20712221826r5945a6d0x8a84eae98c85b25b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 23 17:29:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Ti0-000701-1G
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 17:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbXLWQ3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 11:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbXLWQ3Y
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 11:29:24 -0500
Received: from main.gmane.org ([80.91.229.2]:58612 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbXLWQ3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 11:29:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J6ThY-0000Xw-BU
	for git@vger.kernel.org; Sun, 23 Dec 2007 16:29:20 +0000
Received: from abvd229.neoplus.adsl.tpnet.pl ([83.8.201.229])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Dec 2007 16:29:20 +0000
Received: from jnareb by abvd229.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Dec 2007 16:29:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvd229.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69184>

David Symonds wrote:

> On Dec 23, 2007 1:03 PM, Zenaan Harkness <zen@freedbms.net> wrote:
>> When should a commit, commit twice?
>>
>> When one or more git mv file renames/ moves are involved.
>>
>> In such a case the commit ought to be split into two. Perhaps move the
>> files in the first commit, then make the changes needed to support the
>> move in the build chain (including changes in the moved files) in the
>> second commit.
>>
>> This keeps a clean record of the move, making the move, and the
>> associated changes (as two commits) a clean cherry.
>>
>> Does this make sense?
> 
> Not particularly. Git commits are not (conceptually) changes or
> deltas; they are snapshots of a tree of files at a particular time.
> How does the tree state at your above first commit make any sense? It
> is broken. Git's rename/move detection is smart enough to notice that
> a rename + small-changes is close enough to a rename, so just trust
> that to get it right.

Moreover renames detection during merges is based on three states:
ours, theirs and ancestor, and it would not take into account
"pure rename" commit it is there in the middle of one of chains.

Besides broken (not compiling) commit makes it harder for bisect to find
true bug later.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
