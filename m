Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99C329E7B
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976910; cv=none; b=Fm+2RhI7ziKlgdoHcZCQU/eBAsNxH4zZYRb7BhtpDRbUkuLGYR4WGaUpcv3FHSV95Y3BcOnDZSXLilhL0avVtFbFApOMxi2DFi6xFPmhS9Tx/thcecknuh2n8R1QrWFX7u+8PJaMgKky/BQuL6r6S5oIrEJWcE/WAkeW0hEE6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976910; c=relaxed/simple;
	bh=Gsfk7NymF2+z0e0J3D12wzREyeKtH6oe7IHb7sHEG5c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ks5rjxSjkdBKxNf026aAkQQ4clOzLuHq4qs8mQhMAP/rQZX3Uc9RAaKIdb2WGpxwU8gGfi8PgQiL1UAPaUs1Ehn3WFsLJ1L/D/E+LSb/ZtJ1yZn4eYW/88vOif+FiyxgFQjIFhsHeEVaWnqhhFvy7o5UnCqab8Ftn/NHo3/6Pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUcijFch; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUcijFch"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b31a665ba5so522332985a.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 08:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767976908; x=1768581708; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaMjki1gunqS8aDXb/jE72H5zSGpkl9uZ9frMkuGCNI=;
        b=UUcijFchWevXLNr4iF3AF3lrFbg0VAVN1+c4IG8yU0hWsp06pYkbnmklY9NmaH8zL1
         H7Lfrugir+HiCI1SQ3bJDnc4xSpYuqSL0QWramaozfDAxMNdk4CG5W2U8jlPo3P5mYYw
         IcGU5YuhBv4So4z/X13AeitNlqkj9mv//B+T7yNMz1qSldBwEHxRdpSfhmY8t1KH/N1Y
         HwnEqmF6q8gyI82PAxCImfiGWecoYxot8+AkAwJ1eVBvqGND6MFkJLuuMTNN93GsFoye
         m+06/j9KYxn4yACbCRvCUvtp6rYp7X4zrDdaKTptrpoxjoYq75GdyFz9bQydP4hlDYoc
         c+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767976908; x=1768581708;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QaMjki1gunqS8aDXb/jE72H5zSGpkl9uZ9frMkuGCNI=;
        b=kC+2EI+4qYaG4UagIw/ZVFZBBNq/sK+CnSqqejWWB6Eao7hdTosky8jTlShMCHnhr+
         wn97DY4ftq7651ectRzhS6nOc+G1n8Xf1vhtx5LcpZ4JP0zLO449h5Qzv83QrxRAHHuL
         5qC34LRJ6GNxjzVEW9Jduh+pk8G64eR9E2QCkKlc+2A8hMstvxbef2WIFijtaCJVRIwY
         A7lh9ywYB604q53PhYk1+P1HpbNOzFnHqCebjcNmH3kw+cQ4y0X4EwBGH4efLOntl7Ci
         jck42U/1DFqkQDSMVanKenH3SmJgPBbr2eC3ANPg4dXt5acpTqxiCsIqnkm7xZyPtNR8
         6WPw==
X-Gm-Message-State: AOJu0YxYEwxKf025xxZIntqtmAHnKdYERbmtFGnYPUGWq1vJHg6ViHZd
	F0nlyrnSH9KnEf066c+cntisfnWwcRf5b2VuvADXo7Ut6H2hbm6RHePY141nWQ==
X-Gm-Gg: AY/fxX5ABCFbgvO5Jo7JSA6fiPP102k4KfPW7D480sss8O+Z6csg+e7jdu7XGFoc2dV
	bVb/HCxPHk+oojNq6/vB/nvyS3izuo0tG2kyzdzd7qnpCzkW/v217EgU95o86hXKj4MliwDjfUW
	ufDr4fsRALvpZiL9kABEhoWVXFAorwIc2Q+Rq8HuBx19T9jtIm+Pn/L4daPpp1LmJCZ9zwgRwEd
	Y5RAOUsbq3cZZNIrR4n+J0t0rls3owjr2Gj9vEKFy+8+b3mw2gADxg+OeiXm9yFqIH7umq8MJxD
	M837LSobrvRLntu6cqIaQNasEo8sbQNXk3ZCWOy3pRH+UInf1oAmdRn7PDSkiX8505pawN0UxFG
	0enEhmuGbBdbumpng9pZYeZ9bXeiA9SEHjha9QyhAP8mG6tpkvRWAdod2jz09Y2w3LCg88FGqga
	rIHqYUkSG7FXxgLA==
X-Google-Smtp-Source: AGHT+IFo4Hyg/Jz9vIVumahbHKzcN5sd8DWIdSIWgyEEUiFelURYbPTJmcyH21O3BP7BxdyNvGpeAg==
X-Received: by 2002:a05:6214:390e:b0:80b:11b7:210b with SMTP id 6a1803df08f44-89084235947mr139961226d6.43.1767976907952;
        Fri, 09 Jan 2026 08:41:47 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253218sm77247766d6.43.2026.01.09.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:41:47 -0800 (PST)
Message-Id: <pull.2138.v18.git.git.1767976906.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v17.git.git.1767608269.gitgitgadget@gmail.com>
References: <pull.2138.v17.git.git.1767608269.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 16:41:44 +0000
Subject: [PATCH v18 0/2] status: show comparison with push remote tracking branch
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
cc: Nico Williams nico@cryptonector.com

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: show comparison with push remote tracking branch

 remote.c                 | 174 ++++++++++++++++++++------
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 401 insertions(+), 35 deletions(-)


base-commit: d529f3a197364881746f558e5652f0236131eb86
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v18
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v18
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v17:

 1:  b62a9feb4d ! 1:  451d7a4986 refactor format_branch_comparison in preparation
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      -				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
      -	} else if (!sti) {
      +static void format_branch_comparison(struct strbuf *sb,
     -+				     int sti,
     ++				     bool up_to_date,
      +				     int ours, int theirs,
      +				     const char *branch_name,
      +				     enum ahead_behind_flags abf,
     -+				     int show_divergence_advice)
     ++				     bool show_divergence_advice)
      +{
     -+	if (!sti) {
     ++	if (up_to_date) {
       		strbuf_addf(sb,
       			_("Your branch is up to date with '%s'.\n"),
      -			base);
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      +			strbuf_addstr(sb,
      +				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
      +	} else {
     -+		format_branch_comparison(sb, sti, ours, theirs, base, abf, show_divergence_advice);
     ++		format_branch_comparison(sb, !sti, ours, theirs, base, abf, show_divergence_advice);
      +	}
      +
       	free(base);
 2:  1348542edc ! 2:  02476eb8e6 status: show comparison with push remote tracking branch
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +}
      +
       static void format_branch_comparison(struct strbuf *sb,
     - 				     int sti,
     + 				     bool up_to_date,
       				     int ours, int theirs,
       				     const char *branch_name,
       				     enum ahead_behind_flags abf,
      +				     enum branch_mode_flags advice_flags,
     - 				     int show_divergence_advice)
     + 				     bool show_divergence_advice)
       {
     - 	if (!sti) {
     ++	bool want_push_advice = (advice_flags & BRANCH_MODE_PUSH) &&
     ++		advice_enabled(ADVICE_STATUS_HINTS);
     ++	bool want_pull_advice = (advice_flags & BRANCH_MODE_PULL) &&
     ++		advice_enabled(ADVICE_STATUS_HINTS);
     ++	bool want_divergence_advice = (advice_flags & BRANCH_MODE_PULL) &&
     ++		show_divergence_advice &&
     ++		advice_enabled(ADVICE_STATUS_HINTS);
     ++
     + 	if (up_to_date) {
     + 		strbuf_addf(sb,
     + 			_("Your branch is up to date with '%s'.\n"),
      @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       		strbuf_addf(sb,
       			    _("Your branch and '%s' refer to different commits.\n"),
       			    branch_name);
      -		if (advice_enabled(ADVICE_STATUS_HINTS))
     -+		if ((advice_flags & BRANCH_MODE_PUSH) &&
     -+		    advice_enabled(ADVICE_STATUS_HINTS))
     ++		if (want_push_advice)
       			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
       				    "git status --ahead-behind");
       	} else if (!theirs) {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			   ours),
       			branch_name, ours);
      -		if (advice_enabled(ADVICE_STATUS_HINTS))
     -+		if ((advice_flags & BRANCH_MODE_PUSH) &&
     -+		    advice_enabled(ADVICE_STATUS_HINTS))
     ++		if (want_push_advice)
       			strbuf_addstr(sb,
       				_("  (use \"git push\" to publish your local commits)\n"));
       	} else if (!ours) {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			   theirs),
       			branch_name, theirs);
      -		if (advice_enabled(ADVICE_STATUS_HINTS))
     -+		if ((advice_flags & BRANCH_MODE_PULL) &&
     -+		    advice_enabled(ADVICE_STATUS_HINTS))
     ++		if (want_pull_advice)
       			strbuf_addstr(sb,
       				_("  (use \"git pull\" to update your local branch)\n"));
       	} else {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			   ours + theirs),
       			branch_name, ours, theirs);
      -		if (show_divergence_advice &&
     -+		if ((advice_flags & BRANCH_MODE_PULL) &&
     -+		    show_divergence_advice &&
     - 		    advice_enabled(ADVICE_STATUS_HINTS))
     +-		    advice_enabled(ADVICE_STATUS_HINTS))
     ++		if (want_divergence_advice)
       			strbuf_addstr(sb,
       				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
     + 	}
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	const char *full_base;
       	char *base;
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       			strbuf_addstr(sb,
       				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
       	} else {
     --		format_branch_comparison(sb, sti, ours, theirs, base, abf, show_divergence_advice);
     -+		format_branch_comparison(sb, sti, ours, theirs, base, abf,
     +-		format_branch_comparison(sb, !sti, ours, theirs, base, abf, show_divergence_advice);
     ++		format_branch_comparison(sb, !sti, ours, theirs, base, abf,
      +					 base_branch_modes, show_divergence_advice);
      +	}
      +
      +	if (push_branch_modes & BRANCH_MODE_PUSH) {
      +		strbuf_addstr(sb, "\n");
     -+		format_branch_comparison(sb, push_sti, push_ours, push_theirs, push, abf,
     -+					 push_branch_modes, 0);
     ++		format_branch_comparison(sb, !push_sti, push_ours, push_theirs, push, abf,
     ++					 push_branch_modes, show_divergence_advice);
       	}
       
       	free(base);

-- 
gitgitgadget
