Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CEAE1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 18:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeFESAM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 14:00:12 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:49377 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752683AbeFERv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:57 -0400
Received: by mail-qk0-f201.google.com with SMTP id w203-v6so3215972qkb.16
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=sYEe8iRPTrOcHM3mkoOecfjMEKrpiQl9wbZfoQa3/WU=;
        b=SXHiSoPP+IsNJj5ujIG9q/QAJsK7cADezBTzd5t8mWzXU4h58lxZcIKpqzeVsnPBPD
         LcJygzGFzgACWhoIqYXPpfvf9UbR13cAmFOlaDgnpIGVxZybo3VgFSjsDpfXZRU7jy/G
         Qrw7c4+QdFRU780FJ9IBcWi9ha1wBQ9eV5vMoiGA2D7WWl/ONRWCmGyz8uuxSE9Kz33C
         aW8MxRkABh007C6B0OVAibs0TNsoQZ2Wo58a+biW84xFBywKsvk8cD/0MdbYLsdEHNBU
         7lTsFJKmakXZZH+vDbj077HxpDuLBxF1k9GgzuEaOV2W1e+9E3Y9eTE+zWj5J++J4nD/
         KqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=sYEe8iRPTrOcHM3mkoOecfjMEKrpiQl9wbZfoQa3/WU=;
        b=XcQ1H/H0SZaaJnE5Go5Qw5JYMmxMftC4kBQD8AqcHV8A1zRBjXwKXNZyQFjiuaG/sU
         tM1LgXw80a5l3EcMNG9izGWogm2Dj7O1MK5XJ4t6oXlpjzEJYTcRtbxxGIEBz/xQnIoC
         TuDiint/ueR9r6x9g8b17oIn7J4Ve+XtYBQXekIwGUVKe9i5FblF7hJS3JviiucF7aXs
         A4J/J4SkFEjLDc2RHq7D2C2apvSqzmaYqi0ab72ypF0r0YjplnVb5vF9ptZssHFdnrVZ
         zOfDbFl8mA7UJM88QGuJirGIcKzkQ8sAeO0cfCBpIUZnRPDMVYWodrdVCiJSdRiCBY8d
         rQXQ==
X-Gm-Message-State: APt69E3/6ZMxLoEaN2pFb2vE10oqDzRSV/lKuW/0din0WyTyq0OU1VNk
        d9Ytq0fvthULPNM6lzqtbAi7Qp72zLAOYwnKMp0bVs8lvSYyvdZwrcwTRA4altJxLdniXrmf5Cc
        Epm/O6ynALOrJviOkqlfkgCmRjjUAKfw1qqU3u0hTQgYT8SjdALodS3Zahg==
X-Google-Smtp-Source: ADUXVKK3l0PVmfQT7rXlbYYxyUBEtPiwaxQ841UP5L+ppaGAYtF8V89OUGpRa1RyAX2niTvjpIawnsjjlLM=
MIME-Version: 1.0
X-Received: by 2002:a0c:9416:: with SMTP id h22-v6mr11709427qvh.41.1528221117184;
 Tue, 05 Jun 2018 10:51:57 -0700 (PDT)
Date:   Tue,  5 Jun 2018 10:51:37 -0700
In-Reply-To: <20180605175144.4225-1-bmwill@google.com>
Message-Id: <20180605175144.4225-2-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Subject: [PATCH 1/8] test-pkt-line: add unpack-sideband subcommand
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an 'unpack-sideband' subcommand to the test-pkt-line helper to
enable unpacking packet line data sent multiplexed using a sideband.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/helper/test-pkt-line.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 0f19e53c7..2a55ffff1 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -1,3 +1,4 @@
+#include "cache.h"
 #include "pkt-line.h"
 
 static void pack_line(const char *line)
@@ -48,6 +49,40 @@ static void unpack(void)
 	}
 }
 
+static void unpack_sideband(void)
+{
+	struct packet_reader reader;
+	packet_reader_init(&reader, 0, NULL, 0,
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_CHOMP_NEWLINE);
+
+	while (packet_reader_read(&reader) != PACKET_READ_EOF) {
+		int band;
+		int fd;
+
+		switch (reader.status) {
+		case PACKET_READ_EOF:
+			break;
+		case PACKET_READ_NORMAL:
+			band = reader.line[0] & 0xff;
+			if (band == 1)
+				fd = 1;
+			else
+				fd = 2;
+
+			write_or_die(fd, reader.line+1, reader.pktlen-1);
+
+			if (band == 3)
+				die("sind-band error");
+			break;
+		case PACKET_READ_FLUSH:
+			return;
+		case PACKET_READ_DELIM:
+			break;
+		}
+	}
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	if (argc < 2)
@@ -57,6 +92,8 @@ int cmd_main(int argc, const char **argv)
 		pack(argc - 2, argv + 2);
 	else if (!strcmp(argv[1], "unpack"))
 		unpack();
+	else if (!strcmp(argv[1], "unpack-sideband"))
+		unpack_sideband();
 	else
 		die("invalid argument '%s'", argv[1]);
 
-- 
2.17.1.1185.g55be947832-goog

