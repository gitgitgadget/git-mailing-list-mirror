From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: perl t9700 failures?
Date: Sun, 29 Jun 2008 12:52:00 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Lea Wiemann <LeWiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 21:53:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD2y0-00018g-Rs
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 21:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbYF2Two (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 15:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755048AbYF2Two
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 15:52:44 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50964 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754551AbYF2Twn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jun 2008 15:52:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5TJq14c029675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 Jun 2008 12:52:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5TJq0BI003866;
	Sun, 29 Jun 2008 12:52:00 -0700
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.356 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86822>


Am I the only one who gets this error:

	*** t9700-perl-git.sh ***
	*   ok 1: set up test repository
	*  run 2: Perl API (perl ../t9700/test.pl)
	* FAIL 2: Perl API
	        perl ../t9700/test.pl
	* FAIL 3: no stderr: Perl API
	        perl ../t9700/test.pl
	* failed 2 among 3 test(s)

which I have no idea about, since to me perl is a black box, and doing  
run of the tests with '-i -v' doesn't actually tell any more about which 
part of the perl script is failing, or why.. Trying to run the perl thing 
by hand, though, gives me this:

	Can't locate Test/More.pm in @INC (@INC contains: ...)

which is presumably the problem. It looks like it is assuming I have the 
Test::More perl libs, which I presumably don't have, don't have any clue 
where they are, nor really any interest in installing.

Wouldn't it be a lot more polite to just not run the test when the 
Test::More stuff doesn't exist? Rather than failing the testsuite? From a 
quick "git grep", this test is the only one that uses Test::More..

		Linus
