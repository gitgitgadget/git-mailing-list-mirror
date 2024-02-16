Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E159208CA
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078623; cv=none; b=SzMIUPPQ2oLEc60I8TQvaYSNscw5LLA97c1hyj0Sz7d6BY3oj1N0x18lx8fi2vK1317Yn8AoTqxl9KG4k9wRKvynBHdMjaOcuubgyU3NImrrWsFyQQe9s4Fhnwm2inHlAR3vEUQ31aXBMeyudUD75bBW8KD4e0Yj0YuZmwpJJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078623; c=relaxed/simple;
	bh=7TlOvD4eXxsAEOjwv/pJ/+tDVuYvt5PgXKRpN73VlkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4cggakiKgCSTteP0DC958aLPDZnVZYAF0sO/6voMOw4bfy/ficsPjdO89TVTm9CsXUQsAiIHToXU1kISk/WB1XAV1wdikV4A7wrizsmAadxt8Lqc7gS97hjbNydAvSLqHvrWbi/fRzuHSGx/UiIIafrAkyR5AriYVZuEq+/uuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=i+3tp0AG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="i+3tp0AG"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563a6656c46so2833077a12.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 02:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1708078618; x=1708683418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUuO5ryal8OnM+8J/47QenkPFXvn9ovZYBPDNIQlmLI=;
        b=i+3tp0AGfQ+0cFBPnRwxG7yb9ONHQSKWEMs2//yx60cgSKHxsekbZ5Dt9NKcaCpVlr
         irobz07NfgYX8K7S8eO/wSGaLU9fP6jaAi72wdymY3D1lvMBqv22/2aJNvNMk+lE4dZT
         1ka8CusBQfuJH8g9ejoWuDNcG3FD0jzabveDKO46Uq32UOGASgYebHs20FcE/5zYqaUa
         L7r6ABnVDpVFnXctSNUvG/Sa6SP6xI+O70fRM8RqLGOZWV1E8wI7NXHyEyrgtPxPFSBD
         VQtwntHfjRmuRfDI6GUvjoVQ+EcbM6V/1kUQHOB7oX7o/u3XlkNVEZ2ep0LwGyyii7md
         SXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078618; x=1708683418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUuO5ryal8OnM+8J/47QenkPFXvn9ovZYBPDNIQlmLI=;
        b=VkZu/blNZRZ7Tnl4FvIX99wONWIpiXJHWByOsaK15lOO/9K2CVxjA8NVtH7VlIcJ3n
         oY2uugIKSZPZsOgt4znwnmXMlIHsj2WttyvI4CpjnX4G6aAjrrj0VglXtLAawJqgp6W0
         BOdra956VoDT2fd+Yv6eLB/VoOClrlxEX8NNjMr7h8Yr1d/I/8I1UqYIhoHT7qsUc87W
         Zr6DACJDQsvQyReHDEXTvqyE7d6D2MwWYyWaJCu7lWBNe+1G2b7O2ppUbuGeJFlkl9GG
         QLJadBmI31KTqkqf7Gn9p5ldyL6P/os71PLJOWWLt1Nyc/q7KyL8Be8IR5K08/5R0Cyy
         euyg==
X-Gm-Message-State: AOJu0YzmKu8SJeco4azG0Q1JCfNJp8bNTOIIscuo/DTN6vlUEw15KDTt
	Sps9OorsQlHTTANMnUtm2xXx6wfArR0FqPadBA8B6PKbQVzXhJv85dBN0SzDLMIKDLWhp9P35GK
	B/hb1Qw==
X-Google-Smtp-Source: AGHT+IGOBBEvOnqz9AV6lmsto8nVjNbG/dvHPXGY9941fFaWtfA3M4KJqs6QIoVwGEMJHilUKpDkUg==
X-Received: by 2002:aa7:c44d:0:b0:560:799:f802 with SMTP id n13-20020aa7c44d000000b005600799f802mr3041951edr.21.1708078618630;
        Fri, 16 Feb 2024 02:16:58 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.192])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7d9d4000000b00561fbfebdb5sm1337682eds.96.2024.02.16.02.16.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Feb 2024 02:16:57 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	felipe.contreras@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [Improvements on messages 2/5] transport-helper.c: trivial fix of error message
Date: Fri, 16 Feb 2024 11:15:34 +0100
Message-ID: <20240216101647.28837-3-ash@kambanaria.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216101647.28837-1-ash@kambanaria.org>
References: <20240216101647.28837-1-ash@kambanaria.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark --force as option rather than variable names

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index e34a8f47cf..7014b9ad70 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1072,7 +1072,7 @@ static int push_refs_with_export(struct transport *transport,
 	set_common_push_options(transport, data->name, flags);
 	if (flags & TRANSPORT_PUSH_FORCE) {
 		if (set_helper_option(transport, "force", "true") != 0)
-			warning(_("helper %s does not support 'force'"), data->name);
+			warning(_("helper %s does not support '--force'"), data->name);
 	}

 	helper = get_helper(transport);
--
2.43.2
