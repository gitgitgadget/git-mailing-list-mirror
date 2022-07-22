Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB2FC433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 11:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiGVLKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 07:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGVLKP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 07:10:15 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D2212608
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:10:13 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so5887932fac.13
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NNSRCveNuh9MnLZbDRS0O2LSxGleFDvrwAq5yLNlEsI=;
        b=VC0rNPb6bZYILuq3S2eOfJ2fUh4yYn8doju6OsV/fP2TDzXaI53r9MIT9i2Iw63AJr
         6nSfsXuSe/H1DDu+JdJqcz5XBCxSd8L2HSZHMtYyHFXKEda0DgxqXMUMQWNgjM7cKF7I
         jU348UJxlTkVkv2Ql2TajXuSF4jTsI8ioo0EXh6AgPiIj4g7pUsjD7gUCbSxRe+8t0vP
         NRLqbFOXMYE15hYyk5D6P8heuT16W4Y7mwexxVPZS+i1vnRXVb4iRbnO6SYfpEcLoD4g
         3qIQygxbym9zWRvpoUuSaibxcynJSXgNoc2yXygPRJTocm5DAyL+XBXXSh1rNQRrhbon
         o+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NNSRCveNuh9MnLZbDRS0O2LSxGleFDvrwAq5yLNlEsI=;
        b=t6wk6HHbJhx0d4WnPpohjogqD+DVRfJ74l8icKEMl9Rfkzp8kcZtupb3vrXqIB0iGQ
         E6Kuskswa0u0kTBiCrs7mkWv74+dwmT5FUrpP90jjaxWQxvHq59tQ3XSq69Z/FkvSGi5
         5Vcl1iXLX7VpGlSlV+QrfKvVNF1jAvPy1cH0NOZrpoZtT1e122zXuvDohonCe8zEB7j5
         I7Zwq6tcr3fX7ajsM2ED6P9XRAmj2LnyYWD/sYxrdC2W07wQbhhNN+QBib20e24nENpJ
         hEZ/rpzCChOwIrqq+zns2MBgwZY82/f5X0yPaC03+ybq2YbT2aazqQogl6Llb0T7vATz
         aB6w==
X-Gm-Message-State: AJIora+HqIrQj/2lf/S6XqQKnskC30iWzHAzK6ZKte9v5l8PTCwtxQey
        mOrAsL6/Z40Mm3re37Ehn7Fewi8eYCZUqw==
X-Google-Smtp-Source: AGRyM1thAJpnhlP+3XuFk/AitzhWIG/Od4wdwLdQTZjG4PBl62Bk4/ku3GD0JFUOGxlhXRUZXcw8/w==
X-Received: by 2002:a05:6870:e248:b0:10d:215d:1b41 with SMTP id d8-20020a056870e24800b0010d215d1b41mr7517592oac.179.1658488212298;
        Fri, 22 Jul 2022 04:10:12 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id p28-20020a056870831c00b0010c727a3c79sm1979783oae.26.2022.07.22.04.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 04:10:11 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [PATCH] pkt-line.h: move comment closer to the associated code
Date:   Fri, 22 Jul 2022 08:10:05 -0300
Message-Id: <6a14443c101fa132498297af6d7a483520688d75.1658488203.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ec9a37d ("pkt-line.[ch]: remove unused packet_read_line_buf()",
2021-10-14) removed the "src_buffer" and "src_len" parameters from
packet_read(), only leaving them at packet_read_with_status(). Let's
also update the function documentation by moving the comment about these
parameters from the former to the latter.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 pkt-line.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/pkt-line.h b/pkt-line.h
index 6d2a63db23..1f623de60a 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -49,14 +49,6 @@ void packet_fflush(FILE *f);
  * Read a packetized line into the buffer, which must be at least size bytes
  * long. The return value specifies the number of bytes read into the buffer.
  *
- * If src_buffer and *src_buffer are not NULL, it should point to a buffer
- * containing the packet data to parse, of at least *src_len bytes.  After the
- * function returns, src_buf will be incremented and src_len decremented by the
- * number of bytes consumed.
- *
- * If src_buffer (or *src_buffer) is NULL, then data is read from the
- * descriptor "fd".
- *
  * If options does not contain PACKET_READ_GENTLE_ON_EOF, we will die under any
  * of the following conditions:
  *
@@ -104,6 +96,14 @@ int packet_length(const char lenbuf_hex[4]);
  * returns an 'enum packet_read_status' which indicates the status of the read.
  * The number of bytes read will be assigned to *pktlen if the status of the
  * read was 'PACKET_READ_NORMAL'.
+ *
+ * If src_buffer and *src_buffer are not NULL, it should point to a buffer
+ * containing the packet data to parse, of at least *src_len bytes.  After the
+ * function returns, src_buf will be incremented and src_len decremented by the
+ * number of bytes consumed.
+ *
+ * If src_buffer (or *src_buffer) is NULL, then data is read from the
+ * descriptor "fd".
  */
 enum packet_read_status {
 	PACKET_READ_EOF,
-- 
2.37.1

