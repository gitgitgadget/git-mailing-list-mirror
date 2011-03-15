From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] tests: stop worrying about obsolete environment variables
Date: Tue, 15 Mar 2011 05:09:24 -0500
Message-ID: <20110315100924.GC3923@elie>
References: <20110315064909.GA25738@elie>
 <20110315070445.GC29530@elie>
 <20110315073718.GB11754@sigill.intra.peff.net>
 <20110315100846.GB3923@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 11:10:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzRD0-00062v-6k
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 11:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204Ab1COKJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 06:09:34 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54474 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702Ab1COKJd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 06:09:33 -0400
Received: by ywj3 with SMTP id 3so164099ywj.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=umNKeIBw1zxHV3jEH2MTkLXYKfHkFozwEkH5w+xKd7Q=;
        b=Wz1vdny95gNlu2RMCLvilmrcbu9nl73XfZtVlz5dxoyy5RkAxiq5YIGWNHjx7YMgIS
         64mwnLrl9kem61O2paEk+hboEL/ZLWSFD4qRaxnELtfjt7nryeVr3dY63HUXozSYCqtf
         uBDp/JaZ0H0DpiUsUNzJ5wZf1PgovEfCBmrEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IE1X5ce0y9AGF+EUu7Sg/lvbZmH1clMlZNDEFJff3gMhAS/KgowcPl0kkIlG1caLAu
         sD4IGwStH4TOXLSX0YJ87YtgJ0QCSWc4KjVH+Edj2yxGM22HibxE7hrUzZk9wPfpB9si
         cdMhMwLkRMBACe7IAO1hFvQUt53gWxfH3qy7k=
Received: by 10.236.19.233 with SMTP id n69mr7697992yhn.365.1300183773012;
        Tue, 15 Mar 2011 03:09:33 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id 1sm6029297yhl.11.2011.03.15.03.09.26
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 03:09:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315100846.GB3923@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169058>

After v0.99.7~99 (Retire support for old environment variables,
2005-09-09), there is no more need to unset a stray AUTHOR_NAME
variable that might have entered the test environment.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib.sh |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f35ba6f..8893406 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -44,11 +44,6 @@ export LANG LC_ALL PAGER TERM TZ
 EDITOR=:
 unset VISUAL
 unset GIT_EDITOR
-unset AUTHOR_DATE
-unset AUTHOR_EMAIL
-unset AUTHOR_NAME
-unset COMMIT_AUTHOR_EMAIL
-unset COMMIT_AUTHOR_NAME
 unset EMAIL
 unset GIT_ALTERNATE_OBJECT_DIRECTORIES
 unset GIT_AUTHOR_DATE
@@ -64,8 +59,6 @@ unset GIT_EXTERNAL_DIFF
 unset GIT_INDEX_FILE
 unset GIT_OBJECT_DIRECTORY
 unset GIT_CEILING_DIRECTORIES
-unset SHA1_FILE_DIRECTORIES
-unset SHA1_FILE_DIRECTORY
 unset GIT_NOTES_REF
 unset GIT_NOTES_DISPLAY_REF
 unset GIT_NOTES_REWRITE_REF
-- 
1.7.4.1
