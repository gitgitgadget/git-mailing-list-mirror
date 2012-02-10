From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH 7/8] gitweb: Use different colors to present marked changes
Date: Fri, 10 Feb 2012 10:18:13 +0100
Message-ID: <1328865494-24415-8-git-send-email-michal.kiedrowicz@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 10:19:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvmd9-0005f5-Jd
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 10:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758870Ab2BJJSd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 04:18:33 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61683 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758860Ab2BJJSb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 04:18:31 -0500
Received: by mail-ey0-f174.google.com with SMTP id h12so852938eaa.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cQzQzPtYUItP8/mcjqEqn4xFreAn/XyHja0CRcEvZu4=;
        b=koso5faPYnDGbFndW4WySTHwluBAAz0T36zBS5TZ0L++bMzW3dHYdV5EPmThdlYgfg
         uocI3p3vHAlxtJKjP7hSx0hbImjknRmcP4035yzqKNHx0nEtZaCuitnBP8kJLwAbWuQF
         qsQ8TIKNRrZFEsGB2VyCnnumaeNQkEArOfFZk=
Received: by 10.14.120.207 with SMTP id p55mr1781737eeh.28.1328865510935;
        Fri, 10 Feb 2012 01:18:30 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id e12sm19984418eea.5.2012.02.10.01.18.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 01:18:30 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190392>

This makes use of the highlight diff feature.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
I decided to split mechanism (generate HTML page with <span> elements t=
hat
mark interesting fragments of diff output) from politics (use these
particular colors for this <span> elements), but otherwise this commit
may be squashed with the previous one. These colors work for me but if
someone comes out with better ones, I'd be happy.

 gitweb/static/gitweb.css |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index c7827e8..4f87d16 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -438,6 +438,10 @@ div.diff.add {
 	color: #008800;
 }
=20
+div.diff.add span.marked {
+	background-color: #77ff77;
+}
+
 div.diff.from_file a.path,
 div.diff.from_file {
 	color: #aa0000;
@@ -447,6 +451,10 @@ div.diff.rem {
 	color: #cc0000;
 }
=20
+div.diff.rem span.marked {
+	background-color: #ff7777;
+}
+
 div.diff.chunk_header a,
 div.diff.chunk_header {
 	color: #990099;
--=20
1.7.3.4
