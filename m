X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: [PATCH] Trim hint printed when gecos is empty.
Date: Tue, 28 Nov 2006 11:27:39 +0100
Message-ID: <ekh2uh$nk2$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 10:28:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 41
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82-171-213-190.dsl.ip.tiscali.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32503>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp0Bz-0006T7-6T for gcvg-git@gmane.org; Tue, 28 Nov
 2006 11:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935812AbWK1K15 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 05:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935814AbWK1K14
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 05:27:56 -0500
Received: from main.gmane.org ([80.91.229.2]:16609 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935812AbWK1K14 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 05:27:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gp0Bp-0006RU-Is for git@vger.kernel.org; Tue, 28 Nov 2006 11:27:49 +0100
Received: from 82-171-213-190.dsl.ip.tiscali.nl ([82.171.213.190]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 11:27:49 +0100
Received: from hanwen by 82-171-213-190.dsl.ip.tiscali.nl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 11:27:49 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Trim hint printed when gecos is empty.
Remove asterisks for readability
Suggest use of git-config for easy cut & pasting.
---
 ident.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/ident.c b/ident.c
index efec97f..e415fd3 100644
--- a/ident.c
+++ b/ident.c
@@ -158,12 +158,17 @@ static int copy(char *buf, int size, int
 static const char au_env[] = "GIT_AUTHOR_NAME";
 static const char co_env[] = "GIT_COMMITTER_NAME";
 static const char *env_hint =
-"\n*** Environment problem:\n"
+"\n"
 "*** Your name cannot be determined from your system services (gecos).\n"
-"*** You would need to set %s and %s\n"
-"*** environment variables; otherwise you won't be able to perform\n"
-"*** certain operations because of \"empty ident\" errors.\n"
-"*** Alternatively, you can use user.name configuration variable.\n\n";
+"\n"
+"Run\n"
+"\n"
+"  git repo-config user.email \"you@email.com\"\n"
+"  git repo-config user.name \"Your Name\"\n"
+"\n"
+"To set the identity in this repository.\n"
+"Add --global to set your account\'s default\n"
+"\n";
 
 static const char *get_ident(const char *name, const char *email,
 			     const char *date_str, int error_on_no_name)
-- 
1.4.2.4


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
