From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/26] wrapper.c: allow to create an empty file with write_file()
Date: Tue, 16 Feb 2016 20:29:11 +0700
Message-ID: <1455629367-26193-11-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfhu-0002zR-OT
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbcBPNaQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:30:16 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32820 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338AbcBPNaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:30:14 -0500
Received: by mail-pa0-f47.google.com with SMTP id fl4so91713761pad.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aerlodWnE6D3kz1oy38wQuM+jML0GD1rbtKRk1wAk/w=;
        b=c78s7HcsFaxlxYShN+XicLIpJ5MXIC+Vk8ie6OHuRp1lZpKUPiQpHX9/xnfOa8qhEX
         mUob+rOBsYklqLUmrAtMq1m+JxhyIs537o+v08FO4A4wy4qbZTXlJRt3uBQ5HxtOjAtr
         J8ZcBCpDACkWQmaTVbSmg+ynNYmxiwKhj7xc0QCcUDhtn6i6vfoNMbFQ1ES7XWUXF7zB
         5+V6RHAGTrVZg1oGjozlcPLFvu3g1D6XB8EQY+TBm+0WfY8a7pFz9BSwLHbtHVevjR14
         8WY/m2HzXmMxRZ+3TwWoWRxKgODDm+PPPc9RDmHeARvCwfSRvKCGHRlP46lsHznwQFzy
         s8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=aerlodWnE6D3kz1oy38wQuM+jML0GD1rbtKRk1wAk/w=;
        b=aaZqn4jVRWa1nyxNQGjeL5QpY2a58FkZMEgnZfirstSx0afeF0CGvNZvR5H2dLLROG
         sn9qWYmjm/UG8Og18jDBFEywPCx/HOFPv0Vh5YJ5agBve7ACj6kjoIaHN1HuHSZjJK/g
         3A997U70B0h3dcDUJb+oI3rihcHk7BuVTCS8HBKOBP41i9eTTT9nn3OkrS+vqa1OGH9Q
         3+eE2whAByseEBKldr8pyyrTYH5yPn9Z4yJLHRQ/3GLA9OWXX3RiA4ELHx8j/zuLMkO2
         dBlOc3p13Mq2De2I4y9Ys+crnDuzsOK/feb61wzqQb4pl5AgAiEVROyLjzA/5Q9u0Ffd
         9r5Q==
X-Gm-Message-State: AG10YOTq4w/KM8C2gT92ijplcRaHz/9g0PFgjcoHthS04YvkON38fIKqzOpZJicy6tHxYw==
X-Received: by 10.66.63.104 with SMTP id f8mr30876602pas.109.1455629414306;
        Tue, 16 Feb 2016 05:30:14 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id o184sm45980183pfo.36.2016.02.16.05.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:30:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:30:37 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286372>

This is used later on to create empty .git/worktrees/xxx/locked when
"git worktree lock" is called with no reason given.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wrapper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wrapper.c b/wrapper.c
index 29a45d2..1dc1eff 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -666,7 +666,7 @@ static int write_file_v(const char *path, int fatal=
,
 	}
 	strbuf_vaddf(&sb, fmt, params);
 	strbuf_complete_line(&sb);
-	if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
+	if (sb.len && write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
 		int err =3D errno;
 		close(fd);
 		strbuf_release(&sb);
--=20
2.7.0.377.g4cd97dd
