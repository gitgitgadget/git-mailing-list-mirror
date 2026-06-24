Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344630AAA9
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274769; cv=none; b=AXuUgMeohwilT5rTsKx6qFRmLcT4AJ7LOws3p+uBzmxc+XNVOx+nDhYznTfBJXaMyEAutuyIOvuEPlP1FsGH0GBcdO9opOyxEA6/7qbCrHgxOLHcHb8coOmQzSFzR6Ku3dWWqGK4rxq6dYn0/HYACPTsi/Lk7hco659PT6fUSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274769; c=relaxed/simple;
	bh=I6XopYmLmUzpku/7Mr92iGB+4UQux3NeP6VRTQmvz/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtCzzh6PpZJpeBLrIqjdqbEvyVUxN5raoCkQFrUORhbnollgKw44X9UyB2m3v/SeWx5oUFTGWmheHDeR5qMpf+fqkl7gaeleDouzRoXMwTKhDCyyfqxDx7PpD+yfXj9aeSHTnEUDPvlrXX71wuQMHxg8lT3ufHYpl0724VXBp00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0K6rUQp; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0K6rUQp"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-48670d35a87so973503b6e.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 21:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782274767; x=1782879567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+PbvnrxxVDSG2ikWKY5oqa6V7I8pld0ZVc/wLwOLgag=;
        b=c0K6rUQp8IF7Ka6IuV9ljJiJDT+oIFW6yK/3/Xb8aAYyMEtf4K5GaKPIelNe1Aiy6w
         R/1RI/tqW6rF6SP90jSe+wXX7fMaM6PgBydqltl69aehws1OkDf2YwQzi7W3YhS7WiRp
         5vWfXL9d1JHsnJww7WDCaZi6fdmXjsmX3sQNB0FzccXsJpkewIrg2WRRaRedIXQWjoCw
         N3gKQ5l0DN/0+YoR9klfbLSkefL1DZDfmvpfpr0uHZFcqPYUNa+HzGT7iZPIpCNeis/o
         0GAPXMXsokiG4+65rU7HsKw4KYfx+FsZGlsjKkHLVFCbqjU6Qyr08GWFoeXKZWcS4Iko
         eC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782274767; x=1782879567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PbvnrxxVDSG2ikWKY5oqa6V7I8pld0ZVc/wLwOLgag=;
        b=d76HAFtAjRqos7E1AZx6Jc4emEiEzU8UHrIBAUX/ap0VO1qxTyi645gn/F4zkJyCn8
         F1Mml1vE8o11EIbVIissGs1ykwKYsm2XCM12Pyinilp7f1WSd/UWxf6n8iyi3dEGsysJ
         GPu22ibKWTxBB5WiegvwCMDBVwWDHSDcqztyDIQbP+BJq/jnMrH9HG5MjVVFpU8nTbjg
         oQ9mrzjdcu4i5CDuHIettIRVRhGCIIBYccYc4yj/q75mAud/1UPtcf/qInx5kB3q+OT5
         Ee1W7WZsKzAAYBFMA+d3bnLCWLmygMbA1tM2S10RrI59n2PLxKdgnpISLQ82pZT1XajM
         zjPg==
X-Gm-Message-State: AOJu0Yy2bMdLSKM75J2GQ87aZPTQZkmmq/U1idv99z7ARhYYx+n1+yac
	Ns6d7q58TxuVNYnwyR7daCSW1+HObFG+8KrSSEPBXnXzzuCP7AtBseXzNYLTfg==
X-Gm-Gg: AfdE7cmPELylQvjKd2NIkznp574dSOk6Bnn+pxjqpq6Z2e2kEOwDlhzgYARxsv3k0JV
	2D8HyDo0uEcSNGnlOFdS+LDbZAfEPS3GGJRTR+jaEcB3nWgODORT809gXH/kGvRy/3NxdgJb4+L
	Dbk2HfTSItwzYIJFBw8cxz31hkFu9DENA419aiwG8D6t+B0bcaCaBKRsAp3DEhIAVBhdboXzRuc
	tk8rIaHfRGzoQfmSTR0BI3y/YOd8SVcUB5aIjM/2/5FCtCPN2utgS1uahxBQ1juBfIsgyxCVerp
	V01y6JqrjSqeGodE9CvYWbO/A9qONfiyOB3Bezr5w6BIs8peSa14MdhKbiyo3DL/aFQWMoNHUPn
	T/wZDd/ZQQEPPuNOKwiWNlIXkOUvFCPcm2j98DqwfKVSlLEx55PzeGAQVtXe5wcBDJO7E5z86HD
	8OLH71ijmfPEvGriQbhwbB
X-Received: by 2002:a05:6808:1b09:b0:486:cab8:cb7e with SMTP id 5614622812f47-48ee27579b2mr3646322b6e.1.1782274766997;
        Tue, 23 Jun 2026 21:19:26 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf21f5fsm8111799b6e.12.2026.06.23.21.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 21:19:26 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/6] receive-pack: use ODB transactions to stage object writes
Date: Tue, 23 Jun 2026 23:19:14 -0500
Message-ID: <20260624041920.2601961-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This patch series replaces direct usage of the `tmp_objdir` interfaces
in git-receive-pack(1) to instead use the `odb_transaction` interfaces
to create/manage a staging area to write objects to. The purpose of this
change is to get git-receive-pack(1) one step closer to being ODB
backend agnostic. For now, the object writes themselves are still
"files" backend specific due to being handled by the git-index-pack(1)
and git-unpack-objects(1) child processes. This will be tackled in a
separate series though.

Thanks,
-Justin

Justin Tobler (6):
  object-file: rename files transaction prepare function
  object-file: propagate files transaction errors
  odb/transaction: propagate begin errors
  odb/transaction: propagate commit errors
  odb/transaction: add transaction env interface
  builtin/receive-pack: stage incoming objects via ODB transactions

 builtin/add.c            |  2 +-
 builtin/receive-pack.c   | 46 ++++++++++--------------
 builtin/unpack-objects.c |  2 +-
 builtin/update-index.c   |  2 +-
 cache-tree.c             |  2 +-
 object-file.c            | 77 +++++++++++++++++++++++++++++++---------
 object-file.h            |  7 ++--
 odb/source-files.c       |  9 ++---
 odb/source-inmemory.c    |  3 +-
 odb/source-loose.c       |  3 +-
 odb/source.h             |  9 +++--
 odb/transaction.c        | 38 +++++++++++++++-----
 odb/transaction.h        | 49 +++++++++++++++++++++----
 read-cache.c             |  2 +-
 14 files changed, 173 insertions(+), 78 deletions(-)


base-commit: ab776a62a78576513ee121424adb19597fbb7613
-- 
2.54.0.105.g59ff4886a5

