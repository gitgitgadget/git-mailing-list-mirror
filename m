Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB541DF27D
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770869444; cv=none; b=L3muPnW/QGLegt9sZ8ZYkilwTf4HWg4bR3dySU5+SQ8dI4uaQo/S3dX24qUs4kXlLiTFQ4eAVhqXlI/INLWb/pJpbMrjmOAAO9ygI8OXA9N8AKL9IdKroUwliOWy6CRs90ulAKEFF9pDr5bMmf6wUjN+a6lWXK0+Tex6/pG33M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770869444; c=relaxed/simple;
	bh=p84hT7Vj+RgOSTca3R0/r8XcwJAFl+Aydz/5e9WHz58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mG1+fkpXB8v7wtvmCxCMxWvFDGOUiixqzvysPVbd0QPp4OaZGcT8It073BAUQOYJMySQVX4Pc5b3fXm5rSJPFzDCWmOFPD97kZcvZnz2QN5dA4VSrH/EWf/600jqas8+amG1PWo45N92Wu8cEIXKX5JtaOLfNkm3sMnnrTifAok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mngwdvYJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mngwdvYJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a8fba3f769so32466625ad.2
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 20:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770869443; x=1771474243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5RfDs7QoR/9s0Q6eGp7yIOUa21r0MNgQYDUL6cOIgw=;
        b=mngwdvYJI1NT+LE1n0JnKDwrDcqelAWUmNHBfFcJLEpG7WhqHqPDzF8wDfgEPZYayH
         8oDkjw1spBEzNmUNcKxRsCu9HqSfgNq0JhF7jO89oaIATtlh9m6HKDihJWE11mdGA2AC
         ycn69vYdChGOoNL5pzetZDh60T3es1h7NbQZ2p0AYhpMcLJP2rPs+MYRsfo+r8lVLHjA
         L9mOf0qxdCX/jvl1xZR81bJSGURBMR/5lKHcPh3d1+uYczn/fz5IPe0/g6KXGqtjvfQZ
         87dp4Z/2sHFmHAq+vBKzajIgfR4Tg/9MhtghasOhlwazUCnBlo6lHVjcIVbpa22sODVb
         9uOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770869443; x=1771474243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5RfDs7QoR/9s0Q6eGp7yIOUa21r0MNgQYDUL6cOIgw=;
        b=DfoKvFbN14B7V2g7ub2dmiVDhqSK3MhAkPUOGqfZBAlJ4X9jB6+yQ+MIOuTgQR8BBc
         4h49eHow5ow2U2eklW6aNxrzpudp4pikIvTtiVpRpiM3XTytmt/NIg0IkLxcfG7kAnF5
         ev/gCahp395OkLVEXyC10SzJHSjQvQxdM7n/vAF+v7HEx5acswdXWQ7PCZVuZAwYEysJ
         w1hknPWJAcgb7IrYtwGapjs0p/SMm/EynCG9+DKZ0xKbhQlqcdpxpj1WeMNU3FEie7FG
         37f0ttZ8UVSzVoKeAthBloTvpKa/i1YRqDwDLcjsKylRet32K1gRdEp77aazegvl9+uV
         CFrw==
X-Gm-Message-State: AOJu0Yx+EWJ1xu/5Nqa5dPAoyhwvDPGscPA3AVAzNDRWnGy6EY2gy8RU
	U6HVHG5M2YWH1diV23TUa/AQOAEeSCYhPcrjKHI6VBvTT1Dcp8xpuInjb7WYtg==
X-Gm-Gg: AZuq6aIgUuEASY6mVRYERL9Dvhp9O7My18hSEZrwqWSxfDAmLIBIww/3wQJYuGstUNV
	PhfGq0AO+O+BQCcamZqvuz57wg1n6Io++Rydot+vv3BLD90yGzkAjb6LCot8lONU04lYXjAzS9M
	luwWUwFpAOaM8DhdECK5k531DSvpmmKQ5aDPyeM4OvzO7FgsWndDBiDyX3qjqS2wQCkctamNmnL
	sJ5ZdxSuVWZ7WhzzvF6JCfYG9QUaSX5QOeSRwCCsyfeK6p8H1j0T2SXWjgtF34oBiRprbDa+YVT
	Avl2r6VGMQjHrH6ns3xfbV8X2X+InJ3WlhYsKCSIysBPv9gglrIxhrlx4pA1Yr0nXBVDtCsvJL7
	e5LwLJxeaekK4se0pXJnhLEmQ3tFljScPtUhtKyKEAqDVH1SZPJv6Q8/tb94X7L+e8V1ZOpN5Xx
	bQ7WMwujdRmP3squjTJavKnYrBQjSyYATMvEuJdqBbGNe/bmfuHsgJrEeuFASaUKwQ6vzFSyr/2
	d8=
X-Received: by 2002:a17:902:f291:b0:2aa:e817:1bd4 with SMTP id d9443c01a7336-2ab39b18249mr8010795ad.37.1770869442651;
        Wed, 11 Feb 2026 20:10:42 -0800 (PST)
Received: from localhost.localdomain ([60.254.0.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29966612sm52919805ad.59.2026.02.11.20.10.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Feb 2026 20:10:42 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	peff@peff.net,
	avarab@gmail.com,
	Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
Subject: [PATCH 2/2] help: ensure &keys_uniq follows sort -u
Date: Thu, 12 Feb 2026 09:40:17 +0530
Message-ID: <20260212041017.91370-3-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212041017.91370-1-amishhhaaaa@gmail.com>
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>

uniqueness operation of &keys_uniq depends on the sort operation executed
for &keys this might introduce regressions in future when the logic of
forming &keys_uniq from &keys is changed.

add string_list_sort_u operation for &keys_uniq after the processing of
&keys so it follows the expected sort -u behaviour.

Signed-off-by: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
---
 builtin/help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index c09cbc8912..0c9c007214 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -196,7 +196,7 @@ static void list_config_help(enum show_config_type type)
 
 	}
 	string_list_clear(&keys, 0);
-	string_list_remove_duplicates(&keys_uniq, 0);
+	string_list_sort_u(&keys_uniq, 0);
 	for_each_string_list_item(item, &keys_uniq)
 		puts(item->string);
 	string_list_clear(&keys_uniq, 0);
-- 
2.52.0

