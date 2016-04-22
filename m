From: santiago@nyu.edu
Subject: [PATCH v8 3/6] verify-tag: update variable name and type
Date: Fri, 22 Apr 2016 10:52:02 -0400
Message-ID: <1461336725-29915-4-git-send-email-santiago@nyu.edu>
References: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:52:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcRX-0005C3-4u
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbcDVOwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:52:24 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35074 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbcDVOwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:52:14 -0400
Received: by mail-qk0-f171.google.com with SMTP id q76so26965919qke.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=82EvsE70L57TYC3Wlfm4ody1gSPiePEAPYdV0NvTHY8=;
        b=fzPTgZgySdaUGEd9BEn1OWmr03T0epPJuBOIPcfHefjSFA1TsUJ2fD/aJuD9SQqmmd
         cPFoUfjF4tvoX13QUV6vkxgkyOvD/W94FC/sXnCrlBixqkc/v/zj72zaXoDxctq57wTm
         q7B5oudn8KPLtZfqLK4jr2WSAGts0YbzSNuhZUXwaFt/G/sXaPgmSwHAzuWj3oAKaDoC
         8/s6aaJ+NRxmm1r3snnClTKF68yVlAqOc02oOTgNanVpXaFDSHCGAvk6PokO0+Wm+xGP
         PRFVo+bI4gL8avuXURw/OP00naKhUySAuTH07eTiH2gH71D9RV/XG0vGW45+dlLhXU98
         K+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=82EvsE70L57TYC3Wlfm4ody1gSPiePEAPYdV0NvTHY8=;
        b=SPAmQ+B2N+p+iw+5/1VIl+5t6gt6MyI63lZRLKp37O5BYgaM8CcTum9YsB+yC5GHio
         5BHYERL22evctyDgscQ4Q8a1KOcUOuLb9ibhnHZrLawduYrvpLZYEmRGQFtjn3HHryw4
         Wmv0j5O02jNSqfQnP4lc5ka6lDUwywdM1IWVtBRQqP9v5rQxN0hAcyn4sLDoiJUOCb2p
         7U4gunckbQ9rgwUkBNSq3G01FZtUYOtgNq8oiFOR542xX0xNcq5CQ49YGlUWodBYZ8zN
         AhDtXFIkW27Is/6D3nlTp4FKwf1hryFZnTfoMp4IDCljQVqemkIp4XwJy5Glg7xmw7Lh
         6/jQ==
X-Gm-Message-State: AOPr4FXIDJv7mJF80+YkpK5+eiPZ9fJAOI0DQMCYpPZx9ts8Y+i7i3gv6NB5NLFF3zadEbmf
X-Received: by 10.55.201.70 with SMTP id q67mr4919961qki.121.1461336733291;
        Fri, 22 Apr 2016 07:52:13 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-18.NATPOOL.NYU.EDU. [216.165.95.7])
        by smtp.gmail.com with ESMTPSA id s67sm2583005qgs.48.2016.04.22.07.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 07:52:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292225>

From: Santiago Torres <santiago@nyu.edu>

The run_gpg_verify() function has two variables, size and len.

This may come off as confusing when reading the code. Clarify which one
pertains to the length of the tag headers by renaming len to
payload_size. Additionally, change the type of payload_size to size_t to
match the return type of parse_signature.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/verify-tag.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 77f070a..fa26e40 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -21,20 +21,21 @@ static const char * const verify_tag_usage[] = {
 static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 {
 	struct signature_check sigc;
-	int len;
+	size_t payload_size;
 	int ret;
 
 	memset(&sigc, 0, sizeof(sigc));
 
-	len = parse_signature(buf, size);
+	payload_size = parse_signature(buf, size);
 
-	if (size == len) {
+	if (size == payload_size) {
 		if (flags & GPG_VERIFY_VERBOSE)
-			write_in_full(1, buf, len);
+			write_in_full(1, buf, payload_size);
 		return error("no signature found");
 	}
 
-	ret = check_signature(buf, len, buf + len, size - len, &sigc);
+	ret = check_signature(buf, payload_size, buf + payload_size,
+				size - payload_size, &sigc);
 	print_signature_buffer(&sigc, flags);
 
 	signature_check_clear(&sigc);
-- 
2.8.0
