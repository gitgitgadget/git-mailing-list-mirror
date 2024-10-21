Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB11F9417
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514512; cv=none; b=Rp9ODN2aIFTYEwFBnAkDx0l/+rEgNQN3xlb4laj2DDSouiYbMo9J5rNKC8lfFQrGhEInflYSxTeN0B96OVst89JO/hn1Pmq+ai2roiewMVmWN+jZrSTNnEvyUB74/GSAOeEvXFtZYFJCi5QJYGWvpZOfI8Mz/jEQHpm4XoXMBVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514512; c=relaxed/simple;
	bh=wW4e9sV8/v0Ea64U4rzhjh1umdcwa30W/+/+jsxm6C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJI/7r9b6KqF1M+Nsko7u+SRVFyZpxjwGSm1FSPriqRAPjrXXGV+ATdbVxwSnDtyvF7nKxHjuXRvTW2Ycxg39BmGCu+TXqhDPMBaKrrcc1uTwOXDNc4JtcnC6oz+MPF/1ce4tZBji/FoTS3lZdTzHa+BElaOP8Z2qAmM8cHw/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Udmb/trY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udmb/trY"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so482761466b.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729514508; x=1730119308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FnoeNbYUKSe+mD+onpaZen/6OwjscxLW8L5bZuPSJ4g=;
        b=Udmb/trYm7/cqZ2BwaJoXd8SihQwMpCjROew0k16rdwxj6uM41gogUnQvRDVVULeFD
         XkInOyqO/880V67wHzyhvXoQqYdmOJ7nOViUknE3NGEah55jCh/xqMhiyykcRuGEmBfO
         59ZX7BDA1eQs4yqPBPJS0nDnsYmjzSRGh6y8Y/2iOQYR6NhF+Xz4TSAfw2hH0XB+w0xy
         363DGh9Wa+t64jKg/MVi5IlH5aFpVQEQZfY8nO7zOIU1YFRiykjCDB293evMmNjb+J5O
         rw8nyhcd43ZdffziIUrUjyRN0ZlMfO74UAIyMyl68GZpW4wWH4fjHjqxhbx1bYxl4Zse
         jFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514508; x=1730119308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnoeNbYUKSe+mD+onpaZen/6OwjscxLW8L5bZuPSJ4g=;
        b=GJzzYGvV07Iq35uN665o3k78hK+ugvWxXbn6AB5MirJ8R/2rloc1BbtXNlQ5PyTs7A
         3Qlr5XuTiugYqEzX57eh56WueaZ7jUrqpZgj9ARP/lOHLcKCwDwIB6aYxYH61dWgDJFE
         EgSRVRR3/FjKEpRrb5Df4xVBlUXMoDg0RTsA2UwrQuJnwR3634jVKLr1xgXdWUT4Hl3w
         Z/LyfSREJybg//dYHU+ZiH9xHJdGKVbuUB2Bw0f8k5alyHGxHmea6x1A8ubGfWCsNhK7
         yLmXXI8S/ON1847CGXbvJn2e1Rbtv+timMTCu6N5c2VpSKk+c2jZvcspVKuQnIzhNVuV
         qvAw==
X-Gm-Message-State: AOJu0Yxhqr/gNO0fNPLoXn1KDIl8fo2oJ4EpQowvI+8DFEnVUJ/JGNg6
	CXa8Shudyd3KgYmBAJb5UW2ngWjoZSru84jcXewcMpMHK61bAsj4
X-Google-Smtp-Source: AGHT+IExS2dTzQNTqq5GaziCC8GFttjougT6Kj6SnTqUXlSDZBzEpstpFLKq5b2I34xoo+LDrN52EA==
X-Received: by 2002:a17:907:980f:b0:a99:fa4e:ba97 with SMTP id a640c23a62f3a-a9a69bad21fmr1083743966b.39.1729514508030;
        Mon, 21 Oct 2024 05:41:48 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d8381sm198522966b.45.2024.10.21.05.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:41:47 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	ps@pks.im
Subject: [PATCH] CodingGuidelines: discourage arbitrary suffixes in function names
Date: Mon, 21 Oct 2024 14:41:45 +0200
Message-ID: <20241021124145.636561-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We often name functions with arbitrary suffixes like `_1` as an
extension of another existing function. This created confusion and
doesn't provide good clarity into the functions purpose. Let's document
good function naming etiquette in our CodingGuidelines.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

This is mostly in response to an ongoing thread [1] where I ran into one of
these functions and it really took me a while to wrap my head around what the
function does.

[1]: https://lore.kernel.org/git/CAOLa=ZREg3xuaT6mbM8+Havn3regZDhK45kGy0+Fw8t56c7Mpg@mail.gmail.com/#R

 Documentation/CodingGuidelines | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 30fda4142c..b8e2d30567 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -621,6 +621,11 @@ For C programs:
     - `S_free()` releases a structure's contents and frees the
       structure.
 
+ - Function names should be self-explanatory, clearly reflecting their
+   purpose or behavior. To maintain clarity and avoid confusion,
+   arbitrary suffixes such as _1 are discouraged, as they provide no
+   meaningful insight into the function's role.
+
 For Perl programs:
 
  - Most of the C guidelines above apply.
-- 
2.47.0

