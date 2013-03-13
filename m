From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH] contrib/subtree: Replace invisible carriage return with a visible \r
Date: Wed, 13 Mar 2013 22:42:34 +0000
Message-ID: <1363214554-4490-1-git-send-email-pcampbell@kemitix.net>
References: <CALeLG_kSye2xRoUJ8ytjx-bsj6oSG_brPbj-X3yfXuLA-KEppA@mail.gmail.com>
Cc: David Greene <greened@obbligato.org>,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	Paul Campbell <pcampbell@kemitix.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 23:43:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFuOD-0006xw-3P
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 23:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364Ab3CMWmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 18:42:51 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:40805 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab3CMWmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 18:42:50 -0400
Received: by mail-wg0-f48.google.com with SMTP id 16so1449292wgi.15
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 15:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=NNX1Sk9s2aYNl7JufQDy93vvV9O6uc5Zop999GBH/qA=;
        b=iQ2ubjqr7RtqMQgYiO4v3mfRp3tcTLpP6wJBvsaKEf8SBAbIpM7mkDCg+ki1hxRWD8
         PjQE/wPQPAahNW4vqGG8Q4r/69lx3OES2dgn58BVUHugNOP85Z8XQRCFeWlb6ywnarQh
         Hm84xJK96oQI8YRwiwhZ+gVo4NXEdBQI6UATis18dqwBgSzW+N86e9cJesYYFcqWbrUI
         /2y7+QWdYEJnM5P5xdckjwqpxVCMwiSlGIfMEo81Wx6cqRhNeK3zHlR96y/uBbXCpJdY
         PboyjXZ4MKZM0FqdxfeuelkjjCX3zuCKlmT64N6JKsNFvXZmQF2Xm7mwee44qWYylIdE
         pRZA==
X-Received: by 10.194.77.129 with SMTP id s1mr178741wjw.17.1363214569191;
        Wed, 13 Mar 2013 15:42:49 -0700 (PDT)
Received: from coyote.home (host-2-102-86-203.as13285.net. [2.102.86.203])
        by mx.google.com with ESMTPS id bj9sm5680666wib.4.2013.03.13.15.42.47
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 15:42:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <CALeLG_kSye2xRoUJ8ytjx-bsj6oSG_brPbj-X3yfXuLA-KEppA@mail.gmail.com>
X-Gm-Message-State: ALoCoQnjFr3vUPWMjF3O9M2vYMIlxSudb/oV0U8It5WgR6fLiINp5Hoz3Iuo8mweS94fkG17CQpa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218103>

From: Matt Hoffman <matt.hoffman@quantumretail.com>

The ctrl-M (^M) character used for the carriage return (CR) is not visible
in all (most) text editors and is often silently converted to a new
line (NL) or CR/NL combo.

'say' is a wrapper for echo with accepts the option -e to interperet
escaped characters. \r becomes a CR, yet is not munged by text
editors.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---

Rerolled with the Conflicts lines removed.

 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 2d9b071..5314bd0 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -595,7 +595,7 @@ cmd_split()
 	eval "$grl" |
 	while read rev parents; do
 		revcount=$(($revcount + 1))
-		say -n "$revcount/$revmax ($createcount)
"
+		say -ne "$revcount/$revmax ($createcount)\r"
 		debug "Processing commit: $rev"
 		exists=$(cache_get $rev)
 		if [ -n "$exists" ]; then
-- 
1.8.2
