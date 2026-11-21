Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795279744;
	b=XL3QDpm0N4+K7ueFVAQSpUT1Co67LhNNmjvtesf/y4nfIKlvbaLUSTn84g7Wz1btXXTt
	 G2oIP9dGKnpDClxMr9CRH9HUoCd03Mt0IF/ysyB4nQ2mzhAQmxzdIUEVtLqhPDryMURQU
	 fj1WmyTtP3Sq9QRStlRg+YLN2/YspJjpqz8TwP2FVB5SUZ+jzloHTVh6HA/qnHlfDPpv1
	 CaQ4uG4zWYGYwuv9RexBXljrRsoxBLKzgnoeE/4/6XC+hnG1SUBXLg/As49Zc4tFN/add
	 jy2IHMsxD5SvBFvfTLmxgFtrTiGtcDKtH8A+dKG8SUIi+9vh85LVvpGElKBHjDmlKVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=eQLrooIuvFD6mE4Xy3E+XMDRGU8ca5b2/4E6lkuqD9U=;
	b=fnUuJPwAqrHGBv2i/yvAtq+kn1PCPlC+yNaJShlouS4iuaNEx1OwIh1C2UUAE27PcoI/
	 PvjarWDt8P8ONUsBprisxZwVnv5nS7u/Kv9H79jO51Qky39tusCNakiqJq3auZA2/y65w
	 5ub8bDMeHP3UcoP/RqU0jw+GY1v5zGP5uQc+za5sWuUo2F8qsJe0ZuSXQd5Wy+QWd1wFm
	 xeD8v8xZZCaw1UjecfQx13MwDr8z3jiTu8QgqxrOwptnAxC6a1DondfNISckG/6ylwZAB
	 tEeZVfgHscY7iUys9oWc6AMEiFKjNjAvTXhWfbE+0bZ8fpCXwC+HGjb6w7vP4mOE+hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4eQGRyC;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11058606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 16:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11058606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4eQGRyC
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-943e8d35f74so201710185a.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 08:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795279743; x=1795884543; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eQLrooIuvFD6mE4Xy3E+XMDRGU8ca5b2/4E6lkuqD9U=;
        b=C4eQGRyCdhi/Y+ZiNHBWfEm+z4eBlybROVJ6UflppnBCxMlZdJQNaMN3BewOQc3GDi
         dgrlfNWMs6OWT/89LvDzyHmlhtYv1qBLCYRaPo1AGQrmiZaaArBG5gYw5TkWSWgJGp7Y
         UsF+k+o9cihzTUi9+2x5vOjiF7OEaEK5+BOyO6JlbOhxsCg2/Fe3eLzCq3lFi5YsfR8h
         yPv9EsNGxZGfWjABXiprgQ/WET5cfJiF3XQo0j0CjTWoBDYTegAnzx/fz3tnMurLJ3Yu
         lm0xp4d65NDrhU8NjsWFpRpZPWICY5AEkGcC8Z9gdgtKrs/Tpu4i72ALJFm0Ysn/Nwlh
         qglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795279743; x=1795884543;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eQLrooIuvFD6mE4Xy3E+XMDRGU8ca5b2/4E6lkuqD9U=;
        b=Jy2VUUYAbcJ5MxjYQnYNSWkc3eH52igkWPEO7SzravTcfwo57jZr8F9/pT5+tCnrpr
         qqPV4uEoeU0xjJmXJc/+caZeqxGNEmAF2hXjjdBxwqHHlyTNGwen/C7BdGURsOHzRBIf
         f7HPVSTjLsB3RcjsAEeNM5qcsXft9LMshZGMglS4Nr+6USQani8wZvplXuL0UjbnNuBP
         YBmpA/6G2VNG1iy4QPrGjbkNE2kUzg9UI+c4XA0OV8nbU7ANl6pgOInP97Q/AvfE8kKB
         Dut8VSuw1XW8c5zj0+V8m39ftaNMtKoiTCFxQ/UtONyOwm0eXt61cgKjiR3agttkBlbt
         lPjA==
X-Gm-Message-State: APuU4Z/DismMIyy3BkeNKBrZ8z0gx12vuFvu0RwEYaHHYo5Yno377QT9
	wl3LN2wa4uDRi27v9aSOOtC1ONuuW2QC42Cw4YxaPPZhsCAHel6yYQjZlpReHA==
X-Gm-Gg: AZFdTZdoziTW795fyHA0KdkqeHdoyCS2z9pTSTfHtLzDvqITOJgt2tyaJhtf+il947d
	6kp4qSS//b4QCfdvqQNcd6L/QyYTgMNRd7cE4MiaHRCcI0f9J/lbeRrzkPp++wjIZNi50VpvJvk
	L+Y0/ogG/061j6453HMSDGflDbbMi6lTj/0jGgu6oZTf1ciKnuSWKf7YTGDCGYIaL78P3pfRVt8
	rvntxuaZKGhg1DSWlmsC7Wprm4Lh8993qBsoYwpxkY0jbqN5/xK8rwyvBDRMW5JGNyqBfU2dFxN
	gF/1yDIC4X6dJpcbfOXKLo29hMNtFmRA4NjSGn04hQZ5R7a6bixogadlr/qfJ+IE21fO55tuLEE
	N3Qmy5r+jDjBV0XbbvcnZHy2F53lDrZfKEod2TGVtGe/1HTNAZbjkASZzETAdbeb4rdgSfMFZRF
	bRs6wJN9I5JgLlaA9vc/pAwDdo1oim5uuNlaZ44zom1/7rwhbUfqP0idt1tvfxYxgvEpWGEcZMQ
	1VJZTZAF+v9cwvcVWUdCs/XKd5vvWZ8/VHYY/HTGWL4fan3skH5hjBnWlnq0ZHyQcoS23VfVyYs
	5ZPf1GYlSSszOC9auZsPXC+FGmuhyIDCHpTNm3YtMo4hnALodeP0rlmphj9N5DTJfMVl/sITFUs
	Y1pUz
X-Received: by 2002:a05:620a:19a5:b0:93c:8881:8df3 with SMTP id af79cd13be357-949ba9cbe9amr1075185585a.46.1795279742705;
        Sat, 21 Nov 2026 08:49:02 -0800 (PST)
Received: from [127.0.0.1] (ec2-54-211-170-155.compute-1.amazonaws.com. [54.211.170.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949caf98d34sm239576485a.2.2026.11.21.08.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 08:49:02 -0800 (PST)
Message-Id: <pull.2500.git.git.1795279741855.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 16:49:01 +0000
Subject: [PATCH] setup: fix grammar in code comment
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

Fix a grammar problem in line 271 of setup.c:

will only complain about an inexisting file.

Change it to 'non-existing'.

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    setup: fix grammar in code comment

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2500%2FOphirBleicher%2Fsetup-code-typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2500/OphirBleicher/setup-code-typo-v1
Pull-Request: https://github.com/git/git/pull/2500

 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index cedc031c54..140f1926c4 100644
--- a/setup.c
+++ b/setup.c
@@ -268,7 +268,7 @@ static int looks_like_pathspec(const char *arg)
  * diagnosis when dying upon finding that "name" is not a pathname.
  * If set to 1, the diagnosis will try to diagnose "name" as an
  * invalid object name (e.g. HEAD:foo). If set to 0, the diagnosis
- * will only complain about an inexisting file.
+ * will only complain about a non-existing file.
  *
  * This function is typically called to check that a "file or rev"
  * argument is unambiguous. In this case, the caller will want

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
