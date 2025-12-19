Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A834321E
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766170463; cv=none; b=GknSIQdLwP7UlT7mWfO+5O5EOwoyi/XiDFCRdzIlRvBqQyLGDl3935PG2iuiccr2ahkzS4caCTXyPRTGCW2h/62Cn34Kc6pPekaGfEyL5GxIiLpMfYwtFimcwRqyrKpECD+3cyAYDKIA4/nXhauTpVr/KGGv9BiB5U5Cp8IuIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766170463; c=relaxed/simple;
	bh=Qs7RFdIvod1jd+vhrWeWObbsNwJa/XufALt3wbxN5No=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=WU5JNb3wpktIplQfMB+UNi52pK7Ygbou//yxfds0HChfpvAAxf/xOIxTQ4rFG25uG4IlzishOrqnI6u3wxKi/epPlrt33v6mke7xCkMYZYc7q8J6AsswkzeHC7Qy+bXBmG/ml1yzVt0BSqiJCp33FhJj8pYiT+HGmImjQTB2X4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxHRk0e8; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxHRk0e8"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8b2d6df99c5so303294885a.1
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 10:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766170458; x=1766775258; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnfRmtORcBlzVBoKPl8Ow/SbZe/6wz/+m+vPixFaktU=;
        b=DxHRk0e8kjAUq4/dE8cSMgKgo8OX/ng+gWA/KD9x6tEuIFERO1fPRPwbBB4RmnBAI+
         5zqkysSJ74QpD9cTOmPRsu5Ui5+Vw1tcgwGgQm1V3O/nnM5s/1V4O+efDWn854p+S9Js
         GUQPJ7g/igtafNbmBhsKdsSA2toMGx2jlxE8Yjg+ih31wc4AlC7y+/BFdaLF1Dj6D3P4
         ds1trDUFc1XZV3tGaLCwwPt/nPR9kXox/XeRKNYgyPfxHqIGcWqyJkZrSwCJ+3gRvLfX
         4LxQROqEpg+5GCpwqRT/OC/w8/JfsBp69HcrZMmWQVUoCiIksS3rK28hCTdHtxIijJr2
         h+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766170458; x=1766775258;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnfRmtORcBlzVBoKPl8Ow/SbZe/6wz/+m+vPixFaktU=;
        b=iw7o68trs+gZGUjYLAaw06I2bJHXlklq7WeFxkNMesXWmVYEYXa/6Myt/4AkNtiOcq
         iNLDxxZPraR+Foxbeq6hiNvaqHlA2+wyOblFL/1KSmKuu3wbMXKxquAFG3C9VNsr7ndE
         DmT33jYbIG4PPgwJPDFpVdWdjfpqM4U6M1VNSysTeI3h5Prao/cKKyzL2andA5FdZdRN
         EflQ2VgasD1/NHnuWMSclB3wfvKkhewEDrQl6f9sK5iLrclvyPUnNk75biGa5YaCvCKz
         JQNv7ekCFPyhnHhUsnkyxPLBeEFSPEpZ8YY41wW27+2vDK50NUeIiB7JyKEn2uJ3UC2P
         wGbg==
X-Gm-Message-State: AOJu0YyIxOQ6ugK89jVGWUauYrnOEwI47ubtZNppSF/djkasEhfogGRl
	RKtOfTm2VvY/eSVRHbh54cjX3iBQpDKg4bRpYf8TwuOgr1SQUf+Ll7jtBrYo1PMr
X-Gm-Gg: AY/fxX57nIxNWCLVsmPMdvTf+uuw0V/pTitZpZMwftaJLQHKzi2/OQDMgiaUXQeCBP+
	sRXCht2UZK3LFPDRqA6JI7m0eVW/U5Lz6EoerLI5vL5PemPcVF5dWadBeyXV8fliZln2eCCv4SI
	qtKc2FrTfDPA0uQi00VjOJDmyKdNH4juBeiStIHy4e3ylIJ8GvyNhduQKK+3FKI+30T34I6RfQz
	jVvP6PxNFbD5PkNWLRb8sgH9hFDbJD3XZFGb/jFSRdNpD/iQWgfH3ryOMSX807LGYLl5o6JE4ZT
	khUV7dO3+GFdYWR/WVYhd2KjNxvk+zHglGIGDsNakt8yaJoe15szAtbuljLLOwpsJsKSC9fr2PH
	mQOOC/GSGejnKhbPLNWpbxgSFQ1q8XNEKkhd5mWf8EXzHJILe2zRVuncmT7gJn06ei3TNFfjao8
	B+ECz+m+Sq1uan7A==
X-Google-Smtp-Source: AGHT+IEcTa2I+4UswKlrJc5VleGGN13xnRs+QLTQAw3bKgaCrmf90zoE87oxMUemalfmOI6q618bEQ==
X-Received: by 2002:a05:620a:190a:b0:8a1:e798:bd67 with SMTP id af79cd13be357-8c08f79ca5cmr502480985a.0.1766170457625;
        Fri, 19 Dec 2025 10:54:17 -0800 (PST)
Received: from [127.0.0.1] ([64.236.133.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f0807sm237861085a.41.2025.12.19.10.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 10:54:17 -0800 (PST)
Message-Id: <pull.2016.v2.git.1766170456.gitgitgadget@gmail.com>
In-Reply-To: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
References: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 18:54:14 +0000
Subject: [PATCH v2 0/2] doc: flock of small fixes to various documentation files
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This second version only splits the changes in two commits, one addressing
asciidoc markup, the other fixing basic style issues.

Jean-Noël Avila (2):
  doc: fix asciidoc markup issues in several files
  doc: correct minor wording issues

 Documentation/git-checkout.adoc   |  2 +-
 Documentation/git-rebase.adoc     |  2 +-
 Documentation/git-repack.adoc     |  6 +++---
 Documentation/git-send-email.adoc | 26 +++++++++++++-------------
 Documentation/git-worktree.adoc   |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)


base-commit: d8af7cadaa79d5837d73ec949e10b57dedb43e9b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2016%2Fjnavila%2Fdoc_small_fixups-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2016/jnavila/doc_small_fixups-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2016

Range-diff vs v1:

 -:  ---------- > 1:  31694ab9d3 doc: fix asciidoc markup issues in several files
 1:  b88126ef60 ! 2:  a3a76d448a doc: flock of small fixes to various documentation files
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    doc: flock of small fixes to various documentation files
     +    doc: correct minor wording issues
      
     -    While translating the Git documentation into French, I noticed several small
     -    issues in various files. This commit addresses these issues to improve the
     -    overall quality and consistency of the documentation.
     -
     -     * enforce consistent imperative mood in option descriptions
     -     * lighten wording in several places for clarity
     -     * add missing parameters
     -     * fix minor asciidoc markup issues
     +    * use imperative mood for consistency in options descriptions
     +    * add missing parenthesis
     +    * reword verbose phrase in git-repack.adoc
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     - ## Documentation/git-checkout.adoc ##
     -@@ Documentation/git-checkout.adoc: ARGUMENT DISAMBIGUATION
     - -----------------------
     - 
     - When you run `git checkout <something>`, Git tries to guess whether
     --`<something>` is intended to be a branch, a commit, or a set of file(s),
     -+_<something>_ is intended to be a branch, a commit, or a set of file(s),
     - and then either switches to that branch or commit, or restores the
     - specified files.
     - 
     -
       ## Documentation/git-rebase.adoc ##
      @@ Documentation/git-rebase.adoc: of the to-be-rebased branch. However, `ORIG_HEAD` is not guaranteed to still
       point to that commit at the end of the rebase if other commands that change
     @@ Documentation/git-send-email.adoc: instead.
       	Default value can be specified by the `sendemail.smtpServerOption`
       	configuration option.
       +
     -@@ Documentation/git-send-email.adoc: must be used for each option.
     - --smtp-ssl::
     - 	Legacy alias for `--smtp-encryption ssl`.
     - 
     ----smtp-ssl-cert-path::
     -+--smtp-ssl-cert-path <path>::
     - 	Path to a store of trusted CA certificates for SMTP SSL/TLS
     - 	certificate validation (either a directory that has been processed
     - 	by `c_rehash`, or a single file containing one or more PEM format
      @@ Documentation/git-send-email.adoc: Automating
       --no-to::
       --no-cc::
     @@ Documentation/git-send-email.adoc: Automating
       	via config, if any.
       
       --to-cmd=<command>::
     -@@ Documentation/git-send-email.adoc: have been specified, in which case default to `compose`.
     - 	Currently, validation means the following:
     - +
     - --
     --		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
     --		*	Warn of patches that contain lines longer than
     --			998 characters unless a suitable transfer encoding
     --			(`auto`, `base64`, or `quoted-printable`) is used;
     --			this is due to SMTP limits as described by
     --			https://www.ietf.org/rfc/rfc5322.txt.
     -+* Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
     -+* Warn of patches that contain lines longer than
     -+  998 characters unless a suitable transfer encoding
     -+  (`auto`, `base64`, or `quoted-printable`) is used;
     -+  this is due to SMTP limits as described by
     -+  https://www.ietf.org/rfc/rfc5322.txt.
     - --
     - +
     - Default is the value of `sendemail.validate`; if this is not set,
     -
     - ## Documentation/git-worktree.adoc ##
     -@@ Documentation/git-worktree.adoc: associated with a new unborn branch named _<branch>_ (after
     - passed to the command. In the event the repository has a remote and
     - `--guess-remote` is used, but no remote or local branches exist, then the
     - command fails with a warning reminding the user to fetch from their remote
     --first (or override by using `-f/--force`).
     -+first (or override by using `-f`/`--force`).
     - 
     - `list`::
     - 

-- 
gitgitgadget
