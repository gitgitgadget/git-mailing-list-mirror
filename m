Received: from renault.us.lt (renault.us.lt [79.98.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045BCA20
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.98.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794790; cv=none; b=STkZ+EXPwy/VG/gG2W+C8cg/GcEPWltI3IBIci5Jtx9AcTBXxWNrUZMnw36YB1LOARC8q2dEYv9XjdrmRG/+7D1d2W81XeYIPYTcX8MXZJ31XLf8ulg2fRvRgSGLNcEadMvzTJ495SDezvm5CwHd7K7B7DudQ45l/F//+S15N8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794790; c=relaxed/simple;
	bh=HKuP0qz1B7QLvil8+tX84qk8gBPjLYO0Z8t4nNKbxqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQgMDrTT2mrepdp483iDSyHcgH0BBNHH/blnYH8AgPqykUPIsZlAaw1rBjcDq7acBP+uhSkvR9/wbCGIbs3JuomiPli9R/4prTCWrqSJo0BKZAy/o3N1FogXwgf7V0BIb0GZqSi+wuGF6+IbA63GgcxLrvABzQBAZ8hVlLcLiGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org; spf=pass smtp.mailfrom=kipras.org; arc=none smtp.client-ip=79.98.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kipras.org
Received: from [157.230.0.129] (helo=localhost.localdomain)
	by renault.us.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <kipras@kipras.org>)
	id 1ruiA7-0004tQ-En; Thu, 11 Apr 2024 03:19:32 +0300
From: Kipras Melnikovas <kipras@kipras.org>
To: gitgitgadget@gmail.com
Cc: Johannes.Schindelin@gmx.de,
	git@matthieu-moy.fr,
	git@vger.kernel.org,
	gitster@pobox.com,
	jonathantanmy@google.com,
	linusa@google.com,
	nasamuffin@google.com,
	ps@pks.im
Subject: Re: [PATCH v3 8/8] SubmittingPatches: demonstrate using git-contacts with git-send-email
Date: Thu, 11 Apr 2024 03:19:22 +0300
Message-ID: <20240411001922.67800-1-kipras@kipras.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <4fcab0d3319fa47c2f4126139ca636d6848e9e3d.1712699815.git.gitgitgadget@gmail.com>
References: <4fcab0d3319fa47c2f4126139ca636d6848e9e3d.1712699815.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: kipras

I don't think `git contacts` is available by default?

...
$ git contacts
git: 'contacts' is not a git command. See 'git --help'.
...

...
$ git send-email --to=kipras@kipras.org --cc-cmd='git contacts' 0001-TEMP.patch
0001-TEMP.patch
git: 'contacts' is not a git command. See 'git --help'.
(cc-cmd) failed to close pipe to 'git contacts' at /opt/homebrew/opt/git/libexec/git-core/git-send-email line 2021.
...

