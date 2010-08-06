From: Daniel Johnson <computerdruid@gmail.com>
Subject: [PATCH] Documentation: changes in the behavior of tagopt
Date: Fri,  6 Aug 2010 09:54:27 -0400
Message-ID: <1281102867-6490-1-git-send-email-ComputerDruid@gmail.com>
References: <AANLkTikf96RLfTq4Q6DAPesr6j70CJfT8vBzidJk42dE@mail.gmail.com>
Cc: Daniel Johnson <ComputerDruid@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 15:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhNNb-0004Od-T9
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 15:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761389Ab0HFNya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 09:54:30 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34435 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761367Ab0HFNy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 09:54:29 -0400
Received: by vws3 with SMTP id 3so6131120vws.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=9NQNAtVt/wZql3N/oZrLAAykqR+qt5L9qlxQQFUMKpM=;
        b=pKxt0fTqsj0pY65W/MZf9fsZ13LkhNvsEnCqHx6OK3SapqzfQlPCFcnkxYSL7G09lu
         NCHSSdubIkHCn5pHNnM0163zNF5Swcq9Zn1OjeNHDyLmXZZvX9JCbrgybhfVJspXc5xg
         UV29HqB1OA+a4KHaY2qT9B1BdQWzuMHjZLmdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Zi8HEy+ou+bpmnKRrwRy/pHswwSt2uYlIjS+diGUrSjCzBGmnt920s2kU7PWyDMuWK
         BDMn7PBRGzgiD5UPgDLIyQJ3phJhl6jgQxL0iq+2WiLzyJveALBI1KbqdCoNvM4ZHwG0
         Z7wWkNZDEZ4uee/PTqX8HAODFi2Ha+2PZuRgE=
Received: by 10.220.59.202 with SMTP id m10mr8321894vch.163.1281102868229;
        Fri, 06 Aug 2010 06:54:28 -0700 (PDT)
Received: from ComputerDruid@gmail.com ([151.188.213.237])
        by mx.google.com with ESMTPS id v11sm818219vbb.2.2010.08.06.06.54.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 06:54:26 -0700 (PDT)
Received: by ComputerDruid@gmail.com (sSMTP sendmail emulation); Fri, 06 Aug 2010 09:54:30 -0400
X-Mailer: git-send-email 1.7.2
In-Reply-To: <AANLkTikf96RLfTq4Q6DAPesr6j70CJfT8vBzidJk42dE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152780>

---
How does this look?

 Documentation/config.txt        |    4 +++-
 Documentation/fetch-options.txt |    8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f81fb91..682ebef 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1627,7 +1627,9 @@ remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
 	fetching from remote <name>. Setting it to \--tags will fetch every
 	tag from remote <name>, even if they are not reachable from remote
-	branch heads.
+	branch heads. Passing these flags directly to linkgit:git-fetch[1] can
+	override this setting. See options \--tags and \--no-tags of
+	linkgit:git-fetch[1].
 
 remote.<name>.vcs::
 	Setting this to a value <vcs> will cause git to interact with
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 9333c42..2fdfeac 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -49,7 +49,9 @@ ifndef::git-pull[]
 endif::git-pull[]
 	By default, tags that point at objects that are downloaded
 	from the remote repository are fetched and stored locally.
-	This option disables this automatic tag following.
+	This option disables this automatic tag following. The default
+	behavior for a remote may be specified with the remote.<name>.tagopt
+	setting. See linkgit:git-clone[1].
 
 -t::
 --tags::
@@ -58,7 +60,9 @@ endif::git-pull[]
 	objects reachable from the branch heads that are being
 	tracked will not be fetched by this mechanism.  This
 	flag lets all tags and their associated objects be
-	downloaded.
+	downloaded. The default behavior for a remote may be
+	specified with the remote.<name>.tagopt setting. See
+	linkgit:git-clone[1].
 
 -u::
 --update-head-ok::
-- 
1.7.2
