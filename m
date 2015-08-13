From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 4/7] gitremote-helpers.txt: Document pushcert option
Date: Thu, 13 Aug 2015 15:00:48 -0400
Message-ID: <1439492451-11233-5-git-send-email-dborowitz@google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 21:01:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxkT-000392-Ec
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbbHMTBC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:01:02 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37963 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbbHMTA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:00:59 -0400
Received: by igfj19 with SMTP id j19so42691208igf.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1TRM+Q82F4XY1jQjsI2MKz742ziyEFF9wjOo7aPqdBc=;
        b=Uk4hUSSls7VzBnKYE0G2Tx4izlaA7Ftw1pYuIIYz6nfqxgM3PjNzK6C6mVIeluSPSp
         qMLiGvFClbkFHhWvKlVdbu0/WM3t3Tsn3wRT1/1gVXPAsyzpdw5zSsmJTkBgL50k5P8Y
         6RgBot9wNSyJp0xHb6TFgaaDxed+V5W0QFlacw0TYacLLNpg4KpkkGU35M95Nz/XYj84
         pkfPycfW2FASi5gql/2oE8uB5jzUaRYN8//HZ3e/Ex2bHIoeZHntzoBcnHXzdFfpAkQs
         857y6veeX0nuY6fG5i1i5VM4Bhq1oN/6OCF2Fo+K1qKStZ/RV27j1KA+SEe236BaM5hZ
         oqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1TRM+Q82F4XY1jQjsI2MKz742ziyEFF9wjOo7aPqdBc=;
        b=ZOWamYpqAIsHzUHr8zTOmv6FJK2N0kKAbju91t51zth4aRQt5R1kbiNjB4TFZjcWB2
         Ubs0Ao4v8YygbIBNO4AVczxUX9Libvek6WWg5sO1mc2XXi87KQnKF1Q1wz9aHeqcghUt
         PdSC5xivvK3pflwvAAxWxoYk9LeX4F2Aj8oc1u+ohpJ2zQlOHtR3IrWtxdWDPeaDrK1w
         Cnn48nJXRQH1mWcluHPg5ZjF9yE0jDSGgLAeNtDNeWHXXK3qziXoezp+qSCKP5LDYWlE
         Pw3/dEIhfOx6ZwQdddXiIhS2NU4bV3MD3+qY2+8AjAhaBKfcYnqkiSrS8rartJFpA/VJ
         JIIg==
X-Gm-Message-State: ALoCoQmxEcMEz4SDwXY35tTXo7wFR8oGBWhxYjQkNDzPZJoLOoTLk8Oom/gG6FmBimugIIrcKD2C
X-Received: by 10.50.73.170 with SMTP id m10mr31856038igv.60.1439492458842;
        Thu, 13 Aug 2015 12:00:58 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id c91sm2078646ioj.43.2015.08.13.12.00.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 12:00:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275879>

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/gitremote-helpers.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 82e2d15..78e0b27 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -448,6 +448,9 @@ set by Git if the remote helper has the 'option' capability.
 'option update-shallow {'true'|'false'}::
 	Allow to extend .git/shallow if the new refs require it.
 
+'option pushcert {'true'|'false'}::
+	GPG sign pushes.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
-- 
2.5.0.276.gf5e568e
