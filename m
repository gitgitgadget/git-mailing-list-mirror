Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0A30AAC2
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763498996; cv=none; b=VmHKrsFXr21mEETgFMPm/Ijw5d4qb/Pq8pLNjBMFPpaz4btJzapHFgd90jYHj5Nb5H0uSRWcryFDvp/oM3R+Poj02VaKad8VU7c9F5awz0sYEeutnCJ/VFizfD1smMf5DBcSVnq48AKGvtgaPog8smbpZFv7jE6UFDQj3FFOUZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763498996; c=relaxed/simple;
	bh=O7zBK4O5g5+x5gxnwQ00u3kX8yMHwBUfybf8r1zf/s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEZliBulUHllR45VyL/NN3LhnH0PYFl/ygxmFQR/jnd1KVrduDDBqUc4TlJNXfXb4h4fV031OWZ7J0el+AASCsdH3npwBp1+hqvlkfQGOlieIQO2SRncrvmuY0g0htmAU3ORPjW2Zrn3l2YATnlAOazcwUxIfpjiCHjYXhBTF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlhF7ZD6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlhF7ZD6"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso2316881b3a.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 12:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763498994; x=1764103794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzxfwG8xQUi/Xz+Sqt3OtY4mciIOO+SpdJw2IKS6+gY=;
        b=OlhF7ZD6Yd08MRasESMuLJumdOMdvzfq7bZ8XcQk1Gxy14TfHPsGpILWVDl2GU0k0q
         DT9P9C0PzZj8a6feH9bjcNJKVUY/dtTPs4hhpp6BNcVY9eSzhMNI5rmyEQiHJNirRK6K
         bn04qp5PH17Uo2rATIIzvWzn3cWTLuBPX9ooSw1I+S8kZh+wnVQQEGqwQ56O6L3q6Tku
         BWJbQcOEmq8nPknN18zyeuc9nEgl9T04N+Xp6eYZv1VQxFgmfgl1p0nyulurYBfmjanZ
         WM9boFikVhXco7bbMHygMnnVS+UdtZw1b/LfxIhLjx4v5CdGDJtjbND5Vd0YH1387HaR
         puZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763498994; x=1764103794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qzxfwG8xQUi/Xz+Sqt3OtY4mciIOO+SpdJw2IKS6+gY=;
        b=QMczwjOJeV9l5XA+A+WYq/an3I7EirQ7vVobuCp86RYcGvkKvLEQHsdPwSbrHa7wMM
         33YrGlorWWsSqJFjjLGTCUCLuEJIEpZa7yxqniBPufj04FLlrPXUNHIh+tL1zQGmisHW
         SRII/TxB1ScTvZmUwZtFatgDcnqMwXKP6iVwk7yX/Gey/Nm0AARCoe7noAFDaSPdDjfY
         Nt7VXelYBJxa1tRmOqksXKoEv7nldJp3i+3T3nS8lDf+XBiQ4j/aTP5aNbTXG73vmZa5
         ZUg/Ad2ih2RJM7ssHEmnaBP9VmSa9yAtvtNzQBohWyJULXuQAayd0swTaiQxGv/4OQO8
         XGkw==
X-Gm-Message-State: AOJu0Yy0nU7TChHRT9b5lCHibf9uog7IAF2Ui1UCx4FhF6BK5bTQexA9
	UvfJf94hKT+0VXrQQmmpvlViyNO3Ivx4Zdguf6FTLaxjk4ZR7fPXeUq6pCrdEw==
X-Gm-Gg: ASbGnct7K0aMVgSodP1LAzibHhUdZ/w8xixbVDPE09F2rCkpFwq3cV3Oy7zI16MEHFZ
	43pTPam8iEPabpPMBZn3T8tJUTzfsMkoyOeJwmT8mQ0YSqvCmi2Bmnbbs3ZbrQWI0jQWZWpDHz0
	3dNt+8ga2FL1w0fvGxbbR8vdPVl86oVWPs3iB9ARRNrM2pYzIOxWjYhkPmKPAdG6/OULAz5B4I4
	otOecNsSclsUG2094DNk5ry/LQa3myV9Cc/txh8TLVhX5pfs97I+oEPKdzMX2OyAA9FJbFsHDRc
	w7WI7fIYnBvKNSPknFPvY0WWIpXc9ouFTcOC27bZ5QhpPywGvxyqWwmMNbxxfNI4iBqr3rZexsr
	CCE3JS12K8377fYb7a9mN2gJP4g4zyEWTnwskGLCpFqBkESPmE5kstXi23Q7BheNBfD+e//UE9x
	y3MtaBos4oTGMniMksr4M+KMxVC5yU7iXUgHPhwB3uYF98ZpPVI6/BJPFWkkgcZQVYp/TMYkO7g
	ykS4iOAz8y6uEp8
X-Google-Smtp-Source: AGHT+IFgY/aHMWzXADNv5SHd9ONKMYbdSWcIYVtlbYJ3YyDrGUU9RrI9DtGOg3luCIEQk7OmvyKIuA==
X-Received: by 2002:a05:701b:270d:b0:11b:98e8:6274 with SMTP id a92af1059eb24-11b98e8669fmr3775670c88.13.1763498994260;
        Tue, 18 Nov 2025 12:49:54 -0800 (PST)
Received: from localhost.localdomain (gwmind.semfio.usp.br. [143.107.127.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm61892214eec.6.2025.11.18.12.49.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Nov 2025 12:49:53 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v5 0/2] repo: add --all to git-repo-info
Date: Tue, 18 Nov 2025 17:37:02 -0300
Message-ID: <20251118204929.43597-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This v5 addresses the issues pointed by Junio in the previous versions. They
are two small changes:

- `print_all_fields` now has the same signature `print_fields`

- now it uses `size_t` instead of `unsigned long` in a `for` loop

Lucas Seiki Oshiro (2):
  repo: factor out field printing to dedicated function
  repo: add --all to git-repo-info

 Documentation/git-repo.adoc |  6 ++--
 builtin/repo.c              | 63 ++++++++++++++++++++++++++-----------
 t/t1900-repo.sh             | 21 +++++++++++++
 3 files changed, 69 insertions(+), 21 deletions(-)

Range-diff against v4:
1:  fce09770b8 ! 1:  c792715fdd repo: factor out field printing to dedicated function
    @@ Commit message
         `print_field`, allowing it to be called by functions other than
         `print_fields`.
     
    +    Also change its use of quote_c_style() helper to output directly to
    +    the standard output stream, instead of taking a result in a strbuf
    +    and then printing it outselves.
    +
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
     
      ## builtin/repo.c ##
2:  ccdad86123 ! 2:  b309d0e13c repo: add --all to git-repo-info
    @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
      	return ret;
      }
      
    -+static void print_all_fields(struct repository *repo,
    -+			     enum output_format format)
    ++static int print_all_fields(struct repository *repo,
    ++			    enum output_format format)
     +{
     +	struct strbuf valbuf = STRBUF_INIT;
     +
    -+	for (unsigned long i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
    ++	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
     +		const struct field *field = &repo_info_fields[i];
     +
     +		strbuf_reset(&valbuf);
    @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
     +	}
     +
     +	strbuf_release(&valbuf);
    ++	return 0;
     +}
     +
      static int parse_format_cb(const struct option *opt,
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
      	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
      		die(_("unsupported output format"));
      
    -+	if (all_keys) {
    -+		if (argc)
    -+			die(_("--all and <key> cannot be used together"));
    +-	return print_fields(argc, argv, repo, format);
    ++	if (all_keys && argc)
    ++		die(_("--all and <key> cannot be used together"));
     +
    -+		print_all_fields(repo, format);
    -+		return 0;
    -+	}
    -+
    - 	return print_fields(argc, argv, repo, format);
    ++	if (all_keys)
    ++		return print_all_fields(repo, format);
    ++	else
    ++		return print_fields(argc, argv, repo, format);
      }
      
    + struct ref_stats {
     
      ## t/t1900-repo.sh ##
     @@ t/t1900-repo.sh: test_description='test git repo-info'
-- 
2.50.1 (Apple Git-155)

