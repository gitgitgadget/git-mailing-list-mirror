Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D0230FF30
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773479783; cv=none; b=XA1xaNtXb7hfb/FBQgIDwLGje08gpKlzTlm5huPqZTjZRCtvSvONFsicEpKf1YfGV33/bgdauhmMLxnF4XO50kM/LPnVuQcIlvNzSgMSIMwKX25lqcbHuPIBuq+buI1TMDwGBHWYFsYGNq/TSAxE2W7sH1YecF8HGppGbGzSEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773479783; c=relaxed/simple;
	bh=nXBUjrPe4uxq3tp1JqyG8E+2CzUx5+hDb5UkrD+NSuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ez1rD0tkI7U2Vpi1wptaTXSHzl8bNHjoYdzbG2T4AMUUdEi11utEJolniI9ejSDy5XKvrcEamcshVhprV/BVyK+Aacv3gzV4UM9OzUp7mM1OSzceDxd+69QqR8xZSa6S50QhR93G+PAES+qZidHNyr707m1qmmWXOvZ1YO9Se+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nebz0onD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nebz0onD"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38a23dd61c1so27204761fa.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773479780; x=1774084580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPouXQhBAoOj4unxJlVePUxT2Jj2sb2lP9PLT0dd5cs=;
        b=nebz0onD4YOa/pQsOqpi25tczWsYbCfj1ec4DUquRFdbiWxcmL5hAZGtJqDQ/+lF0I
         F6DKz+cS2hfdP9DVZmQ+z08cnIfxoOdnQHVEe0D0Rb8R0v3aUb6nlN+Qiiucu/RpWQ8o
         ZJt6nBMnsXnloSZUOxvIhkTkx5STLnDJj7gxVb2AllscJOIsVdWWg3MbDlHZHz0AGTSP
         lawOQte/nMdl6ExUSZVP5bjvizQLtvHSgeHFhkEc2J1FNWAsFSdN7V8B+ujqrdNiTHig
         6bYGpE1Y7pnsWbsstmbuC8yfYzqTW9Mvhl6/NRQj8EuSIB5FwmcVAOfBmF0sbalZLKv+
         tdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773479780; x=1774084580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sPouXQhBAoOj4unxJlVePUxT2Jj2sb2lP9PLT0dd5cs=;
        b=GXK4KjB8daUUzxe9BzGcXRkIM0CpdKFLMfqu9whdxzJ0Z5y1Jed75q6Lxvt1myUuRC
         NvjJ+yNAPA2AmH2I7Syklic6zKSVCCI3tLhAqeaSOFv60zW1FETRV8q3nR7laRoz3rN9
         M3+UMX/jgOL47g8JJ8NqTpZWtqEcNcJnBnd89e55lPJfdnIRgVb3ccEnz85p06L17WW4
         n4y96xxTecNYZLZx7aTCiPJqNdJwd8pP3s5UFyvZT2pHo0QGoXSLlS2XZ21SoY0hhBNa
         97I6mQxiujWehg7ywdHBVwwD4Vas26NIsX6QR4moveudO4xXNvBAt8shpeAp4Rk+t5/0
         WpXg==
X-Gm-Message-State: AOJu0YzPkTK+D4vlVdj+igGZyTx2ZI22Cpwrvbas07HOoiWo1U2Ve7pP
	UQ3zAkIQxz1G+CSc1E6lsj2KbTDg4mVOlxEryaA6SmxcZtgFDMcsAkpW
X-Gm-Gg: ATEYQzy1EBq3salOHXG6yQX4ZO31v88IGbuG/B91C2wVIGrg5c7aGaOtXDxanOcI736
	qifvwQ9hQsJ5ecvxdTGHmHVIV0YQZYWlzZVzuP0oUyRcScgXd/WRA7u5xyPGg7NCXWAd95MuWDa
	GTW9Bv8rm9ZSHIWcw/ev5AqIPZ9S3EE942YA+lgFN+5M++3CM2mbJ1KLC/hcdEmqJoj3KrVs1vm
	z2h0SsngSJeg1aRhskBaOUX/8GRSixuS0Mvnt3ukJWuUMG2G/JNXib341jLLXq5ptvpss49Cwkg
	Whf4lREydXIsazyDbxeWcSfk6ZLhytqZMS/6Qid3Aj3szqPpzwfpiUHE0H4ztwHHGj+1Cn4T6pu
	HkucS3t2a48Wt6M41jnt3Qi7UFj6/zBHw1N+HhfSCLUnhyAG2V9LKcWWHVRXivH4X2RF4ETYvHO
	KIbftfsvQFMAXjlGEkz+gMg5aqIFAdmcSXbyIdP8XYqgEtpjaGx1dq/9MVid5cc2dzVoPRD6wUC
	q2/F+63cz8UKLXrwyPgh4ZdKaU=
X-Received: by 2002:a05:651c:546:b0:38a:8c44:7593 with SMTP id 38308e7fff4ca-38a8c4476c7mr20971011fa.21.1773479779545;
        Sat, 14 Mar 2026 02:16:19 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ed41sm20546791fa.25.2026.03.14.02.16.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Mar 2026 02:16:19 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Sat, 14 Mar 2026 10:16:18 +0100
Message-ID: <20260314091618.88072-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <pull.2239.git.git.1773479526823.gitgitgadget@gmail.com>
References: <pull.2239.git.git.1773479526823.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Harald Nordgren (2):
>>   refactor format_branch_comparison in preparation
>>   status: show comparison with push remote tracking branch
>>
>>  remote.c                 | 183 ++++++++++++++++++++-------
>>  t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 403 insertions(+), 42 deletions(-)
>>
>>
>> base-commit: d529f3a197364881746f558e5652f0236131eb86
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v20
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v20
>> Pull-Request: https://github.com/git/git/pull/2138
>>
>> Range-diff vs v19:
>>
>>  1:  451d7a4986 ! 1:  bb3e00863b refactor format_branch_comparison in preparation
>>      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
>>        		if (advice_enabled(ADVICE_STATUS_HINTS))
>>        			strbuf_addstr(sb,
>>        				_("  (use \"git pull\" to update your local branch)\n"));
>>      -@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
>>      - 			       "and have %d and %d different commits each, "
>>      - 			       "respectively.\n",
>>      - 			   ours + theirs),
>>      + 	} else {
>>      + 		strbuf_addf(sb,
>>      +-			Q_("Your branch and '%s' have diverged,\n"
>>      +-			       "and have %d and %d different commit each, "
>>      +-			       "respectively.\n",
>>      +-			   "Your branch and '%s' have diverged,\n"
>>      +-			       "and have %d and %d different commits each, "
>>      +-			       "respectively.\n",
>>      +-			   ours + theirs),
>>       -			base, ours, theirs);
>>      ++			"Your branch and '%s' have diverged,\n"
>>      ++			       "and have %d and %d different commits each, respectively.\n",
>>       +			branch_name, ours, theirs);
>>        		if (show_divergence_advice &&
>>        		    advice_enabled(ADVICE_STATUS_HINTS))
>
> Could you not mix the ours+theirs thing into the same step?  Either
> make it a standalone patch to clean up before or after your main 2
> patches, or leave it totally outside the series and send it after
> this series settles.

Making a change that was left out of https://lore.kernel.org/git/xmqqzf6lqs9w.fsf@gitster.g/

Harald
