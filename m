From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/5] activate diff.renames by default
Date: Tue, 23 Feb 2016 18:44:53 +0100
Message-ID: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:45:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYH1Q-0000wx-9U
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbcBWRpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 12:45:09 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37115 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809AbcBWRpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:45:08 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj497004794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 18:45:04 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj6MT012979;
	Tue, 23 Feb 2016 18:45:06 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Feb 2016 18:45:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NHj497004794
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456854305.61404@428Fi4JykjNlN7jPvkQtIQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287093>

I have always wondered why diff.renames was not activated by default.
I've had it to true in my configuration for 9 years, and I've been
teaching newbies to set it for a while without issue. I think it's
time to activate it by default, but please let me know if I missed a
reason to keep it to false.

In any case, the first 3 patches are useful cleanups.

Matthieu Moy (5):
  Documentation/diff-config: fix description of diff.renames
  t4001-diff-rename: wrap file creations in a test
  t: add tests for diff.renames (true/false/unset)
  log: introduce init_log_defaults()
  diff: activate diff.renames by default

 Documentation/diff-config.txt |  7 ++--
 builtin/commit.c              |  1 +
 builtin/diff.c                |  1 +
 builtin/log.c                 | 16 ++++---
 builtin/merge.c               |  1 +
 diff.c                        |  5 +++
 diff.h                        |  1 +
 t/t4001-diff-rename.sh        | 97 +++++++++++++++++++++++++++++++++++--------
 t/t4013-diff-various.sh       |  2 +
 t/t4014-format-patch.sh       |  4 +-
 t/t4047-diff-dirstat.sh       |  3 +-
 t/t4202-log.sh                |  8 ++--
 12 files changed, 114 insertions(+), 32 deletions(-)

-- 
2.7.2.334.g35ed2ae.dirty
