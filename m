From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] fixup for "refs.c: enable large transactions"
Date: Thu, 22 Jan 2015 15:11:33 -0800
Message-ID: <1421968297-25407-2-git-send-email-sbeller@google.com>
References: <54C0DDE7.8030708@alum.mit.edu>
 <1421968297-25407-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org, ramsay@ramsay1.demon.co.uk
X-From: git-owner@vger.kernel.org Fri Jan 23 00:11:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQup-0001Wa-Fw
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 00:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbbAVXLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 18:11:44 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:43728 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbbAVXLm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 18:11:42 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so23696594igk.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 15:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Y3olTYqVlGs7q/YVNm/SNVR1T+AP68KiY7rLMq9lnI=;
        b=lCTL7+1f9XnCHLrhh+LESPG2zQ9MmNA4Ti3n4s6V90hYhxIZRhd4LsxiUQD/6P3p6w
         COdCFbYB/Rr1mvOuKxuL2m5nbKuOxDuOey2kU8FWXaL+yGSMMx/Oco4mK8IY5Owe/1ZN
         yDJjFsLlkstST8hbgyNOmXKEonpHRFuPaRcz3y8mBZIBA3ts/io3LYTE2v3nHzIlkBwF
         tPC/c2VqNGmpDoOarngqKantzqZ9y++H1mRBthrDBWxIK57YBTTxFGhaOhR5RJl2NIKw
         c1AWo0fpS8pnpa5bL7juxp2B5XlNcO7wMtQOn76hMrbiFfZ+JDgScSXRy4G1p2rqI89m
         gxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Y3olTYqVlGs7q/YVNm/SNVR1T+AP68KiY7rLMq9lnI=;
        b=WvHnhKhv068CDVNvI8C1KYR4jKRc2wX2zNeXIaIcMjg1ELZC8GIZDn9SLrd02FrWDt
         N1+vE/qR/NVt1+mPsBDsSPU0WCyQzlaglUP34NQmpbYj91kYR/a81PVV0rT/HZp3Mg77
         E+7xmfhzmvkZPt8RR02Tkymqum0Qbobr5WxiQ5+Ka+IIGZpZjVAJB18OxpnpZr/2wbZo
         gVFLi8P1KyhQyTWaACAjmhHBCZclui286PWV5fal8YbkQXw3TqjSQIHyHYqX2K33Fz9H
         z+oQG6gDlvPJr2iPwsxA9buGcCJK8oihQkiINGqKt5XMw8cBv29oM4ubJLwHmB+YyS9a
         wnqQ==
X-Gm-Message-State: ALoCoQmihbXzPteVB/kbW5oCJX0729OxXNNUjmB7TockoZmq+FLUa/lJi+O56tmtR9b1pN2Lcpoc
X-Received: by 10.107.133.203 with SMTP id p72mr755053ioi.31.1421968302123;
        Thu, 22 Jan 2015 15:11:42 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e0f4:42de:391f:3cc5])
        by mx.google.com with ESMTPSA id w3sm240315ioi.10.2015.01.22.15.11.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 Jan 2015 15:11:41 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421968297-25407-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262888>

This will fix the warnings Ramsay Jones pointed out.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 9fc0e60..aae3b66 100644
--- a/refs.c
+++ b/refs.c
@@ -3058,12 +3058,12 @@ static int write_sha1_to_lock_file(struct ref_lock *lock,
 {
 	if (lock->lk->fd == -1) {
 		if (reopen_lock_file(lock->lk) < 0
-		    || fdopen_lock_file(lock->lk, "w") < 0
+		    || fdopen_lock_file(lock->lk, "w") == NULL
 		    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41
 		    || close_lock_file(lock->lk) < 0)
 		    return -1;
 	} else {
-		if (fdopen_lock_file(lock->lk, "w") < 0
+		if (fdopen_lock_file(lock->lk, "w") == NULL
 		    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41)
 		return -1;
 	}
-- 
2.2.1.62.g3f15098
