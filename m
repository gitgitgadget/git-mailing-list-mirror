From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: git diff is slow (--patience is fast)
Date: Tue, 9 Aug 2011 11:39:12 +0000 (UTC)
Message-ID: <loom.20110809T133735-979@post.gmane.org>
References: <loom.20110809T093124-847@post.gmane.org> <CALUzUxpOR-YZh-GKzivyKVpff9ue-t3qEoNK4wGsZZjX_a1=-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 13:39:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqkej-0003OA-4M
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 13:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349Ab1HILj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 07:39:28 -0400
Received: from lo.gmane.org ([80.91.229.12]:46952 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753274Ab1HILj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 07:39:27 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qqkec-0003Jn-Cp
	for git@vger.kernel.org; Tue, 09 Aug 2011 13:39:26 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 13:39:26 +0200
Received: from marat by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 13:39:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.218.191.171 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179030>

Good idea.

New steps to reproduce:
~ $ git clone git://slonopotamus.org/git-diff
Cloning into git-diff...
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 6 (delta 1), reused 0 (delta 0)
Receiving objects: 100% (6/6), 478.87 KiB | 722 KiB/s, done.
Resolving deltas: 100% (1/1), done.
~ $ cd git-diff
~/git-diff $ time git diff HEAD^ > /dev/null 

real    0m6.585s
user    0m6.540s
sys     0m0.040s
~/git-diff $ time git diff --patience HEAD^ > /dev/null 

real    0m0.259s
user    0m0.220s
sys     0m0.030s
