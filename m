From: Adam Monsen <haircut@gmail.com>
Subject: [PATCH v4] Documentation fix: git log -p does not imply -c.
Date: Mon,  7 Mar 2011 16:49:38 -0800
Message-ID: <1299545378-22036-1-git-send-email-haircut@gmail.com>
References: <7vsjuyzckd.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 01:50:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwl7w-0004Kr-Su
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 01:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858Ab1CHAuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 19:50:07 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51034 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695Ab1CHAt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 19:49:57 -0500
Received: by gyh20 with SMTP id 20so1851866gyh.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 16:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=2rjEekmakJWvVcdHfSXnEpZXgjhmlU3byELlgWNw9ZI=;
        b=RM9qv+NGFHpWQ36kzTgRKN0XYPng/uyrnRDFNcwGiAo3HNomwTCiFlsEOrElo5sdyj
         jjx71kojrXwocEYwbzREPYfdawyRp/h2LQeW44NisElcb+XpBZQ4iruggZbGBNUBgjYI
         2rhtbS5LgnFcQzBKPjDbw1xGOmw517yBFo984=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mBwaovkZ9hKw4evVPTprxo6/tnwnNG6X/XmesGhU+iWn+L18GzfdOiaRr24I0oKy7V
         HtJVnFCDgy3+IbwaZjbyxUpIxsmQxZaIKfTC8zKHQHhBM+yU0Ft9ZiscXM7oBWrxS1QE
         hwzmgEkrAum3IAwckQOLeG9FEsXTFbLdMOvTg=
Received: by 10.150.100.6 with SMTP id x6mr5649521ybb.26.1299545396622;
        Mon, 07 Mar 2011 16:49:56 -0800 (PST)
Received: from localhost.localdomain (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id m23sm93658yhg.36.2011.03.07.16.49.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 16:49:55 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vsjuyzckd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168625>

Relates to the thread with subject "frustrated forensics: hard to find
diff that undid a fix" on the git mailing list.

    http://thread.gmane.org/gmane.comp.version-control.git/168481

I don't wish for anyone to repeat my bungled forensics episode.
Hopefully this will help others git along happily.

See also:

    http://thread.gmane.org/gmane.comp.version-control.git/89415

Signed-off-by: Adam Monsen <haircut@gmail.com>
---

Junio wrote:
> s/produced/produce/, I think.

Ah, indeed. Fixed, thanks.

I also sidestepped the difference between merge commits and conflicts by
changing the wording slightly.

Your changes to the "Note" seemed helpful, I put them in. Thanks!

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
