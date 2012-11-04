From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 16/16] remote-hg: the author email can be null
Date: Sun,  4 Nov 2012 03:13:38 +0100
Message-ID: <1351995218-19889-17-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:15:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpjw-0002u8-W9
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab2KDCOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:53 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab2KDCOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:51 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qVcCrdvQgx4fvoxxqPt7IJbX3Ih4ZwwG+cV1KjK7RiA=;
        b=KaOVTVfFAsGAd+cMW4+ywfabTTbrpRpl38/ZQKBQlw0RjOvMkKvmOKRse1e88QYiQN
         3KZE6exrAh80NzW2XKbgWF+EU1o8+OiHZxISASbodpmbypYA1611ZjxRiGCjirtAc0Iy
         0Kx5hJtuu0pwz4wSvFRl57hYnUP7iyfB8FGCVwYRbahDF+WfCKTL6gee1yKVKQhKGb2q
         du0uWZliAVmm2SKrqlrbgfPyHauGDR9pIX54086sbUrdbG0QyyWVbRqyWpg2qqucbguE
         l/SHEYO+VutFpUSrYj0Yo3k74EHvsl/AYLElXtchM48Pir4BPgDlkhAb/rkut/O2dJAH
         L8jQ==
Received: by 10.204.128.136 with SMTP id k8mr1413813bks.84.1351995290763;
        Sat, 03 Nov 2012 19:14:50 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id gy18sm7942362bkc.4.2012.11.03.19.14.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209004>

Like 'Foo <>'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index a9ae844..7929eec 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -35,9 +35,9 @@ import urllib
 #
 
 NAME_RE = re.compile('^([^<>]+)')
-AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]+)>$')
-AUTHOR_HG_RE = re.compile('^(.*?) ?<(.+?)(?:>(.+)?)?$')
-RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.+)> (\d+) ([+-]\d+)')
+AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
+AUTHOR_HG_RE = re.compile('^(.*?) ?<(.*?)(?:>(.+)?)?$')
+RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.*)> (\d+) ([+-]\d+)')
 
 def die(msg, *args):
     sys.stderr.write('ERROR: %s\n' % (msg % args))
-- 
1.8.0
