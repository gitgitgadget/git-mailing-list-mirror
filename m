From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 4/9] gitremote-helpers.txt: Document pushcert option
Date: Wed, 19 Aug 2015 11:26:42 -0400
Message-ID: <1439998007-28719-5-git-send-email-dborowitz@google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:27:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5Gz-0004yA-GL
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbbHSP1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:27:23 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35571 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbbHSP1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:27:16 -0400
Received: by igbjg10 with SMTP id jg10so107489394igb.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1TRM+Q82F4XY1jQjsI2MKz742ziyEFF9wjOo7aPqdBc=;
        b=ObmcFmSUrZJQB+8oe0za13SjE1qAF0Jlkye0YlKoGivAAUOOYhtV//A7Pg4UH7d2Hf
         NJdkBAKR7XM8IPECe7piGZUsLNZRsDZTnRODx24RPFVKxdNz3ZD3GYimLq34TAVt0TDe
         rOdl8hadLest+Dz56KIqlZyZ2k0sziNs7hI57g18YQIZTLZg3isTU1UuKNjslZrvIV4D
         9yYnBflWyy8h/AUF62M87xbgW1Sg/4NMAbKsMdRLDhoUUVeZGrKUAiAHEDzceKXT0U07
         b95fGK/IQ4suf6bmZZXoN5UVpvp/qlqk1C1whv04jcuo79jPkP8WrZ/Owy+YpvmWHFqA
         SyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1TRM+Q82F4XY1jQjsI2MKz742ziyEFF9wjOo7aPqdBc=;
        b=K2pdVVISR+DK0WFMVrkfiawaQJDoVKKzioHBQ7r7ikVain10hSurkut4fCc56g7E5j
         pNSWNuu8E9cPEqEGHTsIOkDe+xuGjJxR9HHTQLGPE2voetfV4Ack4uo7iK7d6mQpzTzX
         OBFfzbC0nAsO2PHddp13VAelflhFjm9Sp5CvnB1REzjyE2Tcyx+m4k3Bs2p+RKjneUMO
         xWeXSmFgxLuFakYVVoegP6eqbKMp9s+3F7vcaJNiRQtvvspaCO47GvHhGvhaWOJK9far
         pnqxuXttuWQi+dUU3Y4R/QMVXf80ydhHA3tj5LzE44m839OFyeZC0Dyd+/xuIfjuBz8P
         QUNA==
X-Gm-Message-State: ALoCoQkirSOO2FMraRJsIVRyUVlFQMPspJbeNXYjRfxr+lkvaaN2omNusLqOy9wxxyt280CjQJ1E
X-Received: by 10.50.18.36 with SMTP id t4mr2324575igd.3.1439998035937;
        Wed, 19 Aug 2015 08:27:15 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id o19sm2347819igs.18.2015.08.19.08.27.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 08:27:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276189>

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
