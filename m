From: martinvz <martin.von.zweigbergk@gmail.com>
Subject: Problems with file name case on Windows.
Date: Thu, 22 Apr 2010 12:54:17 -0800 (PST)
Message-ID: <1271969657620-4947131.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 22:54:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O53QD-0003QD-Kk
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 22:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757561Ab0DVUyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 16:54:20 -0400
Received: from kuber.nabble.com ([216.139.236.158]:56733 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600Ab0DVUyS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 16:54:18 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <martin.von.zweigbergk@gmail.com>)
	id 1O53Pd-00056v-L4
	for git@vger.kernel.org; Thu, 22 Apr 2010 13:54:17 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145561>


Under Cygwin, if you add a file "a" in one commit, then rename the file to
"A" and commit again, both files will be in the new commit. Running the
following line under Cygwin produces a commit with both files ("a" and "A").
Running it on Linux produces a commit with one file ("A"), as expected.

git init; git config core.ignorecase false; touch a; git add a; git commit
-m a; mv a A; git add -A; git commit -m A

The problem seems to be with the "git add -A" part, since it is possible to
get around the problem by running "git add A" followed by "git rm a" (or by
using lower-level commands, I suppose). What are the chances of getting this
fixed? It's mostly annoying when importing existing code where it's harder
to use the add-rm workaround, since you don't know which files have changed
file name case.
-- 
View this message in context: http://git.661346.n2.nabble.com/Problems-with-file-name-case-on-Windows-tp4947131p4947131.html
Sent from the git mailing list archive at Nabble.com.
