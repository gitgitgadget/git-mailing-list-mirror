From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] docs: clarify that --depth for git-fetch works with newly
 initialized repos
Date: Fri, 8 Jan 2016 10:32:52 +0100
Message-ID: <568F8244.2030309@gmail.com>
References: <n6j1cs$p4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 10:33:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHTPq-0001Ns-JL
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 10:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbcAHJc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 04:32:58 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35959 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbcAHJc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 04:32:56 -0500
Received: by mail-wm0-f54.google.com with SMTP id l65so127523575wmf.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 01:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=bO0VSCYua8+WRl9xv1SxlIwVuOKMJ9x/c1gP7Tq/Tgw=;
        b=TrJoDxs+xGdc4MtbixTx0vJifi9FGb9ax08Smb4gm2wK27dbAKE2Ld5sQHrRdBUuqw
         HBChWGtccrsdkhTaK2gW5ZTM0ZFIv4qdejSl3Bkz6TuBvJ4udXIHRdA98bMC0AKMdOHF
         7Qa/uEQR+AatHO7kAiLQRwso+8L9Nf4dClD+Rv490qLpYcbPLfy+Tf9f09gvOp8tuGsw
         09FEqNDr59VCwZQMsrAksk5MJ/ucXibbpwCWNhcK5cC09S1QkWD0ijZevp9//3BvbMoH
         BrUfZHHVx46SmqMMYZ8SpBN5Hlsn2px6tQ+MvrQ4eHbwYkw8zzUmHf7NoTWGaiEvA1nB
         Xg3Q==
X-Received: by 10.194.111.232 with SMTP id il8mr137354883wjb.150.1452245575013;
        Fri, 08 Jan 2016 01:32:55 -0800 (PST)
Received: from [10.223.62.214] ([131.228.216.134])
        by smtp.googlemail.com with ESMTPSA id bg10sm104836460wjb.46.2016.01.08.01.32.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jan 2016 01:32:54 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <n6j1cs$p4$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283530>

The original wording sounded as if --depth could only be used to deepen or
shorten the history of existing repos. However, that is not the case. In a
workflow like

    $ git init
    $ git remote add origin https://github.com/git/git.git
    $ git fetch --depth=1

The newly initialized repo is properly created as a shallow repo.
---
 Documentation/fetch-options.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 45583d8..78cd265 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -8,10 +8,11 @@
 	option old data in `.git/FETCH_HEAD` will be overwritten.
 
 --depth=<depth>::
-	Deepen or shorten the history of a 'shallow' repository created by
-	`git clone` with `--depth=<depth>` option (see linkgit:git-clone[1])
-	to the specified number of commits from the tip of each remote
-	branch history. Tags for the deepened commits are not fetched.
+	Limit fetching to the specified number of commits from the tip of
+	each remote branch history. If fetching to a 'shallow' repository
+	created by `git clone` with `--depth=<depth>` option (see
+	linkgit:git-clone[1]), deepen or shorten the history to the specified
+	number of commits. Tags for the deepened commits are not fetched.
 
 --unshallow::
 	If the source repository is complete, convert a shallow
-- 
2.7.0.windows.1
