Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C9D11F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965027AbeB1XYa (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:30 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:51735 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964902AbeB1XYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:25 -0500
Received: by mail-vk0-f74.google.com with SMTP id l81so2279385vkd.18
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=9iNdkqGP6o/B0lDjm3vsD/ZiZ6kbW/tg0Cs6/kc5D2Q=;
        b=pH4a8yDAbGV8AYH8R73uy+jJ+2ybp1eeSYauZlsohl9HJZqzXUL49FIcounVTo3WX4
         7ZBPLYB7dAUxidy/iXB3POHbMSH1PWtGKpegjTeazmskmP0zKPNvoqKiw9fs5bdfdlsC
         ijytC8r1YqnaHK7rt2G7NQgoKwVwLc4t9e0YWKMjyoyWI7h9a4gX5dTs3FAJFs3ZiJKU
         PJgvXpR+dYAUoK+FASJurs5sftsBMnBZCa7j1AWtrxGEXjYcid1QT8M0PzhwIxoMuXi0
         I6E0DOSWhsSEIDVcgDRaI9xYzFR/nKbNi3sDLDzNulEZJxb4UoRtTGNaYvIGSeliaWmM
         QnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=9iNdkqGP6o/B0lDjm3vsD/ZiZ6kbW/tg0Cs6/kc5D2Q=;
        b=e6qgOI2PEeCCmqEP+WttiJE+z+lJczcJFcKlzRk71KaEI5dqIgI0zbBmlcbN2sJaAn
         EGPVrOdzJDhSVnHesfoRjpDGMEGhDwySE+CjMuGoPdcH/pdzI2nRpDYe31qO7FQJ0MqY
         GKEktOJfoerrgUshwQ/2aXo8CO1/Wk2VJsefndlAGW2CjweSdI2AoL00M3uI+lfo00s3
         pMt7hXFRiI8+XB+Xc2MwCFHhGaqVe+vXwK/cZKjtyV0LDWcxyHIoRfSotdB08s7+l0IT
         ZPK7y11JRzkW/6Pl8FhAGh+KFVlsw2Z8L4zw6IXhZq0VXGPghT/lB5Ym/ITUp7DSdd7L
         1tdg==
X-Gm-Message-State: APf1xPCktV8S45CU7SG8wAveHkHOEV/cvPRS7HjFkdggWIQlLKT9XE4t
        udhKdY6dGIVGqQ+rAlbchuv/u+EarDTdI77wjhnZtsfbcOiup9EM19Cu2b4em4Ac0eYKx+VBztf
        cDxGQphZjZkIz31dETgEajABa3NQpwKDtJNIp4d2yHSAACXYrEClZenYtoA==
X-Google-Smtp-Source: AG47ELu4gL7kuMElmu6v21okIaJ4HeQM+0bpCXf3Socuj8DbvwJxWi6W7JbA1iXOcwL2/b58gtFOn5L0LDM=
MIME-Version: 1.0
X-Received: by 10.176.91.81 with SMTP id v17mr9570634uae.116.1519860264276;
 Wed, 28 Feb 2018 15:24:24 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:42 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-26-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 25/35] transport-helper: remove name parameter
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 266f1fdfa (transport-helper: be quiet on read errors from
helpers, 2013-06-21) removed a call to 'die()' which printed the name of
the remote helper passed in to the 'recvline_fh()' function using the
'name' parameter.  Once the call to 'die()' was removed the parameter
was no longer necessary but wasn't removed.  Clean up 'recvline_fh()'
parameter list by removing the 'name' parameter.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 4c334b5ee..d72155768 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -49,7 +49,7 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
 		die_errno("Full write to remote helper failed");
 }
 
-static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
+static int recvline_fh(FILE *helper, struct strbuf *buffer)
 {
 	strbuf_reset(buffer);
 	if (debug)
@@ -67,7 +67,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 
 static int recvline(struct helper_data *helper, struct strbuf *buffer)
 {
-	return recvline_fh(helper->out, buffer, helper->name);
+	return recvline_fh(helper->out, buffer);
 }
 
 static void write_constant(int fd, const char *str)
@@ -586,7 +586,7 @@ static int process_connect_service(struct transport *transport,
 		goto exit;
 
 	sendline(data, &cmdbuf);
-	if (recvline_fh(input, &cmdbuf, name))
+	if (recvline_fh(input, &cmdbuf))
 		exit(128);
 
 	if (!strcmp(cmdbuf.buf, "")) {
-- 
2.16.2.395.g2e18187dfd-goog

