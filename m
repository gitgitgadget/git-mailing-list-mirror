From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Wed,  1 Jul 2015 11:08:15 -0700
Message-ID: <1435774099-21260-4-git-send-email-dborowitz@google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 20:09:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAMRz-00050U-L7
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbbGASJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:09:18 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34390 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbbGASIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:08:49 -0400
Received: by iebmu5 with SMTP id mu5so40231397ieb.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nk4VzgSlaxvne/zzMyQaV4TPM5cMeVXnVt8ta6pVAc0=;
        b=dKSnQ3qVCa6a9Dl59PogvRpcGBL+4kFN9jV7x9Jgxo0hnAh0Y2iZA36YwvjAEjEt+T
         PYXR5c8VX+ef/uK44aqyhFKU4eZR9JCP6H/0MhG4M8dekljVNy+dJGZulHnP+jso8Cwm
         eYKzMz6AMovFWgLlF6ajfa6y9Vxnur5CHwXHGLwj1c3GPbY+sqjLn7foik4QkdbupsjW
         XsDJi3Liki3e8mYSWaLfOcHE4SrodPgX2ps59eIa11bdAohvZ0sr3s61iq81rmqtGup8
         4bUmVw/7pyfU0nA5UgD12oQh2Lh2hKQ2/ABiLKLHzkKoUMt1pyd3O8DqNzu2nICw3wS7
         PbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nk4VzgSlaxvne/zzMyQaV4TPM5cMeVXnVt8ta6pVAc0=;
        b=Bya14PUSFX+IXjjbOhqBNRVe04qCWqABcGJ/b3YQ8zNteBp3b2PCTQ8GpT59itdNTo
         LHmjm3NZYZfeDaPMbDGsc4y444goiFF7cV/uA41OLvf9gCbaQTTPykOHsmjbmI0uEexq
         mjOIH9JDip80O+GIjRpb+CEVm58D0DHslgpgr9JqpkQ0G+iXX477CgQRG6hHD9mzmgD/
         rhUu9ubvkpmvJpUwGy0Xdwhl3Iy1SltvLy84RM9Xw3seGT8uaLAc+WPVTUP3apwr8JDL
         dxAo5fO9QB1KmEZv96jlSjAWfj7nEawOOzzsfCzziSy0iQMDUWnhwWHx/K0ZEvryOCdY
         4otA==
X-Gm-Message-State: ALoCoQkqK1if95ViuZDEHPc2w7KQRW9LHWjDz8g27G1hZl8JB7z+S23yku44jsswtkBCDIF2BsLb
X-Received: by 10.107.12.143 with SMTP id 15mr40093179iom.75.1435774129005;
        Wed, 01 Jul 2015 11:08:49 -0700 (PDT)
Received: from serval.mtv.corp.google.com ([172.27.69.27])
        by smtp.gmail.com with ESMTPSA id k2sm2782076ige.1.2015.07.01.11.08.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 11:08:48 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.573.g4eafbef
In-Reply-To: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273171>

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/technical/pack-protocol.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 1386840..2d8b1a1 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -534,6 +534,9 @@ A push certificate begins with a set of header lines.  After the
 header and an empty line, the protocol commands follow, one per
 line.
 
+Note that (unlike other portions of the protocol), all LFs in the
+`push-cert` specification above MUST be present.
+
 Currently, the following header fields are defined:
 
 `pusher` ident::
-- 
2.4.3.573.g4eafbef
