Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F61A1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 22:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbfAPWmp (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 17:42:45 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:44310 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbfAPWmo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 17:42:44 -0500
Received: by mail-vk1-f202.google.com with SMTP id 101so1838561vkd.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 14:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pyy1mEW/Nxa7MIynSabDrPuKqyvENdnYz6mgQK0Tn/o=;
        b=uqzUEopLy/xiRIwBPpPbOrFiH/6hklr9gvoxuvBQOZbJaCSdfZp/+si2gPLiumsRqY
         LTPLhsLZNYjkRdV90rWbTauXH3H7fLWypakrYGWKM4cnp250p3HUo3kuAQuVqc24tfbU
         sJpSYPFxcrAbJ8ZyycKMtLiDLG39+b70r2IgN57/7xdTzkI470QoNYj/Hf/SloYjrPuv
         y0cBdlyI48Yn/yBSnCTVtD+CqvVfav8lKry9DkXpK1x+feUCIQg34oenzcM88e70OcbQ
         kiKp8btYA7vCBuhmSqguZgezxayJ7ko6hZniLlHh7xV7BsmnzAlVOBi1VQ4zkgCDSEsC
         kfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pyy1mEW/Nxa7MIynSabDrPuKqyvENdnYz6mgQK0Tn/o=;
        b=DgTo1jXPXYExcntxJwNXuNScFuP+614v/L6P3LGlc3M2WuAzyb/0H6W0HFrfZw2/Vy
         xjVcxAwCLeeZyKeyykTmujYrBkA49oX2g3VJdidtVTZEe5uCtpXI1FfSTgchjcBnilDn
         /3sVwcJuIi+Kj7Kw14XQsGMpSbDD8TVNmVL0Q0WiyH56uXHkB6HRqV6QIpm8/3YZVhuT
         GwVtNeU6TxIxkBw9UDDUQ7nJUnpzParKSoQmYLq5uX8+aQKH8Ac41z/cWDz74bUv0WTD
         psafvjdy1QqoHih8t0FvYwhzhiNQY7pd9FE57hciSVGznRKKwEEPxUTfssJN4LO5lacE
         S1HA==
X-Gm-Message-State: AJcUukdP6KcBHYZjianK9NDMyQlQTIHo2uAWoMu/7tjSLrQL0E306sHP
        DiZJprkNygENkWxKxWYt/UaabRgyeN3Op4wLjfn6s2M0kJusrfFROulh9Yt09TqmkE6YQcJQ+Rf
        LIw0peyYLnRJbw5zKrS07OoNn9QbhiethtqSQl3S1v7gDIrlLOTLBnUVsLyjlaanSGnWcDoHQmQ
        2W
X-Google-Smtp-Source: ALg8bN7ElkS69haDdWEPJ+CH+50ohmiG6UwhyLLHUW9PbXiMALzNKhCxVqsmbWq12vXVFSBl43oyRGWh3M/KR8UCLJdD
X-Received: by 2002:a67:8110:: with SMTP id c16mr7411321vsd.23.1547678563963;
 Wed, 16 Jan 2019 14:42:43 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:42:16 -0800
In-Reply-To: <cover.1547677183.git.jonathantanmy@google.com>
Message-Id: <f19beb723416df54e15cecc4db0d54408abdf6e7.1547677183.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547677183.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 8/8] remote-curl: in v2, fill credentials if needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In post_rpc(), remote-curl calls credential_fill() if HTTP_REAUTH is
returned, but this is not true in proxy_request(). Do this in
proxy_request() too.

When t5551 is run using GIT_TEST_PROTOCOL_VERSION=2, one of the tests
that used to fail now pass.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 remote-curl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0d8fe19cc7..cd6749032a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1264,7 +1264,9 @@ static size_t proxy_out(char *buffer, size_t eltsize,
 static int proxy_request(struct proxy_state *p)
 {
 	struct active_request_slot *slot;
+	int err;
 
+retry:
 	slot = get_active_slot();
 
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
@@ -1281,7 +1283,12 @@ static int proxy_request(struct proxy_state *p)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, proxy_out);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, p);
 
-	if (run_slot(slot, NULL) != HTTP_OK)
+	err = run_slot(slot, NULL);
+	if (err == HTTP_REAUTH) {
+		credential_fill(&http_auth);
+		goto retry;
+	}
+	if (err != HTTP_OK)
 		return -1;
 
 	return 0;
-- 
2.19.0.271.gfe8321ec05.dirty

