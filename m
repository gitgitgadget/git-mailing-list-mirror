From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: [PATCH] checkout: Fix test for s/local branch/branch name/ change.
Date: Fri, 29 Jan 2010 13:19:02 -0800
Message-ID: <1264799942-4531-1-git-send-email-jacob.helwig@gmail.com>
References: <1264799342-11093-1-git-send-email-srabbelier@gmail.com>
Cc: Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ron1 <ron1@flownet.com>, Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:19:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayFV-00021C-RF
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589Ab0A2VTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543Ab0A2VTW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:19:22 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:44873 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab0A2VTW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:19:22 -0500
Received: by pxi12 with SMTP id 12so1984383pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 13:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Iy76u63M7+1DbQrDAErnnSzNQYKhegOj+n1LdalGwMI=;
        b=Mix2L6288UCbRuWQYxNyWbXJ3VWZmulwakPAn6348qCl3ermuMfjEZUD5XesddteMt
         XWMtg0pHNXBdi4BNvYlCCQwq2DNbXMsF+cXDEhs4ggSt0NlrpBKWktBlv8SAh+I2ebNd
         dKf3ZsNVO4iFcQhaIwiqfKBYp7w858+BQE7FY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AysoixAq4OLIGNxzWAPxaPPPCWmm5Fu0Hk2QX4NKMu6KCA7TCYZih24BVRzeWsnyDX
         3xjRuJZ4l+8HTi/9JyU4xFENeb+56Mc8uyE/mJnZ/hcgSww76dgBXsKX39KlNOapdMKn
         N7dWhGIinEQtmm/Jf4KLKL9yAe2B7sNGGzPFA=
Received: by 10.141.109.16 with SMTP id l16mr902624rvm.167.1264799961821;
        Fri, 29 Jan 2010 13:19:21 -0800 (PST)
Received: from localhost.localdomain ([70.102.219.22])
        by mx.google.com with ESMTPS id 22sm1886540pzk.6.2010.01.29.13.19.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 13:19:21 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1264799342-11093-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138359>

Signed-off-by: Jacob Helwig <jacob.helwig@gmail.com>
---

This should probably be squashed into Sverre Rabbelier's change, if this is
decided as the way to go.

 t/t7201-co.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 6442f71..b6e3216 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -171,7 +171,7 @@ test_expect_success 'checkout to detach HEAD' '
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
 	(cat >messages.expect <<EOF
-Note: moving to '\''renamer^'\'' which isn'\''t a local branch
+Note: moving to '\''renamer^'\'' which isn'\''t a branch name
 If you want to create a new branch from this checkout, you may do so
 (now or later) by using -b with the checkout command again. Example:
   git checkout -b <new_branch_name>
-- 
1.6.6.1
