From: Adam Monsen <haircut@gmail.com>
Subject: [PATCH v5] diff format documentation: clarify --cc and -c
Date: Tue,  8 Mar 2011 12:51:37 -0800
Message-ID: <1299617497-17447-1-git-send-email-haircut@gmail.com>
References: <7vmxl5e6ur.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 21:52:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px3su-0001SJ-UR
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 21:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574Ab1CHUvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 15:51:55 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34006 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab1CHUvx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 15:51:53 -0500
Received: by gxk8 with SMTP id 8so2136997gxk.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 12:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=0eASche8nwKRbSLxMELycYUIuwdZf8JaB1b+Bn2XIgI=;
        b=SG6PSYj31K8AtJ5NuVtkdmlVEoS+sw0qW/L08ZBhDIspNbqPi0JEngFWPziEhwojtk
         HlQSG8TZ5kaXWW5kKq05EFv0EAhYNw3KlWG9OpWJjRbQXjFFrZxhSDNPk4aIRS+hlGd2
         uK+U6h3jYFE7DS0+a3EVd5FsMK01jN1Kddubc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=btcaHRBgjgy1cv3zwh3y4XpL8VGDVFmDWofp7Z9EvzreaohNV/vFjfoGD/+jeoYz8q
         Y6uDDKwLmE54/0Ok0yPQrw/WohzDu+87kbswtYgPtzh7Z13r/iGh/nCi0rWnZIkLpxdg
         ++oUXwYEmNlVTnx6OObd1eJP1xhirBtk9tagQ=
Received: by 10.236.62.66 with SMTP id x42mr5741119yhc.10.1299617512948;
        Tue, 08 Mar 2011 12:51:52 -0800 (PST)
Received: from localhost.localdomain (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id x29sm753513yhc.28.2011.03.08.12.51.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 12:51:51 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vmxl5e6ur.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168688>

The description was unclear if -c or --cc was the default (--cc is for
some commands), and incorrectly implied that the default applies to
all the diff generating commands.

Most importantly, "log" does not default to "--cc" (it defaults to
"--no-merges") and "log -p" obeys the user's wish to see non-combined
format.  Only "diff" (during merge and three-blob comparison) and
"show" use --cc as the default.

Signed-off-by: Adam Monsen <haircut@gmail.com>
---

Here's another try at "my" first git patch, a one-paragraph
documentation change. Now featuring a much-improved commit message by
Junio.

 Documentation/diff-generate-patch.txt |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 3ac2bea..c57460c 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -74,10 +74,13 @@ separate lines indicate the old and the new mode.
 combined diff format
 --------------------
 
-"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
-'--cc' option to produce 'combined diff'.  For showing a merge commit
-with "git log -p", this is the default format; you can force showing
-full diff with the '-m' option.
+Any diff-generating command can take the `-c` or `--cc` option to
+produce a 'combined diff' when showing a merge. This is the default
+format when showing merges with linkgit:git-diff[1] or
+linkgit:git-show[1]. Note also that you can give the `-m' option to any
+of these commands to force generation of diffs with individual parents
+of a merge.
+
 A 'combined diff' format looks like this:
 
 ------------
-- 
1.7.2.3
