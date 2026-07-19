Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F70262D0B
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784490882; cv=none; b=SNg48c01rnTemColgI38JkgbWkJ7mn0o7hgMzKca5e7PbYVIDRAbqLeVZAw/E4hvtwrZhAma0fr7rmbCZj5s4JHhCNZUg5Du8xKLLDsWvQb2XTSORZxy465QRzTkvceRHNJAAIWqgujk6PpK2KLr7+4I8UpWdbnILbKHo95BZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784490882; c=relaxed/simple;
	bh=SuDh/SOuxglZtSU1YdsMALlz1r6XZK2xqJXwt9J1ykw=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=NgmMXd/WABUjldzW11a40MF64WSLRxOX1dkZQ8ajjPCWL5owwoG4yUPHEZdlVCNt3pRVZ4LCFdt0AC3GgZ5p7AdYsWcsBN75XfpOLSHUtdjZEzYovZ+k5/EIl/0+hoyhZf8ool0Hq7uF7r0GfNwm3zj71OIYCXQYrRTFKm+51eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StYrBQVP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StYrBQVP"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e53581361so733692785a.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2026 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784490880; x=1785095680; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G8L8qQh8ITFXGHJZkfwCWOo4iwnXB7o1QuvBsarn518=;
        b=StYrBQVPcq0NzSpnleQd1nI3HlcHb5jeKyQilVYd7gZ6AdtdRw+K7xMQxbG0Ofh9qZ
         lxZLNhH1cHygz3pvWntovf9uIWt9VwiJjn/BkmL61uutePDGzIywzJu5eH2tT2TL9gHi
         QKDxsyVk874zldvG9vebDg1bleYZ2d6VoWSKRJOQ463PvQEwyIymKLV8XZigsm4hCORn
         3FrFOlgKbu3oY8YzLxT2AG/wzvoIlOgvJUv0TsPdPt2ABbY27OjI9jqYZ3c+1QXinT3k
         4IRcrSBppSJURQgeo8Alct7AKvVY6IERxj9PJa+n5dpSCgaHsuC09260tgg59YW7UE1O
         Tzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784490880; x=1785095680;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G8L8qQh8ITFXGHJZkfwCWOo4iwnXB7o1QuvBsarn518=;
        b=luyG0Y6QZJyiWQnyN6v0rHCXLsUwuOE20JvsESxDgZou01FnAn4p3r/DXkZMmwIYIU
         OCt7OFKePaXOy9KGPn45I5sNZDfrQqxCJD62DmcKZDcJKdjXjcKTyJxPozxG+kn5xeWM
         tne5JSJn6ZZm93VLnERgU3ckkIGqgaHiVjnrf9h8RHB4Ye+aB2J4asNGF6FCk7SaM1ze
         UKIUfiFL5AXCrGCNDjlCMTHVskLLMvwCiWJnewgMSSbu4ma8360L2JL1J5R5Fa/8oPC7
         3/FIbm1rAXlE9F5UKuDWqExP7DS/HHOYWzCyWswpnBJpNHBMacCq1tMaylbQRaNiZSbS
         frnA==
X-Gm-Message-State: AOJu0YyPf2+UlJ7CoqoUsTT1YCV4CjP44sky5NpAPe5nZVO4awDsyxdu
	LP9cwNzeHAVb5MMY1TBIhSvcM5SKwsCoNRuROIIj99oLEg2BA4bMVnVgG5cu0A==
X-Gm-Gg: AfdE7cmD2T0vBHCj8HnqnqOJzNKMjeXVyJ+QvWE1wQMm7JnvlNbep8CYEcNynR/sTKb
	lbN/8Tb7/bW+gYJab2dnnIc2J8Dq74rOzxnbLGXcKTzweUeDzxUZmcPqO2kSveM+y1qSr0fDFfh
	tuZ4tNeDxJSEV/vHUFzMr8aMEa9T4TmDrSzC8fIekgYQp7trYysTN1Y/tm5+9HkgfG4GcS84jT9
	02xYX7JzNyvHT3ICc4zzFqvTCtCo23NPflOa25ZFQnIt+igu634uRNFM+YgWO/irUtXVinBhyhG
	IVdGqoaM8acVmI/hlbjB6gJm+gSA9edR1IWlcw5uuVyVRjXsMTyD/2RSrmIRNe0J3eWEjfTdACW
	gqe8ZsFwmaVY/ECtDt3beDAIzpcKeLh+4ZwBSclVe5rsVi4krsOsNOyyLrUarif7x7kPnoFlrHP
	u+8gw=
X-Received: by 2002:a05:620a:454d:b0:92e:9cc7:fa46 with SMTP id af79cd13be357-930b3ece2b8mr1076480485a.21.1784490880216;
        Sun, 19 Jul 2026 12:54:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.87.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52dff03sm710722885a.9.2026.07.19.12.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 12:54:39 -0700 (PDT)
Message-Id: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 19 Jul 2026 19:54:33 +0000
Subject: [PATCH 0/4] A new batch of synopsis conversion
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

The conversion to synopsis continues. Now the commands are less common, so I
may propose larger PRs if it's ok.

Jean-Noël Avila (4):
  doc: convert git-imap-send synopsis and options to new style
  doc: convert git-format-patch synopsis and options to new style
  doc: convert git-send-email synopsis and options to new style
  doc: convert git-request-pull synopsis and options to new style

 Documentation/config/imap.adoc      |   2 +-
 Documentation/config/sendemail.adoc |  92 +++++-----
 Documentation/diff-options.adoc     |   8 +-
 Documentation/git-format-patch.adoc | 264 ++++++++++++++--------------
 Documentation/git-imap-send.adoc    |   7 +-
 Documentation/git-request-pull.adoc |  38 ++--
 Documentation/git-send-email.adoc   | 162 ++++++++---------
 7 files changed, 292 insertions(+), 281 deletions(-)


base-commit: 08621c32d5536babd139ab1a9086349b3672edd6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2185%2Fjnavila%2Fconvert_synopsis_202606-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2185/jnavila/convert_synopsis_202606-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2185
-- 
gitgitgadget
