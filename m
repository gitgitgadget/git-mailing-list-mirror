Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177401;
	b=LFScgoNv0rCHvTM2i/Tkl4beYSwFQA4Z4qWf5KHLjWjyfH2ndGucKOOnkbJgnkhRjN3I
	 F8MsCbwvi7Achb2vqtzLu/he431WfCn8GLKqlQvshRrOvSh6TkzpS5nFzTyhvyVL2ww/v
	 Nw9bzQN2RxugiYEt9xCYVg+6Xe1lX0EhaeTvt8c14yo2P3XoR2rseMkFfD9IFCusK0DG5
	 2HnOxRI8RvQRt+vESNEUzkqCf39vNsl//mZp7yw1POehKQLQw1VxenooTr8B50EPy+2HA
	 vYYafIAxhcJBlzPlcQfstJzTV5qOyQWPImqarmDRC7jUXgezaJqSxYcN0WrywFaAUqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=6ZbFU8V3zYbHIHH2GlqlDkOC08ByY1i/ganwnrDS1ZU=;
	b=vBS68h10xvJrVim3F+MBqk9v3y/yVWDNvQL7PgvZdqnYrC+/Snpc/QqXdZqUW1L5tarr
	 LxakCj9SDilkVJ+yAteX0B4YcEsWmyPwgSydEOdtU07bVoQioanXLo9MVeNI1cLot+2Kc
	 QWGIbgWYsxcyRlDoNDh21fgbS2zT1YEpYmrC5vQHI7eZGm+VSPvPXVmBPmKq7jr6lsNyC
	 kX7HC02RHkx5+7MPmsye20mUQreptvzUYLuJ5vOe39U+Zb+DpTjB98bBXGHvaXWabsuBS
	 OQjwzN/hA23j3BCjCp3nb/zaqyQjLmPZsukwi/b1B2HGZ2EgdMVKYDCmWmukNqRGLfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gYpeAkls;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8CA606A32A
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E8CA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gYpeAkls
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f048476ab9so3428875ad.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 04:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795177400; x=1795782200; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6ZbFU8V3zYbHIHH2GlqlDkOC08ByY1i/ganwnrDS1ZU=;
        b=gYpeAklsUW2NSADkWQBVAik2enBtIHvBClpMh3cKL93YTYP/FsC3XGKbKY4byqyWE2
         6FScp2GhbyWneFPSzx3s9dIdDH/3S+c7Alwbu+ZG6yKZ4HW7/e1rM0zucrX8I8R+wdfk
         SNheSEhnC+UvUgB7S/JjMkUX6Na12nzxOIA1ZeE0fQuDhHBH3EMC8uVskTf2xHp5/FER
         eEgkjHe40A3oAtu5kQeYfRVhtRB5IsqSRTb1DXV0y8R3eaCndX9SSKF+wLsx2/6Jif9e
         uR6KtH+sxFdzGbWOvIAKaXo6hMAflv4QrbO5Ycej7n8cJey+7geJLIAm6VdJPqyGPhhN
         NFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795177400; x=1795782200;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ZbFU8V3zYbHIHH2GlqlDkOC08ByY1i/ganwnrDS1ZU=;
        b=dc8DJNb9QvA5wHdaLi1XIM1JRlhiS/PbEWfSuSL2M4RdNwigbQ5fr30hBVK7F61p98
         spZlx3VJDh5n3wAUVsuz1JxUzBl6NlrtkKoEcnTITvMOxAiXh6JxIuPN7wAdPLmw2xQK
         IbS+jidLgFxkriGqUykaKMPs1JqVZOFW9FxcYS39/O7cWA5qw80Iv4TAfFSS/r/h9UeG
         Zr2D6YkMZeyJgrS33dAyIFy/9JXbi3o2nXbUTogSCvREzSpE/Zc85j5O7FUeaDq6sTgk
         m6yMzPk7w19WVKuzvww85uP/IXQ3EZ5qEcSQ7l/xWWgRv2+GTe6VqHKwE+W23krxGons
         sZiQ==
X-Gm-Message-State: APuU4Z8sAOjhopa24oY0bG4+YZENwx87NiP14oioAieChZ9bcgMm61Z0
	liGoNxa9DTZ9vZDbkEekOwlTj2wbNbpovPF/nYsLCnCbrbNEAVzlC1aPQtHOtWD8
X-Gm-Gg: AZFdTZdm+rEcDKHG6kA0iXMGwq2y0qjuF6n3jZqgOlj0O8tTl8egl+76FKlb5SU2N+I
	5KzPUj9bqtyQtwslNnTiYJsc7GtGVmj5fcKq0mUsXfgohXWd/1TU2+Lkn0ZUuETqfQmVhGjumbO
	hd9e2jiXNF3IKhxf+XmbbqkSaD2aa1sEtL1Et/n1dEAQYTilos0cFou7HpwJak9vHgfXISitKPJ
	xoPOiOcEzftMp4gpEnyyGB867VKxxQyiGmPazpN+5pcRjEMgZezkXWMOJ0A2EF0ryQbvkNAhxsZ
	hJPznrnwgtqUxHPUa5xUosvWjEFrh2+7fFYJ3WjPlQRPfj11lc2IQXK4OJGqF8MlCL3ypczFW5T
	NPTZtUzVGtkuZCAS5Uy4ui2rjkr4rBJi5IwJLBj9Qvaqk8Wl0CcKoe++WM+XfGQE1NPp1K3LYRp
	+/6d/ehfSwCz385/T0S2aXs05JPjK2cHrHPmdZR+Wbz06qeuBr7kAZ3dpKwRc3b1JploOT7+8Tx
	f9fGCAUbriQOZyRsTft5HPaserfDsasU8QzCiI4j2PJoeD/4gSY3xjfcDrekQjSNtnbwCWJ2xEa
	udHIgOk9TlCfLyY26AoSQyzhbMR6xWSz6lN3wnzDwiigvqeKQvJ1gQ==
X-Received: by 2002:a17:902:f603:b0:2e9:8505:5471 with SMTP id d9443c01a7336-2f03ef44affmr33532345ad.7.1795177400228;
        Fri, 20 Nov 2026 04:23:20 -0800 (PST)
Received: from [127.0.0.1] ([40.75.162.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0433a3a43sm9741965ad.62.2026.11.20.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:23:19 -0800 (PST)
Message-Id: <pull.2493.git.git.1795177398801.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 12:23:18 +0000
Subject: [PATCH] doc: correct typo in 2.46.0.adoc
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

Fixed typo in the 'git describe --dirty --broken' section of the
release notes (chang -> change).

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    doc: correct typo in 2.46.0.adoc

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2493%2FOphirBleicher%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2493/OphirBleicher/patch-1-v1
Pull-Request: https://github.com/git/git/pull/2493

 Documentation/RelNotes/2.46.0.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.46.0.adoc b/Documentation/RelNotes/2.46.0.adoc
index c06a04a91b..2d7b7a0bc5 100644
--- a/Documentation/RelNotes/2.46.0.adoc
+++ b/Documentation/RelNotes/2.46.0.adoc
@@ -406,7 +406,7 @@ Fixes since v2.45
    (merge 4b837f821e rs/simplify-submodule-helper-super-prefix-invocation later to maint).
 
  * "git describe --dirty --broken" forgot to refresh the index before
-   seeing if there is any chang, ("git describe --dirty" correctly did
+   seeing if there is any change, ("git describe --dirty" correctly did
    so), which has been corrected.
    (merge b8ae42e292 as/describe-broken-refresh-index-fix later to maint).
 

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
