Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC34D1F461
	for <e@80x24.org>; Mon, 13 May 2019 22:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfEMWnT (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 18:43:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41715 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfEMWnS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 18:43:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so19826548edd.8
        for <git@vger.kernel.org>; Mon, 13 May 2019 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PNI6C10YZCEZ/QScsWDeRlnuCiESIX0D0FbGSJqU+6A=;
        b=GOqSSt0l1b4BR29fQFaKbfIazzYoN2649O6V+cvTS7BORL0efttG/RXmAqbRBE3mk7
         vN+ni3HnMpzjYyxDT0ETHq+ujchTyOeKlv4WFxzN/LtrkrBOqJDQNFC+ZdxafUFtkpiv
         G66SFsewDHMly8Z9+W45+qPbX2GyWrbsJU+ryYNrLPcSqOUF6VUJFnu7yMdfnOFPa+er
         0l+InICKqdK6ZtWns7j3ZgKNV+16deUu5Jhj9IpCvSt4Pko63baMG6M7FnI1A4WCFPvY
         SBsFo/WSRcqzPZAuWAcRXQNqWFISGA/ZypWIp00ok+HBiKGh85MeHEVM8pKzNYRJaFqg
         t/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PNI6C10YZCEZ/QScsWDeRlnuCiESIX0D0FbGSJqU+6A=;
        b=V5Cgty+fIgVt7i6UNqwejbrN0/pUlyEZQaH4CsJZxA0yL1+adI+VTM0HJWp1WLeYS1
         9CaGdpB7tT6Z2h94pG4pl/6b9fQok4MMoOpNZSTXHGhep+Ew7xsm0VhSBbAT1rkF+P7b
         HKktklHQOWpHcpU5+bwgX8OonE2HNrrC69mdmNQWp8hGmzXWJex0uqvkTiiq+Ehb5vhv
         rrHFgZITJPA6HmbE2RFNLJMBfJh0wZzcdHouuBtJpDu8vZXnVjc3dhQh3Aeli62lQ77T
         qcf/uYWdxB8J3s1j+0xJ0TiIqNj+K9kKSl9oa3tJKqMVhqNtZ5Afi6pkG7NVIExK65Pe
         S9TA==
X-Gm-Message-State: APjAAAWPHcUxauUwPtMVfB5f+EuHwtJ3KBRU2DoP7gwsclKjB6nSVkd/
        /B0jfG9o/0EREP0uPchXLAfK1EOF
X-Google-Smtp-Source: APXvYqwYmSQJ8UByz9S/gRaK3u/8fVQQuiepo91NWYhBChI4+8xwXzdfhphjgIc1oyl/9x331PjeRA==
X-Received: by 2002:a17:906:d7aa:: with SMTP id pk10mr14816409ejb.283.1557787396821;
        Mon, 13 May 2019 15:43:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm4088221edm.56.2019.05.13.15.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 15:43:16 -0700 (PDT)
Date:   Mon, 13 May 2019 15:43:16 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 22:43:13 GMT
Message-Id: <a6bfec76c85bbe9187b536ff78252b82e30e20d3.1557787395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.192.git.gitgitgadget@gmail.com>
References: <pull.192.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] pkt-line: fix declaration of `set_packet_header()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When this function was changed in a97d00799a19 (remote-curl: use
post_rpc() for protocol v2 also, 2019-02-21) from file-local to global,
the declaration was incorrectly missing the `const` qualifier.

Let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pkt-line.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.h b/pkt-line.h
index 5c62015db4..04ae7d802c 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,7 +25,7 @@ void packet_delim(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_delim(struct strbuf *buf);
-void set_packet_header(char *buf, int size);
+void set_packet_header(char *buf, const int size);
 void packet_write(int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
-- 
gitgitgadget

