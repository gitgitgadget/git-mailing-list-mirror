From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] add setup for HP-UX to Makefile
Date: Thu, 24 Jan 2008 19:35:20 +0100
Message-ID: <20080124183520.GK30676@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 19:36:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI6ve-0006Ed-Ex
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbYAXSf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 13:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbYAXSf1
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:35:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:7477 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbYAXSf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 13:35:26 -0500
Received: by fg-out-1718.google.com with SMTP id e21so321781fga.17
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 10:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        bh=LhjTT7MwYZB3aqOV0D4cUrLmoDfEB2PjkprWWAwV7HM=;
        b=ME5DO0FkiozEwG7/H9d28NUJpCkKjaDGHBZyzNXglvHOtHTDd+Y/EVafz6XStu1/Osx78K9iOKInvGu+i3uBnUuMObA3aTULTFw60cTpcSnWxksc/jyvHi4irvzCMxrFwZ3EGfo/do26r65M5Q0FKo3CyjS4WpMkpseXm1yATd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=Ok9hlulKwXf0Y/cfqSgJXRQQGuVT3A1lchFwLIKkwMJle54xnHXfaQUUmDLtF2jGwUqScDfHOxIuM/EjTq1WoqLi/FZJ20idAC98NrAS64x4xp6j55TLCH1bL6bnwCqu2L4bNWFVFcnzfgPHaYBayFbUCLN0Dy7CieJdxYKT5io=
Received: by 10.86.99.9 with SMTP id w9mr904417fgb.44.1201199723143;
        Thu, 24 Jan 2008 10:35:23 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [91.18.121.55])
        by mx.google.com with ESMTPS id e20sm1630239fga.1.2008.01.24.10.35.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Jan 2008 10:35:22 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 12D442A8CF; Thu, 24 Jan 2008 19:35:20 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71645>

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
 Makefile |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index c9e54b1..dd12b6a 100644
--- a/Makefile
+++ b/Makefile
@@ -505,6 +505,17 @@ ifeq ($(uname_S),IRIX64)
 	# for now, build 32-bit version
 	BASIC_LDFLAGS += -L/usr/lib32
 endif
+ifeq ($(uname_S),HP-UX)
+	NO_IPV6=YesPlease
+	NO_SETENV=YesPlease
+	NO_STRCASESTR=YesPlease
+	NO_MEMMEM = YesPlease
+	NO_STRLCPY = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_UNSETENV = YesPlease
+	NO_HSTRERROR = YesPlease
+	NO_SYS_SELECT_H = YesPlease
+endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif
-- 
1.5.2.4
