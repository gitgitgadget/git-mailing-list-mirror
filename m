From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v4 0/5] Reroll patches. Pretty print truncate does not work
Date: Wed, 21 May 2014 17:20:02 +0400
Message-ID: <cover.1400678003.git.Alex.Crezoff@gmail.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 15:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn6Rd-0001m9-2Q
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 15:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbaEUNU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 09:20:28 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:47406 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbaEUNU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 09:20:26 -0400
Received: by mail-la0-f41.google.com with SMTP id e16so1584085lan.0
        for <git@vger.kernel.org>; Wed, 21 May 2014 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3/gYSM8IsUTjFT4/DW8K3236rnxd/h3A4jFV7CyK5TQ=;
        b=zsMF2VADsbzzNWpHts1Is7iil4DteeFbnXMyX5yD+4WBctPvEi5GwiDtqYuECtSiUe
         FDWN9xuMYaXbCBz753x4MS+ZgebNTONgFoV5WF9NFstv3xHc/TYZPxaSvd1GjHYDSaLX
         nzvZ/StZwioGKS/HDvH/rdxnisLRqLWwnj8QvpqZkMqMMoyQoBk6nN5ZxRspAbv8jQCg
         mfT1dtxuOU0PVaVnpsKHyeVkfvri8MzXBdiqJxwi0xnj6SJiliCeSINkH44X92kmMYhG
         NeNJpfX7AhXhAtb5p2A/BdPFsPUJGhfIAexeslrnvUjQL8iURLOa88sv+N09VKY/Bc31
         Ldsw==
X-Received: by 10.112.41.101 with SMTP id e5mr26004600lbl.46.1400678425083;
        Wed, 21 May 2014 06:20:25 -0700 (PDT)
Received: from localhost (ppp91-77-196-183.pppoe.mtu-net.ru. [91.77.196.183])
        by mx.google.com with ESMTPSA id r2sm25535714laa.5.2014.05.21.06.20.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 May 2014 06:20:24 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <cover.1400513063.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249794>

This version (v4) differs from the previuos (v3):
1. Fixed typo ISO8895-1 (vs ISO8859-1)
2. Fixed t4205 test: tested format strings are double-quoted

Alexey Shumkin (5):
  t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
  t4041, t4205, t6006, t7102: Don't hardcode tested encoding value
  t4205 (log-pretty-format): Use `tformat` rather than `format`
  t4205, t6006: Add failing tests for the case when
    i18n.logOutputEncoding is set
  pretty.c: format string with truncate respects logOutputEncoding

 pretty.c                         |   7 +-
 t/t4041-diff-submodule-option.sh |   7 +-
 t/t4205-log-pretty-formats.sh    | 217 ++++++++++++++++++++++++++++++---------
 t/t6006-rev-list-format.sh       | 110 ++++++++++++++++----
 t/t7102-reset.sh                 |  13 ++-
 5 files changed, 282 insertions(+), 72 deletions(-)

-- 
1.9.2-15
