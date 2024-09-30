Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB8917E012
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729119; cv=none; b=KzFww7egqjgIjrcea3icX8KDvmA0J3jKSojCdo8PWRT7WsgalZfRSw635HFkb54yh5aAfE0MZpPJqQROkvgXvJToICz482FRAarZHMaLRbSR9oQa7SDkffyW5oKG9anPAYIbck2mMsok+9gEmfS+wkNl1BzjydWM6DoWn9AFHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729119; c=relaxed/simple;
	bh=q86kYGzYrlXtTcC2Azkw5IRZAOPdOoUXrBqwAEUmKIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPuCc41B/YaLjMOO2SzCe+Nh34ZRI/YBNMGRDl8dtCryOMygeGG+lha8W+IyQR96QAgizNVNtio56mynZXh/awDv8hJAcq6V/RLSuUXAKJQiceUhkI5BQb+rLeGNdnLqdL2Gv0QYBmi470li2w8YKhYHH7kKFnfL4GgEOxCBjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kN+0gZfF; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kN+0gZfF"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e04196b7603so4395005276.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727729116; x=1728333916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VhePz8NrkBGqD5pb6fEmJ2Dwkvi9T14SAu9RTJyWYHQ=;
        b=kN+0gZfF/gorJkYDPxxmnRBYYi10aWLku0dDOQV6U73vLE1hGbDl09DFNaFtiCcfDv
         874YS/dQX6SPU5iUTj7ksKU41Xc44N1VBEs982Dya1nRXhcFNta1amJwIBEtSE9BYe8I
         lQWQQtWy5nB+Cg1QEXkwVnaUA9z5RGcnzXXhu78VMiajjnY5cW7lSsOvE3H7qLoi1jOH
         0+uP4VX/05pik8LQp/Jw9m9zOl4mBf9v7QqZHlal2/N8/QTpjptlgyzkToa3nfLc/uVJ
         HOxzHVSjNU3btZcfVUd9Gc5EWLsjj2vRtyYLePf/cQb4pjXIVfwIYSQD7YW4DSJIrSKt
         +Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727729116; x=1728333916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhePz8NrkBGqD5pb6fEmJ2Dwkvi9T14SAu9RTJyWYHQ=;
        b=FdHV8c02f+h77u9IPH4X6eRFQgGbBoMYYAZz9TsVDEzsQureyjG6BSaTD9tnPCf5mA
         GvzkfD/XEkFaVKdATd4hGFBOJENDbpYq82StLafKUHImCPSKrGu+dGIfFl/XPf49XWRx
         35mx8ezwe3OQtFSwIIkLW0JhkKvqYFlKjVX9x9A+72jszbZdxLqkxecwalpJaj3TFfXl
         vw9gBHG0PVHPMCloLbgf1n2lUfijogrkX8QKYOZ+OghIjTW0Oqf5sDGHEVFPcm/mSsBC
         JmAXSY5fUPxfbXigl7OkTVHMqY1Yzm41d18dyvKL2pPaO6pnMm3dOYlmYzZs4mPjY4fj
         Bh2A==
X-Gm-Message-State: AOJu0Yxdi11rG5r/AbAGMtpwGzbPIdzabxJqQv6c3xU0YX92bsdOmM/P
	gjrBQUybxAPJu4B6yM3RuHqycHkk+j3DlxICe+6ePUNJ2mNxePmh59xhBT7jahEEAy/l1rkoIs3
	tXPY=
X-Google-Smtp-Source: AGHT+IGzG5iE/kTZa6hIXdPZUqk5zieONOpZg7zK4dww1OqUH59wSCEUJzOdwRqwQWuYkPPd2YeJoQ==
X-Received: by 2002:a05:6902:278a:b0:e20:2a1d:956e with SMTP id 3f1490d57ef6-e2604b3098amr10025425276.14.1727729116247;
        Mon, 30 Sep 2024 13:45:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e400f08csm2595161276.22.2024.09.30.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:45:15 -0700 (PDT)
Date: Mon, 30 Sep 2024 16:45:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH] Documentation: mention the amlog in howto/maintain-git.txt
Message-ID: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
References: <xmqqv7yd548i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7yd548i.fsf@gitster.g>

Part of the maintainer's job is to keep up-to-date and publish the
'amlog' which stores a mapping between a patch's 'Message-Id' e-mail
header and the commit generated by applying said patch.

But our Documentation/howto/maintain-git.txt does not mention the amlog,
or the scripts which exist to help the maintainer keep the amlog
up-to-date.

(This bit me during the first integration round I did as interim
maintainer[1] involved a lot of manual clean-up. More recently it has
come up as part of a research effort to better understand a patch's
lifecycle on the list[2].)

Address this gap by briefly documenting the existence and purpose of the
'post-applypatch' hook in maintaining the amlog entries.

[1]: https://lore.kernel.org/git/Y19dnb2M+yObnftj@nand.local/
[2]: https://lore.kernel.org/git/CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com/

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/howto/maintain-git.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index da31332f11..fd1560327c 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -165,6 +165,22 @@ by doing the following:
    In practice, almost no patch directly goes to 'master' or
    'maint'.
 
+   The maintainer is expected to update refs/notes/amlog with a
+   mapping between the applied commit and the 'Message-Id'
+   corresponding to the e-mail which carried the patch.
+
+   This mapping is created with the aid of the "post-applypatch" hook
+   found in the 'todo' branch. That hook should be installed before
+   applying patches. It is also helpful to carry forward any relevant
+   amlog entries when rebasing, so the following config may be useful:
+
+      [notes]
+	rewriteref = refs/notes/amlog
+
+   Finally, take care that the amlog entries are pushed out during
+   integration cycles since external tools and contributors (in
+   addition to internal scripts) may rely on them.
+
  - Review the last issue of "What's cooking" message, review the
    topics ready for merging (topic->master and topic->maint).  Use
    "Meta/cook -w" script (where Meta/ contains a checkout of the

base-commit: 3857aae53f3633b7de63ad640737c657387ae0c6
-- 
2.46.2.633.gf09c3c1769.dirty
