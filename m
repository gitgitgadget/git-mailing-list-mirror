From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 3/7] Documentation/git-send-pack.txt: Document --signed
Date: Thu, 13 Aug 2015 15:00:47 -0400
Message-ID: <1439492451-11233-4-git-send-email-dborowitz@google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 21:01:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxkN-00032R-TK
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbbHMTA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:00:59 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36997 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbbHMTA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:00:58 -0400
Received: by igui7 with SMTP id i7so5791280igu.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n0q+PCKEGL74laP6oi03i7y83KeYo40dNN6HibpN1aU=;
        b=TD9bCdpULFeBc02aQRRgYpnIcN6PnkBIDEbnYFyiW1JP0a5E2JSgDpoQNTHrezvaKK
         J7kNceOZoCe3rDoy8HkS899n5Wvxn6eNQ/lke680LYL5RGeQberhhdi4XjrB2iWwasq3
         bR4+tV/bAim/CBvLIZUGLp5X95U7XAvFrSR/vXXGIabxIIJim0mRwwKaQj2IAz5u6pss
         x4ycI4lcS2hlVojjq70T1c+2PQvJqW/OS6jWzPivN7fjlZpkqBGfS5hoak0m8oFeihT7
         adQ1dswfZcPWzFkgNxiNOMNCzS0jCe7fyCJHovU87ssIFx5WyKzyt20FSMazEVBj2rMg
         AnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n0q+PCKEGL74laP6oi03i7y83KeYo40dNN6HibpN1aU=;
        b=BFErwRZf1x4zLgfJ9nHiPh7MXyZCUgbw5rnetpZDMUWBHBLwo229ecDvxVihLvnclf
         etODGd+23u/HfvvpIHUN+oynxbuB/BnfWCFeM4NV1VZXN3tsxspsyMUKWTmmYwQu+NUq
         MNGqzmmVOLndM+fWldpuyuUGn5XcouFKzwP6NQSXhbw3qd6xmVvEfMFoJlvTueYc8PRT
         VW3PsZ6gWOBvLOa4bCd8sus8BKfr8Eg3tgyNGXfm8XF60WHudufCq0G9U2p3ZyU5Gjzu
         9Zpk78jWkN3iJcnzFLOqOepvEG1AnRlhFhTZZ9u7/UXpdGoYuviB5/C93LD/g5O6j+gB
         GFiA==
X-Gm-Message-State: ALoCoQmU/0GXc6RNB5MywhNMu+/ZiXNgF9pOmGYq8uDTgqGS83XnhJIQJUTPGH6998dVyaPO4ne+
X-Received: by 10.50.142.67 with SMTP id ru3mr29354305igb.16.1439492457887;
        Thu, 13 Aug 2015 12:00:57 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id c91sm2078646ioj.43.2015.08.13.12.00.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 12:00:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275875>

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/git-send-pack.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 6affff6..dde13b0 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
-		[--verbose] [--thin] [--atomic] [<host>:]<directory> [<ref>...]
+		[--verbose] [--thin] [--atomic] [--signed]
+		[<host>:]<directory> [<ref>...]
 
 DESCRIPTION
 -----------
@@ -68,6 +69,14 @@ be in a separate packet, and the list must end with a flush packet.
 	fails to update then the entire push will fail without changing any
 	refs.
 
+--signed::
+	GPG-sign the push request to update refs on the receiving
+	side, to allow it to be checked by the hooks and/or be
+	logged.  See linkgit:git-receive-pack[1] for the details
+	on the receiving end.  If the `gpg` executable is not available,
+	or if the server does not support signed pushes, the push will
+	fail.
+
 <host>::
 	A remote host to house the repository.  When this
 	part is specified, 'git-receive-pack' is invoked via
-- 
2.5.0.276.gf5e568e
