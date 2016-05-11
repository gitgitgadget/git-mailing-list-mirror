From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 48/94] builtin/apply: rename 'prefix_' parameter to 'prefix'
Date: Wed, 11 May 2016 15:16:59 +0200
Message-ID: <20160511131745.2914-49-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:20:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3v-0003ZN-GT
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbcEKNUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36230 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253AbcEKNUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so9350322wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Po/9XIMa7BpiEOK9cfREE8Z+u+pRtWZ1LxqFrZGTtFI=;
        b=sslEkI35Gu9oQTrYRLbX8el60x3xiotiqBagVqHZYCZ68fRscirXmN0ftYHV8tDvpj
         SlhGhGF2OBXykxjJ1Cr4YrLfjCjQk7jg+FPr0w+j3x+qTTrKCVv1rzRcSOpkRV8GKb8D
         n0/aN0mbtCSFALq+eY7INqjSkru2JED8hnqP4bheYStc24ynq63FwcLj/Ta0Ak2JUvSW
         3NOlCLV74Jl7cWqJOTNkI0+UWNLqtbDnZslUkYwDI3IAYQ5Gz/KdkEytqjQGc5cu8XWW
         O3BGfSdgavol8BDBB/+O6sQrfOnLZ2eQ0faGJL/D0NFDFx+GTB312Ib0OxaNmzMARbOr
         8Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Po/9XIMa7BpiEOK9cfREE8Z+u+pRtWZ1LxqFrZGTtFI=;
        b=hCzgTvO6eICM8M/FVGQ1hB5XqHWiDe9LcShRFInn5Q89KvqFXYii4vqs3RTda7WtGr
         wbwzDHaUdCYsWQB1hPKfYwyzKhFrM94vvAZPJMl33jqH3+nGxymo3ccIOijCQIRGQqij
         iSkGQyCTab4X/xvZV5VNqR79IC0V2DDPCetMw9lClNuCS3y0OkV5wRs9+SDuhUh20hUB
         D4cPOC834reRrVL/kiqAH31rR8jIBD0aaWs7jNQF0v2FtRefCNd0TaJ5VoZlUrowl+V4
         no7hpBmQMcSiwgtYbhaMLbEg1rblR3Jj8OO+zB9shZCG2iCoh8PfyuMJ02ejKqz8PQUK
         B5iw==
X-Gm-Message-State: AOPr4FXYgPv7VysiT90C+jpyRVPmufpqhzea2j/pH1oaAiHEKdBdUuuybhKp9rYBV5kFag==
X-Received: by 10.194.47.9 with SMTP id z9mr3758146wjm.164.1462972805638;
        Wed, 11 May 2016 06:20:05 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:05 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294279>

This is just a small cleanup.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 67c64a5..2aea8ba 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4778,7 +4778,7 @@ static int apply_all_patches(struct apply_state *state,
 	return !!errs;
 }
 
-int cmd_apply(int argc, const char **argv, const char *prefix_)
+int cmd_apply(int argc, const char **argv, const char *prefix)
 {
 	int force_apply = 0;
 	int options = 0;
@@ -4853,7 +4853,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix_);
+	init_apply_state(&state, prefix);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.2.490.g3dabe57
