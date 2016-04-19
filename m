From: santiago@nyu.edu
Subject: [PATCH v7 3/6] verify-tag: update variable name and type
Date: Tue, 19 Apr 2016 13:47:18 -0400
Message-ID: <1461088041-19264-4-git-send-email-santiago@nyu.edu>
References: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:48:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asZki-0002SY-7J
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 19:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933221AbcDSRrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 13:47:39 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34959 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbcDSRra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 13:47:30 -0400
Received: by mail-qg0-f48.google.com with SMTP id f74so12143214qge.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=82EvsE70L57TYC3Wlfm4ody1gSPiePEAPYdV0NvTHY8=;
        b=0vxzdOWnpxnfNZJvPfEYZF/4Vtj8nJd5ZpBtZX/fCHkqP37hnR/LHPVjKyqvreJeVJ
         LObCEV1qhWOeIjFTOissLdVt3AHJPK/LPRiAjpeQM3Gsy6/h3H1XJeqreU6LSwxwDU93
         w/SQLF31n+yiPMabPyCnrtKvgXUIL86L/DxMLcJWQRzCLW6q9is5wrM1/Ae3n3iuvT8w
         YX4k6WB5RnpT+oSsX9LM1+35eoQOOAaYPy6Lcu1njbZkT80jvaYGtDtxIXNS47m9jOV9
         YhLXCKvXEwH8RNGVRItWvWFm0yJBlpkQxiOSNL5nbyK0Qpk10rmetffZgbmmkfDr1XKH
         uy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=82EvsE70L57TYC3Wlfm4ody1gSPiePEAPYdV0NvTHY8=;
        b=deH6zJidOtUeVLHWieMR/kSjMvyJatqc3oNkg7lvoCSWXM0wjSJPICO4M7np3l/Zzz
         9oAS+t4s/q6noJePavLpf5snjJ8+SBhYs7USKzOirN+BGvanQ1u/DHL3Ozt8iknrbOeg
         pQ/muysgwgNElhtaIJlsFVpQ9rg5BuzmrO5rpYbxjP/xfswjYkuJxeKu3VRWMvR0Jr9X
         W0ieQNiMqHBpUG6KyqSggFdmiQX4DkyJwR1TOYAhX5BXKkPdPJoOEAzua8+fdt3VO5LU
         REyCmdwD8owSOWQU8FygZvsSd+MnMbD17AYiu8dp1EIrtulqP+L55F12ih3zsWHxxbMD
         pyhQ==
X-Gm-Message-State: AOPr4FUPw7rL0CHJ4S44ty3ZpThHD0vkjNtj4RzesgrO7I/kLTAh9l+0OxhsHspvT35wTmF3
X-Received: by 10.140.94.87 with SMTP id f81mr5209156qge.0.1461088048900;
        Tue, 19 Apr 2016 10:47:28 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id w184sm11073374qkw.4.2016.04.19.10.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 10:47:28 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291889>

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
