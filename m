Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC319476
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770869435; cv=none; b=d9rkop9udeO96hQPVhfcdKbOvdNC3Li3oOjIBKpy10hWKqb/uLxcgXsPTquY3toyZ9oE4URCd3jGV+zzXyIfqm9/Upw9GW5kV7+t1u5zMI8YcSpbio5uSuDRURHmPeh+nafWXcPpaoMwJv4qQFASoKN7zkDEljHZZmD+3vW+J6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770869435; c=relaxed/simple;
	bh=FSDFfu9boYULMhfe7cditcpcBSeUvwpHrluL3tdyOCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0mEYfHwvzm/pgtTlVkAYDYlqhIIOACLi0CWNI4xd6K+p7Gs+O4ua2ljVwmCq8mcjmeGhZXJ58QphMEl0xz9DpztQzbvr4OpMh8nuOPc4Y2FrMZUJDFfz1FADvHFaqn+bO38yketpf0MG6bNoXvA4JQoltO+kjh+O+M+elyEHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdhOuVqq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdhOuVqq"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a79998d35aso53260925ad.0
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 20:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770869433; x=1771474233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vicDjEud3c336lkU6U06ABltx8EaR/7CJLged+mar4s=;
        b=XdhOuVqqPQPtgsnDqNfI6Q0RsJSg8bQNaB0kUvwgFKAv2VlMTWIyqkHk7fjAJpXmfb
         ugnsccRoMyRZhKDYSgNrq5IlFCNF/a93/oK4iTFt8o0YZnA890lKEXYHIVaugyt/zVX1
         hYw276HAZaiATvkr6II+sW7Px6JSThMq5telpelThZyKJ3d9kL6+Ati7No30P0qGKJlJ
         N9317ya6LPrn0Ck+sC+nhxQLW50MJFeIaOlgEY8Rd8TOAghIHqm2ATZJBAzHJOscuTzR
         zWg2mSMkDm8QVy4d54s4ZsXpHs4di8QLneDOxhy/VRuyQG3cYExuF5doO8kqI2Hm5wo7
         vW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770869433; x=1771474233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vicDjEud3c336lkU6U06ABltx8EaR/7CJLged+mar4s=;
        b=hkVPuIQDOyFsavdg3O7LxRAfxyLTQszhWqvQNyicJNp4xNYzFbzyNRPLJ42uUR8vYf
         sG5tYSH99YRX6vYSss/J2qQxdFaeOp0qGKsj7KxHSKNfzKVmpq0ecfv9jNlhMdH6G6ET
         o7vmcWfKpKzv2mBWlo39s02M+eLls8gn5ja+SlOrCUzNc2YLY26Ll4C3OFxBSWgYnexU
         Bm45YBAmaYYEX7/JtXTfpgmEFLdvLdnNLKoWXuFyYhBRFLe+l9qTvvLSRZ7Xsyy0tKTQ
         dGc08Vo1wXBgA/LVKv4MMvTFodCTxZ4tWR9qcM6tTcGmBFoC4utLeJzuXGX986yNgxk7
         8Rog==
X-Gm-Message-State: AOJu0YyHcb9wNVbEPRxaAgtsbonxPzCMPX4ugaMW/xOEq+9bGrt2kPVV
	29gyUcCJGQvTKwWUPMBx2mPdeZMo6eYt1JIUJQoh/vyn/THKSzz0TY+R0rENtQ==
X-Gm-Gg: AZuq6aLamYNpy0+j/Qv0nQ7MVAc/4xqbzOBoD9ojflufWhL8AApUJaurwW4vD2YvFvT
	2cGTCBfGnIAOe0OBC3DHQFiVVhbIy/xkaYi7rTi9Vea2/yaKapBI1EC0OirCSk+jsviQkUSXzjN
	IgkhZgyv9h3VAl2TlQRKxXD01WWg8V2u0yz0wjEmRT+aBjcVrs6xIETD+ftRfKcXMDTaPkGSBhb
	uy+GL6yaE50uHG6o/PJPzET/+5tHfLslw2Lh587zIwLLhiNvw6PZozV7rrLbi6FXdWl1yMfdkgo
	YNgehesBJDsc0eLXzmok4ahrXKAm4pV9xLN/9ep2On1afYPwJJcP84jcHUPnGF2fdOlJAeeAbWi
	Wn9GHQxMyjW+gUDS0/88yMwErCWiIl03eryVMLeBLqouVTRM16d84rkPeuai0dlexeujaJmP5/f
	mCIu0HL+akUazHiFsEZJn/frsT0C+MWerhLxQarTmmbJjn0pKsL3+02eV2PDzseoRfb2WNA8lzU
	cM=
X-Received: by 2002:a17:903:3c6f:b0:2aa:e3ba:d045 with SMTP id d9443c01a7336-2ab398a9b31mr11937595ad.8.1770869433312;
        Wed, 11 Feb 2026 20:10:33 -0800 (PST)
Received: from localhost.localdomain ([60.254.0.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29966612sm52919805ad.59.2026.02.11.20.10.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Feb 2026 20:10:32 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	peff@peff.net,
	avarab@gmail.com,
	Amisha Chhajed <amishhhaaaa@gmail.com>
Subject: [PATCH 0/2] clean leftover calls to string_list_remove_duplicates
Date: Thu, 12 Feb 2026 09:40:15 +0530
Message-ID: <20260212041017.91370-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

replace calls to string_list_remove_duplicates with string_list_sort_u.

sorted behavior of &keys_uniq depends on the call to string_list_sort on
&keys before &keys is processed to form &keys_uniq, this introduces an
edge case where &keys_uniq will not be sorted as expected, follow [1]
to reproduce.
add string_list_sort_u to &keys_uniq to fix this edge case and ensure
future enhancements to the processing logic does not introduce regressions.

[1]
run command:
cat <<'EOF' >> Documentation/config/add.adoc
aa*.b::
aa.b::
EOF
from git/ and then make test, this sees one failure when the test compared
actual output with sort -u output.

Amisha Chhajed (2):
  sparse-checkout: use string_list_sort_u
  help: ensure &keys_uniq follows sort -u

 builtin/help.c            | 2 +-
 builtin/sparse-checkout.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.52.0

