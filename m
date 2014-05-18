From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 22/33] The log.decorate setting should not influence patchbomb.
Date: Sun, 18 May 2014 23:59:58 +0200
Message-ID: <1400450409-30998-23-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:10:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9Hl-0004GF-KP
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbaERWKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:10:22 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:34158 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbaERWKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:10:21 -0400
Received: by mail-la0-f43.google.com with SMTP id mc6so3457533lab.16
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BGFtS/v/hn8VdV5YbCEUDzOVeaiEXuWkjmC88TF8FGc=;
        b=N2+rKaHc9m/AJOMQw4D/aWxH3athfSaWi3EFkBoYM3Ht1+9c0pW0X6diFn+fbFe5y3
         hSuAFDVUy0YRhdpNWTmYIwlSJFxhQ7NwqPQza0fhEzPseJ7HHPXYymhwgcOiaNKj1k0F
         LkT681GQcyRvv3cXMvVM2sY6471OommzcXgEIolt+GgOyJuTKvKeF7HTZGS8G7l1gJT4
         pAwAlG/NCQcZPNBFksCMLkLGFHASw50Ad9dE41MlHabBQ+aEFy9LUSOixwaN+yUTpMpn
         hptvuzb2UiMkAYLRQFwwv0N8MhpnXlwSyEgC2vbGpAUAEs5UdWgHRQpUi4tr6gfhn9c9
         oSPA==
X-Gm-Message-State: ALoCoQkNPcQ1L9vDWBj/viDkjsTQ2hMOaq6Nwx0lYOOKMFRSKEgzhUem1kDuDiO/b6bvEYm3jMPR
X-Received: by 10.112.159.7 with SMTP id wy7mr4233811lbb.4.1400451020170;
        Sun, 18 May 2014 15:10:20 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.10.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:10:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249537>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-patchbomb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-patchbomb b/guilt-patchbomb
index 1231418..164b10c 100755
--- a/guilt-patchbomb
+++ b/guilt-patchbomb
@@ -47,7 +47,7 @@ if [ $? -ne 0 ]; then
 fi
 
 # display the list of commits to be sent as patches
-git log --pretty=oneline "$r" | cut -c 1-8,41- | $pager
+git log --no-decorate --pretty=oneline "$r" | cut -c 1-8,41- | $pager
 
 _disp "Are these what you want to send? [Y/n] "
 read n
-- 
1.8.3.1
