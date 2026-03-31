Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB03413254
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971275; cv=none; b=DqFvOaBb71hIHwEoxqfy30xGxoK3abaP01iEau2aAJ4oW0N8xyj2rbsgP05fACEcFdv+Vrvg1P6wNgz3uRMrLcjWG3z1TCVWJaN52flD/JVyKPhTlSjy+1KeIcFK++gIquTQ8yNHPH5QsYOrP5Wf6BIyz7zyVtT8QIefWRWOIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971275; c=relaxed/simple;
	bh=bzrRKEu2cCaOI7HmpwPqoIFxGFnw2Jtyc+ZvYKSNOAQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=syMQnc17NjKoEJQfqdwPs760AxBguOvFyjKNV/ps4VumdFGQOE1ugQc/HvOIMiorHwrsC0bQ7gIifivydHRGBSQJBT2rTHsMvxdMou94TwnHv5kJFgX2FsnlPbYOXmPSg4mlmBqGMP93bt49pF4NRZImLs22HGur9yQmUP/E8bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6U+Iv2V; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6U+Iv2V"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d006a80ccbso734983685a.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 08:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774971269; x=1775576069; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56ZS7uOx+IJTsgPF4PAvS3OlsK/gzx/X9JVZMswBdME=;
        b=m6U+Iv2VVEJCsPogjxH1KZo9Bn9P/sHjV+gbOthsMMANJj6XONvSV2LYB7K7OHfwJ0
         2//rMxYP1/KA0B5Fs0HlTLUFcPR2gpXPaLi+TkLQVI5gz6rA/imCm2okBtoHTrcKGWTy
         K+3GtJyAPjUZNsqEZLOe+v5I072VNXS7/B7l9u4VM6gQosA1L/Il8Q+fbi9wmJel4Dkc
         n091DJqwYXZIhCa04Viz6MAWh9X/zbKTomMN6IaUNfPJMCNaEfM3oun2lbX2qbCyMyOf
         oHBzJzX0Z8cd+E6nIQcTqbDfaXTt1D/F2yOYoD1evynoMhaetN0rIK1m79PsYOTzEEfA
         HD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971269; x=1775576069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=56ZS7uOx+IJTsgPF4PAvS3OlsK/gzx/X9JVZMswBdME=;
        b=HI4+ivckoXEPgtv95X86LCUfRY0uYjAwnPLvDSmyHR43uSpValTUQRTRZ+wGD+snxs
         4H3Bo4IZ00KRoN53eJL5vdzL9WOZG9cIgzbJl7GqjJZeL/N5kNHHFeXZorsYG1s2OTqO
         PN8GpfAlxgjnoBHdXWtGpM9p+ABjW6y51iMfq4+5+sTrvWXgOt2Ch+ELM1jhkWNFGinY
         QD+F4YnREG+/T5H4HrNPDBfMvnB0WNej0SEdix3qGpZKhMIQvZbyJ5UUe6T+D9RsIgtM
         jVI7iBWe2aydzbzSC7Jmj114kXhhNGNq6QX2dILhM9WLYggYA2GZf5HvW+K01Me+93C1
         2e2A==
X-Gm-Message-State: AOJu0Yy16Omz0FtBnB/kSNcOJ9rM/xnfh1NpvYHnbTUc/JJySgdjuq18
	u8FeXI/m1kOkPgu4bf3AVnSUVvikgA+FIto6jdBOINA2+/rmmi0NGjQs08ZZHA==
X-Gm-Gg: ATEYQzwgrQbU2a8vmqSufex3tt7KjhL3ZfsgLKncS5Ms6lyOh3uNgFQ4NCRsgQGTJnO
	Fo1HYv4v+hrAV0YDe/obJ9T2dXRWG3z6IqLTs0qye8V26TcNy6Fx4Zrh2t48cpwZ8yC+hvwmGVe
	Kk1mWrJBzoMRDPYA5IViMWyl4OUhxiJraVcta82H/hlJC1PX3vLnTl4IW3qqT498gQtZ5fqBouC
	uUW8/8X+QZOFu8nxLcsVsQahrbGXJEOdkFw9lJMBMUO8+gz1hRv3+yGwG6N5QjoGf4A0H7QvaqD
	jaQz+Rszq+AOnHxU67Il68zXl+ZRtpwUhbBPIrywO4366EEesa+2jGKxs+YjyjCbXuWhvFg9nlE
	OFlmbS+kVd97aO/axIjxBNQY6sDHreq8DT2pX9SUDh4Ok1jFXQW+U33gPhlnOrT6j1K3n6SxSHR
	wvSwXUEpmjMyet60yZpMwY7WpbSEI=
X-Received: by 2002:a05:620a:1981:b0:8cf:ff82:6dc3 with SMTP id af79cd13be357-8d1b5c190efmr7643585a.51.1774971268516;
        Tue, 31 Mar 2026 08:34:28 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edc550sm999985085a.5.2026.03.31.08.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:34:27 -0700 (PDT)
Message-Id: <pull.2258.v2.git.git.1774971267.gitgitgadget@gmail.com>
In-Reply-To: <pull.2258.git.git.1774901607564.gitgitgadget@gmail.com>
References: <pull.2258.git.git.1774901607564.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 15:34:25 +0000
Subject: [PATCH v2 0/2] unpack-trees: use explicit repository in trace2 calls
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>

trace2 calls in unpack-trees.c use the global 'the_repository', even though
the relevant context provides an explicit repository pointer via
'istate->repo' or the local 'repo' variable.

Using the global repository can result in incorrect trace2 output when
multiple repository instances are in use, as events may be attributed to the
wrong repository.

Use explicit repository pointers instead in these call sites to ensure
correct repository attribution.

Signed-off-by: Jayesh Daga jayeshdaga99@gmail.com

v2:

 * Use repository from src_index instead of the_repository
 * Address review feedback from Patrick Steinhardt
 * Avoid introducing new API or struct fields

cc :Karthik Nayak karthik.188@gmail.com

Jayesh Daga (2):
  unpack-trees: use repository from index instead of global
  unpack-trees: use repository from index instead of global

 unpack-trees.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


base-commit: 5361983c075154725be47b65cca9a2421789e410
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2258%2Fjayesh0104%2Funpack-trees-trace2-repo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2258/jayesh0104/unpack-trees-trace2-repo-v2
Pull-Request: https://github.com/git/git/pull/2258

Range-diff vs v1:

 1:  717da16044 ! 1:  f03ea194e3 unpack-trees: use explicit repository in trace2 calls
     @@ Metadata
      Author: Jayesh Daga <jayeshdaga99@gmail.com>
      
       ## Commit message ##
     -    unpack-trees: use explicit repository in trace2 calls
     +    unpack-trees: use repository from index instead of global
      
     -    trace2 calls in unpack-trees.c use the global 'the_repository',
     -    even though the relevant context provides an explicit repository
     -    pointer via 'istate->repo' or the local 'repo' variable.
     +    unpack_trees() currently initializes its repository from the
     +    global 'the_repository', even though a repository instance is
     +    already available via the source index.
      
     -    Using the global repository can result in incorrect trace2 output
     -    when multiple repository instances are in use, as events may be
     -    attributed to the wrong repository.
     +    Use 'o->src_index->repo' instead of the global variable,
     +    reducing reliance on global repository state.
      
     -    Use explicit repository pointers instead to ensure correct
     -    repository attribution.
     +    This is a step towards eliminating global repository usage in
     +    unpack_trees().
      
     +    Suggested-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
      
       ## unpack-trees.c ##
 -:  ---------- > 2:  fbdf3271b7 unpack-trees: use repository from index instead of global

-- 
gitgitgadget
