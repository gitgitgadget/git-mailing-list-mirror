From: David Kastrup <dak@gnu.org>
Subject: git branch --merged and git branch --verbose do not combine
Date: Sun, 14 Sep 2014 09:52:04 +0200
Message-ID: <87fvfutza3.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 10:24:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT56x-0001ui-Ky
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 10:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbaINIYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 04:24:39 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:34793 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbaINIYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 04:24:15 -0400
Received: from localhost ([127.0.0.1]:33835 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1XT56U-00082B-SC
	for git@vger.kernel.org; Sun, 14 Sep 2014 04:24:15 -0400
Received: by lola (Postfix, from userid 1000)
	id 3BE6EE0533; Sun, 14 Sep 2014 09:52:04 +0200 (CEST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257007>


dak@lola:/usr/local/tmp/lilypond$ ../git/git branch --merged --verbose
fatal: malformed object name --verbose
dak@lola:/usr/local/tmp/lilypond$ ../git/git branch --verbose --merged
* (detached from 5b2267a) 1c23f39 Merge branch 'issue4097' into HEAD
  issue346                8cf033e Issue 346: monochord issues
dak@lola:/usr/local/tmp/lilypond$ ../git/git branch --merged
* (detached from 5b2267a)
  issue346
  issue3855
  issue4030
  issue4083
  issue4092
  issue4096
  issue4097
  removelyr
  test-master
  test-staging

So depending on the order of --verbose and --merged, one gets an
incomplete list (basically ignoring --merged) or an error message.

Since both behavior and naming of the --verbose option is more or less
orthogonal to other listing options, it would make sense to allow it to
combine with them.

-- 
David Kastrup
