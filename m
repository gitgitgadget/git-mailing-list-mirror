Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F93112BD
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251373; cv=none; b=HjwAVI3JweM97j/x5yovS9vOa/KQVihqA1hOmmLhRJKuhoFrZpZQo5+PKtpfvaZF9Ru/vwBUfY6pb6aew86VC1LIPDLZAJ91j0vaNSX/FH7wpSqeBuxACJht8rkzp67r1XRvbwmQUK5dFIxgDfZcPjg3iW3vkoWip/MwgHZ3S1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251373; c=relaxed/simple;
	bh=chvqYvBMeX+752ZX+nTB/xs77QC5GuSXS3sZEaZBbXU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DnoK7s0NCiMSLLcG4ZS7SM5qhtXi15/yAt2UseWnY+gRw0WaVTcVeshwoVugmzueQa2aPQUQ7UFUHL9OfPLH244A2Nc1hlSqkMskQybk6hORJB0BSn2zGJYlc1t5hvWlmZX8R8RZUH4lndrUmhU963vTekV/QayIUakgkDbDE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuDy7Gul; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuDy7Gul"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so269640eec.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251371; x=1773856171; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HmnYTXxKxtt6FAUJG6AJVTHxQ6TucRBPzSKcZWZRfk=;
        b=SuDy7GulTLIXCmQRdAfXyhAf28eVQlreHd0Zm6BPIp1Z4kvay83/GJEVc01brj2M5Q
         Lbj/WEjE06hbDeDPK1LMY3YIEYMDA0xD7NizT/4HFitbYpMyTaWbpUvRmWQmVC0Bakp9
         r83AgVqxKe/rndgDOhWbqaaLSeWPYJyoZbnys7c04xOTXfmk7mQ+ec0eSIiIUs9Q2qtF
         n4sxAMkaw8Kl7SDAtWGU7/YUUnh0mQVigxx7nAglw9BSbU9Xe4lnuIRls0AfXxoJOLrm
         1T6nouTANP6DP9Bfcwqgkj8AImv3skdZlBxZRzWBpZJ8zlPRtQa8MTr/RUlXXCNX4+99
         9J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251371; x=1773856171;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HmnYTXxKxtt6FAUJG6AJVTHxQ6TucRBPzSKcZWZRfk=;
        b=W+JHKPrgdBHeeoaICrvisJGX5mDQ1K6+wQNmeWUuwq8Xa9bEH7cIkK/YH/qJqAhmM5
         OhEO7JVJ+IrHbNldjq1UHIm2/4qP7xhQR6nAJZyD4aifRQ577x3NI/AIK2W8nuj3OsBU
         leVmQYcr8czo2qWC0tXOlGkMkyaKpfYaur+G5n4PaHVpwXlCzZBwEoLNg1j9nHd2ACnX
         eOXF/8/M7Rh+omp0GsBAWmxVYF0WLWyBXUHiUTJqRv4Z9AL+Hul9QZ+bhwuYcG0fVVeB
         2sSx50bUxvW/DxGm5LbPSUqF/8CiuQ41+1U/YWMjlskStg9MZm8glFin4ziX+8Sx3Q3P
         O3eA==
X-Gm-Message-State: AOJu0Yx78cQgJdnnePPO7/03Bt4sZ2oHB/+xuC+L6oJkllvXGYxlwdLE
	1ld9H7/fMlE6NjonYNoo0NrM/ym+UVamoA4T6+mjOkEXVtSLfEmvJiDgNZBYhQ==
X-Gm-Gg: ATEYQzyQ3Jn3KMv3v0TEJsXh8rhiUuDgjBYDy/DipDWNASdNh6j/0slcA6QcbrF9bLD
	haImcyA4dqZ7aHBCbVjx5sE1/zelSPJ8gd9Vnr8IV1AH5zAaJaQfGGJr/cOp9PwqZ9/wUJKsMNI
	9Zv3jsN77ep0nOIlYDz1MmSRgFWzIQzV1R6gnrLHBRwJqP0sUyUfzVBOGBv5tmQ7qJAYKVRvTeu
	+INcnapd5hpOyg2SLsxhryHrQIstjQiP/YBwNMxK4JjiCdsyXzB7yughmdgmQF7dU94DL7A9KVk
	PuoEDeTnjnEb1b65gWKHkfG7z1YuEMVzXzsydHZaELNL3Gk4S7w5pfBsKM0zps1wq0JRvyrO6XH
	9K34HM1A+p1VPKgmJGKwqjE8gIVHp0EzfdWcUjPpbeRp6GLuu7KiOhUWhzqAe1XP+pNlOR+06DA
	DYqVglPd8xDxG3UezUJP5i+X/VKzI=
X-Received: by 2002:a05:7300:4346:b0:2ae:5bde:a5c5 with SMTP id 5a478bee46e88-2be8a586345mr1703061eec.30.1773251370789;
        Wed, 11 Mar 2026 10:49:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.192.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8a854268sm3244967eec.10.2026.03.11.10.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:49:30 -0700 (PDT)
Message-Id: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
References: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 17:49:26 +0000
Subject: [PATCH v5 0/3] Advice on checkout dirty files
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

This is my submission for microproject [GSOC]

This patch adds a new advice type ADVICE_STASH_BEFORE_CHECKOUT to help users
when they attempt to switch branches with local modifications that would be
overwritten by the operation.

The new advice follows the same patterns established by existing advice
functions such as advise_on_updating_sparse_paths(). When triggered, it
lists the affected files and suggests using git stash push/pop to save and
restore local changes.

The advice can be silenced with:

git config set advice.stashBeforeCheckout false

Changes:

> advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: add
> "stashBeforeCheckout" to advice_setting[] and implement
> advise_on_checkout_dirty_files() function
> Documentation/config/advice.adoc: document the new advice key

Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com

Arsh Srivastava (3):
  advice: add stashBeforeCheckout advice for dirty branch switches
  advice: add stashBeforeCheckout advice for dirty branch switches
    [GSOC]
  unpack-trees: suggesting 'git checkout -m <branch>' with its
    repercussions

 t/t6439-merge-co-error-msgs.sh | 6 ++++++
 t/t7406-submodule-update.sh    | 3 +++
 unpack-trees.c                 | 9 +++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)


base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2233%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233/Arsh123344423/advice_on_checkout_dirty_files-v5
Pull-Request: https://github.com/git/git/pull/2233

Range-diff vs v4:

 1:  eb5639dbc3 = 1:  eb5639dbc3 advice: add stashBeforeCheckout advice for dirty branch switches
 2:  e88c851701 = 2:  e88c851701 advice: add stashBeforeCheckout advice for dirty branch switches [GSOC]
 3:  4237b9667d ! 3:  1cc22f437e unpack-trees: suggesting 'git checkout -m <branch>' with its repercussions
     @@ advice.h: void NORETURN die_ff_impossible(void);
       
       #endif /* ADVICE_H */
      
     + ## t/t6439-merge-co-error-msgs.sh ##
     +@@ t/t6439-merge-co-error-msgs.sh: error: Your local changes to the following files would be overwritten by checkou
     + 	rep/one
     + 	rep/two
     + Please commit your changes or stash them before you switch branches.
     ++Try using 'git checkout -m <branch>' for a quick fix.
     ++Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
     ++Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
     + Aborting
     + EOF
     + 
     +@@ t/t6439-merge-co-error-msgs.sh: error: Your local changes to the following files would be overwritten by checkou
     + 	rep/one
     + 	rep/two
     + Please commit your changes or stash them before you switch branches.
     ++Try using 'git checkout -m <branch>' for a quick fix.
     ++Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
     ++Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
     + Aborting
     + EOF
     + 
     +
     + ## t/t7406-submodule-update.sh ##
     +@@ t/t7406-submodule-update.sh: test_expect_success 'submodule update should fail due to local changes' '
     + 	> error: Your local changes to the following files would be overwritten by checkout:
     + 	> 	file
     + 	> Please commit your changes or stash them before you switch branches.
     ++	> Try using '\''git checkout -m <branch>'\'' for a quick fix.
     ++	> Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
     ++	> Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
     + 	> Aborting
     + 	> fatal: Unable to checkout OID in submodule path '\''submodule'\''
     + 	EOF
     +
       ## unpack-trees.c ##
      @@ unpack-trees.c: void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
       	if (!strcmp(cmd, "checkout"))
     @@ unpack-trees.c: void setup_unpack_trees_porcelain(struct unpack_trees_options *o
      -			  "Please commit your changes or stash them before you switch branches.")
      -		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
      +			  "Please commit your changes or stash them before you switch branches.\n"
     -+			  "Try using 'git checkout -m <branch>' for a quick fix. \n"
     ++			  "Try using 'git checkout -m <branch>' for a quick fix.\n"
      +			  "Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.\n"
      +			  "Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone."
      +			  )
      +		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
     -+				"Please commit your changes or stash them before you switch branches.\n"
     -+			  "Try using 'git checkout -m <branch>' for a quick fix.\n"
     -+			  "Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.\n"
     -+			  "Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone."
     -+			  );
     ++				"Please commit your changes or stash them before you switch branches.");
       	else if (!strcmp(cmd, "merge"))
       		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
       		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"
 4:  b25ea22410 < -:  ---------- Updating tests and unpack-tress.c [GSOC]
 5:  2ef7d5a3d6 < -:  ---------- File updation [GSOC]

-- 
gitgitgadget
