From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] docs: clarify that passing --depth to git-clone implies
 --single-branch
Date: Wed, 6 Jan 2016 14:06:47 +0100
Message-ID: <568D1167.30700@gmail.com>
References: <n6j1cs$p4$1@ger.gmane.org>
 <CACsJy8D5DeDOCd1tn876s3+2fBR6e-X1UANkAeiw8tzAeDcDng@mail.gmail.com>
 <568D10D6.7020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 14:08:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGnon-00039M-Jg
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 14:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbcAFNHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 08:07:53 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38770 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbcAFNHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 08:07:51 -0500
Received: by mail-wm0-f53.google.com with SMTP id b14so74555553wmb.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=Dor+Pk2jPYUgZ+OHljFDJl0MknMkrYm5Bd7ObIvgJn0=;
        b=gPj44HY7Q2ltwCYojCUjjs6LhTSMQRHJRnhHl5ltaVGRlFiNw3WlgQtftLa3v+3h3y
         aZyFYhlX7qnzDzQ+sQ+m5zCJ2pmr6pPCtFeiePMvBY+OjSP+ia9XbDIhk1xZn2LR3c0h
         BW1RdyEhQcsO0Swia1bPeE22BDpFO3IdBRDW2xAAXqd3w3ZVqsMg62AKw/jOgDUTycgw
         O1Al39KaVsVxQ7OLt+viFa5/7AneW3f5MqSgahKVDwn55y9V1uEeNZouDhVsuQqW5z1Y
         fEvbTrTVJ4RYAv6TWG1nj+Tj5q3RDZMvcwgqOUqh7zSTDKrxgQBFp4I5lHxOt8dHOcsG
         yVVg==
X-Received: by 10.28.55.209 with SMTP id e200mr10600866wma.2.1452085670650;
        Wed, 06 Jan 2016 05:07:50 -0800 (PST)
Received: from [10.223.62.214] ([131.228.216.134])
        by smtp.googlemail.com with ESMTPSA id 67sm8672523wmp.20.2016.01.06.05.07.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jan 2016 05:07:50 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <568D10D6.7020707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283441>

It is confusing to document how --depth behaves as part of the
--single-branch docs. Better move that part to the --depth docs, saying
that it implies --single-branch by default.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-clone.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6bf000d..943de8b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -190,15 +190,14 @@ objects from the source repository into a pack in the cloned repository.
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-	specified number of revisions.
+	specified number of revisions. Implies `--single-branch` unless
+	`--no-single-branch` is given to fetch the histories near the
+	tips of all branches.
 
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
-	branch remote's `HEAD` points at. When creating a shallow
-	clone with the `--depth` option, this is the default, unless
-	`--no-single-branch` is given to fetch the histories near the
-	tips of all branches.
+	branch remote's `HEAD` points at.
 	Further fetches into the resulting repository will only update the
 	remote-tracking branch for the branch this option was used for the
 	initial cloning.  If the HEAD at the remote did not point at any
-- 
2.7.0.windows.1
