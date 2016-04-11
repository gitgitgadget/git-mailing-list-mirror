From: miwilliams@google.com
Subject: (unknown)
Date: Mon, 11 Apr 2016 19:04:23 +0000
Message-ID: <001a11492f107354a305303a369a@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; delsp=yes
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 11 21:04:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aph8P-0001PW-Hr
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 21:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbcDKTEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 15:04:25 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:34210 "EHLO
	mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbcDKTEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 15:04:24 -0400
Received: by mail-io0-f201.google.com with SMTP id v3so23341566ioe.1
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:message-id:date:subject:from:to;
        bh=umLjPyeKnWo5J6OKZocKNrrMS87xefLYjYuAN3OSnwA=;
        b=EtIz5pY8/2q2dg4ECBwINqUC40jKWWGWoS1zn1vYfFVHp7zoORoxanKFp4VJOYXwda
         CTa5TRrz9/RdCh6J7LPOnt2j6Dd1ClDV/sAaGl7yq8eFu/JajQlevradqc/AH4g2Z/ds
         jXLTu69ySg2+MWe21zJasBnlRUPKO7XGF2QUWLDZg9lHptgxRSNC4eV5KtQP+8QASzJA
         fGTGXsOWXIl1EUUJDay3idrJWLrseeUX8IZcaBqg0N9MI6/nguBiWMpegzAHDG4wZz5P
         L14ojuMqglXxFPXvwatS5MJ1+j4OhlJZ4qKsTY3vm0SdieNpNEWjJg6MfFIAvsKZbqds
         37Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to;
        bh=umLjPyeKnWo5J6OKZocKNrrMS87xefLYjYuAN3OSnwA=;
        b=Y4fhfQzuvGW/uRV9N2O86mdmdppBJKeQGlXVvgbplwRG7D1MyYlq51TgInMPSs2TPC
         939UuXlSjyOPutqcJ7oRs3SPrBh35n8AzXtAJFPT2qNXEt3fI1jNqEJZV2lHp6QDeuIG
         031G54UpBbLPulbdMPuGvAA9IcloRdWCRyYeV68VXOCzQxb/jJ9T+1yXDXl7Hy2VG9Kp
         SNanm71sU6/AibvVzYOE0aHq2af+XPoEiUH5SHrdmBbALT+9OHf4A8BBmVeAH4j67k2U
         1U2av0HwixeQvFS60IjXKljVlfLTB4MMg7tpOdqsThGAPRinWddDtr19wkVkwg1A6nBk
         nyBw==
X-Gm-Message-State: AOPr4FV4y5YePCb7lInmK0KR71DUs3STMSxWWYJcRc6sk3sYDfqsblmDtTHSwndUsET/fiKNhzPBW2byU94OqCtVqXsSprjtqMKrKfSYqpETf/9ACcV8lFaSQa1Z4Yon9s1RwmwbFpmb0BxCDT2MflP5XlNzjYijfxFKNg/i8OqzmMdVuKDNz1BMsiG58dw=
X-Received: by 10.157.61.226 with SMTP id l89mr1440154otc.5.1460401463293;
 Mon, 11 Apr 2016 12:04:23 -0700 (PDT)
Subject: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291226>

 From 7201fe08ede76e502211a781250c9a0b702a78b2 Mon Sep 17 00:00:00 2001
From: Mike Williams <miwilliams@google.com>
Date: Mon, 11 Apr 2016 14:18:39 -0400
Subject: [PATCH 1/1] wt-status: Remove '!!' from  
wt_status_collect_changed_cb

The wt_status_collect_changed_cb function uses an extraneous double  
negation (!!)
when determining whether or not a submodule has new commits.

Signed-off-by: Mike Williams <miwilliams@google.com>
---
  wt-status.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index ef74864..b955179 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -431,7 +431,7 @@ static void wt_status_collect_changed_cb(struct  
diff_queue_struct *q,
  			d->worktree_status = p->status;
  		d->dirty_submodule = p->two->dirty_submodule;
  		if (S_ISGITLINK(p->two->mode))
-			d->new_submodule_commits = !!hashcmp(p->one->sha1, p->two->sha1);
+			d->new_submodule_commits = hashcmp(p->one->sha1, p->two->sha1);
  	}
  }

-- 
2.8.0
