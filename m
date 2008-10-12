From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 0/4] Decodings
Date: Mon, 13 Oct 2008 00:50:56 +0200
Message-ID: <1223851860-13068-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Oct 13 00:54:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp9ot-0001ia-Lw
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 00:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbYJLWwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 18:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbYJLWwj
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 18:52:39 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19052 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbYJLWwh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 18:52:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C5F6C147EACA;
	Mon, 13 Oct 2008 00:52:35 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zf95EGVdol1J; Mon, 13 Oct 2008 00:52:17 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id CF4288003E7;
	Mon, 13 Oct 2008 00:52:15 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98061>

These patches might be slightly controversial. Since there is no perfect
solution, we may want to try something that works to some extent and gives
what a user might expect, i.e. presenting to a viewer the same glyphs 
that the user who entered them saw, to the extent it is possible.

We already handle commit messages like this for the old style objects (sort of).
This patch set also affects other data like refs. Currenly no sane solution
exists in git so nothing really works well outside the non-ascii range for
refs anyway so we can discuss what should happen with refs that contain
non-ascii characters. The best thing is to avoid them, but some of us live
in countries with funny dots in what we do and other have even stranger ways
of expressing what they do, and hence things like branch names etc.

Legacy SCM to GIT conversion programs seem to do every variation of transcoding/
not transcoding commit messages and file names to UTF-8 so there is an issue here.
The nice thing about transcoding filenames to UTF-8 is that they work on all
platforms. A non-UTF-8 filename in a UTF-8 environement doesn't. In particular 
such filenames are more or less inaccessible to a Java programs. For the reverse
case it looks really bad. C Git currently does not transform file names. Missing from
this patch set is test cases. As it is quite undefined in git what happens that
is sort of ok so far, but I'd like to define it too in the same way.

-- robin
