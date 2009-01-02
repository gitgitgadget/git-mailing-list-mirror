From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: suggest name for OPML view
Date: Fri,  2 Jan 2009 13:49:30 +0100
Message-ID: <1230900570-25324-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 14:31:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIk7p-0004Wg-3h
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 14:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbZABNaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 08:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbZABNaT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 08:30:19 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:57135 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbZABNaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 08:30:18 -0500
Received: by bwz14 with SMTP id 14so20059192bwz.13
        for <git@vger.kernel.org>; Fri, 02 Jan 2009 05:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=mI94oCHlwBi0ZrFvNOd2QZUKLeWgYWfTbJ3gJVWceEc=;
        b=GHjFPtiVUKk52OoOdu8O84BWlqN03ZGdosQQgULRc3jx5RkkyJgTaGQu10WGQejgwd
         yPQnGv7JyFJzB7m4kwQw0E7MHaSF1BWZhxgcQuH+htj4eDnSF/QBF1PzLasUMJK6mObf
         zdZsI+urYFXQ64MJXUUSlmBm4R5QCAmpdAQlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SWXog1kAg9IxAaeTWcHbHhd4ZvsMORZP724BWIgkooM1T1u8ad56GGATgmUi6m7CN9
         TNXt6NTNNKn9VT6HhtUn9RDlz1htvFrSfSfzsVvqAZTG7f7prhviB3ICEFh8rsd+yANd
         JuwHyB+AzVnW1fkwpVu4B5fMNZ6tHOMQa2o5s=
Received: by 10.103.160.3 with SMTP id m3mr6376759muo.25.1230902674456;
        Fri, 02 Jan 2009 05:24:34 -0800 (PST)
Received: from localhost ([78.13.52.22])
        by mx.google.com with ESMTPS id 14sm21531165muo.39.2009.01.02.05.24.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jan 2009 05:24:34 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104380>

Suggest opml.xml as name for OPML view by providing the appropriate
header, consistently with similar usage in project_index view.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b164001..995bc1a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6122,7 +6122,11 @@ sub git_atom {
 sub git_opml {
 	my @list = git_get_projects_list();
 
-	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
+	print $cgi->header(
+		-type => 'text/xml',
+		-charset => 'utf-8',
+		-content_disposition => 'inline; filename="opml.xml"');
+
 	print <<XML;
 <?xml version="1.0" encoding="utf-8"?>
 <opml version="1.0">
-- 
1.5.6.5
