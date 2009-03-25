From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] hooks/pre-commit.sh: fix it again
Date: Wed, 25 Mar 2009 12:43:04 +0100
Message-ID: <1237981384-7857-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	u.kleine-koenig@pengutronix.de
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Mar 25 12:45:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmRXj-0007DE-TU
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 12:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760787AbZCYLnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 07:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759206AbZCYLnj
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 07:43:39 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:48305 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760091AbZCYLni (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 07:43:38 -0400
Received: by bwz17 with SMTP id 17so2635084bwz.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=wiqtj2O4b8xGXwakOtf9fNqlC2xEJdkP7gSq+0mgEbw=;
        b=lazliSZJ2y6OZAKAdZJ0r/Q4IY3YPjUtww/NblkXd8Mdi1qg6Wgx9pljeya0HukbiT
         ywB8IpW6xQ5BoXiDR0r0iEX1OWaxCdbj3wZ/FFSNQwbqLPuuV9+i67IyL4hi+B1pXyj9
         9VBi/pSVq7d9j3eSpfeOPXojPqYgRpAcqUUn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=R6HZ3+hoVsYiu6hHFPBuAG+YwM9gjWiVALG5ODQvwwm35K07mMPmnP8amGFkaO2ana
         IC1XhljTe9UlHEsdRtZZ7VSt1XrU9lB4EV670Les/7hu3ChaEIfK4Ga9W38Mp5CNS0r4
         nEZSndggPKXaVfShNIRAVUqcDKfs+x2024YNI=
Received: by 10.103.193.12 with SMTP id v12mr4150303mup.23.1237981414818;
        Wed, 25 Mar 2009 04:43:34 -0700 (PDT)
Received: from localhost (p5B0F7A07.dip.t-dialin.net [91.15.122.7])
        by mx.google.com with ESMTPS id j9sm14320262mue.10.2009.03.25.04.43.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 04:43:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.148.g0b7ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114590>

First I think the '#' is a leftover, second this is now a bashism.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 hooks/pre-commit.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
index a12cfa6..edf2932 100644
--- a/hooks/pre-commit.sh
+++ b/hooks/pre-commit.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # TopGit - A different patch queue manager
 # (c) Petr Baudis <pasky@suse.cz>  2008
 # GPLv2
@@ -20,7 +20,7 @@ tg_util
 if head_=$(git symbolic-ref -q HEAD); then
 	case "$head_" in
 		refs/heads/*)
-			git rev-parse -q --verify "${head_/#refs\/heads/refs\/top-bases}" >/dev/null || exit 0;;
+			git rev-parse -q --verify "${head_/refs\/heads/refs\/top-bases}" >/dev/null || exit 0;;
 		*)
 			exit 0;;
 	esac
-- 
tg: (fcb488d..) bw/fix-hook-again (depends on: master)
