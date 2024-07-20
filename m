Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128113C689
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491330; cv=none; b=RXxW1S2wBWvtd/B62liwG7odleGdEKg2NjNx03IwnDZmGAf3l+80Y9GshV20DNTiaa5Ou8dqXxTlkhQEIe9bEQuly2Y5uVxAAzXC1jXCvFxZmvAkKoOqQ34zQfRjz5avm1j3PmcYWj0ACVbJvcZxDMy0NnpqJnvjdFq4H38Hj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491330; c=relaxed/simple;
	bh=XvRrJsaf/kyLaVhr6z6IwjVCr/3sRBwaL2qDGS4uGs8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=COrW6GsSDOOT2AULfxBY0Ps2FwYKf3K45qSbEMjUFIk1q7+EOn2UihQfzNZ2Gkoe66tlSwseDWGxBhHzK3IlFsM3/0vP4vDxY1MeaNiawmGWPiXJDPBdOquW8W6IFrOUpVwfOWl4FeKLk8DAgSbYLaSvGNzTJ0nvS0vsYvMzVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqayhzbb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqayhzbb"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4272738eb9eso20713315e9.3
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721491326; x=1722096126; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xn15d2w0u5wwj7SVEeyQFSPTSbLNpYi5g7QcyZRsBcs=;
        b=TqayhzbbEf6Gpi+6oqhGTLzWlSyxqpB5fMyREvik0GCIMtuHtlLCsRaGrc8VXWRy/L
         9OpIgKfI0/zIWYYNmNbanLsKLgygzB22WRHcCWegsjS6l8Ay0frQLOSDBMktRsuu3SZj
         j67wX90fHMNJH38Rw8JV62oIOSYWjO3JNatEbnlDMnTeyICynOHqBzGi9ruTBohS74bM
         2+6Z6ld9J6Zvd4UY3GQom5Oq1iUtVACKkh8J0oW5IqtWrh+1cVXix3f7ynyb6c0zeutE
         bE4wUaHfce4rbs4s9tnESl/4AC1FlWEXDFKPZ/KCB2hzHd0ZnFogQZxer7Cm2ydlBkIu
         5jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721491326; x=1722096126;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xn15d2w0u5wwj7SVEeyQFSPTSbLNpYi5g7QcyZRsBcs=;
        b=CN56q93tTxQR25U1fWUP9X97qk19CZQhyuud0A1RaB6VQORtBzMb62nQlykFzSSYCS
         1EEBEVQlC2ZO7CBH6ByKNmJ+yW5cAoGmtppm7RPus/SrYAElSdgehwjf5/QCO7Pvhnh4
         91RfMBVgUtEYCTx0Yp4dwIGwXWGsLm/dg4QXuqVOktuh8X7Mo2lNsv7m/kX9jDoKGaVD
         rDmKeFAZI6+yoHQxyCl7GSnSV5PyxOpJIMpycmt/oU7AalVaZFEYgHLZ/U3utrSID6kK
         GjRMoxRY8oSEu8Eud3zy0dukLHsmSjQQ5tgK6nPjyYWFiWppQZp7TrUModVFWW9f2ZM7
         4OdA==
X-Gm-Message-State: AOJu0YyoZbhBiaei8IiSdjXEnyfJS3oSJ0Nwnr0UQ0qLCKCFxMXEAqD4
	45iHnqHeFKSf7C44WXKjqii5wtnGX/VmVKhIXCU+vL1t5FMc54kL8EPfbQ==
X-Google-Smtp-Source: AGHT+IHQvNKTkw8/NyhJTvZ3cHXlV04P9y8tCVZju36hFKBkZJiZn3zrQaWoGBwlxD/O+DOGHWnKcg==
X-Received: by 2002:a05:600c:3542:b0:426:59fe:ac2e with SMTP id 5b1f17b1804b1-427dc559b85mr13115195e9.29.1721491326238;
        Sat, 20 Jul 2024 09:02:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e420sm89004135e9.35.2024.07.20.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 09:02:05 -0700 (PDT)
Message-Id: <7bdcd2df01246932e452417815368f6c56d83e8d.1721491320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1763.v2.git.1721491320.gitgitgadget@gmail.com>
References: <pull.1763.git.1721312619822.gitgitgadget@gmail.com>
	<pull.1763.v2.git.1721491320.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jul 2024 16:02:00 +0000
Subject: [PATCH v2 2/2] add-patch: use normalize_marker() when recounting
 edited hunk
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
Cc: Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

After the user has edited a hunk the number of lines in the pre- and
post- image lines is recounted the hunk header can be updated before
passing the hunk to "git apply". The recounting code correctly handles
empty context lines where the leading ' ' is omitted by treating '\n'
and '\r' as context lines.

Update this code to use normalize_marker() so that the handling of empty
context lines is consistent with the rest of the hunk parsing
code. There is a small change in behavior as normalize_marker() only
treats "\r\n" as an empty context line rather than any line starting
with '\r'. This should not matter in practice as Macs have used Unix
line endings since MacOs 10 was released in 2001 and if it transpires
that someone is still using an earlier version of MacOs where lines end
with '\r' then we will need to change the handling of '\r' in
normalize_marker() anyway.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-patch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 8feb719483f..2a72ad63d14 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1178,14 +1178,14 @@ static ssize_t recount_edited_hunk(struct add_p_state *s, struct hunk *hunk,
 
 	header->old_count = header->new_count = 0;
 	for (i = hunk->start; i < hunk->end; ) {
-		switch (s->plain.buf[i]) {
+		switch(normalize_marker(&s->plain.buf[i])) {
 		case '-':
 			header->old_count++;
 			break;
 		case '+':
 			header->new_count++;
 			break;
-		case ' ': case '\r': case '\n':
+		case ' ':
 			header->old_count++;
 			header->new_count++;
 			break;
-- 
gitgitgadget
