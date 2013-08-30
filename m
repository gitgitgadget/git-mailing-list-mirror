From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 18/28] rebase: cherry-pick: fix status messages
Date: Fri, 30 Aug 2013 00:56:12 -0500
Message-ID: <1377842182-18724-19-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmK-0007TR-QP
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826Ab3H3GBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:48 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:56822 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab3H3GBq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:46 -0400
Received: by mail-oa0-f42.google.com with SMTP id j10so1431228oah.29
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vuRvnqeNHfiJhprh6Mt5Mzh2LzcXfV7CGRt21Xz4/I4=;
        b=s5agfkf6kZ55YZ4bGX0N0zmGN386Xspasf/AGmP/M3MzxYvZvZ+CFzOYQeCr+SCan+
         QGKyjNMmrRHd8ga5afyhXjL8exSIuO0uzR+Ch1+G91ckPulwFglRW2rt79X27ei0UngD
         FceYK5iX27AJRK3wXDU2kh1OoAujk4XJ7GX4StzH30Z6Sv1DaZ3U6IdniZjAJgzSTVuc
         HuHcsu9yBF65INbWbkPRiD8wMBoOyrMq2HZxwurPvE4gNJBjB9LV5mOicZAEq0rywSq/
         Ou4HeZn9aif4SddfaHzbkUujNeDV68fEGZGQnfIyyLm1GyEujQDFPaFqIiS0mBn7xWnU
         Uxog==
X-Received: by 10.60.52.81 with SMTP id r17mr5655315oeo.3.1377842506236;
        Thu, 29 Aug 2013 23:01:46 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm32422221obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233413>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index e9ecccc..be17ec4 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -3,6 +3,9 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
+GIT_CHERRY_PICK_HELP="$resolvemsg"
+export GIT_CHERRY_PICK_HELP
+
 case "$action" in
 continue)
 	git cherry-pick --continue &&
-- 
1.8.4-fc
