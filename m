From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t9118 broken in current master, 9918285, git/git/v1.7.2-rc2
Date: Wed, 7 Jul 2010 23:15:29 -0400
Message-ID: <68AF81DF-7434-4493-8FBF-6DDEF27BFAB1@silverinsanity.com>
References: <4C352EB5.5020005@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 08 05:15:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWhaP-0007VC-T8
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 05:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037Ab0GHDPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 23:15:35 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:46945 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab0GHDPe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 23:15:34 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 9FC461FFC058; Thu,  8 Jul 2010 03:15:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 82EB21FFC056;
	Thu,  8 Jul 2010 03:15:21 +0000 (UTC)
In-Reply-To: <4C352EB5.5020005@gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150531>


On Jul 7, 2010, at 9:49 PM, A Large Angry SCM wrote:

> I've been busy with other projects and haven't attempted a full make & make test since f526d12, which did pass all the tests. Since the test name implies svn/git-svn breakage, I hoping the git-svn experts can find the problem.

I'm getting intermittent errors in t9115 instead.  Running the full test suite with prove[1] gives:

./t9115-git-svn-dcommit-funky-renames.sh ............. Dubious, test returned 1 (wstat 256, 0x100)
Failed 9/10 subtests 

Running the test separately gives:

 $ ./t9115-git-svn-dcommit-funky-renames.sh 
ok 1 - load repository with strange names
ok 2 - init and fetch repository
ok 3 - create file in existing ugly and empty dir
ok 4 - rename ugly file
ok 5 - rename pretty file
ok 6 - rename pretty file into ugly one
ok 7 - add a file with plus signs
ok 8 - clone the repository to test rebase
ok 9 - make a commit to test rebase
ok 10 - git svn rebase works inside a fresh-cloned repository
# passed all 10 test(s)
1..10

These may be unrelated, but thought I'd bring it up.

$ git describe HEAD
v1.7.2-rc2-191-gd2de19a

[1] prove -j 3 --state=hot,fresh,slow,save ./t[0-9]*.sh