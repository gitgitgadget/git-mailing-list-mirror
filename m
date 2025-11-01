Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA711258EEF
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762034259; cv=none; b=I8fT6VQ0VpED7NckvNzcZbgetIcTrlg0w9fwVMnbaAbduRorQS6fKeeJ5nM1w88tBQ9HMIpDhhGL8a1nSJ8/AmqBWdmBv/U3R+s4suXPmVJ/hJFtCZd8+ljcp9ZIn/Sy5lUbG/0UgbWUbpJWbyBhKLdBLPGyulEeJmBeqO/Cfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762034259; c=relaxed/simple;
	bh=o7xFHPLWUbS06tcBlRSLsl4QAAIdQfM4bE9xhr1Cit4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mwABKauWvhRdM4ZHgVvMxcQhJq2ZJ9UHJD223PhVFruNVJ8+FVzb8qU00FdqqOh0PGAo0QDVtom8NT0zjUTy8MuKKCKJpp1B4BC5/hhAInFUIFcrCzGG1Z149wcZRjQ8/dxOAQWDmWAxi0GpP9EGZoUYfcaL3QGa2ibjEgZl3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2qfQcij; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2qfQcij"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93e7e87c21bso329458739f.3
        for <git@vger.kernel.org>; Sat, 01 Nov 2025 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762034256; x=1762639056; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6Y4JBgQEw7Hs5biOMYp0j1i9X/QOxV3R6G5c0PLcgM=;
        b=N2qfQcij6VljTE5eLzC/zk32SqfzHSML5Txb+6P4U4pqlUOoF8yioLdN7kwBqlG9qh
         SFyP+zWE6aSKpzMAB48IVUoKzRXZSfmHplnDxrVqnZnrtzGAvCSHCYsjlvLdBTiGENsw
         Rmf4ugJ8VuXtibRAGuU1fqS+auoj7M1llHNjSwHKwoMbKPAVSWkBtaC6NtcgCbG9ih1H
         mgRHb5CdVnDycC1T70cHew4KB4btOYJO6mSQFWFjRon/G/mS8LhWU3EaAsj7L//5dAM4
         YpvB1Gclr/1hi1XM4BGocCIbazesRRnmsHdaLeqQzZuPVcdnVSLXAYxyzW6IXbHYwC3c
         7V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762034256; x=1762639056;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6Y4JBgQEw7Hs5biOMYp0j1i9X/QOxV3R6G5c0PLcgM=;
        b=XXfJOf0zuR8IaHg2xZ+cMsv+tWLjuz6fM/czFvocUxo4mREnst2OuapCM3yXJNbTWs
         AHEYeqM1rMir6LQ0rTcsSFOFU7dl5yfSZzx9Ml3XzJu/4j9KLqnpQRZEuhm3AO8kanuB
         PLz1mB17PcLlhwu8JpBHIzhf77AHZXORjOZYywxj+8V0MdnFC8FZP2gxDS/Dn7w3qNBT
         YjoIn9FOkJV9WoslP/dE0X/dFMyLHTyTnoe7K30JjjFSyGrBDA6j1O4TjizUqwaOOfb+
         lH4biDl9xNV4/1IynHLIGZfLt7D8THeNN6nUYe2AI6SWjK0G4Cv9mU0p3ioML1y6g4mQ
         S7Pg==
X-Gm-Message-State: AOJu0YwN/uLGFfzLi607sfwQbjytFsZt9NIdWvxIVMHsJHDuV0NcRU60
	zgBzxS4IFWY5UVbnmt3tYbG5HZFryn5Kf0Mm5ivaw1h7tLavou68eTHGRlaNtQ==
X-Gm-Gg: ASbGncsTCUzdljn9PaCG0Ssekrshmp+aR4eYeMdMaV0xaogBRUOg03pRuC1WYmPqma+
	eWyU7lChkI7p423Ad1/wi9ernxyPT9tep/RIM0jtP+eBXyWcU44fkjU7l8CjHQZTbAUxvH8siW0
	bURh2nDDzNQovtYzjJVSHQnf221xv0mNHVmB2BlzMbF4ooWLcE9evXf/HJkbO3ESybE+7UlzGd9
	a1gdsjQ3SNaHQE6anJRXf3+Z0EW9Ymy10k4hDWx9t4qJsD4kRzW47453uH4tuDRjzizXSqEkqIa
	tCWL8tGN+afGeNxa7TKAC7Sc1E2AAqhPXAIa42iMF4FRPhjuQVMFCdisFsOrTMNn+sa3gECvGR3
	/77HtUugbvgWhs38JbVpYeWaAh/tMW0AK6npwJpnD+7OkofenyW++vyWGicuOisG9FAWWZ4MGWZ
	Z60YSxbCAkjrMgwpq9zfdHw0A=
X-Google-Smtp-Source: AGHT+IH+irbzFUCRB2uMO0ll3S0BIacs5bs2jwUfLvVPyX0tv7up4beR4YPtgWpRYp3/uzBMPIJzGw==
X-Received: by 2002:a05:6602:158f:b0:940:ecfa:811f with SMTP id ca18e2360f4ac-9482297d545mr1328573839f.8.1762034255966;
        Sat, 01 Nov 2025 14:57:35 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.96])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94827db991bsm185542639f.20.2025.11.01.14.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 14:57:34 -0700 (PDT)
Message-Id: <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
In-Reply-To: <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
References: <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Nov 2025 21:57:30 +0000
Subject: [PATCH v4 0/2] blame: make diff algorithm configurable
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>

Changes since v3:

 * fix resetting of diff algorithm by adding XDF_NEED_MINIMAL to
   XDF_DIFF_ALGORITHM_MASK
 * restore --no-minimal support
 * fix typo in description of --minimal option
 * remove the 'for now' in test description
 * remove piping in tests
 * pass configuration variables to the blame command directly instead of
   calling 'git config'

Antonin Delpeuch (2):
  xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
  blame: make diff algorithm configurable

 Documentation/diff-algorithm-option.adoc |  20 +++
 Documentation/diff-options.adoc          |  21 +--
 Documentation/git-blame.adoc             |   2 +
 builtin/blame.c                          |  52 +++++-
 diff.c                                   |   2 -
 merge-ort.c                              |   2 -
 t/meson.build                            |   1 +
 t/t8015-blame-diff-algorithm.sh          | 203 +++++++++++++++++++++++
 xdiff/xdiff.h                            |   2 +-
 9 files changed, 279 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/diff-algorithm-option.adoc
 create mode 100755 t/t8015-blame-diff-algorithm.sh


base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2075%2Fwetneb%2Fblame_respects_diff_algorithm-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2075/wetneb/blame_respects_diff_algorithm-v4
Pull-Request: https://github.com/git/git/pull/2075

Range-diff vs v3:

 -:  ---------- > 1:  e81a5d2bd2 xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
 1:  b8bdb03516 ! 2:  920a6f3acb blame: make diff algorithm configurable
     @@ builtin/blame.c: static int blame_move_callback(const struct option *option, con
      +{
      +	int *opt = option->value;
      +
     -+	BUG_ON_OPT_NEG(unset);
      +	BUG_ON_OPT_ARG(arg);
      +
      +	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
     -+	*opt |= XDF_NEED_MINIMAL;
     ++	if (!unset)
     ++		*opt |= XDF_NEED_MINIMAL;
      +
      +	return 0;
      +}
     @@ builtin/blame.c: int cmd_blame(int argc,
       		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
      -		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
      +		OPT_CALLBACK_F(0, "minimal", &xdl_opts, NULL,
     -+			       N_("spend extra cycles to find better match"),
     -+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
     -+			       blame_diff_algorithm_minimal),
     ++			       N_("spend extra cycles to find a better match"),
     ++			       PARSE_OPT_NOARG, blame_diff_algorithm_minimal),
       		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("use revisions from <file> instead of calling git-rev-list")),
       		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("use <file>'s contents as the final image")),
       		OPT_CALLBACK_F('C', NULL, &opt, N_("score"), N_("find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback),
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	GIT_AUTHOR_NAME=Commit_2 git commit -m Commit_2
      +'
      +
     -+test_expect_success 'blame uses Myers diff algorithm by default for now' '
     ++test_expect_success 'blame uses Myers diff algorithm by default' '
      +	cat >expected <<-\EOF &&
      +	Commit_2 int g(size_t u)
      +	Commit_1 {
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_1 }
      +	EOF
      +
     -+
     -+	git blame file.c | \
     -+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
     -+		sed -e "s/ *$//g" > actual &&
     ++	git blame file.c > output &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
     ++	sed -e "s/ *$//g" without_varying_parts > actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_2 }
      +	EOF
      +
     -+	git blame file.c --diff-algorithm histogram | \
     -+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
     -+		sed -e "s/ *$//g" > actual &&
     ++	git blame file.c --diff-algorithm histogram > output &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
     ++	sed -e "s/ *$//g" without_varying_parts > actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_2 }
      +	EOF
      +
     -+	git config diff.algorithm histogram &&
     -+	git blame file.c | \
     -+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
     -+		sed -e "s/ *$//g" > actual &&
     ++	git -c diff.algorithm=histogram blame file.c > output &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
     ++	sed -e "s/ *$//g" without_varying_parts > actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_2 }
      +	EOF
      +
     -+	git config diff.algorithm myers &&
     -+	git blame file.c --diff-algorithm histogram | \
     -+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
     -+		sed -e "s/ *$//g" > actual &&
     ++	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
     ++	sed -e "s/ *$//g" without_varying_parts > actual &&
      +	test_cmp expected actual
      +'
     ++
      +test_expect_success 'blame honors --minimal option' '
      +	cat >expected <<-\EOF &&
      +	Commit_1 x
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_2 G
      +	EOF
      +
     -+	git blame file.txt --minimal | \
     -+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" > actual &&
     ++	git blame file.txt --minimal > output &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	Commit_2 G
      +	EOF
      +
     -+	git blame file.txt --minimal --diff-algorithm myers | \
     -+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" > actual &&
     ++	git blame file.txt --minimal --diff-algorithm myers > output &&
     ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > actual &&
      +	test_cmp expected actual
      +'
      +
     -+
      +test_done

-- 
gitgitgadget
