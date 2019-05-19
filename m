Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8DE81F461
	for <e@80x24.org>; Sun, 19 May 2019 17:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfESRcs (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 13:32:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41178 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfESRcr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 13:32:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so11695341wro.8
        for <git@vger.kernel.org>; Sun, 19 May 2019 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m08/Log2R9MrL9P1sm3lQ+nrgfkwPzuIgqSJsDKhMfc=;
        b=L4gXbf34i/DxxgWvZl67H6r8rlsp7oDnjOCfCjaKwZjbWTt4y55QKgnBRprE4MFcgN
         oAsICOGqI92xg7sHBhcDMMf7vG+ol13C0TsVQkMq7z3x6jBIDkXZAggb2khwxYUTnOa/
         WRM9UZwcy+sjrcwl+IfzDPRgb+M92RQo56u5gQvERGmV4e3EQyGk7N0m4RvVCnZ/zQbg
         rp4Ud3QS+XlSfFNXBpVofaY/z+o39XdQ4UdzvgM+peUHOBoV4J9uGdr8OKFZEropAcBg
         kSabqQpGqXv7QYiAxFbJksUWYIYC0llxzuJqzVcFI3Aciq4AsJk5gZZ43iyDR9tOfelm
         Jjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m08/Log2R9MrL9P1sm3lQ+nrgfkwPzuIgqSJsDKhMfc=;
        b=TUCD5VbJGuxRQuahDkRgDuYd7FL435PwZOIgBLQn5BDl0wTS6ph9zzsDVfaYLDQDXP
         U2A4g0eBuidveIkC8rF9Z4WaglMZJ7jeYiW1OBPIsbyPVL0huEa1pE+tEO9sr7uS7+2M
         jiTDSJ4Vuwyalm3MDtUuo80v0YsRbwHf9fDM5X64ColuzLNJRTJPSox5klQnWXs2Xn4V
         GJeAduqo0SrwXBz4d9+IPXGCRTq0fCzHHOqhvIuw4ptMh2WodM0wpTRQv2VYOJonqTN6
         uNIiDAwlptlWQ4fE1Pl/EGoj0uy9yLeW9UVAImnlLXXS8nArXX/EZgmkIIWn3kX0b+Op
         ZNcg==
X-Gm-Message-State: APjAAAWKpeN3qHTPbunpBMWH0ko7zcr5W0paZ36EKLwbj//QEHZGctgN
        K8rDcxRlwE78v9CuKfGquYF8Nt4u
X-Google-Smtp-Source: APXvYqz1kGfc0da1DHc7ZFOgW1HsoNJbKxBNe5JBHdMSxmzfgRKtPLyR77mVoA5kG4mpQLMuz+NnOA==
X-Received: by 2002:adf:8189:: with SMTP id 9mr39799430wra.71.1558276994133;
        Sun, 19 May 2019 07:43:14 -0700 (PDT)
Received: from localhost.localdomain (x4db573a6.dyn.telefonica.de. [77.181.115.166])
        by smtp.gmail.com with ESMTPSA id z21sm1782343wmf.25.2019.05.19.07.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 07:43:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] trace2: document the supported values of GIT_TRACE2* env variables
Date:   Sun, 19 May 2019 16:43:09 +0200
Message-Id: <20190519144309.9597-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.424.g15834b9bb1
In-Reply-To: <20190519144309.9597-1-szeder.dev@gmail.com>
References: <20190510211502.GS14763@szeder.dev>
 <20190519144309.9597-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The descriptions of the GIT_TRACE2* environment variables link to the
technical docs for further details on the supported values.  However,
a link like this only really works if the docs are viewed in a browser
and the full documentation is available.  OTOH, in 'man git' there are
no links to conveniently click on, and distro-shipped git packages
tend to include only the man pages, while the technical docs and the
docs in html format are in a separate 'git-doc' package.

So let's describe the supported values to make the manpage more
self-contained, but still keep the references to the technical docs
because the details of the SID, and the JSON and perf output formats
are definitely beyond the scope of 'man git'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git.txt | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index fcf81e3acf..6ddc1e2ca6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -665,21 +665,48 @@ of clones and fetches.
 	Output from `GIT_TRACE2` is a simple text-based format for human
 	readability.
 +
-The `GIT_TRACE2` variables can take many values. Any value available to
-the `GIT_TRACE` variables is also available to `GIT_TRACE2`. The `GIT_TRACE2`
-variables can also specify a Unix Domain Socket. See
-link:technical/api-trace2.html[Trace2 documentation] for full details.
+If this variable is set to "1", "2" or "true" (comparison
+is case insensitive), trace messages will be printed to
+stderr.
++
+If the variable is set to an integer value greater than 2
+and lower than 10 (strictly) then Git will interpret this
+value as an open file descriptor and will try to write the
+trace messages into this file descriptor.
++
+Alternatively, if the variable is set to an absolute path
+(starting with a '/' character), Git will interpret this
+as a file path and will try to append the trace messages
+to it.  If the path already exists and is a directory, the
+trace messages will be written to files (one per process)
+in that directory, named according to the last component
+of the SID and an optional counter (to avoid filename
+collisions).
++
+In addition, if the variable is set to
+`af_unix:[<socket_type>:]<absolute-pathname>`, Git will try
+to open the path as a Unix Domain Socket.  The socket type
+can be either `stream` or `dgram`.
++
+Unsetting the variable, or setting it to empty, "0" or
+"false" (case insensitive) disables trace messages.
++
+See link:technical/api-trace2.html[Trace2 documentation]
+for full details.
+
 
 `GIT_TRACE2_EVENT`::
 	This setting writes a JSON-based format that is suited for machine
-	interpretation. See link:technical/api-trace2.html[Trace2 documentation]
-	for full details.
+	interpretation.
+	See `GIT_TRACE2` for available trace output options and
+	link:technical/api-trace2.html[Trace2 documentation] for full details.
 
 `GIT_TRACE2_PERF`::
 	In addition to the text-based messages available in `GIT_TRACE2`, this
 	setting writes a column-based format for understanding nesting
-	regions. See link:technical/api-trace2.html[Trace2 documentation]
-	for full details.
+	regions.
+	See `GIT_TRACE2` for available trace output options and
+	link:technical/api-trace2.html[Trace2 documentation] for full details.
 
 `GIT_REDACT_COOKIES`::
 	This can be set to a comma-separated list of strings. When a curl trace
-- 
2.22.0.rc1.424.g15834b9bb1

