Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EACC2C9A
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459134; cv=none; b=TEeicP3nWicLxhetpFDE99fP6lhBCeBo1FXROxFkA2peqJStNrRGLVRy0by3cxSfQvXz5+V/s2rDjGxkXEFgkCW81BYFbmTA+4vldWQM+AQ9n0jHeZ6106DHvFZD1fYYmUvpDJvfnh/vz0e80n3+P4oJoEBQ5Xr1QNyqJ7gGvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459134; c=relaxed/simple;
	bh=bW87DANajomW1S6m8mvTVZNlVC6Xj+e6UlGy/thcbF8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=YCW3VTZCWhJNaOtPWsype1cSkW4DyO/8f0sFn7mzkDA9PRq0ZQ9K5AmPXjnMWOLqAN3kz/VvVmOItNawAu58+kyFOugg+6UJYvrWfzkhd7kCMxEi9sXLRBgabhEcHI4r9VW48SmjZj3a83f39k6yjb8cyxVmXNFM9tH5yp66b4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeFLon2l; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeFLon2l"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so79232575e9.2
        for <git@vger.kernel.org>; Tue, 12 Nov 2024 16:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731459130; x=1732063930; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3sboP08i9Ek0LJngzDbD2pRL5nwVzB3UN3cplUWhpuU=;
        b=VeFLon2l2UeX9m94ILtJtVg23DiPYzJc/52IRI9PGPIv2JAZM7Ggw6eMt0zOZwfUYR
         sWk6RB/rZ2eB9gvBajtv2JWNb5i6KlsMbRecvFlu87rMzGrjSDtyMN3WHHBdWJqXWPCx
         Ho8wUxh9O/YP09P1aaLE/7PGykDFo/cb+UwrbLeq3P5ZbR2jevnHTGkNASL8EHlR/iUL
         NUvFLvU+fIFj2mOoHWvLxU+KruXFayJEs0kjrqy4fHG/SIK7QhP5cXn7anxukW4cep5A
         s6o+bSE7FoekoawZn8zL51WP8sr8OU2t3ACZzPXCuhXAP6Ah/z0wKqjQwaQIrHlY8bkD
         Fe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459130; x=1732063930;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sboP08i9Ek0LJngzDbD2pRL5nwVzB3UN3cplUWhpuU=;
        b=lng7wjLBPRWiChpwbIdCZ9O1PIHFLwHBmpel+b3Dvas9ijUJysVUUMtt0zh97QCqwm
         mBTORpBshrpWLseA9HG3VljnHIUTYM14txTaSuTEK1u+wwBYIvZSxkiYzNe7pHrQX2Mp
         tC44ZvnGUlTS2jFBGy5+hHywUceKAYS11m/WOjh6UUEw2KJ6WWylr3zauymH/UtcOnLh
         QgbRQW+fp/oQygEb8ik+8fKS+O57XhWm2SahJQhhUaVbPHDVydwfFDvEiggLLllnXuCu
         42OeKMIb5sLyk8f500RtEqFCY8D2qGYLq05DEHYjlBisjpEoRtCtuTACIGSgNty9CC+D
         nbRQ==
X-Gm-Message-State: AOJu0YyK5uNT9u8yA0C6Ef/Qvnh87Gwj8ajgaMX6+iSMzflYDCehDjTc
	xgG/yBOteTgfeu7QokIPU+ff8/xosbnGbmXdZN0V6PXLqAj7X0pavMKk2A==
X-Google-Smtp-Source: AGHT+IElR6rM3BjvwFb3w2mdMiaUrMMgqDAeN7Q62qxcKKIRtCnyRux/+S7SV9RxvSsXizis+TkaLg==
X-Received: by 2002:a05:600c:510c:b0:431:562a:54be with SMTP id 5b1f17b1804b1-432b7503f4emr204378745e9.9.1731459129820;
        Tue, 12 Nov 2024 16:52:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54fa047sm4724365e9.17.2024.11.12.16.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:52:09 -0800 (PST)
Message-Id: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Nov 2024 00:52:03 +0000
Subject: [PATCH 0/5] git-mergetool: improve error code paths and messages
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
Cc: Seth House <seth@eseth.com>,
    David Aguilar <davvid@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Philippe Blain <levraiphilippeblain@gmail.com>

These are a few improvements to improve existing error messages in 'git
mergetool', and make sure that errors are not quiet, along with a small
completion update in 1/1.

Philippe Blain (5):
  completion: complete '--tool-help' in 'git mergetool'
  git-mergetool--lib.sh: use TOOL_MODE when erroring about unknown tool
  git-mergetool--lib.sh: add error message in 'setup_user_tool'
  git-mergetool--lib.sh: add error message for unknown tool variant
  git-difftool--helper.sh: exit upon initialize_merge_tool errors

 contrib/completion/git-completion.bash |  2 +-
 git-difftool--helper.sh                |  8 ++------
 git-mergetool--lib.sh                  | 13 +++++++++----
 t/t7610-mergetool.sh                   |  8 ++++++++
 4 files changed, 20 insertions(+), 11 deletions(-)


base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1827%2Fphil-blain%2Fabsent-mergetool-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1827/phil-blain/absent-mergetool-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1827
-- 
gitgitgadget
