From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 00/11] More consistant terminology ("remote-tracking branch", "not updated")
Date: Sat, 23 Oct 2010 18:31:11 +0200
Message-ID: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 23 18:33:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9h1u-0005ro-Ao
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 18:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757997Ab0JWQdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 12:33:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37900 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757970Ab0JWQdF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 12:33:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9NGGtM1005319
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 23 Oct 2010 18:16:55 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P9h09-0006cA-Bf; Sat, 23 Oct 2010 18:31:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P9h09-0007Hb-75; Sat, 23 Oct 2010 18:31:25 +0200
X-Mailer: git-send-email 1.7.3.2.537.g7e355
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 23 Oct 2010 18:16:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9NGGtM1005319
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1288455420.42903@lZZ5VIiaYA/kwN5dgMrgog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159798>

Following the discussion in

http://thread.gmane.org/gmane.comp.version-control.git/159287/
http://thread.gmane.org/gmane.comp.version-control.git/159287/focus=159288

this is an attempt to be more consistant in the terminology used in Git.

The first patch fixes git status's "changed but not updated", and the
rest tries to use "remote-tracking branch" consistantly. This
essentially changes the doc, and also does slight modifications to the
code. This changes error message, and maybe more controversially the
generated merge messages (in a separate patch in case this is too
controversial).

I've tried splitting this into systematic changes to ease review, but
patches should be applicable in any order (i.e. Junio: if you find
some of the patches good and uncontroversial, you can pick them
right away).

Patch "user-manual.txt: explain better the remote(-tracking) branch
terms" comes last, and adds a few sentences to make the distinction
between remote, remote branch, remote-tracking branches explicit.
Hopefully, this should avoid future users to have the same
difficulties as Thore ;-).

The last 2 patches are minor things I noticed while going through the
docs, but are essentially unrelated.

I'll be busy next week, so if anyone else wants to pick this patch
serie and update it according to list review, he's welcome. Otherwise,
it may have to wait.

Matthieu Moy (11):
  Better "Changed but not updated" message in git-status
  Remplace "remote tracking" with "remote-tracking"
  Change remote tracking to remote-tracking in non-trivial places
  Change "tracking branch" to "remote-tracking branch"
  Change "tracking branch" to "remote-tracking branch" in C code
  Change incorrect uses of "remote branch" meaning "remote-tracking"
  Change incorrect "remote branch" to "remote tracking branch" in C
    code
  Use 'remote-tracking branch' in generated merge messages
  user-manual.txt: explain better the remote(-tracking) branch terms
  git-branch.txt: mention --set-upstream as a way to change upstream
    configuration
  git-http-push.txt: fix typo (branch -> branches)

 Documentation/config.txt               |   13 ++++++-----
 Documentation/everyday.txt             |    6 ++--
 Documentation/fetch-options.txt        |    2 +-
 Documentation/git-branch.txt           |   14 +++++++-----
 Documentation/git-checkout.txt         |    2 +-
 Documentation/git-clone.txt            |    2 +-
 Documentation/git-describe.txt         |    2 +-
 Documentation/git-fetch.txt            |    2 +-
 Documentation/git-gc.txt               |    6 ++--
 Documentation/git-http-push.txt        |    2 +-
 Documentation/git-log.txt              |    2 +-
 Documentation/git-pull.txt             |    8 +++---
 Documentation/git-remote.txt           |    6 ++--
 Documentation/git-tag.txt              |    4 +-
 Documentation/gittutorial-2.txt        |    2 +-
 Documentation/gittutorial.txt          |    6 ++--
 Documentation/glossary-content.txt     |    8 +++---
 Documentation/rev-list-options.txt     |    2 +-
 Documentation/user-manual.txt          |   22 +++++++++++++++-----
 branch.h                               |    2 +-
 builtin/checkout.c                     |    4 +-
 builtin/fetch.c                        |    6 ++--
 builtin/fmt-merge-msg.c                |    6 ++--
 builtin/merge.c                        |    2 +-
 builtin/remote.c                       |    6 ++--
 contrib/examples/builtin-fetch--tool.c |    2 +-
 remote.c                               |    2 +-
 t/t1507-rev-parse-upstream.sh          |    2 +-
 t/t3409-rebase-preserve-merges.sh      |    2 +-
 t/t5400-send-pack.sh                   |    2 +-
 t/t5505-remote.sh                      |    6 ++--
 t/t5513-fetch-track.sh                 |    2 +-
 t/t7508-status.sh                      |   34 ++++++++++++++++----------------
 t/t7608-merge-messages.sh              |    4 +-
 wt-status.c                            |    2 +-
 35 files changed, 104 insertions(+), 91 deletions(-)

-- 
1.7.3.2.537.g7e355
