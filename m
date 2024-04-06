Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F221848D
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366542; cv=none; b=C7BLDp6ao0oey/wchH/6/NdqhTTAkQLOY+KkVMgvDUUibQ8NHmbuwBlXHOwOdp0qRREbZryKBf69ehD7JokNMaVlnzCyD0yCV1qbmGT+wmjm01ySpldgi/SM6Hs4SsN5rIvgEeXQBYxCQ43+4Atbq+EjoU1Wd1PTkknrwldmiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366542; c=relaxed/simple;
	bh=SuGdnHRej8pB6ESere2A1ws7OXMgQbxhh3sO06fBWtw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bzXK1+vj7VMXGmIVxMIXIVSGfwU98MA8VYDxYDg6PqXhTa2cXFlypgYAQp6wr44qIUg9q4MHUMHDpLxfbvVZW+IZz7fSRE1A+n+bHQqptFczS6oa+T2FQM7WzRvTnE5fJ+wQyUqCzTJTfH2WsUysJAGn8/HBbo9wXoD1o7si5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab53gfQk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab53gfQk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4156c4fe401so17887025e9.1
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 18:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712366538; x=1712971338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01REL6Gb7WUS2I51BR0AeiajbooITmdGqmgL2RHrCmI=;
        b=ab53gfQkKT75K0tzu4SStRQIlGf9woF8WYgBiI14Hrsv28llp4DLByRi0/Wc7FzsyA
         EeCO+UpSJNFX5wKAGSF2GOdpuCuyMBh630PZ7wtni393gK2g038vJVoZYm7jQT/p8BKt
         xJr8zMJaFpKPuJtdtXsW70UWXbgjG3d++JIRp1UxmjZn7zZRS8ztCOvD/RYklYjD5Uwe
         88iehQy99SlHSgVMGXou7fmc9kssTmMfWuK8SsQAsWRXATeSe9ye43JcwqhETqDdnrA9
         3nMQzowZtken1TKOA79G5c/f123fOP/0O2KHO4Bjp8KpE2C6kXZ+AYNu/laC2oe79Onr
         Dojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712366538; x=1712971338;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01REL6Gb7WUS2I51BR0AeiajbooITmdGqmgL2RHrCmI=;
        b=mKb5Xg/NzpZTcMbRt4DQ72N6fo7Lk2IER7kE9FdPLsK+TMeDYsQMcGPygMo3cuTOxe
         OT1zcLYoAi8RBp5kjMeEf00unfLMf6FOkr1/qizM50fCTANNX4Fx9ucyHhaRWmNhcc/0
         /LnSPjOx6fPIqoDzpCdXjv+o8t2odEyfw3hnZaPePy0PuMBVwD+IexagAcAeecdYtxfV
         CR/AS6xhY3tZGfD7rNC2mu0QGXEJBG913+Baye1wulHIVjdGk9pBIdTlE/iQE3K0Zjrq
         O2nFTgPtpCkpKoG5Qvu2XY99Mz1FNB2a0Y6BUasRIUfQbKnzVrK4Xf7jPZM6FIwZgVs6
         R2Rw==
X-Gm-Message-State: AOJu0YxiTZKaToY7Y20guzMeoEJGAcP5GAv5Mmouxlis4wfxQbkywDXC
	dWs8JD3wKWf69XGpNicO8ax89WpL7ODZVj8rLUxjIbBiFHem+QBiugSWSQFi
X-Google-Smtp-Source: AGHT+IEj8TaFY/aLmi5RP6wSGS9G5CDI0G6D1F4US+AiPtJ6sph2cRIwe9Q1RZWhp5MjV2Xjo8UPew==
X-Received: by 2002:a05:600c:c1a:b0:415:8651:9bae with SMTP id fm26-20020a05600c0c1a00b0041586519baemr2425729wmb.41.1712366537938;
        Fri, 05 Apr 2024 18:22:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jb15-20020a05600c54ef00b0041624db414esm4585011wmb.35.2024.04.05.18.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:22:17 -0700 (PDT)
Message-Id: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Apr 2024 01:22:08 +0000
Subject: [PATCH v2 0/8] docs: recommend using contrib/contacts/git-contacts
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Linus Arver <linusa@google.com>

Make git-contacts more prominent in our docs.


Notable changes in v2
=====================

 * Improve existing mention of git-contacts in SubmittingPatches (instead of
   adding a separate, entirely new paragraph)
 * Add example usage of integrating git-contacts with git-send-email with
   the latter's --cc-cmd flag.
 * Various smaller fixes to SubmittingPatches

Linus Arver (8):
  MyFirstContribution: mention contrib/contacts/git-contacts
  SubmittingPatches: make 'git contacts' grep-friendly
  SubmittingPatches: mention GitGitGadget
  SubmittingPatches: quote commands
  SubmittingPatches: discuss reviewers first
  SubmittingPatches: dedupe discussion of security patches
  SubmittingPatches: add heading for format-patch and send-email
  SubmittingPatches: demonstrate using git-contacts with git-send-email

 Documentation/MyFirstContribution.txt |  5 ++
 Documentation/SubmittingPatches       | 68 +++++++++++++++------------
 2 files changed, 43 insertions(+), 30 deletions(-)


base-commit: c2cbfbd2e28cbe27c194d62183b42f27a6a5bb87
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1704%2Flistx%2Freviewers-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1704/listx/reviewers-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1704

Range-diff vs v1:

 1:  7f1ac742008 ! 1:  3817e7f3cd0 docs: recommend using contrib/contacts/git-contacts
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    docs: recommend using contrib/contacts/git-contacts
     +    MyFirstContribution: mention contrib/contacts/git-contacts
      
          Although we've had this script since 4d06402b1b (contrib: add
          git-contacts helper, 2013-07-21), we don't mention it in our
     @@ Documentation/MyFirstContribution.txt: $ git send-email --to=target@example.com
       valuable, such as changing the Reply-to address or adding more CC and BCC lines.
       
      +NOTE: Use `contrib/contacts/git-contacts` to get a list of reviewers you should
     -+include in the CC list.
     ++include in the CC list. In addition, you can do `git send-email --cc-cmd='git
     ++contacts' feature/*.patch` to automatically pass this list of emails to
     ++`send-email`.
      +
       NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
       please don't send your patchset from the tutorial to the real mailing list! For
       now, you can send it to yourself, to make sure you understand how it will look.
     -
     - ## Documentation/SubmittingPatches ##
     -@@ Documentation/SubmittingPatches: an explanation of changes between each iteration can be kept in
     - Git-notes and inserted automatically following the three-dash
     - line via `git format-patch --notes`.
     - 
     -+[[suggested-reviewers]]
     -+Use `contrib/contacts/git-contacts` to get a list of reviewers you should
     -+include in the CC list.
     -+
     - [[attachment]]
     - Do not attach the patch as a MIME attachment, compressed or not.
     - Do not let your e-mail client send quoted-printable.  Do not let
 -:  ----------- > 2:  82e5e05288d SubmittingPatches: make 'git contacts' grep-friendly
 -:  ----------- > 3:  6e6950afa6e SubmittingPatches: mention GitGitGadget
 -:  ----------- > 4:  fb06d5ce247 SubmittingPatches: quote commands
 -:  ----------- > 5:  a8abcf45881 SubmittingPatches: discuss reviewers first
 -:  ----------- > 6:  326afe13315 SubmittingPatches: dedupe discussion of security patches
 -:  ----------- > 7:  09f4e7ad123 SubmittingPatches: add heading for format-patch and send-email
 -:  ----------- > 8:  b35748f0cf8 SubmittingPatches: demonstrate using git-contacts with git-send-email

-- 
gitgitgadget
