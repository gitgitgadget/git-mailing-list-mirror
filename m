From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 11/16] line-range-format.txt: document -L/RE/ relative search
Date: Tue,  6 Aug 2013 09:59:44 -0400
Message-ID: <1375797589-65308-12-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:01:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hos-0003fH-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab3HFOAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:51 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36439 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab3HFOAs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:48 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so905561obc.17
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P8ctNBPxU/3pGqX8H7aMZzjCFyPw0kLzeZxELkLfOag=;
        b=ezCfURyqDp2hx2dQvr+wMfZndtFm0EahTb+Qa1tfN7ovUGZmF5SggF9718Bb3YtQH6
         bbWbEMG6jNKhVeNocIIVza/TxLX1isixnh+Lc8M592F8jAuGLM1zZXUOFpL3ciArHeRM
         Nd+KT4c/3SRQC0Oi8+Mr5eMP4EJv36WBPgBzY1xv9dIr5Agxz9BSn+vBnaUYR1AaMtCm
         0uSGXv+It5Hkk5L9G4niBmiQehMOm1rqq8T1PAJFk+IocXEoNr0726M7ePyDXSv//rML
         DD7eR7G9tg7EvipZYIzEpJWPNdJgH62lRRNlhNrjeW6tSycGX0hWe2aFaaBHk8FOWC1w
         bMFA==
X-Received: by 10.182.119.229 with SMTP id kx5mr1151390obb.23.1375797648250;
        Tue, 06 Aug 2013 07:00:48 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231745>

Option -L/RE/ of blame/log now searches relative to the previous -L
range, if any. Document this.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/line-range-format.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index a1b2f4e..42d74f7 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -9,7 +9,9 @@ absolute line number (lines count from 1).
 - /regex/
 +
 This form will use the first line matching the given
-POSIX regex.  If <end> is a regex, it will search
+POSIX regex. If <start> is a regex, it will search from the end of
+the previous `-L` range, if any, otherwise from the start of file.
+If <end> is a regex, it will search
 starting at the line given by <start>.
 +
 
-- 
1.8.4.rc1.409.gbd48715
