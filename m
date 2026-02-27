Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174443783C5
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772228600; cv=none; b=dMOHYsS3uDBKcgS/oVYYrj/OqktJU/bem8DxDuVi5rQuAfJ5s40JK82Bc/I7Le9Hhf/uFa5ojIth4o9yXbsoPhLG3joz3f156ibOxijh8/oV2VGa4iMSHqYe6dkrCWyAHiU8g/y+KvgzyWOb+PNf01/bL86eQhvkolnFDyWvGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772228600; c=relaxed/simple;
	bh=gsp445g5YnA+IeX/Iyz6fnZLe6eeV9/CTuSacj9SGIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8TBv9ZAywbysqr8ZDC4nReCu4RcS2BY8LyX2e0qDGbEUrNIgreWYKukTvnhoRimkvuW22j8vu5v/2ADcLa0hCqBOFhCQS5D5s/Skc3/iMbWdjb2eJbP3FULoeJsCS0T5FY90SItgHyJK6gSSnjGGIjD/rQFZuFob6PQUv63HCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaQJa7X5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaQJa7X5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483703e4b08so22255865e9.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 13:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772228597; x=1772833397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKuySplScy/RLhYyPoZTBA/ZFH2ai0to+/1Fcefg+9w=;
        b=QaQJa7X5e/SzJ41f5ZtGpyKK1sv3ea2+0o+bwKYtaW59xk4ZqEtROQOT8TcsRUCMLR
         C+OiA9mgbYgoUw3YACBrmc7nl0m8iPzUlL/MnQPZsG/p6f1IVCzzjpqaf9tr+TfEnmNB
         l1bOprI0niuUD7+eSL04T95OGmSIkvNZnJUzTtVtg3TvcXJkB8AkB97h42tRzhb3rcI7
         bD48MmfvsALiEo1DavdrXmOFouJ9JUDHIYSQC/4g+41wYxIx+C0s9cD8u4NDkjsQAT3l
         dimf5lGDA633YjZCpwX3g4k60ILAIpit2hkjF4J7NxJys6aBP2D/D0Y3KKGoyVMqZXM3
         91tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772228597; x=1772833397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKuySplScy/RLhYyPoZTBA/ZFH2ai0to+/1Fcefg+9w=;
        b=eqcdnPPFmYvxLUNBo+X+JBnQ+6PqQKd+PqJzSp/Oz239N+segn1DcdtDZsFetM+a6B
         fxzqIDyTsiS92ZdndBVygI7kb4M/eELgoLLN0rRma8sH/KhGZZ6XgLDMjOhl7cK+rpoF
         3YJK3l4gWzVM8XGpSpRcWgoNW09bD5Q5L0HgQ980T0PQLsdccK64lXsLMW34Yn6kDjgC
         iOPK7Oq/CGC7IvLbH144j1s3M9ssLKXXZGaAdYW9q7P2s/piuH4xv2ADGJ1DCxJdxUpv
         mYtq/AwMBmZi1rF74at9v0q5lONg82BHDJegLBfqvO/gXy+GTejkDlhW9MKDtpDKECZ7
         +i+Q==
X-Gm-Message-State: AOJu0Yw3urHd9SAjZraE7miR2A/7/3P+TsIrgQzTbaySFqG5GQdlr9Xf
	XVwv+W3Q0XUYUTgzuNoa+FCm2tYNIndX58Z9feaCKw5VA9bGEVme866pv0TY4g==
X-Gm-Gg: ATEYQzwY0Gu2+ncjZhq3xu0LuXM4XI6Mn0T9LGJHnDflAJQquaUafeHtKbTnl3Sf9KM
	wCR0DeynrI+8tLiMaTXEIyCZXrNQyHX1zU6cU5NfO+fQsU3rI+s3nl7SMVR22sk/DKoDgRrZ4PZ
	9wX/zQ6XEGT5JneC9jDm8o1ZyHKVIkChWIcbn3dEv1td2gV+Xh3tCt4VN7nixdVq/uFbDepFsGS
	p7ZU5Hwuj3mzqRtynUo40JmEIXK5ejRL0iIbebRfc0hi6qYAOqMX+jNpdVs/fa4ixfJ6jE9Layu
	vc+cV5L6HruV8vLW1EWCPKQDjJnkIp/zG+nbRWSWU4AW9ZXpLumtsX1qBilkBAGtPinTa+s9hNF
	SeMMMSag2iTSdCqMUshkRFOx6SK5krxaNrdTC/4UsxryMP9/PpOhG7SOSBQNUvoskYNUCo0cTEI
	+yPCw/Zr77H+RpV7AGwhsjweNwvMou40AvPz2oTbdQaZPnYw==
X-Received: by 2002:a05:600c:1d21:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-483c992e3d8mr75189005e9.11.1772228596995;
        Fri, 27 Feb 2026 13:43:16 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750607sm241699525e9.10.2026.02.27.13.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 13:43:16 -0800 (PST)
Date: Fri, 27 Feb 2026 22:43:14 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v3 0/2] diff: handle ANSI escape codes in prefix when
 calculating diffstat width
Message-ID: <cover.1772226209.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772136203.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772136203.git.lorenzo.pegorari2002@gmail.com>

This patch aims to fix a bug where the calculation of the diffstat width
incorrectly uses the strlen() of line_prefix instead of its actual
display width.

This patch addresses the NEEDSWORK item added by ce8529b2 (diff: leave
NEEDWORK notes in show_stats() function, 2022-10-21).

Thanks Junio for you guidance.

V3 DIFF:
* Changed references from "UTF-8 char" to "ANSI escape codes"
* Removed mistakenly added empty file
* Slightly improved the test script comment

LorenzoPegorari (2):
  diff: handle ANSI escape codes in prefix when calculating diffstat
    width
  t4052: test for diffstat width when prefix contains ANSI escape codes

 diff.c                 | 12 ++++--------
 t/t4052-stat-output.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 8 deletions(-)

Range-diff against v2:
1:  9e8161a700 ! 1:  f75d6d779e diff: handle UTF-8 chars in prefix when calculating diffstat width
    @@ Metadata
     Author: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
     
      ## Commit message ##
    -    diff: handle UTF-8 chars in prefix when calculating diffstat width
    +    diff: handle ANSI escape codes in prefix when calculating diffstat width
     
         The diffstat width is calculated by taking the terminal width and
         incorrectly subtracting the `strlen()` of `line_prefix`, instead of the
    -    actual display width of `line_prefix`, which may contain UTF-8
    -    characters (e.g., ANSI-colored strings in `log --graph --stat`).
    +    actual display width of `line_prefix`, which may contain ANSI escape
    +    codes (e.g., ANSI-colored strings in `log --graph --stat`).
     
         Utilize the display width instead, obtained via `utf8_strnwidth()` with
         the flag `skip_ansi`.
    @@ diff.c: static void show_stats(struct diffstat_t *data, struct diff_options *opt
      	/*
     -	 * We have width = stat_width or term_columns() columns total.
     +	 * We have width = stat_width or term_columns() columns total minus the
    -+	 * length of line_prefix skipping UTF-8 chars to get the display width
    -+	 * (e.g., to skip ANSI-colored strings in "log --graph --stat").
    ++	 * length of line_prefix skipping ANSI escape codes to get the display
    ++	 * width (e.g., skip ANSI-colored strings in "log --graph --stat").
      	 * We want a maximum of min(max_len, stat_name_width) for the name part.
      	 * We want a maximum of min(max_change, stat_graph_width) for the +- part.
      	 * We also need 1 for " " and 4 + decimal_width(max_change)
2:  984fa10d72 ! 2:  1d55bff06e t4052: add test for diffstat width when prefix contains UTF-8 chars
    @@ Metadata
     Author: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
     
      ## Commit message ##
    -    t4052: add test for diffstat width when prefix contains UTF-8 chars
    +    t4052: test for diffstat width when prefix contains ANSI escape codes
     
         Add test checking the calculation of the diffstat display width when the
         `line_prefix`, which is text that goes before the diffstat, contains
    -    UTF-8 characters.
    +    ANSI escape codes.
     
         This situation happens, for example, when `git log --stat --graph` is
         executed:
         * `--stat` will create a diffstat for each commit
         * `--graph` will stuff `line_prefix` with the graph portion of the log,
    -      which contains UTF-8 characters (ANSI escape codes to color the text)
    +      which contains ANSI escape codes to color the text
     
         Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
     
    - ## t/b (new) ##
    -
      ## t/t4052-stat-output.sh ##
     @@ t/t4052-stat-output.sh: test_expect_success 'merge --stat respects COLUMNS with long name' '
      	test_cmp expect actual
      '
      
    -+# git-log will print only 1 commit containing a single branch graph and a diffstat.
    ++# We want git-log to print only 1 commit containing a single branch graph and a
    ++# diffstat (the diffstat display width, when not manually set through the
    ++# option "--stat-width", will be automatically calculated).
     +# The diffstat will be only one file, with a placeholder FILENAME, that, with
     +# enough terminal display width, will contain the following line:
     +#     "<RED>|<RESET>  ${FILENAME} | 0"
    @@ t/t4052-stat-output.sh: test_expect_success 'merge --stat respects COLUMNS with
     +# FILENAME in the diffstat will not be shortened, we take the FILENAME length
     +# and add 9 to it.
     +# To check if the diffstat width, when the line_prefix (the "<RED>|<RESET>" of
    -+# the graph) contains UTF-8 characters (the ANSI escape codes), is calculated
    -+# correctly, we:
    ++# the graph) contains ANSI escape codes (the ANSI escape codes to color the
    ++# text), is calculated correctly, we:
     +#     1. check if it contains the line defined before when using MIN_TERM_WIDTH
     +#     2. check if it contains the line defined before, but with the FILENAME
     +#        shortened by only one character, when using MIN_TERM_WIDTH - 1
     +
    -+test_expect_success 'diffstat where line_prefix contains UTF-8 chars is correct width' '
    ++test_expect_success 'diffstat where line_prefix contains ANSI escape codes is correct width' '
     +	FILENAME="placeholder-text-placeholder-text" &&
     +	FILENAME_TRIMMED="...eholder-text-placeholder-text" &&
     +	MIN_TERM_WIDTH=$((${#FILENAME} + 9)) &&
-- 
2.43.0

