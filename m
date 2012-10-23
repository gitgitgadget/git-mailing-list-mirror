From: Peter Krefting <peter@softwolves.pp.se>
Subject: [RFC PATCH 0/2] Localize log output
Date: Tue, 23 Oct 2012 13:24:09 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1210231323480.602@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 14:24:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQdWy-0001nU-9Y
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 14:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab2JWMYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 08:24:12 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:38635 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756505Ab2JWMYM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 08:24:12 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q9NCOAUj000626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 23 Oct 2012 14:24:10 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q9NCO9Iv000622
	for <git@vger.kernel.org>; Tue, 23 Oct 2012 14:24:09 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 23 Oct 2012 14:24:10 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208224>

In v1.8.0, I saw a regression in, among other, "git show --stat" in
that it would no longer output the diffstat in Swedish. This turned
out to be intentional, to fix format-patch and friends, but I liked
the old behaviour.

This series tries to fix that, and related code such as "git log",
while making sure that "git format-patch" still outputs in English.

I am posting this as a RFC, as I might very well have broken something
else in the process, from not knowing the code well enough.

The branch is also available from
https://github.com/nafmo/git-l10n-sv/commits/fix-diff-translation-20121023-1.8.0
with an updated Swedish translation.

Peter Krefting (2):
   Use localized date in log output
   Localize diff and log output

  builtin/apply.c  |  2 +-
  builtin/commit.c |  4 +--
  builtin/log.c    |  6 ++--
  commit.h         |  3 +-
  date.c           |  4 ++-
  diff.c           | 22 +++++++++-----
  diff.h           |  5 +++-
  gettext.c        |  1 +
  log-tree.c       | 11 +++++--
  pretty.c         | 87 +++++++++++++++++++++++++++++++++++++++++++-------------
  strbuf.c         | 10 +++++++
  strbuf.h         |  1 +
  12 files changed, 119 insertions(+), 37 deletions(-)

-- 
1.8.0
