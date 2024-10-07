Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27021D8DF5
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315130; cv=none; b=YDoJ+s03YurdL5LBJj/D+Is5vK0EyJqiGVH6Kcaf7P16Zf4CdexUguN2sSAKXaWMxrtqangvAeH8HVbSUKozDxHHaUybOfSafXSxptFUCaYw+qrNqZzbEudzVnMy0nWnAu5+hI0gupXYFaysxauU8WFLDryYAwIFuzlDXd5ux4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315130; c=relaxed/simple;
	bh=pN2Hxh5PneKYRbyErFKFEYUXxAMHZm76IWuyxLGUeqY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WY/tQal0x6F9eNB41CSt++Tk4DpOVoi5IZUU+AnoZ/M4P9RlWmfKSty3wCiADUmm179WfGl0KQPYEBkRL/eb2JEdszV3QARwrqTf3QHrgTp4kCJ+cYmysM2d3owRPqjtHPx4TxHQyinMP56ZqnNrpQjBHos2Gr9uND3OKaySt60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAVm7org; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAVm7org"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fad75b46a3so41881941fa.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728315127; x=1728919927; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLkCg87u99TnYYr75/BDb20ZnRh5kzjpzPC8uZi7ddI=;
        b=RAVm7orgweYE6/SsBgSlzdCyIKXkGoq50Kr/sYtn/+O/y6NIQLu0YLynjHOXuz8dMp
         2BLXNSVuNtYNMZMm50C+axCxJNmhe2emXxbWYjp9rlWpOSkYOHDMkwdUNC+52C5AeOWu
         4KoJ7BbbzDE3C1Q6HhA9Dob46O9XT+KOFPkxlPKcKlLeKS6ElIK0iWIHHX+sxSjBgfZs
         weh8qrZDbhzReY01EdF45Mma0zn3g9bZRMxIow6hG5VRyHizSRwOlUvFl+H6zg/KjTko
         PzNcZ6ArTMUG6SIy/Hp1nyrBqFfuNl1udZCLMKs21L8QCiGPguFksx8ymcM5tjB/YGUE
         TfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315127; x=1728919927;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLkCg87u99TnYYr75/BDb20ZnRh5kzjpzPC8uZi7ddI=;
        b=HnJDI3fXNc1Hc5r5OXMBekKfHAuiT/s5hovlKTVSlSdL+HRyQlRhbOnVjb10QptLH/
         syTHniRApXZl/Rrnfu+Xi2l3tczIu057nlP4mWYUxpPfNeLOoETwwaVVkzYz4ZicY8/I
         6lQBSxaqxOjuZjZM10ZnGe7Z3Q+I2w4HWd85s4bQomnynppfgaD7mOm+5wnMjzkrWjJj
         PRRfMqGAXGcSfGgBXoiso0YY7+0EYxoI8YGKIjikoV2RQzMNAsKtzDwsjcDsanBMk/AL
         ToVvl0HhQSGsKmfSy5GoYLS1HfR3HEM+zpcBxu/aPObNLGqQbdeIbgZGeoY0dwBKuXSc
         dRaQ==
X-Gm-Message-State: AOJu0YyaJOVHm3/8p7jUhatsSPUvCeryVA8Z0nuxF58SN5Aye0dwNEIx
	OIngsiYOsjv++NGB/yJ9FR0jzRpUFRpNd9BGUBrQS054JPCB6pkbq22l6Q==
X-Google-Smtp-Source: AGHT+IGIQRooFRA5PpHZB6zXMFkUSEEQuscRFw5CJoua/zSUebCwSR8Q2/Qf6iAGWo3cDTHTMJkrNA==
X-Received: by 2002:a05:651c:210e:b0:2fa:d3d8:e991 with SMTP id 38308e7fff4ca-2faf3c0c561mr55510771fa.6.1728315126254;
        Mon, 07 Oct 2024 08:32:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05a92c3sm3315343a12.25.2024.10.07.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:32:05 -0700 (PDT)
Message-Id: <pull.1805.v7.git.git.1728315124.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>
References: <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 15:32:01 +0000
Subject: [PATCH v7 0/2] [Outreachy][Patch v2] t3404: avoid losing exit status to pipes
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

Changes since v6:

 * Updated commit subjects to use imperative for proper Git commit subject.

Usman Akinyemi (2):
  t3404: avoid losing exit status with focus on `git show` and `git
    cat-file`
  t3404: replace test with test_line_count()

 t/t3404-rebase-interactive.sh | 75 +++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 25 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1805%2FUnique-Usman%2Favoid_git_pipes-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1805/Unique-Usman/avoid_git_pipes-v7
Pull-Request: https://github.com/git/git/pull/1805

Range-diff vs v6:

 1:  bfff7937cd2 = 1:  bfff7937cd2 t3404: avoid losing exit status with focus on `git show` and `git cat-file`
 2:  b3d3deced25 ! 2:  e2cae7f3a51 t3404: employing test_line_count() to replace test
     @@ Metadata
      Author: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
       ## Commit message ##
     -    t3404: employing test_line_count() to replace test
     +    t3404: replace test with test_line_count()
      
          Refactor t3404 to replace instances of `test` with `test_line_count()`
          for checking line counts. This improves readability and aligns with Git's

-- 
gitgitgadget
