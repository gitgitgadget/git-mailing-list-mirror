Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A020B1E1
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312182; cv=none; b=Srmx6EPk7u/XBlFiW7IJOVRhNxRxNyjs6NzAZUBIR80DzvBbY83zADB3mrWu/BiPSPMLiYOlNBlSh1ZGDf2t1ssarJMBKQmNSQ4wCF8dZrMkoEOaiLpC0TcHQ0aKJjATTtYGU7ScGW/C7xOFrM3glJ+cJbM87IQjOP1cSkRrBd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312182; c=relaxed/simple;
	bh=sJer6G71vc60UzpEDoI/6/PjVf7Bb6ga792Sf+Qmmm4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uTZvMutz9wNBXS1U0wZksZmqm/Zs/Xez5pckZ1gZOPHKN27ggPux6nuyVzMIDuXZLlUMGlz1yncsUUvJH1rRQ4yuosl32B62quOfljCmZK+T+Wmql06GnPTMWz07au/UDNNJCrP9VBzDoSceIunJ3NHo+UBVv68Qvkpk2iiWzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT0nzOyq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT0nzOyq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso37366985e9.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742312175; x=1742916975; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzWIZpU5QypkgbctemCD4yo3tnLTjZmdz0N3ZK1GDCs=;
        b=LT0nzOyqQT16u+GEsNtcQkOMKhgAt5Xe/qihCFpWlE0rj1SIoPZWhYZ3T6674SRodN
         7g8TZr88lHS7SF1tc8ZC00Lpx1X7PGidRk9KCpIGOgB/6NjhhVY28c6HmeKo9Q/ps1/1
         rDnsv7aCRjnufTjfMY5iZqPEL+E5Jx5op80LkKQ3iaxxlRbi8knMTMu4w4XNHT8p+MZU
         RTx2a5wF8Uvkz4VBEHZRb8Mi7y/L0FroMmNy6ie32AMnXjJMJC/vvqYgTGsYGuGakMn7
         G/BN9w9nBeBArdWy2hO0HYB2G8PIHf38FooKYVvg7As1WYR/wQpekDutF2WC2lmuY22M
         YxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312175; x=1742916975;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzWIZpU5QypkgbctemCD4yo3tnLTjZmdz0N3ZK1GDCs=;
        b=HRIq8nHqghzcoDGy+nBG6g3gkLIo3OM7MtfZCWQxNOYo9GanwKn31DceIomol+wpBb
         hYO+M/JlV8C1LoqiU7D1SJYkYNDPvJPK3yJDYNvFS2af0KQNhKU0wky83W6hgJ/3QwEy
         xl2IRFvbGT+Tn9t7ZC3CC3iEhQHFDRrkSza45XXFCtb2kVqMN5Ju6G+G3btAIEd+kbEn
         7KRZYGjmQ3V2U30M8KAgnpMD/siI95OmYfk8HHVHnziTjA9Nj/QoYszhXVRhigHuAyGs
         oWUPt7bq57It0Q267c+uNs+/aTApuCnll2Ab6dZdrt83zXEdzIviTT5oFn8u6k3saGHq
         ThPw==
X-Gm-Message-State: AOJu0YyGpRxXcCrQqGhgxPa8QXeTOvItFeBNh2O1H1rOal2I0HFaE6rs
	0fIRXILt7bcenjCjOcXgKc9gtSUqUdra8VApkcPaDoOcO/D1opk2iIv1cw==
X-Gm-Gg: ASbGncsu9lPtovG24ARKHdEZNikxHZ3GN9Iy51I4P6JvjNBHp2Qn8UZ7F7wGUEYzwGP
	40GMUOHH1XJovTQ4MDhes/HD4ii+3keIJRk9KXfdOv6IGoIU7zmr230/F6864wRQTMOj1vEvRbz
	IuB9jp3UcTuT/WxmaXVRuBJNqxJIWDk8Vv1z5pW65nSRVZo8lVmMGyU7DBMP7Nxk6R9VdhSfYZI
	Uou8VWtbvrlj6bULsO8A7zbFowhIsPTRSXQNpxavVxwgwLwIQexhPV/VIe7beY+6yl5A+/SuunC
	NwoAzHPuc6nWw5ly7w/0zCWrhBbwlZao4i2qzLN/ftaYDA==
X-Google-Smtp-Source: AGHT+IGOSt6sZmxzrW5jiYTxInQvfW2SVr33ii7YlnYbmHDyFDDCfE7nH5RhkV1QZp/I5S0kegTBVg==
X-Received: by 2002:a05:600c:3ca6:b0:43c:f8fc:f6a6 with SMTP id 5b1f17b1804b1-43d3b9865c2mr31815955e9.9.1742312174726;
        Tue, 18 Mar 2025 08:36:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda29esm139214525e9.7.2025.03.18.08.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:36:14 -0700 (PDT)
Message-Id: <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
References: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Mar 2025 15:36:11 +0000
Subject: [PATCH v3 0/2] bundle-uri: copy all bundle references ino the refs/bundle space
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Scott Chacon <schacon@gmail.com>

Rebased the series onto current master and squashed the patch that modified
the existing test into the main patch.

> bundle-uri: copy all bundle references ino the refs/bundle space
> bundle-uri: update bundle clone tests with new refspec path

Scott Chacon (2):
  bundle-uri: copy all bundle references ino the refs/bundle space
  bundle-uri: add test for bundle-uri clones with tags

 bundle-uri.c                |   2 +-
 t/t5558-clone-bundle-uri.sh | 203 +++++++++++++++++++++---------------
 2 files changed, 118 insertions(+), 87 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1897%2Fschacon%2Fsc-more-bundle-refs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1897/schacon/sc-more-bundle-refs-v3
Pull-Request: https://github.com/git/git/pull/1897

Range-diff vs v2:

 1:  b36bc876fe1 < -:  ----------- bundle-uri: copy all bundle references ino the refs/bundle space
 2:  5e198ba5c66 ! 1:  2ccbfdcc2dc bundle-uri: update bundle clone tests with new refspec path
     @@ Metadata
      Author: Scott Chacon <schacon@gmail.com>
      
       ## Commit message ##
     -    bundle-uri: update bundle clone tests with new refspec path
     +    bundle-uri: copy all bundle references ino the refs/bundle space
     +
     +    When downloading bundles via the bundle-uri functionality, we only copy the
     +    references from refs/heads into the refs/bundle space. I'm not sure why this
     +    refspec is hardcoded to be so limited, but it makes the ref negotiation on
     +    the subsequent fetch suboptimal, since it won't use objects that are
     +    referenced outside of the current heads of the bundled repository.
     +
     +    This change to copy everything in refs/ in the bundle to refs/bundles/
     +    significantly helps the subsequent fetch, since nearly all the references
     +    are now included in the negotiation.
      
          The update to the bundle-uri unbundling refspec puts all the heads from a
          bundle file into refs/bundle/heads instead of directly into refs/bundle/ so
     -    the tests need to be updated to look in the new heirarchy.
     +    the tests also need to be updated to look in the new heirarchy.
      
          Signed-off-by: Scott Chacon <schacon@gmail.com>
      
     + ## bundle-uri.c ##
     +@@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *file)
     + 		const char *branch_name;
     + 		int has_old;
     + 
     +-		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
     ++		if (!skip_prefix(refname->string, "refs/", &branch_name))
     + 			continue;
     + 
     + 		strbuf_setlen(&bundle_ref, bundle_prefix_len);
     +
       ## t/t5558-clone-bundle-uri.sh ##
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'create bundle' '
       test_expect_success 'clone with path bundle' '
 3:  ea204679cb0 = 2:  d148b14c390 bundle-uri: add test for bundle-uri clones with tags

-- 
gitgitgadget
