From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] Prettify log decorations even more
Date: Thu, 14 May 2009 00:22:05 +0300
Message-ID: <1242249726-8514-3-git-send-email-felipe.contreras@gmail.com>
References: <1242249726-8514-1-git-send-email-felipe.contreras@gmail.com>
 <1242249726-8514-2-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 23:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4LuS-0006Qz-Mi
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761303AbZEMVWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 17:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760995AbZEMVWQ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:22:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:3444 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756645AbZEMVWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 17:22:14 -0400
Received: by fg-out-1718.google.com with SMTP id 16so313426fgg.17
        for <git@vger.kernel.org>; Wed, 13 May 2009 14:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QTrf4qwtt29GsVJWNro1WHR+9UkqTnYnOXatMMi+9vo=;
        b=Knw0h4WKCYqYZ4g5NhDFTIWRgbGf4qe/sFTkPvo2HYY6aX0N2b2YiRO1yMx7YrukEm
         7UDp46KDTkilMx3jsfLMCS0qcAp06Gp0KOO4ejrFKVLfm2N4L1WEjMCzLSjNEYfYT8oM
         M1Lhv9NmgZ19wJT6u8t3edG+9mv1DHWW67tW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SY+drWhiV8WlcwmcBX53ry6Ik2HEyfXz6H3BHujTC1Z7EeoSFs9ouJrFv0BsvSEaxM
         pciNR48i+70TAQXlBtTCUKjeWEYqjCy05e3H2QWeoLJrdjUB2+0EcSmrD4uP14g5/jV3
         tqY96wmDwwi9sX0376/sGGZTF1bMUO11Vc5DE=
Received: by 10.86.91.3 with SMTP id o3mr1719833fgb.29.1242249734147;
        Wed, 13 May 2009 14:22:14 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 12sm779639fgg.20.2009.05.13.14.22.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 14:22:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1242249726-8514-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119109>

"tag: v1.6.2.5" looks much better than "tag: refs/tags/v1.6.2.5".

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 log-tree.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 5bd29e6..59d63eb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -25,6 +25,7 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	struct object *obj = parse_object(sha1);
 	if (!obj)
 		return 0;
+	refname = prettify_refname(refname);
 	add_name_decoration("", refname, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
-- 
1.6.3.1
