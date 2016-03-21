From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] Revert "config.mak.uname: use clang for Mac OS X 10.6"
Date: Mon, 21 Mar 2016 00:35:58 -0400
Message-ID: <1458534958-6956-3-git-send-email-sunshine@sunshineco.com>
References: <1458534958-6956-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Renato Botelho <garga@freebsd.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 05:36:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahra5-0004oe-Er
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 05:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbcCUEgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 00:36:39 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35800 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbcCUEgg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 00:36:36 -0400
Received: by mail-io0-f196.google.com with SMTP id 124so8499392iov.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 21:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2JoJAIhtZEyWcq+bNuYjgN/NAiCEuQhyICsDWEoTAVo=;
        b=0Ydl44jBAycBQkARgYWB/vsKKbweRnWSsAuLKJWxbWWtzEHCTGcQdWRXxEm0SVnNfd
         Kp4RMqcX9pqN6LFFLFyucvbpv0TrlM516tS0pfoi2axGALs82jXGsgd/7Uv1esXY3YLY
         ZdKMNMTuQOhwPkSAYfhR0227XZQ8sHWlBOxhpcKu5Dz2JA2URig2mpEnTqsq0UiYc0AK
         7g7PecjZpjrEl2t9KtXn8S/Dvm8SgtmTD8wBV8mtdBfO7+6cl+HzA1vpFv4FyKIMQAUm
         cAfWGfEetQ7d0IbS5gNnGuZiW8XS+kK1E2GdhkdoFxlLL9VF27nAQFfHPN3xmAHEoDG/
         S89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=2JoJAIhtZEyWcq+bNuYjgN/NAiCEuQhyICsDWEoTAVo=;
        b=VmZBB2PbJFW4pONDhTuDxBbkkHdGniN73vAPGtVSLkDmeAGh1Pxaa2InQWQrT2qRrX
         ZGP3KkfoAkURO96ADejW7DOV8LCFHg7pFR/HHzPpIvqXCK5E02Ds6zrd7x2HYAWYFX46
         iVOR3LpwHnBHxbrng5Vv46q9ZMimtUJI2oqWzFKYFd9ubvyoSQags9UcaQJdw1WcAeDC
         bCIs3LQAXMXJSZEwbSbIaZa5jEFf0BELcRpdB317JE2mje/GGFrsOkd47MKygkjR74sH
         fEfaOsXWggj+sg9Tv+yHacEMu7r/hzyKbnlKdLx2HoZAeAcb/7V51aGHTPfJK5/Qlmec
         vQ4A==
X-Gm-Message-State: AD7BkJLZbpWMaFb7ollJmBrNhZ6DCgO52BaDDnxAvNv5h3Zx7qrYXtG24wfHD1EPDzKWHw==
X-Received: by 10.107.135.32 with SMTP id j32mr27164135iod.40.1458534995582;
        Sun, 20 Mar 2016 21:36:35 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id i187sm10725620ioi.33.2016.03.20.21.36.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 20 Mar 2016 21:36:35 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.240.g104e649
In-Reply-To: <1458534958-6956-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289398>

This reverts commit 7b6daf8d2fee1a9866b1d4eddbfaa5dbc42c5dbb.

Now that st_add4() has been patched to work around the gcc 4.2.x
compiler crash, revert the sledge-hammer approach of forcing Mac OS X
10.6 to unconditionally use 'clang' rather than the default compiler
(gcc).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

I verified that the work-around in patch 1/2 "fixes" the crash on
FreeBSD, and I'm pretty confident that it fixes it as well on Mac OS X
10.6 since it manifested identically on both platforms, but it would
still be nice to receive confirmation from Torsten.

config.mak.uname | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 1139b44..fe8096f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -103,9 +103,6 @@ ifeq ($(uname_S),Darwin)
 	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
 		NO_STRLCPY = YesPlease
 	endif
-	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -eq 10 && echo 1),1)
-		CC = clang
-	endif
 	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1),1)
 		HAVE_GETDELIM = YesPlease
 	endif
-- 
2.8.0.rc3.240.g104e649
