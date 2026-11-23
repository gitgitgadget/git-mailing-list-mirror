Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426501;
	b=wdW7Ai1kkzR/qJLJgW+P2Dlx1rit13faOfJh4ERvb8hncrRjJ8V4Y+Rf8+yUy/0h7X+S
	 7vbaCdkNOk1Ty+UJRutQ/SPqW0lvOxR1CcAfXdYve1IHejzVOBWiJXl0IDDt/0Gi/uZ3Q
	 afElpjfOWPWEDyY0bePzWQ0hylMz+qSq21YkSeYrQQfMjVs5tQx94mxAoDG1nnILo15yC
	 HjxJZM/pf67WFhQ4DiNVoiEXgypAOH+jjv5LFGa6zk5n5bkCv5kNSJ8zDttgQlT1TUmQQ
	 LCC5C93J0WQ4yS+c/QPvXPGybcqtZ6SCn7O22VlOtxNS4utbEBtAmo2adaow3CJ6ejQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=21I44TJVC0yZpK29fORHP3FWhZy+Cu1lqNt3YGriP78=;
	b=2Gagwiz5IBXd2NLIRs9iEx4Y1Y03cEEH6tW+eYskjVw6oDw+PVF9y5fg7CpWtAW30u5E
	 QvfOpHd1n/cG4INnnZe0qhugYZwhKbYnl5SiUOQDezWG/Pri6EZ/kjFOB5lSzdAkT1mA9
	 5AG2JElGVabiMYF65yPw3bPZKPM5/5px1UhB4ka7oftMFIwYBZn5JIaazVzLRUsYtGApP
	 qlrd6/W3tnK0jPXrOIQZP1d3+mzkjA+evctZdLkkWhg5TUNXR9/gqYCLuCSBeqCFIHe9c
	 tIK8Zm5zMviMX45TAnb6M9VpaEJQWDI5DfS6QeZ3SnoMAM9aiM69MdMcKaqhtmryUHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TB/h8gVa";
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4046606A330
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 09:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4046606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TB/h8gVa
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-499f20c7054so1637419fac.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 01:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795426499; x=1796031299; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=21I44TJVC0yZpK29fORHP3FWhZy+Cu1lqNt3YGriP78=;
        b=TB/h8gVagiJdtUaRIrU9TSJAGTh1fCUDiLWJ4W6PSTM5INlcKInrJJOHLuDo6kbple
         BMMfrLejqlelKVrxg25uHrhFRcHHxtzBg+W0yAjrfRTElU5xNlrTc5JDUx7Ndg4a0NWb
         ncx8/fzNxmLEeg48JZPGnaLCjlthSPeSkYA6WVWkufK21j9SdppQGt55P0E+PIaBWjoD
         vIf2nUmhlMuWjjk+iSVq3ZJJAbOPX5DGLHUqcR7zmYNejIrEkPPalxHO08szfOMP+3Ey
         07oimfuhIf28PkH1ARpOTen4Y0TDr0L1IurXvBRRrrtbybL8Uc9Qvfp7L+rtnRHB4x0W
         03PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426499; x=1796031299;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=21I44TJVC0yZpK29fORHP3FWhZy+Cu1lqNt3YGriP78=;
        b=qtJK13wgC/K10e3YO80yFhSscsadgui+BMF/JgcOBdswrtkKN4sZQedVtZszcieuNr
         agcK6/Y9hi1cXADSy47LE0cVM9hG0FlGokfLdKQTu7vkmoI91kemk4f8R2/s0tsxGlMZ
         cfxF0NNUlZxIdfuapMNbi9Y0Pk3bwfvVMx+OjsABCbYA7lpEiJ89CwVyYKWPT8A2NKgy
         RMMY8Riebj8ITY1ir4uDaF7dRPdSQ538BMyLz5JkSDHN/XLteI7PhS+e+mFeoZ+1ZNPT
         TDvxY73Al5k3UGjoOSCsoT0koKtAOz9IN/pm5NklICwXyb7+jJTWbwqMcX15fXqxyXyi
         lO7Q==
X-Gm-Message-State: APuU4Z9QebrY6hvVwJ7VHFU9jcWz7VU+I8tX2eKf03XWxrqLPokKkMVS
	DuWO/ZRlNmkhglZaQ8QAlR5My6cEnjgrsO7rY3spHT0hx2z80UNEtVUaBf9mPVAF
X-Gm-Gg: AZFdTZdRfa802b0VFDQ356z9MAdNc/2HzmQTWWiz4hbRYRu6u/QGV2sGtdjLIfQTOdh
	dNS8DFXRUXg7k8mlCiCvnihceATEBCtXXAfZ7dDtW/RIhVkWwhxI5bpTRSekmQJwzd8Wos06DZB
	C92luRwJYA/y7EUuCqrLRrCq9RJAciaCm+SxR0NRVa3elzgKm3hKim7yf4lS8VwJ2FsICESKUOv
	zZAAuDtgcsHg9PgwbhXld3cVzWNZsELWbuy/Ox/iGU/4na5MsaDc1pOcvfxHMX3Ka3WiE/mLcyJ
	OUCeGWmHM4enr5d0vgCpIsTAQA7zrZiwqa2yUM/xwILKlmmcUCRZ1+azsscV3+UOnVVpslqrnol
	33rOrC3Er1Q8qWsuxM5oBRMXT1Vf7/ZzZJAl+l7Ffm3h15zGWtk6WvY5ZBcs79ya7OVa9I/Q/aA
	ffBTmL5j8HtUsN6lQ2sQrUwtXUpCEYA397vys4khhrmh4fadtH5N4MtonDl4qozAPbAcYVOolN6
	Xy/q2QC99zkzXvy5clBmGLECX5n66uxgwGyIh3KIXaFVs4beIHE5dgr8xPebHgr2lCLwCOCQGfd
	NQff67K2yhlTw+D9+2Ehgm33R7L6
X-Received: by 2002:a05:6870:4e84:b0:49e:7629:fb06 with SMTP id 586e51a60fabf-4bc83d51b87mr9977688fac.58.1795426499448;
        Mon, 23 Nov 2026 01:34:59 -0800 (PST)
Received: from [127.0.0.1] ([9.234.6.28])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5b07d57csm10253838fac.1.2026.11.23.01.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:34:58 -0800 (PST)
Message-Id: <pull.2502.git.git.1795426497536.gitgitgadget@gmail.com>
From: "Gontu Sujith Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 09:34:57 +0000
Subject: [PATCH] git-commit: document --date=now for amended commits
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Gontu Sujith Reddy <gontusujith2009@gmail.com>,
    GontuSujithReddy <gontusujith2009@gmail.com>

From: GontuSujithReddy <gontusujith2009@gmail.com>

Amending a commit normally preserves its original author date. Mention
that --date=now sets the author date to the current time when amending.

Signed-off-by: GontuSujithReddy <gontusujith2009@gmail.com>
---
    git-commit: document --date=now for amended commits

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2502%2FGontuSujithReddy%2Fdoc-commit-date-now-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2502/GontuSujithReddy/doc-commit-date-now-v1
Pull-Request: https://github.com/git/git/pull/2502

 Documentation/git-commit.adoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 8329c1034b..ba0d5aeb8f 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -182,6 +182,8 @@ See linkgit:git-rebase[1] for details.
 
 `--date=<date>`::
 	Override the author date used in the commit.
+	When amending a commit, use `--date=now` to set the author date
+	to the current time.
 
 `-m <msg>`::
 `--message=<msg>`::

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
