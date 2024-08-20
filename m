Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3455168DA
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118520; cv=none; b=Kya3L75w2SlfusLd6m7KZ+eP0xDadmSxzrxkQfClNKaLMy3U1VNLt7Zt0hGA8SvPS2slwUxNBNyC9dFlTmFgHIhJSLFrNTdrnx9CjXjEmmXkkoBRCwsrfAlHS3wmXScxUEv6xmbrHULg/HrVJE6ZJoUFdV1qTI8NuZMBucpUaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118520; c=relaxed/simple;
	bh=PeWD7Xzsyt+Jh9Nqsn4TpYWX2egoJFqBtWAUMS9nZWQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ah9wWlh4CHUW32gjTpRi0Rou6+s6qksIs/QTpNlsUIPXRBO8eL09SkbcFnfU0U6zRR7N/zvZaog0sKJoAZqohqFC4UbsORWMb4tD/M1CcZ3UPgzEtuFZWXyAyUKk80Dj/g9f2AT8mwns/XV41WNpyg9l40ccCCgC9bHzqd803KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKoAu0kf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKoAu0kf"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3718b5e9c4fso2476204f8f.0
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724118517; x=1724723317; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bffUfw/AShNzuPzmr6Fl68h5i7kGOyEHgnQZYZFtG8Q=;
        b=GKoAu0kfJUjmtaBzmLeGDMq3UxhQHrLcqmB8ZzTu8VXxyV6bFKKQ1N3kTMYlkS24PB
         kKsDNIModejNXE10PKIIIQe7DdjUsfpvdN87j79WTtAurUJSeDTEHH8gJXLdnDYewRC9
         GPb12xaOCCPZ8aDnMXfzAUVTfanwfPG1yZVbTyKqo0jB2SjRol7yqIylRH+GuQzcnMar
         ePBSkS8U0/CJUK3J5GMOOsLvytQJ1s8TELoTEeEqO8DxQNyp0h4dR1cs2f4hvr2lptuH
         axkykw5EHdRFXg0JNxT8igw4wfNrD/Vm0hsDmqWf+oKVMpNam1hNmpmsV9jmxthxKDF9
         HVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118517; x=1724723317;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bffUfw/AShNzuPzmr6Fl68h5i7kGOyEHgnQZYZFtG8Q=;
        b=pWaxs2Q82A2agQnbutKw3efFWu0Od+BWfZhQt1njngADDfWPXqnrK5xDEbowFCElWO
         aB1K3f0zElwsn46GVpbubGfVUATmfG7iEOpqJQymkYq38JnE4p9V/2S/YYM/bhNmqeR3
         HuI7b5LG7LKk0OE/2Dv9WB8HvlDVJDwuDVCVDpPkbxySrf+Oy6LPe3xAnoxXMu3gIpvD
         ajpdEmzzyZhltjTnRxYs+sK6ezyGA0H6G56N4hTO1CGYXUl2RvBNJcaujiIGkwwQmpA3
         JbY4ejXLHNkZOtzQNYfAuodKbVgLPGYAc9HkOC7yMGU83WT1uyo42zCwie9Oc6wRQLKB
         HVNw==
X-Gm-Message-State: AOJu0Yx8PwnFbfn51xknrCBcL1b6IXiNY9+xtUaH31tXdbTwrT39s/NT
	fN7XTrPGNZ9fP3sXQ2syKs+4Iwdc6/zKmDQYwvhL7T77JZyp/4WiBEOktA==
X-Google-Smtp-Source: AGHT+IGev0l57w4xowoYvJ5EH7Ym6s89T6ObIrt9/ZfbxogCiRZQkMfry0Lf5nL/Nv7UHR4TxKwX4g==
X-Received: by 2002:a5d:52cf:0:b0:371:8d47:c17b with SMTP id ffacd0b85a97d-37194653697mr7497150f8f.30.1724118516379;
        Mon, 19 Aug 2024 18:48:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839344fdsm697933466b.100.2024.08.19.18.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:48:35 -0700 (PDT)
Message-Id: <680ecb524040c64f886c4e484a64f0d17b512e27.1724118513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
References: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
	<pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 01:48:26 +0000
Subject: [PATCH v4 2/8] git-prompt: fix uninitialized variable
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
Cc: "Junio C. Hamano" <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

First use is in the form:  local var; ...; var=$var$whatever...

If the variable was unset (as bash and others do after "local x"),
then it would error if set -u is in effect.

Also, many shells inherit the existing value after "local var"
without init, but in this case it's unlikely to have a prior value.

Now we initialize it.

(local var= is enough, but local var="" is the custom in this file)

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index ebf2e30d684..4cc2cf91bb6 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -116,7 +116,7 @@ printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 __git_ps1_show_upstream ()
 {
 	local key value
-	local svn_remote svn_url_pattern count n
+	local svn_remote svn_url_pattern="" count n
 	local upstream_type=git legacy="" verbose="" name=""
 
 	svn_remote=()
-- 
gitgitgadget

