Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182536606A
	for <git@vger.kernel.org>; Mon, 11 May 2026 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502119; cv=none; b=AtBN22Kwywlk0l9hmOwReq1HkgVBlDwLdQKAehWtWg5ww8ET+sdX0d4pCKTuxB7k2FBtfqKOV64mAjFLLjawWWuJWKAcEs7zgpTCMD8q0clr412Sw3/WfyAKPCIdnWM0XeAw0hPUaPT/3tIxVcMqNkocj8+ZDuG0P82dQS8uf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502119; c=relaxed/simple;
	bh=W1QYEhypYU4tLWP8vVhaVyChVpDKFWzp0NG34bySy8Y=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PTwt57kv1IqdNvfnfnak90v81Ao+seBFfYQvX27LS1NF4cniuGbNbBrep4yld+37OMlrzFZ1z5o66NoMnbqfSKh8unbnnB9TgunEq+E6D6cORs81sDAdjviRHn5xTDH/8xgl3fAjqNgvZtuFdm0f/Jl9CrRnef49viIJKqx6Ip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmGpndSf; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmGpndSf"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d7e7f48499so455671485a.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778502116; x=1779106916; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=37TxKI4VSd4TLAPEogWbqgngA08Pu2wYa7FG+uONfuU=;
        b=QmGpndSfOXRZ9xsPlZA3cQ4Dk5qwcW4J5I7YqyyZ1PLrK3NMcM3x1zyUY3tVpnRxbH
         ic4/fU29h70m519xty6i40vPiE8obSrmSVDVq0LtblFQWxOMrraZSeJ3q8UsOm6/bpgY
         srBn7nfQ6s4wfHnqSPTBLDEzQbmIJApenPHDDEd2cR+dpre9Iv8AfMIGP3QZsbdtU5wa
         a1fdXr5U5/af4vDav9XIDvGRoQIf8v8ikZsUyzX6IJn45W1GdHWvpz4UqYGOBi3fIdC4
         pncbAlwydS9/OL4or3CoX5UaONhJdU6Aenon3e/r7SOQqaWD4K8SVy832ddAYtoNse3Q
         Yacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778502116; x=1779106916;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37TxKI4VSd4TLAPEogWbqgngA08Pu2wYa7FG+uONfuU=;
        b=NEuU2we0/xC3SzQr0/kWAwMSnziLjutDPElJICjI945J7K3qS0Byvx7eTlNY8yis/f
         /uIty59uf8yOnUHXnpvGD5qv2d2YutTlD87DDjG84x7tJWX7mOYAQsSDBJFs6ZL8ha/f
         EtPmZC4y62s/t184dnFojsSqjVUSF2tKqdMTAUmf6myRit4QJR0BdBVdTt2uc3i5FC8y
         z5403z+ihU6jYYakMZdec9M0lWyFk2xugL9GBsTUkP1biJiq/w23NvB1d0DXNEX+msBw
         0o9eOOgVtCZrm6UUmSPhj/lRa/E1jJ+//ASYHc1G2Ei4A/iGnPzdYUybdHfFIKDGzjj9
         Kgjw==
X-Gm-Message-State: AOJu0YxuteUAspY67tGk6rMXG5HWZd/mfcXChKZREEY84qcwNTSHJLaW
	R5r69WO2bRT+iHzIIBhAMZJZcljDgd4id+w1iPZP5Ft3qF8IwNXwiiOmDUskIA==
X-Gm-Gg: Acq92OEdw7NCrceZBhaOP1RgIcbGVu6YJC6G55EsDadHAWLsPo5Scl93u2P3cb+0rWM
	53kiHpOygKBziMkr/Ifr7N9FerM5t+q4ggSQVAtQhFPJXEWP8zK/Y+fGQGn/PszbhwrjTthr8Zv
	DtveRPhA5Oc30Awuo1J6N/mSvGugHjCfwo5/R55qJssgqqJ/zp3rrUjZc7M7J3HRgaBy0obT1Ql
	QMRkZQEJHmUGM9i6b2kBMkKv4PFDQshh43OZaBh4JM6H8ziad/f22kjx+opTRVYp9VXpi+s4CYt
	NowQK6tffAkLy8P5Jyat0gyTfwgZxjifus3yxXC3F9t9/ShXUTrP5sl5fQrxiW+z35VopiOL6Yt
	ZlXLs8lOvM80drmA07vBpb6lVRSXeWDGDyEqa8ZebBSuTJf35qSgVMxtTWqoGxcVbN8E2qOzEO/
	+ijbdRMUKzJVK/zb2H0yNswSWWMZ3Vn4x93LaKNQ==
X-Received: by 2002:a05:622a:110c:b0:50d:a8f5:d519 with SMTP id d75a77b69052e-51461c25bf1mr353086461cf.14.1778502115558;
        Mon, 11 May 2026 05:21:55 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.153.154])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7c0289sm95511491cf.18.2026.05.11.05.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:21:54 -0700 (PDT)
Message-Id: <pull.2111.git.1778502113485.gitgitgadget@gmail.com>
From: "Abhinav Gupta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 12:21:53 +0000
Subject: [PATCH] sequencer: remove todo_add_branch_context.commit
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
Cc: Abhinav Gupta <mail@abhinavg.net>,
    Abhinav Gupta <mail@abhinavg.net>

From: Abhinav Gupta <mail@abhinavg.net>

The 'commit' field in 'struct todo_add_branch_context' is unused.
It's written to, but never read from.
add_decorations_to_list() gets the commit passed to it explicitly
as an argument.

Signed-off-by: Abhinav Gupta <mail@abhinavg.net>
---
    sequencer: remove todo_add_branch_context.commit

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2111%2Fabhinav%2Fsequencer-todoctx-rm-commit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2111/abhinav/sequencer-todoctx-rm-commit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2111

 sequencer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..19839da1e6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6409,7 +6409,6 @@ struct todo_add_branch_context {
 	size_t items_nr;
 	size_t items_alloc;
 	struct strbuf *buf;
-	struct commit *commit;
 	struct string_list refs_to_oids;
 };
 
@@ -6498,7 +6497,6 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 		ctx.items[ctx.items_nr++] = todo_list->items[i++];
 
 		if (item->commit) {
-			ctx.commit = item->commit;
 			add_decorations_to_list(item->commit, &ctx);
 		}
 	}

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
