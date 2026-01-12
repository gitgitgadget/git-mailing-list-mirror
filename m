Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B53168E3
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249590; cv=none; b=E6BFpXzsGn7+uwRm9wgxpBpJzfy3XLQfSFPyx41iwvEMvFIFsEKF1dLpy00h43jcHJL+cLQx/cq+5GunhffRzY3q8UyEHGdihWeLqYLDWjS7JJ5W/jPB1mp8o+/v6CQ0DjN/2JZiujn3dg0TSTPv9Le7Zo3/e3fV3UlvREO84FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249590; c=relaxed/simple;
	bh=h15ty5+BYyt9zM/Y6hDGfbAZyr7bBXF2NgdfwCRBm98=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ajEMmpHyhCFCuM2uRp5zT/fUe/K+7A0T7eWjg3mM8IHKwyeHvlmlj+Z3yVDrvkr+Shr3UWv4hef/zJ9KG+qM1+dUb6auxlq2bCl+0BSuaz0VVBgRztC7pONRdwbQFjQeSd0+clIAJ+t8fEc2pxOADyec3kGROP2dXQM7wKiaA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cokNy2iA; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cokNy2iA"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a34450f19so69212376d6.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 12:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768249587; x=1768854387; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LOTnCiip/FzJ1QF25tjUAL3pNZvdGoc9KwUNAtgUq0=;
        b=cokNy2iAo0KhuayKrflCP0NuBpTb9rp5BHXR9rD1AClcWvoD8EuOtnW7TMIa7UKV6l
         684W6tjt4sTE02Hx5Kq65al2ipMcLJGr3rryAUZ288erlMgiaeevEsCk/QL5gXWGxeUp
         8M4fZk28hYm9AbnrL0qo5tVFTRUU0T7wRckVITKqj7U8QdRbLL9T9eoNh6JXOKTq5Eu0
         lCE9SSM+sD7k6qfer+n42KlLP9JcMUYs4/HwRB8dsXDhkSrUOI0vxXvVg6aPGAyP6Xb/
         9En6Si9fADdxqn9H/v8n3GbSClLjrc4XqKOPCOMKX2JRLScdplEtmilUoLbtg91mk9Px
         BTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249587; x=1768854387;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LOTnCiip/FzJ1QF25tjUAL3pNZvdGoc9KwUNAtgUq0=;
        b=i+d+f4zuUDtkudktFpyPC/Y+zEXk7Y5KZieA39krbJGPfMAqPiAPxfzRUP7ZF6WJI7
         jpRYApQSRARh6yutfzLcpVkW2EKs+pmTLO2Nt0w+48R95S2FZHt6TgdEq5+GVkCnbWBz
         /spyUfRuYN13tOGJ8mUG/YnoHlfmT+OgQfi2Nq6hl9zwI+xsS3pFFmf6pnaSeaEwqshj
         y7106fEYiYQ6R3wFMq8dv4/k/iCvYrUCrQ2WoFk2JSblDd5OUlapRf8vOY+s2RQf9sFt
         fYjRf7632FkGK4teqgvG3jwiKNVZCtN0BCEXywXRUHC1DaHDyNcYfdlY6jHSlATZ4gmF
         N4oA==
X-Gm-Message-State: AOJu0YxDMudx/ZFg+Z2l15UAjGzRHj2otb5F/pHrQs/zRI8mYlzIKqyC
	9erJhUnshPXsnCPpeXiD6eyNsipGLTH0zZRbgl9M/9Z/C18jcWqKMUtQQCxsTHBu
X-Gm-Gg: AY/fxX6+xOFwecKzfevkx+FINZ3qj497gfqJy7X89IgLcbVOUkhsD8k1/UDHGzQkpIE
	LZ4EyodQzT5gTdhcLZiUuqOA2kJ76cuf7GaH+J3Pq5b/HxsAKLyTUEmen2W0NZsAXZI2MiRXJl6
	juMAduSCP9jXDOjBz/+9Tpj8zIKIWigJn4G3fX5GGeKHrM5/hKWp1TmUcvhhCMEqa2r9lExqArv
	jbZBdUKR6e7k5wpOL4ianG2sohRsxT69s22rPpyYmO1Hm1gkqmfNIn0GcSNFtpDb6ksi3xNZSve
	MsYDBr8QNvODjEZL+MoSxrqJOX8/Nx+YSVC/rEBB2pxQDQ1/tqUJ84zWGOs8Hw16NyDVdxe0fq/
	GDYPqprJUcqga1EAZhhJL2/FGQfOjCqyfmXIVT4Yk3qCM5dAFID8Pewh0W3m9zmTLYdpT06jdLG
	YRfbnTRLsdyMtr
X-Google-Smtp-Source: AGHT+IGYH5rhI+LgAnfxIKZNbklk94M7YV4EaRa5N/fNIish5A1bAJMy46YTAB9x5q0IT/g4izzkCA==
X-Received: by 2002:a05:6214:5889:b0:87d:e2b:cdf7 with SMTP id 6a1803df08f44-890842b2b04mr264122326d6.66.1768249587514;
        Mon, 12 Jan 2026 12:26:27 -0800 (PST)
Received: from [127.0.0.1] ([20.161.30.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077268016sm142518216d6.46.2026.01.12.12.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 12:26:26 -0800 (PST)
Message-Id: <pull.2138.v23.git.git.1768249586.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v22.git.git.1768074976.gitgitgadget@gmail.com>
References: <pull.2138.v22.git.git.1768074976.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Jan 2026 20:26:24 +0000
Subject: [PATCH v23 0/2] status: show comparison with push remote tracking branch
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: show comparison with push remote tracking branch

 remote.c                 | 173 ++++++++++++++++++++------
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 400 insertions(+), 35 deletions(-)


base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v23
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v23
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v22:

 1:  4aa4f1abc8 = 1:  fd05c7b778 refactor format_branch_comparison in preparation
 2:  b7e29887d9 ! 2:  f1ad7a1b6f status: show comparison with push remote tracking branch
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +		advice_enabled(ADVICE_STATUS_HINTS);
      +	bool want_pull_advice = (flags & BRANCH_MODE_PULL) &&
      +		advice_enabled(ADVICE_STATUS_HINTS);
     -+	bool want_divergence_advice = (flags & BRANCH_MODE_PULL) &&
     -+		show_divergence_advice &&
     ++	bool want_divergence_advice = show_divergence_advice &&
      +		advice_enabled(ADVICE_STATUS_HINTS);
      +
       	if (up_to_date) {
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      +	if (push_branch_modes & BRANCH_MODE_PUSH) {
      +		strbuf_addstr(sb, "\n");
      +		format_branch_comparison(sb, !push_cmp_fetch, push_ours, push_theirs, push, abf,
     -+					 push_branch_modes, show_divergence_advice);
     ++					 push_branch_modes, 0);
       	}
       
       	free(base);

-- 
gitgitgadget
