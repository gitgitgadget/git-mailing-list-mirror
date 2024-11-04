Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3A176AD8
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746970; cv=none; b=f6EDvZbBjy5VaR5v+Li5LbYsl8we2yUqS8vNghQy7BfCs3qMjAzBPoKy4QLVKtefQLvGgrxEdYaKHqnsvnkMy0p41sZatPAXdeF2SnZZ2cPUavxokd7HmxD0nlaS04ipAR6y2hLusM+V0KLgz2XIfzQCnHtx222NaK4xiKnd1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746970; c=relaxed/simple;
	bh=4ZYTzyzfoWEjBPjZ7mdt58gVUJQQgKzEDtiRyNSZXmA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Z01nlC1d0gfkJNS0KZGB0ML6P99vS9W6ylJUfYpvOek5cOmsWxuvpQuQEaGqmzIGDrcz9QDWG0x0vBO8J/iMvdKrmMhD2HdO/Epe3WPMlFqb0KsX4KDCKoKxXRtF6o73vV5ImzOB935qk5spVsZ4tJYEaJlPgtT497AEBfX4Jn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIKzHSBf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIKzHSBf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso39026485e9.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 11:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730746966; x=1731351766; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cS3g8kxfh5KycdDDlMQDVzsdq2YxaIT8dua0w/HGwRs=;
        b=TIKzHSBfZL78Yj+29TCu3B3I/du3JDL4C4rNi1lxiG/Eo0hOP56PdA6XYEywuNct9e
         ieYHDT7OKiJsAoJQzWQvxOziJRcUURt/7WpOuHpF+ThDGZAP0MAUQQnvGpALKM3y2CYo
         yuyn2hZP0sAU8kezs7uYZrcUxnG7zvGcieFtsk1FDRms2hTpgimbIHf784YsrJ9yKE0z
         +9RzsKQmelzvaQEF/0TCgDY1h2VH9jy4pabrO161hnRvwxlizCmVGOHEWTq67qj3Wgyu
         fc9KBIzfREXN6FO+Komgt42N4w6dfBQ7tqdARAems+tXfZ1HjJS1eAUN5CWDv+4WGJIk
         8qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730746966; x=1731351766;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cS3g8kxfh5KycdDDlMQDVzsdq2YxaIT8dua0w/HGwRs=;
        b=ptiRe9NwVmWsXZlORdxUymbMeTW0f3liWB+16/35MdpIIcLbeleIgLIqbDtKUjR78A
         mbe60ZcGDa5OTJV3/KV1OJqDP+F65x6ZOS/oAH0qoBeLj0+WrFvIf5fVwzuJMjTG9rOs
         xivBEGqri73f84mUJZTNNWwTBp53+0DPCSEqEEWlGXNV853e1sWdxVfgoJf8I91eLfQA
         AUjTC65+f1rQ5OZv/ez7vooTXcXv98Qq6r5S+AhUwB19yJ3GCiJmdFDa6dsMcMqHcFqr
         9yPVrbpevotb5nsKRbfw4xTaC90gcg+M1H+7AEBhBaEyHzbn9W1npWJjgtoiO6a/2zjY
         8LaA==
X-Gm-Message-State: AOJu0Yyu521cT8ex5WlSTi8LFOf/o0vc33NRLWDG+62yk1t06dOk+rT5
	sP65ogvR6nzyH+PL+KGyvxno7kAYQyrshbm5JcuK2RNPBNjslHu7ATbmAQ==
X-Google-Smtp-Source: AGHT+IG3pL5RaInRn3v1uDfzFhL/3OAGCi4t7BBQYk/Q1/0oscQ07RWqOSZVgSxY3DIWO7TFQ6TkMg==
X-Received: by 2002:a05:600c:1f91:b0:430:57f2:bae5 with SMTP id 5b1f17b1804b1-4327b7eac96mr144080345e9.27.1730746965924;
        Mon, 04 Nov 2024 11:02:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5c65b8sm160312215e9.18.2024.11.04.11.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:02:45 -0800 (PST)
Message-Id: <pull.1822.git.1730746964.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Nov 2024 19:02:42 +0000
Subject: [PATCH 0/2] A few --shallow-exclude fixes
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
Cc: Elijah Newren <newren@gmail.com>

Here's a couple patches to fix up an error message and the documentation
around the --shallow-exclude option.

Elijah Newren (2):
  upload-pack: fix ambiguous error message
  doc: correct misleading descriptions for --shallow-exclude

 Documentation/fetch-options.txt  | 2 +-
 Documentation/git-clone.txt      | 2 +-
 Documentation/git-fetch-pack.txt | 2 +-
 builtin/clone.c                  | 2 +-
 builtin/fetch.c                  | 4 ++--
 builtin/pull.c                   | 4 ++--
 t/t5500-fetch-pack.sh            | 7 +++++++
 upload-pack.c                    | 6 +++++-
 8 files changed, 20 insertions(+), 9 deletions(-)


base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1822%2Fnewren%2Fshallow-exclude-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1822/newren/shallow-exclude-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1822
-- 
gitgitgadget
