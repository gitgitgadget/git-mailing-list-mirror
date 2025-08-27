Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D1313E22
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279351; cv=none; b=HshQYVLkTJV5F7vaSBHcYQFEWuMM7frbQ4ilka7Yc/HinZb9xJ+OpJwbckcpymy+xjYjIDQ0WWe5IRO/UeMmYyX/3OqMYyLfkt5wCCeKDEfPPBNzXT8xTG3zMBDo60AhbH9T/ksMNBFVvCC0GHnSrtR+esb7hAqjwF9ERrPa5ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279351; c=relaxed/simple;
	bh=FgLw1vP4/2kmPF8Y8BLoI6IpXVh2dLkRXwZqDq7UYi8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gMGMALSSORxIvjWTypHZp/fP6yCKIpl+rPj4MztC74T5Q71I2B3H1TD5kvb+fXWIZc9Wbk7Ql5WNSOXWavCr5+FusELfoFbkrAjP6L13Z6sIo1rerMD2tY7UZeFhChW0xMm9hHg1WjgDA3vIqWOXGiCB9zFgtieRV3UBMwimLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho/BlhE2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho/BlhE2"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso5205193f8f.3
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756279347; x=1756884147; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfQb6PAAyNAZML7RXk3FVm5vx1OgqcT7pe9Cr6fGhd8=;
        b=Ho/BlhE2wyXTticRhU3rZRVC9IX5DbjnMNRc47XX650qAnqJi/meCLORyB3cEtObGl
         p416c8hp3xMsiR239dwgKekAWT+DqFNKGCUzUuww1kacAt2gcBrjnyUJnu1nk8fNna8b
         7d10UrVjrPrVEkMXPAL/3w5wIql1alEdAOOC64ZR/XKetq2dVh6VnFJn9U5ZUHSr+BWo
         KQw4ZCAZnU6eNJ1lvWUdbbImtgUJ51fF7EOY0i412WcHDCZ11BfUfWtQwVBsF6jpbPtV
         yE8GCFCIzsieuy44wTq0eg8irpIaMHgI57uBmFzZKJaic0CJPNQG/nmstiuCa7CQfjNj
         c8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756279347; x=1756884147;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfQb6PAAyNAZML7RXk3FVm5vx1OgqcT7pe9Cr6fGhd8=;
        b=ZxAjOhKYsA7Lk99ta5E4oEK8gJG3ik507pQb1WeoNWZR0MmEYYskGx2kZqsoKnk4Fe
         IIvhnJp8ih7oZGD6L+4g9lqXJG0SfEJsRoWO+/znSa2ynag+FGT168zB3ez0rKx4/iHZ
         6U/le0Chunb5ISXVhFZl2d1V0PYLRhSRQfvomLW7io1q+cZbrC9fpgkUWSWMsZmSexuB
         YpELw/ouHQdb99AcjUMSyCfFVlQOQSSmFHUOrN/6GyJoNndGKzF9K//s+TV73fw3Pxf/
         WV845Lyu9A1jW1zYPQijrIHRYUpZMq+zD2kETmQ1qNZ/cGD17xHN6TyEPVv129OlupCw
         Jy6A==
X-Gm-Message-State: AOJu0YxaiOXGXbZCainH+Lf1MWP6rzhTY91S+0luUQkeHPO4so+ZqKa4
	TEq6pa1AzYZumwzIlIxOakAsA2hhse3RAPS3C4jAg9dPkfhUcG7CwFK1Xt3ZNg==
X-Gm-Gg: ASbGnctgQ4z/9JbJBCMH9bMtRcGMUP4EsJ/ogh5qAzQr4G85RLeT27OayMiJLtXpyKY
	mHJdxvRDm/An+pmS6PrMGKDTHlLCD+G6PA6KKvOTdiYX5VTBr/ksf+2FBa6gN4BDGm/pAQWct3O
	it5TJSgmZqZxylnum2WtSkXj3X3AdZFWa6AS1AGX+c3NpD0H4nZpOwp0Km3oBWmj5BHOSC7/bjQ
	o3MmSjummTHkqcX4bLy4oHxicsjFjf5ioknWm7aG2r9TuFM+LtPVFAgWk5aUoaI4LCfY/krHwYr
	Tj5npiKhpOfi7c3bqszQPU8rYMaPHf+4VJ5FlISyDQ0/andPuBpZVFLB9dRKfINZBZxsk3A7X7N
	rhs4J1dWpvDOhyhTXrepn7lC+9MUnKc8++12W5w==
X-Google-Smtp-Source: AGHT+IGRVn8/7E+L3/wFBUFFWV22lH55+onfejhAvZbnozj7+a26V/M3YEHxin8vw2ZrF1+xtsmTyw==
X-Received: by 2002:a5d:5f86:0:b0:3c7:516c:f664 with SMTP id ffacd0b85a97d-3c7516cfafcmr9515977f8f.50.1756279347175;
        Wed, 27 Aug 2025 00:22:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211cd3sm19070812f8f.40.2025.08.27.00.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 00:22:26 -0700 (PDT)
Message-Id: <pull.2042.v2.git.git.1756279345929.gitgitgadget@gmail.com>
In-Reply-To: <pull.2042.git.git.1756279041881.gitgitgadget@gmail.com>
References: <pull.2042.git.git.1756279041881.gitgitgadget@gmail.com>
From: "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 Aug 2025 07:22:25 +0000
Subject: [PATCH v2] doc: document rev-list opts in revert, cherry-pick
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
Cc: Andrew Jeffrey <andrew@aj.id.au>,
    Emily Shaffer <emilyshaffer@google.com>,
    Emily Shaffer <emilyshaffer@google.com>

From: Emily Shaffer <emilyshaffer@google.com>

In f873a273d1 (revert: accept arbitrary rev-list options, 2010-06-14),
we added a handful of new options to `git revert` and `git cherry-pick`,
but did not document them except by example to `cherry-pick` only. We
have a nice shorthand for adding the rev-list documentation, so let's
add it now, to both commands.

Reported-by: Andrew Jeffrey <andrew@aj.id.au>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
    cherry-pick: document rev-list options
    
    Ach, sorry for the noise, turns out it touched both revert and
    cherry-pick, might as well do the docs for both.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2042%2Fnasamuffin%2Fcherry-pick-docs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2042/nasamuffin/cherry-pick-docs-v2
Pull-Request: https://github.com/git/git/pull/2042

Range-diff vs v1:

 1:  fa352ccda08 ! 1:  f41cb4e8abc cherry-pick: document rev-list options
     @@ Metadata
      Author: Emily Shaffer <emilyshaffer@google.com>
      
       ## Commit message ##
     -    cherry-pick: document rev-list options
     +    doc: document rev-list opts in revert, cherry-pick
      
          In f873a273d1 (revert: accept arbitrary rev-list options, 2010-06-14),
     -    we added a handful of new options to `git cherry-pick`, but did not
     -    document them except by example. We have a nice shorthand for adding the
     -    rev-list documentation, so let's add it now.
     +    we added a handful of new options to `git revert` and `git cherry-pick`,
     +    but did not document them except by example to `cherry-pick` only. We
     +    have a nice shorthand for adding the rev-list documentation, so let's
     +    add it now, to both commands.
      
          Reported-by: Andrew Jeffrey <andrew@aj.id.au>
          Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
     @@ Documentation/git-cherry-pick.adoc: fail unless one of `--empty=keep` or `--allo
       SEQUENCER SUBCOMMANDS
       ---------------------
       include::sequencer.adoc[]
     +
     + ## Documentation/git-revert.adoc ##
     +@@ Documentation/git-revert.adoc: include::rerere-options.adoc[]
     + 	configuration variable can be used to enable this option by
     + 	default.
     + 
     ++include::rev-list-options.adoc[]
     + 
     + SEQUENCER SUBCOMMANDS
     + ---------------------


 Documentation/git-cherry-pick.adoc | 2 ++
 Documentation/git-revert.adoc      | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
index 42b41923d5f..03848aa9f21 100644
--- a/Documentation/git-cherry-pick.adoc
+++ b/Documentation/git-cherry-pick.adoc
@@ -174,6 +174,8 @@ fail unless one of `--empty=keep` or `--allow-empty` are specified.
 
 include::rerere-options.adoc[]
 
+include::rev-list-options.adoc[]
+
 SEQUENCER SUBCOMMANDS
 ---------------------
 include::sequencer.adoc[]
diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.adoc
index ffba365e639..28827807473 100644
--- a/Documentation/git-revert.adoc
+++ b/Documentation/git-revert.adoc
@@ -122,6 +122,7 @@ include::rerere-options.adoc[]
 	configuration variable can be used to enable this option by
 	default.
 
+include::rev-list-options.adoc[]
 
 SEQUENCER SUBCOMMANDS
 ---------------------

base-commit: f814da676ae46aac5be0a98b99373a76dee6cedb
-- 
gitgitgadget
