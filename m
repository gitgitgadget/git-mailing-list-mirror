Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3B4DA526
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812400; cv=none; b=ntwYPLcF3qdSumhtg9ETTG3DJ7cskeCNeeZ/Xfgq7Z/zWMxb4xZtoS+fZK+o35H0Aj2xQZiOcJggqssTwb603ORfBINbDgm1455FP73mGV4aRh5a8lWv1LL8uZw2LSY3V5F0YKTEwe0v/aUpqPg7FGz7/zxNNc1UxRb5g6NA/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812400; c=relaxed/simple;
	bh=BOXBMGfQonIy0rhOycrEK9qf0EJ0/R9LJMCNFop5NlQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RoznUAEFG9hQM2lHKvPPMcAOzOW2O+6OnYkxUdK9eAKk17vYhxx7cm5J2YAhPUCpBS37WVrqPvAxrClRd+D7PeB4A3TsklngUDJpHQpwphQJnW+YvCWEF25B17+LD0N1SnF3CGIhLmQbaWb/aWK/AQAFX+28VSZqEdJB+kIB9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3ubqSOt; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3ubqSOt"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39d4c864bfbso5898261fa.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784812392; x=1785417192; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=deBvTHsOFWdZPf0BW0g4cHNniqASxhQMQ2kmT+cqNfI=;
        b=n3ubqSOt+BUFOwL3sEKhLyC7M3uFoD0/DkXbJPCI9X+MkzfwHT3dJUdgmdzF6LcBAX
         0q5hBdMSqKgNlM9UrISdLH/scknlGm1vvZCBr7uyuBZrx7VQV3mmkA2Mkql/18WrEqtJ
         l31YX+Vsnz6ImHaTMutesF1zAIWdVJMOz+kRZU2MXwWBHcW2+LZqtP0gv0QhoUN5OngB
         QBWjVWyE+CCO0Hmt2tR5N1SxZg/uAMDmnaqwuMfg0H8KLEUFwb/0f+MBEdXjA8NK6+TX
         aQODhnhWZ74pEadeJkRLdFFVbJiKNH3WuOshlDajbrPkl90O9fUsQ+jFcuXItvIARm/P
         UK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784812392; x=1785417192;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=deBvTHsOFWdZPf0BW0g4cHNniqASxhQMQ2kmT+cqNfI=;
        b=PObe34Haa0WltvqsWZNvT/3aIZV2PpFX/DO0Np8amZF2t40obNoTgXSNkJ6xHBziuo
         OxHuax4jzFHxk8UQJOWrigKd0vC86mKQvQ9TBlzZXaHYQ58qbCN3pK96Tea1bbb/nCz5
         UTRGSm39OPdk6Bho51YUY8ql6RRFrf+O6fIrY0duaRawOLS+wwR0NJysNGRVXsCAGV3r
         9ujkwidE//xAq/Fkg+QD12m3bTP0Ah6N1XOn/BSwOU4btFgQNdg6f9ymFVqFxRCrx9Dh
         Z94yiFnTWE/LnVFYTiA7oClv1tQktCEgijC3K54S2zIURClVzfsj+Fp04zUCGtPwl9F2
         g5aQ==
X-Gm-Message-State: AOJu0YzOTZW8oSC7gvVyBn7ncfxhDFVaM62WMg0z+P8weT0LczWK3shh
	vAhRVytcFha4Bfj3IljEOG8s2+W5pzydOpSnFIolSVJzqi3lLDIiJ4hWH6DLIVab
X-Gm-Gg: AR+sD10e/rt1ejz+h/UwAPmAyzVSuNgeJJZVReS7j2lSXF7Cs1+dTJnMH2tm/Qo0B6n
	HWXg2Cl8eFiBdLU3jYeHZHPcBeMTh+TBcR6cCy3ViZXnwUD4yJHah/kPSNvV/OZ7dW3QBBPFJ67
	X47wTWp+L5COJ/rc/NvrHuU1CuE0t0we91XJOIZjQBVqxsfJTd9qY7QidpAvqW/D2GolT1N4WfB
	n+9DHHN1oBgrPwryGTgGtp+2Djo10lBzlfZs2UaRtAlQY3ayf3jfuv/FsHSGTr3XRtF572qnf7z
	xZCH4W3TaoMWinnBJF2HV6pyvt17FvgyB55s9aNUhZCTFOmxAWgn6tVUJJ5276GOfC/j0YCXs4C
	fG4v4KngiWgCj50N39zvP9+ncG4nAH119SGaCI1Dl0XlHzjzYBoUOz1vuaUIGEYszu2pdogu/3C
	wAamSlpPnJw68CEBw=
X-Received: by 2002:a05:6512:3e01:b0:5ae:ba28:a56e with SMTP id 2adb3069b0e04-5b2b2f699d3mr644194e87.35.1784812392089;
        Thu, 23 Jul 2026 06:13:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.103.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9f52fa7sm1009765e87.80.2026.07.23.06.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 06:13:11 -0700 (PDT)
Message-Id: <pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 13:13:08 +0000
Subject: [PATCH v2 0/2] mv: report missing destination leading directory
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>

Changes since v1:

 * altered the error message to include both source and destination as
   suggested by Ben Knoble

Lucas Zamboni Orioli (2):
  mv: name both source and destination when rename fails
  mv: check for missing destination directory before renaming

 builtin/mv.c  | 23 ++++++++++++++++++++++-
 t/t7001-mv.sh | 14 ++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)


base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2356%2FZamboniL%2Fmv-detect-non-existing-target-folder-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2356/ZamboniL/mv-detect-non-existing-target-folder-v2
Pull-Request: https://github.com/git/git/pull/2356

Range-diff vs v1:

 -:  ---------- > 1:  0d67da588b mv: name both source and destination when rename fails
 1:  692f44456f ! 2:  1a790e0016 mv: report missing destination leading directory
     @@ Metadata
      Author: Lucas Zamboni Orioli <lucaszam0@gmail.com>
      
       ## Commit message ##
     -    mv: report missing destination leading directory
     +    mv: check for missing destination directory before renaming
      
     -    When moving a file to a destination whose leading directory does not
     -    exist, "git mv" fails at the rename(2) syscall with ENOENT. Because
     -    the error is reported via die_errno() using only the source path:
     +    Moving a file into a directory that does not exist fails at rename(2)
     +    with ENOENT. The checking phase already rejects a missing destination
     +    directory when the destination ends in a slash, but a destination that
     +    names a file inside a non-existent directory is not caught and only
     +    fails later at the syscall. As a consequence "git mv -n" does not
     +    detect the problem either: the dry run never reaches rename(2) and
     +    reports a move that would not actually succeed.
      
     -        fatal: renaming 'src' failed: No such file or directory
     +    Detect this during the checking phase. For entries that will be renamed
     +    on disk, stat the destination's leading directory and, if it is
     +    missing, fail with the existing "destination directory does not exist"
     +    message. Guard the check with the same condition under which rename(2)
     +    is invoked, so that directory moves, whose child entries are expanded
     +    to paths under a not-yet-created directory, and sparse or out-of-cone
     +    destinations, which are not written to the worktree, are not flagged
     +    incorrectly.
      
     -    the message misleadingly blames the source, even though it is the
     -    destination's parent directory that is missing. A user who runs
     +    This is a best-effort diagnostic rather than a guarantee: the
     +    destination directory can still disappear between the check and the
     +    rename(2). It fixes the common case and, unlike the syscall path,
     +    lets "git mv -n" report the failure.
      
     -        git mv a/file b/does-not-exist/file
     -
     -    is told the problem is with 'a/file', which exists, giving no hint
     -    that 'b/does-not-exist/' needs to be created first.
     -
     -    The checking phase already rejects a missing destination directory
     -    when the destination ends in a slash, but a destination that names a
     -    file inside a non-existent directory is not caught and only fails
     -    later at rename(2). As a result "git mv -n" also fails to detect the
     -    problem, since the dry run never reaches the syscall and reports a
     -    move that would not actually succeed.
     -
     -    Detect this during the checking phase instead: for entries that will
     -    be renamed on disk, stat the destination's leading directory and, if
     -    it is missing, fail with the existing "destination directory does not
     -    exist" message. Guard the check with the same condition under which
     -    rename(2) is invoked so that directory moves, whose child entries are
     -    expanded to paths under a not-yet-created directory, and sparse or
     -    out-of-cone destinations, which are not written to the worktree, are
     -    not flagged incorrectly.
     -
     -    This gives a clear message and lets "git mv -n" report the failure.
     +    Add tests covering both the error path and the dry-run detection.
      
          Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
      

-- 
gitgitgadget
