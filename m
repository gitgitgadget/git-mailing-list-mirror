From: John Goerzen <jgoerzen@complete.org>
Subject: "Contributors never merge" and preserving history
Date: Mon, 25 Feb 2008 09:59:45 -0600
Message-ID: <slrnfs5pfh.lkc.jgoerzen@katherina.lan.complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 17:02:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTfmC-00037t-VE
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 17:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbYBYQBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 11:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbYBYQBX
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 11:01:23 -0500
Received: from main.gmane.org ([80.91.229.2]:42598 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754576AbYBYQBW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 11:01:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JTflQ-0003Yl-Gx
	for git@vger.kernel.org; Mon, 25 Feb 2008 16:01:12 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 16:01:12 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 16:01:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75035>

Hi folks,

I have a question about git philosophy.  Yesterday I was on #git
(thanks to those of you that were there and very helpful).  This
comment was made: [1] 

<vmiklos> patch series are created by contributors while
          contributors never merge

Now, here's my question, posed in IRC and over at [2]:

  Say we started from a common base where line 10 of file X said "hi", I
  locally changed it to "foo", upstream changed it to "bar", and at
  merge time I decide that we were both wrong and change it to "baz". I
  don't want to lose the fact that I once had it at "foo", in case it
  turns out later that really was the right decision.

I understand that git projects that use a kernel-like development
model -- which seems to be common -- do not want to know that I once
had it at "foo".  That is fine to me.  But I want a local branch -- or
a local *something* -- to store that, and make it convenient to
access.

That can be done easily enough if I use git pull instead of git rebase
to pull in upstream updates.  I'll be committing a merge patch on
every upstream update.  I suppose I'm OK with that, though it's not ideal.

The canonical answer from #git seems to be "never pull", always use
fetch and rebase when submitting patches upstream using
git-format-patch.

I have tried various ways to somehow make rebase get along with
merging, but have failed on that, mainly because merging confuses
rebase's algorithm that figures out which patches have already been
applied.

So, the question is: what is the best way to be able to keep a full
local history, while still using format-patch to interact easily with
upstream?  I'm thinking the answer may involve a submission branch
that uses squashing, but I'm not entirely certain.

And the corrolary: As upstream, how can I facilitate users that may
wish to do this?

[1] http://colabti.org/irclogger/irclogger_log/git?date=2008-02-25,Mon&sel=66#l99
[2] http://changelog.complete.org/posts/690-Git-looks-really-nice,-until.....html
