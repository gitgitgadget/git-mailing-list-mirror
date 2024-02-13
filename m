Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5421A06
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813714; cv=none; b=l9Sj3HJN060YS7VU2evCE4BsOwXovQNn2eBzWZqVU0ea1qkQPdvy82YaAk0wmLkSs/2PfuJQk38omeYMMbC93w8Lfho2o7ILJZgpTvjbsNzSzy+Zh0nvVGbSFOc8lw1T3y3dVWrRqf8YFfpbZYyk2wI0wM0iBosJGQ23IL5I5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813714; c=relaxed/simple;
	bh=maRSH6CdZ0quV4tjfMdY3X/x0x6ekaCEyHdN+5gSPNQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i6vJ+jw7TehyNWkWY5NvYqQAUqXYZQLFrbcSEiCjQTuEAxi5NEgnPrFzR6pwNOimPqX2o1SfOuCCW4+p4GZk8X38iWGGt4BY85pkW5orOElB7DyQOJKekXiPv+gVQLAB7k/XC3VGEoaB4JUX/H4z3kRZPIo7tnVwvAtTU0KQj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUFE6btg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUFE6btg"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b8807b55aso774647f8f.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813711; x=1708418511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7TKBKP3jIBTZf2WQYt+2Te9xx/3veTpIXxjz+O2OTo=;
        b=KUFE6btgykpYUoQTG9Zg8f4kVYRwOovQ4ABC3JKSSkSGc6m5I5f+O960eRY1rji5M8
         +SYOexlkpNf90cSwGkpKrvLO3yW2DodaJ/yZ3R6dXWbMVmJfAMwlJhk+n+vhBzLul/E+
         bEx2mZsV4MC3EdgvoAMV76l6O4yTyyd7+EfNWn5ExO/djjBSsvbLQAAsLNGTlP0lTWrU
         qGrjcW0QbzeFBe2Gb8kOaeAEbx0oPyTcSU5BXCIShuXloah9rz2fv/3jaXJpViBFUvso
         ZbnsCB5VQz98GnyFsPi3L4yFn/d/Poy2X/cUv0/hWZsR9bl6kx7LHlIrSsqjYYENmnAs
         Nimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813711; x=1708418511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7TKBKP3jIBTZf2WQYt+2Te9xx/3veTpIXxjz+O2OTo=;
        b=nYmVG4e4/UJBjGYnuqrzWxIktbPpSctHGFaykMXOEj0SaItfhIpx+TwufgLBhbijef
         sy+Q7mtuI9ifzHVtmvYTwVzhU/O4+UKa9prAb/lCzd+WMEzpZuVEh/2ef5gr3zyRwMT/
         M/pXDTgtQxdkaS4llggWNc/A1OBh0SToWTsvpjrRnHuk9pi3mMMQDNdqbKygJ7sgf3A/
         8WRzOOCbZxOC+CdsR1eIKbpEjHFL7GXx2JF4YQGJFq0sJAOEqTHvKV5VCWQnBSTPLUdV
         FnDkzcRlmgF2cqhDukEI4S5CtCkqdTWCgEkmwe7ATHA1L7JVZ0wxlR8l2x6dQJLGFUQ9
         lJHg==
X-Gm-Message-State: AOJu0YyxnZ3xnWTcTwqOxNO74rFWiRftVS59wTXv2mGcWuZ9NescVfml
	AGc1H0Uy0ORDVao1e380K5v3btNQXWc1yCVzMgFzc2DGf2Ab3Yk/tnatais9
X-Google-Smtp-Source: AGHT+IE2u3hc6hFfpbkwdmbBGTqONZMHcrJ73GPS/zy0C7+/sc7uEcarh4Y/0HMDN46jZpahpHePnQ==
X-Received: by 2002:a05:6000:4027:b0:33b:4e58:7a8d with SMTP id cp39-20020a056000402700b0033b4e587a8dmr8219779wrb.63.1707813711164;
        Tue, 13 Feb 2024 00:41:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d66c6000000b00337d5cd0d8asm8879209wrw.90.2024.02.13.00.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:41:50 -0800 (PST)
Message-ID: <818eef0a64443e42c288ea3b294bf52e7411914b.1707813709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:37 +0000
Subject: [PATCH 01/12] paint_down_to_common: plug a memory leak
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a commit is missing, we return early (currently pretending that no
merge basis could be found in that case). At that stage, it is possible
that a merge base could have been found already, and added to the
`result`, which is now leaked.

Let's release it, to address that memory leak.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index a868a575ea1..b2b102926c9 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -105,8 +105,10 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 			parents = parents->next;
 			if ((p->object.flags & flags) == flags)
 				continue;
-			if (repo_parse_commit(r, p))
+			if (repo_parse_commit(r, p)) {
+				free_commit_list(result);
 				return NULL;
+			}
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
 		}
-- 
gitgitgadget

