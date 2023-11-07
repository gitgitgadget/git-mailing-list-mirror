Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439911C06
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjHS912D"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF46AD47
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:26:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40806e4106dso31214815e9.1
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 17:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699320366; x=1699925166; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrNqApZaTAMJ3ypF51MD7pz+pkjEnOmXRPaJrQHAEdo=;
        b=OjHS912DIUISIWiWvySgNFoezYDs8dphe2Mw6jhwsOhYPrHSd7YtlIl26aXWdz9Np2
         g8dN7Im2RCgWIhjiEr6VjzuHgCW6np/ZV3z3oPS8Mxkp/6/QHN4VY5eMJ3ZsjOID9sKI
         GFywDtOy4fMvEBeaU7TfHBdDO15PqRwYrjQMmMITyVUOrY2wFHIzR8xXzQq5IhPjo86c
         T6HDbP5nG4usWbZ6PK6+x9WcMuRH04tcyD7MoRo8LkUigi2akAMIoHeE6otOmH4KT+t+
         Wg6EyzmdX/8nJ6I47tvmRzYfdPYIqaeJckDGr/pwEzByrp3AC2aw7bM7uy2Bc/MtX06/
         NSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699320366; x=1699925166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrNqApZaTAMJ3ypF51MD7pz+pkjEnOmXRPaJrQHAEdo=;
        b=lh6hcTBrPj+7gJM/ToBsjCxTOoez68F/olE2p/c2d924efsqotM6+1Pczb3joC7hjC
         nbrc2/lyVRlW78iEo3QHBNzo0za5EBzLGyU9R6YyvrTm6332wsyzaDWobRZDl8W+KKGY
         w036m3TsjoDB35v3rOUEt0UdwPXKuyKTOmjezAWYXj45J8Uo9K/FD4qHX9Xi41VnU7y+
         4YQWZIcAWXERVV2O8jgolDFc1rkgh0SJQRqJnVIjRDnOiXqeAC6L6OCgHH88zDYOAvvY
         bAsy8NOHvOmUUaIMitjyQFL5RtM4UQZ/sXH0JMEkXdEcifKc5bTJscmAVGycdEAtBh34
         np2A==
X-Gm-Message-State: AOJu0YyTs0sACqsx7EfXdZl+7zW/FsogqlvYIGQ7eHyHl7ZsvCd4GXjI
	UWaIBm86eKIwPm/l5VAlN11fAIcE6Pw=
X-Google-Smtp-Source: AGHT+IGccurL8bzn8M8fND5g9b2etvIsUSnr5T7bj4hKWfi2Du1oOP1mseOF6GlP4WouWobmuWtYPA==
X-Received: by 2002:a05:600c:154f:b0:406:51a0:17ea with SMTP id f15-20020a05600c154f00b0040651a017eamr1330044wmg.10.1699320365601;
        Mon, 06 Nov 2023 17:26:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b003fe61c33df5sm13975599wmq.3.2023.11.06.17.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 17:26:04 -0800 (PST)
Message-ID: <88eba4146cd250fcabfb9ffa9b410ce912a82ce7.1699320362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Nov 2023 01:25:54 +0000
Subject: [PATCH 2/9] for-each-ref: clarify interaction of --omit-empty &
 --count
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Update the 'for-each-ref' builtin documentation to clarify that refs
"omitted" by --omit-empty are still counted toward the limit specified by
--count. The use of the term "omit" would otherwise be somewhat ambiguous
and could incorrectly be construed as excluding empty refs entirely (i.e.
not counting them towards the total ref count).

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e86d5700ddf..407f624fbaa 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -101,7 +101,8 @@ OPTIONS
 
 --omit-empty::
 	Do not print a newline after formatted refs where the format expands
-	to the empty string.
+	to the empty string. Although omitted refs are not shown in the output,
+	they still count toward the total limited by `--count`.
 
 --exclude=<pattern>::
 	If one or more patterns are given, only refs which do not match
-- 
gitgitgadget

