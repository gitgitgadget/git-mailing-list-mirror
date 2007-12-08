From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 0/3] builtin-commit fixes
Date: Sat,  8 Dec 2007 12:38:06 +0100
Message-ID: <1197113889-16243-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, krh@redhat.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 12:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0y1L-0002Ln-5E
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 12:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbXLHLih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 06:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbXLHLih
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 06:38:37 -0500
Received: from wincent.com ([72.3.236.74]:34206 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbXLHLig (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 06:38:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB8BcAA9021147;
	Sat, 8 Dec 2007 05:38:11 -0600
X-Mailer: git-send-email 1.5.3.7.1115.gaa595
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67542>

A little series to bring built-in commit back in line with the
behaviour as implemented by git-commit.sh and described in the
documentation.

1/3 Allow --no-verify to bypass commit-msg hook

- git-commit.sh used to do this, but builtin-commit wasn't.

2/3 Documentation: fix --no-verify documentation for "git commit"

- The "git commit" man page should mention the commit-msg hook to
bring it in line with what's in the hook notes and in
Documentation/hooks.txt.

3/3 Fix commit-msg hook to allow editing

- Again, git-commit.sh allowed this, but builtin-commit wasn't
doing so.

I have manually tested these changes and they seem to work, but
the fact that the test suite didn't break when the behaviour of
"git commit" changed is indicative of a hole in the suite. I am
not very familiar yet with the test machinery, but I am going
to see if I can whip something up.

Cheers,
Wincent
