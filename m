From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 10/12] gitweb: git_repo_url() routine
Date: Fri, 24 Sep 2010 18:02:45 +0200
Message-ID: <1285344167-8518-11-git-send-email-giuseppe.bilotta@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAlV-0006TI-25
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369Ab0IXQEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:04:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40755 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111Ab0IXQEk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:04:40 -0400
Received: by wyb28 with SMTP id 28so2052430wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VR6LVIodSR34QSr/lc/DRdfo9NlokdqRLf8MvhVBw+s=;
        b=N4loAA1EzOE21PZS3LbsHjaQLN3Y6F+xAKsQp6Znh7/Z6F5eW+MWDQsCIC621JcRyN
         rtmRh5GqmrtE2M5KId/YjuSDz+FIbdwjKRsKatdjIfepQYe1kqnaMP6gM/pSFPKXdTzb
         /4DiQqZ92lGRiYmkw6J1X+pctANBbJpDDrRi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GBI67E15YWZ919gIl4N4+mK+hrIvT4awpVRbh+7aNRLU2SA745LinGnfZqTKnfDBXf
         R8OkF1zK1W5mM8YhReBRD5SGirbGMGRJNWIaHUYMnQrHpKhqsrJ7iTV7ytvfs1R43OxH
         eaMmGWZIcoZqaNiy1AWgy6Or2Dhb+g8vU6+ZA=
Received: by 10.227.27.214 with SMTP id j22mr3089656wbc.72.1285344277917;
        Fri, 24 Sep 2010 09:04:37 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id p45sm1429827weq.45.2010.09.24.09.04.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:04:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157010>

The routine creates a table row with a name and a repository address,
like the one used at the top of summary view.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8f11fb5..2ab9327 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3802,6 +3802,11 @@ sub git_group {
 	print $cgi->end_div;
 }
 
+sub git_repo_url {
+	my ($name, $url) = @_;
+	return "<tr class=\"metadata_url\"><td>$name</td><td>$url</td></tr>\n";
+}
+
 sub print_local_time {
 	print format_local_time(@_);
 }
-- 
1.7.3.68.g6ec8
