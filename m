From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: add more cherry-pick options
Date: Wed, 10 Apr 2013 04:08:18 -0500
Message-ID: <1365584898-4842-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 11:09:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPr21-00060y-2h
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 11:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762485Ab3DJJJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 05:09:24 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:40659 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab3DJJJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 05:09:22 -0400
Received: by mail-qa0-f50.google.com with SMTP id bv4so152332qab.9
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 02:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ofnVWP91XAQlewXs6t0txKD4ik+vE0/MQP9QmQDVEfM=;
        b=oNW7WS9lwEVpbI6LMjjn6lDxRY0z8EJ3/PZTKyC4lz/myJ1I3+vFDc9OpplefoT4XD
         GIQ4gh+ZMZI9IVhjd+gzI3kbyH9EWi7PlTgif2i4XcpsFb0eJDbrafFf3Ut+bbHFWtUm
         tTjFD50NrCxKTvfBmMcx9qktSF7Msc9EAfVjZyQSWkxzQNqpDTNCYfuMa7kQq1i6wMf8
         66T1IM56FDUfKvLNxyuT/DNODPHUK/R3zL6CFrQFZKlvZDGHLZ/uCYHVgfzSjnkAoM/D
         E7Rk0Hzr1uPU+9e2xgxRUCVzm5EO0ZG+7jrUCgNFiv2JzkitXw/49pRlTLyA6+JEgSu5
         GorQ==
X-Received: by 10.224.9.198 with SMTP id m6mr1475695qam.46.1365584962234;
        Wed, 10 Apr 2013 02:09:22 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id e3sm29829728qeo.0.2013.04.10.02.09.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 02:09:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220674>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 93eba46..d257b90 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1124,9 +1124,14 @@ _git_cherry ()
 
 _git_cherry_pick ()
 {
+	local dir="$(__gitdir)"
+	if [ -f "$dir"/CHERRY_PICK_HEAD ]; then
+		__gitcomp "--continue --quit --abort"
+		return
+	fi
 	case "$cur" in
 	--*)
-		__gitcomp "--edit --no-commit"
+		__gitcomp "--edit --no-commit --signoff --strategy= --mainline"
 		;;
 	*)
 		__gitcomp_nl "$(__git_refs)"
-- 
1.8.2.1
