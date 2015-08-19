From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 3/9] Documentation/git-send-pack.txt: Document --signed
Date: Wed, 19 Aug 2015 11:26:41 -0400
Message-ID: <1439998007-28719-4-git-send-email-dborowitz@google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:27:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5HE-0005AP-BM
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbbHSP1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:27:36 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33463 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbbHSP1P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:27:15 -0400
Received: by iods203 with SMTP id s203so13020894iod.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BjZferK/wpeJfpvW84sFcd2m59Bify7ZhaKapuqXiww=;
        b=omyev7rwNtux4xDSQjQHxNGIP04ZzHF/nVhU/fhqEnT5IT7EIE7j771mEJqSXDGpCi
         3dTiNJeB6lxVtxl2+tG2x2JFHGdXMRjjb5aUe1CDr59qgRR7jzZflQMzSn9WcQgndVhC
         IYOWGM4FUG6hInO14W7ybW6Lt4oyLoxiehYGaeCjb8t+itvLVpvyAik9Q0w0rjEL1Qmq
         J4G4sx/smRcxN46mSFz/ZiKsi86a6U3Umlp4xJx6jabQCXa3iXlfsqH2K7WuCv80JH9B
         AK2lw2VYn3RXVx2BcTjF11c3kOqXTllMLztG9GyEX3rwsvG7A9t8c+vk+0We2Gx6Kb5p
         Ttfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BjZferK/wpeJfpvW84sFcd2m59Bify7ZhaKapuqXiww=;
        b=XJcmD9dkxgIy1tSYImVFwA6Cl8r64oqrWT2nMXt7QI5i4sSR8R/omzFlYrEsnSjeEh
         o0Yt3+18F6+uCv+p5Zb16mN2RKW+mZkoPaNq5NuDLcNYV+Ym0hsJ+7cclfLsbQBH11Cp
         vF0fwLHcKAOcHIRVYCI3SvMBuol1R/BV1Vvcyb+w6OLLZc7u0wFlb0ygOzOEPOGvdyqL
         R55TYgtgbjAiaVxJkjPkSvwXq0hJmPKQQ+cLs26+iQlK5T618NNhVN4SsSZ09G9h+1TS
         1lx0sNH5ABqbOyu8CMfcQEG+d02BolceXiJK7jUa7UShFWGo7tHiPVL4yABrDBHE3RLz
         kFWA==
X-Gm-Message-State: ALoCoQkl3mw3KWZrJzJaXfy71IOaOM5m4qVVgIz1FshHp3RA6xrCZOqM3DQOJnVy0qcISVGByNs2
X-Received: by 10.107.170.36 with SMTP id t36mr14513446ioe.107.1439998035162;
        Wed, 19 Aug 2015 08:27:15 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id o19sm2347819igs.18.2015.08.19.08.27.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 08:27:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276193>

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/git-send-pack.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 6affff6..0a0a3fb 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
-		[--verbose] [--thin] [--atomic] [<host>:]<directory> [<ref>...]
+		[--verbose] [--thin] [--atomic] [--signed]
+		[<host>:]<directory> [<ref>...]
 
 DESCRIPTION
 -----------
@@ -68,6 +69,14 @@ be in a separate packet, and the list must end with a flush packet.
 	fails to update then the entire push will fail without changing any
 	refs.
 
+--signed::
+	GPG-sign the push request to update refs on the receiving
+	side, to allow it to be checked by the hooks and/or be
+	logged.  See linkgit:git-receive-pack[1] for the details
+	on the receiving end.  If the attempt to sign with `gpg` fails,
+	or if the server does not support signed pushes, the push will
+	fail.
+
 <host>::
 	A remote host to house the repository.  When this
 	part is specified, 'git-receive-pack' is invoked via
-- 
2.5.0.276.gf5e568e
