From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/1] perl/Makefile.PL: warn about duplicate module list in
 perl/Makefile
Date: Fri, 15 Jun 2012 13:14:46 -0500
Message-ID: <20120615181446.GI10752@burratino>
References: <1339781427-10568-1-git-send-email-adam@roben.org>
 <20120615180505.GH10752@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Adam Roben <adam@roben.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 20:15:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfb3N-0001kp-9W
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 20:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022Ab2FOSPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 14:15:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52931 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757008Ab2FOSPV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 14:15:21 -0400
Received: by yenl2 with SMTP id l2so2140924yen.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 11:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KDDrWcRkP4hNb2z8+sNo2ZDVxk+HuaLmqqPFaHN7cPg=;
        b=dO2HuqWBU3B/tX0H/fE3kkPQcskJL6dKwwWbNlplY6ANI7TVd+L/VQSgUNxuFbW1Pk
         52CPI9FY6wqWQCrr1+QXN7mjc4LZs1HJRx8wicpo5/TENzOMb/y9SUCFc2IvvUQ42X38
         SlsqgchLSdKhRiMKuPYnqMjlWjPoSIdgda0o6x+pbuzLVY0XQcGTHdmwncHQg70ytJeL
         NjjxJ/yTm5xjwjHGWmIJfSiqFB8KiT09gJvEDk5fpnW8po5srDsUqHmoLjfq/AfTs1Rk
         5RrcchHAwM3gSVDp4/EKQ/zwlzX8RyooU4Wb5AXI5OXxUCW6NBsPpIQtajeUJtaMoErv
         vQzQ==
Received: by 10.50.236.71 with SMTP id us7mr2940774igc.16.1339784120071;
        Fri, 15 Jun 2012 11:15:20 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gw4sm3047967igb.6.2012.06.15.11.15.19
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 11:15:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120615180505.GH10752@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200075>

Adding or removing a module requires modifying both files to support
builds with and without MakeMaker.  Add a comment to remind patch
authors and reviewers at the crucial moment.

Longer term, it would be nicer to maintain a single list, perhaps in a
separate file used by both build systems.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 perl/Makefile.PL |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 2c20290f..b54b04a6 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -24,6 +24,10 @@ endif
 MAKE_FRAG
 }
 
+# XXX. When editing this list:
+#
+# * Please update perl/Makefile, too.
+# * Don't forget to test with NO_PERL_MAKEMAKER=YesPlease
 my %pm = (
 	'Git.pm' => '$(INST_LIBDIR)/Git.pm',
 	'Git/I18N.pm' => '$(INST_LIBDIR)/Git/I18N.pm',
-- 
1.7.10.4
