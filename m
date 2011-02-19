From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/3] Git rename detection improvements
Date: Fri, 18 Feb 2011 20:22:24 -0800
Message-ID: <AANLkTi=+5w6=-RCge3n=bv-5CLBbdY3bNVGcepyz7HrR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 05:23:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqeLy-0008RV-4Y
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 05:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578Ab1BSEXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 23:23:17 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37128 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645Ab1BSEXP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 23:23:15 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p1J4MjHa026640
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 18 Feb 2011 20:22:45 -0800
Received: by iyj8 with SMTP id 8so4171899iyj.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 20:22:44 -0800 (PST)
Received: by 10.42.227.133 with SMTP id ja5mr1770517icb.509.1298089364105;
 Fri, 18 Feb 2011 20:22:44 -0800 (PST)
Received: by 10.231.16.129 with HTTP; Fri, 18 Feb 2011 20:22:24 -0800 (PST)
X-Spam-Status: No, hits=-103.461 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167247>

Ok, so this is a cleaned-up series of three commits that I think are
worthy of being considered for inclusion. They're against current
master, maybe I should have done it against pu or next, but I doubt it
really clashes with anything, since the code hasn't changed recently
afaik.

                          Linus

---

Linus Torvalds (3):
  for_each_hash: allow passing a 'void *data' pointer to callback
  diffcore-rename: propler honor the difference between -M and -C
  diffcore-rename: improve estimate_similarity() heuristics

 builtin/describe.c             |    4 +-
 diffcore-rename.c              |   69 ++++++++++++++++++++-------------------
 hash.c                         |    4 +-
 hash.h                         |    2 +-
 t/t4003-diff-rename-1.sh       |    2 +-
 t/t4004-diff-rename-symlink.sh |    2 +-
 t/t4005-diff-rename-2.sh       |    2 +-
 t/t4008-diff-break-rewrite.sh  |    4 +-
 t/t4009-diff-rename-4.sh       |    2 +-
 9 files changed, 46 insertions(+), 45 deletions(-)

--
1.7.4.1.51.g2bf8a
