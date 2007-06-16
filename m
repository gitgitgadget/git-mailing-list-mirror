From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 00/11] Document missing options
Date: Sat, 16 Jun 2007 21:03:36 +0200
Message-ID: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdTU-0007Dl-HG
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbXFPS6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbXFPS6M
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:12 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:13011 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbXFPS6L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:11 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1608069mue
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=enyGHedpWGGrdK4i6w4HH/yo9gBdGCohMEAv0afQZCRlhG/0LojmvyHwz6niOOB2XgNw/x4Deo1PuYQtirn8ncY4eiGQOMEKt7wdkTFD0DiwofrkybYjSqQCMgrqV1KJdtdGt2A2vKNEacWD/oOYL3WcysQ/48dbZtTbYEAd7VM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=TyBz5W+YGQ5BXALJZCNuT2iO1h+LrMm19cwtHMEFYPOL2RcQ6enmfarsa30ZhvirgJ0Ts2G/q01B1uKcSnWKIz2xm4sLHeT/GtCftYTCQUcahRqbEtpFdA3YAHqjD5lkUVssKtAmsHF1HgtigNZTcAGbIwxvlmCpGa9c5o0Cuk4=
Received: by 10.82.182.1 with SMTP id e1mr8115714buf.1182020289186;
        Sat, 16 Jun 2007 11:58:09 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id h6sm1875492nfh.2007.06.16.11.58.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:08 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3mAo004222;
	Sat, 16 Jun 2007 21:03:50 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3m8N004221;
	Sat, 16 Jun 2007 21:03:48 +0200
X-Mailer: git-send-email 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50293>

This series of patches documents [some] options which were missing
from the documentation.

Table of contents:
==================
 [PATCH 01/11] Use tabs for indenting definition list for options in git-log.txt
 [PATCH 02/11] Document git log --full-diff
 [PATCH 03/11] Document git log --abbrev-commit, as a kind of pretty option
 [PATCH 04/11] Document that '--message=<msg>' is long version of '-m <msg>'
 [PATCH 05/11] Document that '--no-checkout' is long version of '-n' option of git-clone
 [PATCH 06/11] Document git rev-list --timestamp
 [PATCH 07/11] Document git rev-list --full-history
 [PATCH 08/11] Document git rev-parse --is-inside-git-dir
 [PATCH 09/11] Document git read-tree --trivial
 [PATCH 10/11] Document git reflog --stale-fix
 [PATCH 11/11] Document git commit --untracked-files and --verbose

What is still undocumented are:
 * git clone --no-separate-remote, which is deprecated and perhaps
   should be left undocumented.
 * git commit -o|--only, which is now default when providing files
   to be committed, and -i|--include is not present. Description
   of this option was removed in commit 6c96753d:
     "Documentation/git-commit: rewrite to make it more end-user friendly."
   Should we re-add this description?
 * git commit --reedit-message (--reedit) and --reuse-message
   (--reuse). I'm not sure what are the meaning of those options, and
   how they differ from -c (or -C --edit) and -C. I think, but I'm not
   sure, that --reedit-message is long form of -c, and --reuse-message
   is long form of -C.
 * git reflog --dry-run. The --dry-run option in other command describe
   what would be done. I think that this option does not work for this
   command.

I have checked only ling options in builtins and shell scripts; I have
not checked Perl scripts not short options, and I might have missed
some options for which the same named option but for different command
exists in the documentation.

I might have missed modifying usage strings in command source, and
in command documentation.

But I think this series of patches is a good start...
---
 Documentation/git-clone.txt      |    1 +
 Documentation/git-commit.txt     |   12 ++++++++++--
 Documentation/git-log.txt        |    9 ++++++++-
 Documentation/git-read-tree.txt  |    8 +++++++-
 Documentation/git-reflog.txt     |   13 +++++++++++++
 Documentation/git-rev-list.txt   |   13 +++++++++++++
 Documentation/git-rev-parse.txt  |    4 ++++
 Documentation/pretty-options.txt |    9 +++++++++
 builtin-read-tree.c              |    2 +-
 9 files changed, 66 insertions(+), 5 deletions(-)

--
Jakub Narebski
Poland
