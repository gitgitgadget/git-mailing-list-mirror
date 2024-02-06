Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65401BF37
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256254; cv=none; b=hGjsMvzoc4SlcC3VUBI/33USDX3vHstQT9oQ7mHD0Bs7vZT2E6Kqnp/pkkQ1kuhskNa+xTo0UhV+FDLUsCvnrYa0UO5QSWVccpa1HxYzk2Ut/JeIWxBupWzY6jnyvhzcM9xJGHjc9QtWDL8fTbowdeFfZIK/ESO5Au51M04AYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256254; c=relaxed/simple;
	bh=N+lhkUYX+ibAyiAiKKcpJ8+fwTaEnVT199o29zMyKys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPF7GTQdGvjZx+2aFfGXWm6nMDNNIfvuHzf/LS3wwTodJQwo4k30yoi6tKuc6tvwOyvRqZkTzV9y/7CizEYSUTPQzvdaPtsGU3ypGfSRtyquCqGdO6j9az/29r036MLwebSFxvK6Nq7O7Oyz8e6SsmLj7fSShJSIcv56miOBghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Keph1np7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Keph1np7"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so479b3a.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 13:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707256252; x=1707861052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iK0kg8AT6BboYTyOgGtw7VMuRBV10GcaVsu3gzfdHg=;
        b=Keph1np7f3X8Dy16BAknOzP4HABWuCrx9jyVn9IYBOIWWA6At7CtYLBpCTRAq56Byr
         vV1Cjg1saINTNZBQh5nZGRGyQaCVU0wXc0AJrvTx75BSXZmdUcXpnjSbBb8meNT+Wrij
         2SU2+GkHAHCVgVwB7MJhXTqUACNw5y5egEYS0mgjayejLSBFBXLaycBLFlWBCyjbpLiW
         sxrKLQ8SMkV98cjRdp5Cd6oZzzlJtTEr7j5rXhGA3BK0pOUaMvda4cCU3Qq/Mb6p8B1C
         Gn5V1QlREUwm7P7PGQxX16RPnFNmeY9hqdg+1tM+3ux4khjTHjN6d4kMBly5KQrmBkcy
         9/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256252; x=1707861052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iK0kg8AT6BboYTyOgGtw7VMuRBV10GcaVsu3gzfdHg=;
        b=pvy2paYgN3vAnNIM/Te2cyffNRQsx07MgAkKo43xshmegolBFzSk4eiH3TeQG7l+AF
         RAbIxbWSwPvMoUKHtkNlo6bpjpVTQBuCU3+uk28GtyHn+Lh57U4F/592WdSKmnkbXMYH
         sx1t1xN1sCrsluAyO17RGwWahbUgtqS+bC+z/bGa721l/D9I5V+yIgrkNqO10lZp+m6R
         vBtgcHinDeJTJM9BRpFAphXGtLvpI3WA3y648MzfUXzZ9MY2gvy+PLTowGUmtInND1FK
         KJH0i2VszO/jyXeUrjd9NWIG/J/ruVmNAfvgv4w2ooaOkNOiNlfQx3Wz2GvxjS22dBhv
         RgOg==
X-Gm-Message-State: AOJu0YxsiXQogzJLp/qRXxzzTkL/iyH71TZK2mZ6HMYAmKDxmUz3Rft+
	q9ogQmVB1roYAlL0obeWBixfRWlET1yFKcAiVwzTbWld1BSD/bFQVOQSxnYJ
X-Google-Smtp-Source: AGHT+IEFbdPfIs56yiCrikp4+RmE7K8ge3KVwu/msaMEAZHN5TQ3jHHqjTVRQzoZ0jY7Muht00XJHw==
X-Received: by 2002:a05:6a00:994:b0:6df:f8db:44db with SMTP id u20-20020a056a00099400b006dff8db44dbmr970498pfg.16.1707256252103;
        Tue, 06 Feb 2024 13:50:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXiybRTnTMGpzgp2GDS20k1eYzaZDf9bk3RcEEbBgpQRsbg+7Mtai2OUng/TrMsij+dQDsVtsFHW21LjB365x2/eAEmViRTe7vByzjl0TvdZMaC
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id it9-20020a056a00458900b006e03b413056sm2462384pfb.188.2024.02.06.13.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:50:51 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 43EBC52029D; Tue,  6 Feb 2024 12:50:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v6 0/7] completion: improvements for git-bisect
Date: Tue,  6 Feb 2024 12:50:41 -0900
Message-ID: <20240206215048.488344-1-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206020930.312164-1-britton.kerin@gmail.com>
References: <20240206020930.312164-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relative to v5 this makes the following actual changes:

  * Treat COMPREPLY as an array on assignment and test, rather than
    relying on the bash mechanism of implicitly acting on the first
    element of the array.

  * Whitespace fixes.

The commit message about __git_complete_log_opts has also been changed
to indicate that COMPREPLY is emptied and why, and a broken
Signed-off-by line fixed.

Britton Leo Kerin (7):
  completion: tests: always use 'master' for default initial branch name
  completion: bisect: complete bad, new, old, and help subcommands
  completion: bisect: complete custom terms and related options
  completion: bisect: complete missing --first-parent and --no-checkout
    options
  completion: new function __git_complete_log_opts
  completion: bisect: complete log opts for visualize subcommand
  completion: bisect: recognize but do not complete view subcommand

 contrib/completion/git-completion.bash |  65 ++++++++++--
 t/t9902-completion.sh                  | 141 +++++++++++++++++++++++++
 2 files changed, 199 insertions(+), 7 deletions(-)

Range-diff against v5:
1:  71b73de914 = 1:  71b73de914 completion: tests: always use 'master' for default initial branch name
2:  3a478a7a08 ! 2:  7bc45bfc13 completion: bisect: complete bad, new, old, and help subcommands
    @@ Commit message
         such that the commands and their possible ref arguments are completed.
         Add tests.

    -    Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.c
    +    Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>

      ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: _git_bisect ()
3:  fab7159cf4 ! 3:  be925327d3 completion: bisect: complete custom terms and related options
    @@ t/t9902-completion.sh: test_expect_success 'git-bisect - when bisecting all subc
      		reset Z
      		visualize Z
     @@ t/t9902-completion.sh: test_expect_success 'git-bisect - when bisecting all subcommands are candidates'
    - 		EOF
      	)
      '
    +
     +test_expect_success 'git-bisect - options to terms subcommand are candidates' '
     +	(
     +		cd git-bisect &&
    @@ t/t9902-completion.sh: test_expect_success 'git-bisect - when bisecting all subc
     +	)
     +'
     +
    -
      test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
      	test_completion "git checkout " <<-\EOF
    + 	HEAD Z
4:  73f3343b94 = 4:  c3141921e5 completion: bisect: complete missing --first-parent and --no-checkout options
5:  a20846bbd3 ! 5:  092bfba6b1 completion: new function __git_complete_log_opts
    @@ Commit message
         completion: new function __git_complete_log_opts

         The options accepted by git-log are also accepted by at least one other
    -    command (git-bisect).  Factor the common option completion code into
    -    a new function and use it from _git_log.
    +    command (git-bisect).  Factor the common option completion code into a
    +    new function and use it from _git_log.  The new function leaves
    +    COMPREPLY empty if no option candidates are found, so that callers can
    +    safely check it to determine if completion for other arguments should be
    +    attempted.

         Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>

    @@ contrib/completion/git-completion.bash: __git_diff_merges_opts="off none on firs
      {
     -	__git_has_doubledash && return
     -	__git_find_repo_path
    -+        COMPREPLY=""
    ++	COMPREPLY=()

      	local merge=""
      	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
    @@ contrib/completion/git-completion.bash: _git_log ()
     +	__git_find_repo_path
     +
     +	__git_complete_log_opts
    -+	[ -z "$COMPREPLY" ] || return
    ++        [ ${#COMPREPLY[@]} -eq 0 ] || return
     +
      	__git_complete_revlist
      }
6:  fe5545c9a3 ! 6:  9afd4d4e0f completion: bisect: complete log opts for visualize subcommand
    @@ t/t9902-completion.sh: test_expect_success 'git-bisect - options to terms subcom
     +		EOF
     +	)
     +'
    -
    ++
      test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
      	test_completion "git checkout " <<-\EOF
    + 	HEAD Z
7:  c9102ac532 = 7:  dba916b31c completion: bisect: recognize but do not complete view subcommand
--
2.43.0

