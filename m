From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH] Added hint about using .gitignore in git status while 
	printing untracked files
Date: Thu, 18 Feb 2010 15:18:19 +0530
Message-ID: <e72faaa81002180148k47881f47qdfd5d268e4b2b44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 10:48:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni2zi-0000kK-3B
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 10:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab0BRJsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 04:48:21 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:47889 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab0BRJsU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 04:48:20 -0500
Received: by gxk27 with SMTP id 27so2425168gxk.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 01:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=eVqSt6x0r08BnOfaDB+zCRManmCDKxitjVJQE9pmIkw=;
        b=ebdoCNGNBnnmyApm0lVNq4tMJ4h0QV8AFtpRRKmBJi1DKpzZ/h/pjQv4e16s+waktO
         xEF45bFqKwtUX+eXJ8CEoHUdz50PmJx/gvFbH2EU4yTDYPH+HptlgrEPCgkG4EEDRhZl
         zWKrYa2Yd9jyCAinENS2L6eRXQt1iohXO9o8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=eYgSAGkFlkBLJXbtq80FqzNmnRKHWcDRvIet6TOgfNlum2qlwpmCUGscazqemaneB6
         hEe9lN5KH9OjASSGVf5N3yWALW2Yv2EUM8uNFaZAiM1hxRGbawblo5JhlmjXXacpATIC
         CSAQmM9x9scFH9AHgirrbz5vuES1FmqB4071s=
Received: by 10.91.52.20 with SMTP id e20mr5436669agk.47.1266486499147; Thu, 
	18 Feb 2010 01:48:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140308>

Added hint about using .gitignore in git status while printing untracked files
Basically, many users don't come to know about .gitignore functionality in
their starting stages of git and wonder over how to keep the build or doc files
without tracking by git. So, if we add a line saying about gitignore
while printing
help to add untracked files in git status output, it can be very useful

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 wt-status.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 5807fc3..f17300f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -100,6 +100,7 @@ static void
wt_status_print_untracked_header(struct wt_status *s)
 	if (!advice_status_hints)
 		return;
 	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to
include in what will be committed)");
+	color_fprintf_ln(s->fp, c, "#   (add it's path to .gitignore to
intentionally untrack it)");
 	color_fprintf_ln(s->fp, c, "#");
 }

--
