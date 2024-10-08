Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1306F2F3
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358709; cv=none; b=G6eyRhbnAkYnIq226rvZHnDmfnRV3LaGhGywHMRhbnEfeJGzMxnVWPFXmhsvzv/1RwSejr2PVGJuNi6nEjNPXdCPvsMJLB/iBBFJ4LohH13hFZxVMNf6oQ9KrWg78isUCSX6UjGWNFBG19zjTs/OZvCBtAJbjdBsGM72XArTSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358709; c=relaxed/simple;
	bh=ZNrV0asGkxNjjvfCARN0KkMZqwSFdzKekMLIDJm1Pmo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z5BDO/q0kHS+DsPywlY7lX8/o3SkLEeGS674JDMkgbyHQhUMW3rJOeOlXl4eD8yM7CcfJKmR1mafxBBxPmykhqfxKXPIuJ4f7Fw5kBkVj1QDQPbXO/7MmHqgvh+15pcOobkeDUzYNZrbnsFoPv2xuShVcMLXtuHishgCYvo8L5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNCl8lzl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNCl8lzl"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9950d27234so260524966b.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 20:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728358705; x=1728963505; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX3vzHs7fir54mNp/yxy4vKBlC4u7BMkh5W2Qxv5Qnw=;
        b=mNCl8lzlmY4Wmc54gLPrPclsLqMksma5GjN7hTW+T54nEOfGtk/+4GAG+QXLVw+esO
         i3b1EGABtBSWjdpnrhl34T1nhnmj1UoUh0UrkBJYIMZzdDjRd0RTT7nJ2n+381OPVD3k
         f1LrgsNxywPE64lZrX8DHdD8xkjLZOtURmoswFdCofdjCKvzESMGaY5zg1VI8GtwNYvl
         jxl7kWaMTKiVfqVMFqp6KsBrQfqHQH/1iEPZOQF9mvBBWFQacZOD9AxRaege+0ac/V6a
         M15XgDT6HL4vhTS5vk/8NXPzLlW3pSn0RSOmoNph0jW7M3TSH8G90pPeShuZHUNITpwn
         qplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728358705; x=1728963505;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX3vzHs7fir54mNp/yxy4vKBlC4u7BMkh5W2Qxv5Qnw=;
        b=SIbXMc2y4eY7mzdYqPq0W3M0q10eeeiLOjx6mjCZRl5b4JDd+GMCH9xBsMFprV3ZBx
         sAirCQvKMskwcxFB6Qjyk3HOZMSrd4a89XHfpUXMSEeE6/rcd58RxzFm0C2KKgngEnxP
         Iit0PI5LxsjOuyLEkM5qxhMT/mqbRkRHH8syove36JvO8ghJkw6GcN0IJJcIc2bqWL+6
         LAHmjBHEQF34S1Ip+YlDes9243D/nJdh28pyyn7DC8/7lPM2+ULYT8kXWj1MgcZl0jsL
         HRRn0gWkaEQjSqq8R7CS6Qa8CwIZBAA7uUhVUaZB2CBbmvQiC+RRJCzw63Tvz8eDCmcc
         Ybhg==
X-Gm-Message-State: AOJu0YwAyoFhS/7wq/8LSpXMhaJzYMjz+2Fe83YtgPqjPIi8IFrzD5hd
	g1mJVnNMGWXM8KmwG/ONcsZomAIUs0Rn2Bu90CZ5KCznDGOcUlKgo/cWNA==
X-Google-Smtp-Source: AGHT+IFh+KmtmL6rbJYns/pcRvF7kged+o9KJ4zM95Gvp8VR3USXQI1SUavYWGfQhBAAsHHL2WeYFQ==
X-Received: by 2002:a17:906:f5a6:b0:a99:3eb1:a37f with SMTP id a640c23a62f3a-a993eb1a766mr933947466b.58.1728358705102;
        Mon, 07 Oct 2024 20:38:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9936bc91f4sm420551166b.56.2024.10.07.20.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:38:24 -0700 (PDT)
Message-Id: <2528d929c7e37f592a12967e6a2d86b57dc38293.1728358699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
References: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
	<pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 03:38:19 +0000
Subject: [PATCH v3 5/5] ls-remote: leakfix for not clearing server_options
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
Cc: Brandon Williams <bmwill@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Liu Zhongbo <liuzhongbo.6666@bytedance.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Ensure `server_options` is properly cleared using `string_list_clear()`
in `builtin/ls-remote.c:cmd_ls_remote`.

Although we cannot yet enable `TEST_PASSES_SANITIZE_LEAK=true` for
`t/t5702-protocol-v2.sh` due to other existing leaks, this fix ensures
that "git-ls-remote" related server options tests pass the sanitize leak
check:

  ...
  ok 12 - server-options are sent when using ls-remote
  ok 13 - server-options from configuration are used by ls-remote
  ...

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 builtin/ls-remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index f723b3bf3bb..423318f87ec 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -173,5 +173,6 @@ int cmd_ls_remote(int argc,
 	transport_ls_refs_options_release(&transport_options);
 
 	strvec_clear(&pattern);
+	string_list_clear(&server_options, 0);
 	return status;
 }
-- 
gitgitgadget
