From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 11/12] gitweb: use git_repo_url() in summary
Date: Fri, 24 Sep 2010 18:02:46 +0200
Message-ID: <1285344167-8518-12-git-send-email-giuseppe.bilotta@gmail.com>
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
	id 1OzAlV-0006TI-K0
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370Ab0IXQEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:04:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46042 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab0IXQEn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:04:43 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so27998wwd.1
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VWUmurnwGFlN7Wsgffx7xTvSHyWREbihIitCNDsBGwg=;
        b=SunK9LCZWOC8hVJYPiVMvY30KfoSrRXPr6CVitLJKVrBfD7d5C2fuYWD9+QSs5bmff
         w074MCNItvSGQWWh4DW7MQkJ7tuRpm8/droU7PAvbtma4vPxI067DufKo/7aKurZ4sUe
         wpXKwmcUnC8JOsft9E+lCzb9A7V7FDe8hcL4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WSTZje0cgrHPn4hwglnO9WMSsjph8l1W6Pwsdqy3Pn1Lqu9e6ewpDxbxDTuCriowEM
         mzO//GzAryLxUIO7qMgchqbHSwLVderTVNO5xSBO1elBCZ58yEVohWhvpypGu6+QBZDt
         83jF76WaGGIBG8pPP2RWrD0Br2QU7jJVTVP7g=
Received: by 10.216.164.132 with SMTP id c4mr9682526wel.9.1285344283010;
        Fri, 24 Sep 2010 09:04:43 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id p42sm1431482weq.36.2010.09.24.09.04.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:04:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157008>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2ab9327..93017a4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5190,7 +5190,7 @@ sub git_summary {
 	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
 	foreach my $git_url (@url_list) {
 		next unless $git_url;
-		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
+		print git_repo_url($url_tag, $git_url);
 		$url_tag = "";
 	}
 
-- 
1.7.3.68.g6ec8
