From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] Fix describe --contains --all
Date: Tue, 18 Jun 2013 22:43:23 +0530
Message-ID: <1371575608-9980-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 19:16:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UozWM-0002ru-F4
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567Ab3FRRQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 13:16:38 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35345 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab3FRRQh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 13:16:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so4206433pad.33
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JayteajMnMresbB56BP7dH/YZlyEBxTlUGJUH3eKw9k=;
        b=hSFUWgu84HViRn6KLJoVgWvhgi/OdjhNh8dVyYuhy41tc+Oc7EEDXwbmCbveZsPpdT
         b4KhKnFcgy2JXOQqNshDqVbjMVrvyT1bNkq1yzTC+D0XqBcyxeO20ql4FmRBv+WJ+y8T
         Cb2jgScP8VnPY4lwMzofvASz3b6SPTAZw2nI76yCsNnWG5zJBpc/JB2ixJjNG3HAB6ow
         DZRBA5iP9l1PQP+H7XuFFSE05gR3oGCt2nW0uTQOofGLO7AmF2ohJmFZ5h7/jqlsypav
         xiXnH74d6s4e1G8y6GuVzInDS9+Lrk+5BYf4/tE+Tx9RvcENBEIaE9/0eDQ3rTKK3kkj
         hs0Q==
X-Received: by 10.68.251.234 with SMTP id zn10mr17945410pbc.188.1371575797219;
        Tue, 18 Jun 2013 10:16:37 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id vz8sm20498303pac.20.2013.06.18.10.16.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 10:16:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228278>

Hi,

I discovered --contains --all in describe, and found out that it
doesn't work as advertised for a deep historical reason.  [3/5] is
super-important and addresses this issue; everything else is
decoration.

Thanks.

Ramkumar Ramachandra (5):
  prompt: clean up describe logic
  prompt: do not double-discriminate detached HEAD
  name-rev: fix assumption about --name-only usage
  name-rev: strip trailing ^0 in when --name-only
  name-rev doc: rewrite --stdin paragraph

 Documentation/git-name-rev.txt       | 12 +++++++-----
 builtin/name-rev.c                   | 13 ++++++++++---
 contrib/completion/git-prompt.sh     | 20 +++++++++++---------
 t/t4202-log.sh                       |  8 ++++----
 t/t6007-rev-list-cherry-pick-file.sh | 32 ++++++++++++++++----------------
 t/t9903-bash-prompt.sh               |  2 +-
 6 files changed, 49 insertions(+), 38 deletions(-)

-- 
1.8.3.1.456.gb7f4cb6.dirty
