From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 0/4] Removing deprecated parsing macros
Date: Mon, 29 Jul 2013 21:49:54 +0200
Message-ID: <1375127398-31904-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 29 21:49:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3tS2-00010T-Q8
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 21:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959Ab3G2Ttr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 15:49:47 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33027 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab3G2Ttq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 15:49:46 -0400
Received: by mail-wi0-f178.google.com with SMTP id j17so2951397wiw.5
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=NL7JAB18rd4pISd0oXTQzGe21RIVi9GEydtHPmc1aJc=;
        b=Hu0zofI+P0jCd47MvuxN0ydds7E+JEynprpzSYFtipEdCMt3LIwYWjUWc4IRE9uvMU
         Izkbnung6L6NMmPrvyFEVtdY/qsXMMh38W7Dg8KgN58Pmj/mAEAAapCfR8fOpyeh4Lvz
         XrXTWfR69l1AgzFh2EC3PzqfRsLpvEZBYXKbzJPTxMLmf+cnS4wZjAgBiSUYqazraspJ
         0oAo43PuUQSWxtG13iDD7zyI7BVYOVrzKfIYZhcf2Vz+e01J+2mUyIpDZzamIlDkMQbu
         7Cm8jeC/jAPgFacRF2mNXBALznOWOAGolkCXhmpS1FOAMFYGHB9SPrVMXfrPvEJuD6yk
         V0Yg==
X-Received: by 10.194.60.5 with SMTP id d5mr31325270wjr.26.1375127384966;
        Mon, 29 Jul 2013 12:49:44 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id w4sm24743411wia.9.2013.07.29.12.49.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 12:49:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231323>

The first patch of this series is a start on replacing
the deprecated OPT_BOOLEAN macro by OPT_BOOL.
All occurences have been reviewed so far, only 140 occurences to go.

The 3 patches after the first are things I noticed during the
review for the macro replacement. These should ease readability.

I'll continue replaceing macros the next days, this series is
for review only.

Stefan Beller (4):
  Replace deprecated OPT_BOOLEAN by OPT_BOOL
  log, format-patch: also accept short parameter 'q' to be quiet
  checkout: remove superfluous local variable
  name-rev: ease up condition

 builtin/check-attr.c |  8 ++++----
 builtin/checkout.c   | 22 ++++++++++------------
 builtin/clone.c      | 16 ++++++++--------
 builtin/fsck.c       | 16 ++++++++--------
 builtin/grep.c       | 36 ++++++++++++++++++------------------
 builtin/log.c        | 14 +++++++-------
 builtin/ls-tree.c    |  6 +++---
 builtin/merge-file.c |  2 +-
 builtin/merge.c      | 12 ++++++------
 builtin/mv.c         |  2 +-
 builtin/name-rev.c   | 14 +++++++-------
 builtin/notes.c      |  4 ++--
 builtin/replace.c    |  6 +++---
 builtin/reset.c      |  2 +-
 builtin/rev-parse.c  |  4 ++--
 15 files changed, 81 insertions(+), 83 deletions(-)

-- 
1.8.4.rc0.1.g8f6a3e5
