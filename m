Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB72F84F
	for <git@vger.kernel.org>; Fri,  1 May 2026 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777632866; cv=none; b=LN6EIHD8c19L1c5iH2BX9amU2jVtiCCB3VABGSvO6EUCxYc8ZaWOYTbeDvxLoGqh+VTXwbqPIniMG9ofAWxwiuNA6/Fpo5vz0Qw0s6LSzidiLAnLQD6UGqZZhJ/ytxzCQNfhzcNlF4biA7eTaAtuS4TMrMi/4tmKfoGFC6/8RUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777632866; c=relaxed/simple;
	bh=bxBz7PJrZtsxEDkCrDiXJ1B5P0oWCO9AUKNTkegyfH8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BAo3U9kbQiSFhTG5BykF/pcSei6wr569mk7AxPFUi4oQ/i+sYFPV+Zqi8Eu/JmV9IA4mGBUAbHYobEpaIEgPlWrjCDLiOsvn9hCd8u3jVhk7L2PdIfvtRUY7JZMFNIXyExHgPfPrgKFyg/LREqIKq4wr2NGPe5UUrt5wI0LiwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=t/iN9scT; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="t/iN9scT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1777632852;
	bh=bxBz7PJrZtsxEDkCrDiXJ1B5P0oWCO9AUKNTkegyfH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t/iN9scT0ou+lxygVYMau9A0/VW+o37PrzOQYz2FQsv3A5QzOtG6pw7XNYs4c3y/R
	 oqnecZ4teZDdVroVH8CBbJencS8A/3d58igb57EjrmQW1S4RfL6TGvmidEKtaBnmW/
	 yoWbiyk+O8nMVrhSZVU+KWM4YhPsWPLcHyH04FL8=
Received: from DESKTOP-31CF0TC ([117.188.244.93])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D82B6251; Fri, 01 May 2026 18:54:02 +0800
X-QQ-mid: xmsmtpt1777632842trmsljdsm
Message-ID: <tencent_CCA549318D2A7DC6095954F2858371AB6D0A@qq.com>
X-QQ-XMAILINFO: M7W7QqjC7ykdfTVvjzsXQNxbsiMZAWAKVDH/vi73Tkng5SUfOh4LLNSspTo+X1
	 tHBskfo9lGUVytpXLipNsJJ7QEuZdiCqW+5br0GP+DsaK1BnavVkj9sB9Gl5tR3svkMRsA3JeZ4C
	 1c7C7eauCWIcVRw+wgRwySwlevhq9MezgoltysA21pb+tt+v/fjnYZctNfgZtk2hqMx3uh+XkdbL
	 qBwem7yQpVIpac6CWDqbEhzwnLIJvPmMgmFKAzUgkryA+hHAYqdz0HgIh4OJJ8NvPEwy3RAfe8Ss
	 bNfEbL62mWTlIjqV8yOMH17Fu5OTy/fvPFlDeKtIsOWJmMIj3dhw7jm78BGcC7LS2TD1VGqxUE8b
	 0FVJFxRMr9ZBrH7+t2e6maoNv+QbjUVjr37hTkC+9h//Q29NUihcDtXdRTo419IMOrn1mKTT6XZz
	 H4tuBPVjhQGNhSwyEf9HCq0vgBMFnf4aBfWFdKIXMNpRiAgZ5YVyikUn/IH6VhUZC57wIQ3BkriI
	 3KLPUoU900MDSwKSjgDExyBz3NQJ9cbuZZvuQcm6cC3fFAULNyL3UM7jWTNIfonORzfRWllwDOy9
	 PCfLGgRvKB6khsdqRIiEUCDgPDZhar9bOiaWrzlKH2Vb75rFde0TwFAoeIg4Jvn9ZeACTOGePyv3
	 qzwJECuQ33Q42VeTOM3okyXxJGVJE1wZZVK9jpoq2Q5ur8/F7gGMN4SiWH3sdNVUVA9ZtjaKHrVr
	 /VII5w/JVvCpsDINYJH4x0y9OP5cgov1vDAEMGme85YJEue5UJhwQyK9/t2VVIz9KVF0Kn1Db2+4
	 4vO6DPR8oBPlGMsZ/duoeCvUjo3aE7ExNX7+eKgNeRUyAIYyaUpvOIWGSs3bbGD9fA90MfT24KDE
	 d7BiSuvJsINC4BC07foDsVWmi8CJHfuzU3TXMSLSJ+qtNqNx95kuaBs3UZ6OuSF8UG2E7JW+DO4c
	 H1zFNX61nOVr++0g7Y/pQQtU9wL0MrbE+0QUqJA2y0VS8eEKx+yNDxSCNPjKC8Q1RYGOHGNWOmR7
	 KWK3U6SdTe7NtbpaA7
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: mlevedahl@gmail.com,
	git@vger.kernel.org
Cc: Shroom Moo <egg_mushroomcow@foxmail.com>,
	j6t@kdbg.org
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
Date: Fri,  1 May 2026 18:22:31 +0800
X-OQ-MSGID: <20260501102237.163-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mark,=0D
=0D
Thanks for catching the multi=E2=80=91worktree ambiguity. The parent=E2=80=
=91directory=0D
fallback can surely accidentally pick the wrong worktree. As a =0D
reminder, the current code deliberately supports starting git-gui from =0D
within a regular repository's .git directory.=0D
=0D
The comment says:=0D
# beware that from the .git dir this sets _gitdir to .=0D
# and _prefix to the empty string=0D
=0D
In that case, _gitdir is ".", _prefix is empty, and the later logic=0D
falls back to using [file dirname $_gitdir] as the worktree. A blanket=0D
"if --is-inside-git-dir then exit" would make that case useless.=0D
=0D
I'll send a v4 that first checks --is-bare-repository (preserving the=0D
original bare=E2=80=91repo error), then checks --is-inside-git-dir and refu=
ses=0D
if inside a gitdir. This accepts the .git=E2=80=91startup limitation in=0D
exchange for safety, and keeps the bare=E2=80=91repo message unchanged.=0D
=0D
Two alternatives still exist if a different trade=E2=80=91off is preferred:=
 =0D
- Only check --is-inside-git-dir (simpler, but makes the=0D
bare=E2=80=91repo error_popup useless).=0D
- After --is-inside-git-dir, consult git worktree list and=0D
switch to the single worktree if unambiguous (keeps .git=E2=80=91startup=0D
but adds complexity and a runtime dependency).=0D
=0D
Shroom=

