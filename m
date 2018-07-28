Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0F71F597
	for <e@80x24.org>; Sat, 28 Jul 2018 03:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeG1E3l (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 00:29:41 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:39116 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeG1E3k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 00:29:40 -0400
Received: by mail-qt0-f202.google.com with SMTP id c6-v6so5565048qta.6
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 20:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TrbV3W+J4gr2vAyy/UEW+psjA0NJf7yNYE8R5Sx5b5c=;
        b=u6ss94ypgMeaAocJ5uD03ZfbVLCQsZgVVzzE6fv9FKlvtAYKIlfyOEAKgDD1j2HQtM
         43/U3kYLfPnaOJafc1bJMlWRyzEIdBiQXOr0Ieph72xFy4HLQ7wdLIDk5kz6T4NK9ZJ5
         tN3L6IsKJe3TGyg2QQLqMGkSQ3rmQl4igjOQIMwvYjXaGxwcN97pAaRM/la6j8nU7Zmi
         vjgxI1LSEstEdLMWf4OJxB6iA4hqDdQORYaPMvZ3hd4F324IC4+SnZFYxy/PzxCvhcN2
         GFSWn17CUWkNaq2cJuahxtiYxoSKy3g8/EsIA4l6fZwKbVBxEn7m/0y9K8VR/9k3Vu3n
         /lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TrbV3W+J4gr2vAyy/UEW+psjA0NJf7yNYE8R5Sx5b5c=;
        b=e2xX5Hhf+0/fcvYLX22iKJZ+lGHwTwlqHJNA/SYQKcIFp2ZcQqTCs5fIeekN2A84l0
         3Ix26khyR1nu+uusAQVw2237kColqw727vaooWQq62ntWmJYAzOH0XzT5KHWBIkstP3s
         TeQ8a2shyUkVTDeZIGmNhbR6r8XloBYel1XdswzD17gg+sB3XfOn1/LCd0bcWdZ8SALR
         Um2zU2tkRFu4RRbdjXAblklRiw6r1pB/CEQLKl3gWyVV5os26qZUN2S78byuMwgy8nIS
         7rt9r1v1PksitV4VTHUyLYCj4hLgPBPPRleGeDPrS+E4kUSgTXOrcf83xMNMyDQNqIlj
         n49A==
X-Gm-Message-State: AOUpUlFlSRDEpWqi63tia7B8RRthSgXCQwJw6PxkVAAJirUmaWYx5Ugv
        XUjFCstZq6BM1B4Gr+GDIuElEp51xsw8HFVfLf/SfBNspZwO7rw2oRLAIh0smGcFysCardqbP/d
        UPozH6/WZ+44JzOWZdJaSR26GwfKYQaslVX2qVoZk/oEKMwpyNDjQHM6PNNAc
X-Google-Smtp-Source: AAOMgpcG7DWtHCMFV+t/iVIgVqgh5L+GWbmsVC11X8ThXi+p3dim9+cWHCM12uNeiU+0mFWYPNu2udxLIMEn
X-Received: by 2002:a37:e211:: with SMTP id g17-v6mr4938657qki.17.1532747095404;
 Fri, 27 Jul 2018 20:04:55 -0700 (PDT)
Date:   Fri, 27 Jul 2018 20:04:41 -0700
In-Reply-To: <20180728030448.192177-1-sbeller@google.com>
Message-Id: <20180728030448.192177-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 1/8] test_decode_color: understand FAINT and ITALIC
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/test-lib-functions.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2b2181dca09..be8244c47b5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -42,6 +42,8 @@ test_decode_color () {
 		function name(n) {
 			if (n == 0) return "RESET";
 			if (n == 1) return "BOLD";
+			if (n == 2) return "FAINT";
+			if (n == 3) return "ITALIC";
 			if (n == 7) return "REVERSE";
 			if (n == 30) return "BLACK";
 			if (n == 31) return "RED";
-- 
2.18.0.345.g5c9ce644c3-goog

