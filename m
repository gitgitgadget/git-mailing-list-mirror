From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: [PATCH] config.c: make git_env_bool() static
Date: Thu, 19 Jun 2008 08:21:11 +0900
Message-ID: <20080619082111.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 01:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K97NS-0001wH-DF
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 01:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbYFRXqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 19:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbYFRXqu
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 19:46:50 -0400
Received: from karen.lavabit.com ([72.249.41.33]:37458 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbYFRXqt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 19:46:49 -0400
X-Greylist: delayed 1503 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jun 2008 19:46:49 EDT
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 3B2B4C7B31;
	Wed, 18 Jun 2008 18:21:47 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id IOHIYNM8V83K; Wed, 18 Jun 2008 18:21:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=fPk3URSxIOAp2HDEA/uwkjgV9VaQ3HfKoccmyP5pgbHF59EFxYpzTucSgMKf2GtehVvCiCt3WbA2a+IY2mXnaldrrCiLCk2eIyEaB/GUl4PkmAxF4h9k8SKbZhZcQEIO7eEBJJIbUW0HdOKBTv9FGGRtfLb0euxxt9vhG74pycc=;
  h=From:Date:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85427>

This function is not used by any other file.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 cache.h  |    1 -
 config.c |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 81b7e17..a82e493 100644
--- a/cache.h
+++ b/cache.h
@@ -735,7 +735,6 @@ extern int git_config_set_multivar(const char *, const char *, const char *, int
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
-extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int git_config_global(void);
 extern int config_error_nonbool(const char *);
diff --git a/config.c b/config.c
index c2f2bbb..04d97e3 100644
--- a/config.c
+++ b/config.c
@@ -549,7 +549,7 @@ const char *git_etc_gitconfig(void)
 	return system_wide;
 }
 
-int git_env_bool(const char *k, int def)
+static int git_env_bool(const char *k, int def)
 {
 	const char *v = getenv(k);
 	return v ? git_config_bool(k, v) : def;
-- 
1.5.5.4
