Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2318DF9E
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594833; cv=none; b=gdgy9x7qUdeE0Vt2gNePrlcMJ0nhB8EkEUjP9fu38Cmb/nDRGtbNiXKO3WdYbD9Yf66JrBXJt6plVgthCGMAbNgn4gn0WAoQYDD+rhO/fmxmmdhjp15FhmoGUOsc2Zk6SA3psOQqD24RXODleWudTtLOlGnYzoERz1mEXFdNZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594833; c=relaxed/simple;
	bh=aAcOhYm7DHceMHm+5vhJLZqZwkizbSy2W2RMTF2S0pA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a8HWhFwun9/QWPQ8TTtGj9GMC9l5Yn2mX2ktp6Zi4nx3UezkFBNVahVOCGoa3GevAfvUxfLo2DyJsf/nbJeoGIst/uw/KW1ljugoaNZtpLF0MhivpP+VcDgrehAf/YwqaWWWObdWJaWj8zNvWnvEmACvAZbLnUbmoDeJnv6m/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnA/uqe0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnA/uqe0"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a994c322aefso91073166b.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594830; x=1729199630; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE2WF0kie868YYHQjaZPoZQElJVmtCji9826je647C0=;
        b=OnA/uqe0QnUNYMmK7B/xf+rCD7POO0XGCjqre3TCHE1BY61CxUmXnPPdKivOXENHAJ
         64CVFTjnNJ1rHArXVx0hB1/1bCNEjB8FLKBNGWdfMnDd+bh/OZwQgoUFsDRM+pBeb6aW
         j9bexPCqDuON8hBXTxnCv4RMI1QEev1l5TmlOFmc4HnOZ+VKZcuuUPcWCuGAeScZcBGK
         kaWpwt2ASPy/6/dttxtKprspg/0tR1hI0zXY99Mp+bkkIDU0yC1im5KAM78f53A1V2Wk
         ezn2mISd9GMTa8j2uE6FAen4oRpPhXdNJHg8MVX8qL9yi65+nAJr2O9hyAtmtq+dxjXk
         m3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594830; x=1729199630;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE2WF0kie868YYHQjaZPoZQElJVmtCji9826je647C0=;
        b=Ib8o7uPlUqXHgxUQI8AjDhNsJawglbhBsgA/odJ3/L/3pPqkckTxYTswH7B+M6mIpT
         JrpSvk4oMOACM1RcUOJaCsRr9leydZxd1fiHJrH27wyawgbOvEt8Vi3aEkVU63QCU0af
         N2Xse0HQYX11tdr63oqcArXQV5AD9B4ULNyFf0MwMtpwSbXl6saFVSS4oHTXkVC1r+mw
         PpR9487woKVwvuPF/k6Gz16+ccUH1OMMW4LT9Enx8QsnCg4Sx57/R2HU0a5ZQWEfczRx
         nixe8EeYY8rVURjrldfJu/24qaajNCKBZqP4cwTuXPq093Ki4PL3+zF0f58aVwunkMyT
         gmAQ==
X-Gm-Message-State: AOJu0Ywp4lrC2xwY6URMWjeFkvVAMOztT+M1rED1SHodsu8P/G1eMTIN
	vJ+5kJFAOCyW0eMAi4L8m8xw7/99f/4K7FElD9OvWSSjReq+eszP9Fm2Cg==
X-Google-Smtp-Source: AGHT+IHo/+OpYY6jyawPcEPk8fWzlp4F26WvymrztoB0eKlyjS/fqv1pWHpt0XMhBgXlHLnBFDJ0Cw==
X-Received: by 2002:a17:907:720f:b0:a98:f44d:a198 with SMTP id a640c23a62f3a-a99b8775a40mr36842766b.1.1728594829524;
        Thu, 10 Oct 2024 14:13:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80efb66sm137346066b.194.2024.10.10.14.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:13:48 -0700 (PDT)
Message-Id: <pull.1788.v4.git.git.1728594828.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
References: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Oct 2024 21:13:45 +0000
Subject: [PATCH v4 0/3] Remove the_repository global for am, annotate, apply, archive builtins
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
Cc: shejialuo <shejialuo@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>

Remove the_repository global variable for the annotate, apply, and archive
bulitins.

Changes since V3:

 * Improve commit message in patch 2

Changes since V1:

 * in patch 1, only pass in repo to the bulitin if the repo exists

Changes since V2:

 * drop patch 3, which is a bit more involved to dis-entangle the_repository
 * use a single variable in run_builtin() to keep track of whether or not we
   are operating in a repository

John Cai (3):
  git: pass in repo to builtin based on setup_git_directory_gently
  annotate: remove usage of the_repository global
  archive: remove the_repository global variable

 builtin/add.c      | 3 ++-
 builtin/annotate.c | 5 ++---
 builtin/archive.c  | 5 ++---
 git.c              | 7 ++++---
 4 files changed, 10 insertions(+), 10 deletions(-)


base-commit: 3857aae53f3633b7de63ad640737c657387ae0c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1788%2Fjohn-cai%2Fjc%2Fremove-global-repo-a-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1788/john-cai/jc/remove-global-repo-a-v4
Pull-Request: https://github.com/git/git/pull/1788

Range-diff vs v3:

 1:  8009fdb38b0 = 1:  d59b85b5298 git: pass in repo to builtin based on setup_git_directory_gently
 2:  1b82b5dc678 ! 2:  f26d09215c3 annotate: remove usage of the_repository global
     @@ Metadata
       ## Commit message ##
          annotate: remove usage of the_repository global
      
     -    Remove the the_repository with the repository argument that gets passed
     -    down through the builtin function.
     +    As part of the effort to get rid of global state due to the_repository
     +    variable, remove the the_repository with the repository argument that
     +    gets passed down through the builtin function.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
 3:  5d33a375f41 ! 3:  736212f34b5 archive: remove the_repository global variable
     @@ Metadata
       ## Commit message ##
          archive: remove the_repository global variable
      
     -    Replace the_repository with the repository argument that gets passed
     -    down through the builtin function.
     +    As part of the effort to get rid of global state due to the global
     +    the_repository variable, replace the_repository with the repository
     +    argument that gets passed down through the builtin function.
     +
     +    The repo might be NULL, but we should be safe in write_archive() because
     +    it detects if we are outside of a repository and calls
     +    setup_git_directory() which will error.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      

-- 
gitgitgadget
