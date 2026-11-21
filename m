Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265689;
	b=39OKu0sCoxaC3nkCY0fXqlFxN1aPL+aaYX33PcEecA6aLLfBM3Z8+7QtVPLLuIhncU3v
	 7hrd6KWf60ZRz3Or/XWdt0L9L6NSsAme2IptwuIsqQrD70kkUMwS/yO0kQFVPmr/31sQZ
	 kP6nPJnjbX8Rq/m+xeNpBTrTQtCVdBelm1SMt2SV7mZTYSxakZh8VPWFMLbyPyBqtJXVW
	 9vr9wxblq2gtLN7o+iYRS2opQW7o0/rJVHcdnRr8RoUsOtwfjtTOHEZy+50CM1Qs0kTll
	 i9ZrimESXN4ctGE5pJvxvCN3EVzsAWU5SnYC//bP70Md1tQ52RmUyL4yMzScO4914Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=k4LL2wuQmu7V09l2jPQ5vidDyWVDBCJEOJutK96Cssk=;
	b=XRiVj8bfTylR3NWr9+wEoTO6DdmdpBkHkQzmz0Hx0FyKDy4m7HT+nVCR7MpddyZHvdor
	 mRzn0cniXq+1stTcLP9B/f8sMuFUrYNDryGt+NVnugo6E5CaSW9WQZjP2rtPS2ey2Tyx7
	 at4I0jloVzgJUoQOj7hLQ7DaG1LFeifMFKKKEATAG+MJmnzO6I5d2kFMw0AMoaw3FbsS2
	 mhPiGc9qwHYYkeG6K4xavsQ8oWoz54tRBX9seGFAhfB67CLud6TwabF017vUaxGTq4vAG
	 khj+zdtbcK77/UfTfzq25pHQ75xdOG4xyh70soSkCuKImbnVTOU/W6UqhCa+LXGQl3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p2Rv5l8F;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A71606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 12:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8A71606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p2Rv5l8F
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3712b6d9843so1701191eec.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 04:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795265688; x=1795870488; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k4LL2wuQmu7V09l2jPQ5vidDyWVDBCJEOJutK96Cssk=;
        b=p2Rv5l8FOlzLK4vJIpdp5IVRmYiZsaajffostNov5n8GvoheCmwaa0mKQtd1/vNlZW
         9vvAkRnaOMlBo7PPoLNwb8U+/Y5Bfyef5eoqMw40+TUlwPytnh+1nx+4qMwBQVsFIOOX
         +jtJvubPIN8jGO5Z6n4a2+75M95JNF9pHz59n0XXP+CNE7CaMfDi2Jyddy76yf65JSth
         fdPFtCgztI/AJwNCxWjcXFUhtHcPIoIRHvPfvUT/W2+K7kbA6SJsCNp/mXIPMFPbB9yg
         DDemcfC7k0zZJVAeLu/JxMzPoJ6xS1Asr8pSptuT6kV6ugDW+hz2x7YIt4g88adYbbrt
         te6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795265688; x=1795870488;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k4LL2wuQmu7V09l2jPQ5vidDyWVDBCJEOJutK96Cssk=;
        b=n6acT1SqF/FrrEqJmPYSd8GwsOEC2R81JBo7jXX9+3LdIenuVBGnrzBCNvM9+N6ZlF
         DlyBJGPnWtmbswiuwI47A2HqHgtSrHwIgkE8ukqXfkFreICptjjzX3qSzE2dXhmnGzbh
         3C5x+XgjghSvv8aG0uDuAXqRswbsko4TnzkfWR37RlQowybEZi6enq3/spPCGL5DTmqE
         zNSwIjtISShsuEm/g0CFYosDQobPoQAJWXIgw/AZ0Iz7EmErpXQSvS0CIQkSBKOnQPKp
         KWw/jv7Hr4BVOsb+orQSAVzHHCqeF1cZOUcXiIGZuvCQJS3OSUlob3TYg9espQoYIhus
         8ekg==
X-Gm-Message-State: APuU4Z+O9XKgmxG1V7Gw44M5ErSSUW9HhEo/9T0Wv6mDHIGSUo5DWZrd
	dk27uEXTBEjNMOmAJ952MOaBlhS+UK/2pAp3Rg+lSbaF0YT6nXp67nrt0cEG7w==
X-Gm-Gg: AZFdTZdG/HewtFC1hzaw7/STU8BdUXDr0zwaG5Liki1ctEr4cwWP/IeqAQePihjRS64
	MGJizpnwblNFjWld2QTPCzu04a2IlUWWBC8jQtCFQzIJHF2vuLg/mqeVmwl/bA/YYoohT7hnZQz
	UlEMHj2efibpCiJ+buVo1UX4LoMMYfmtCnt9X4u5Z6JGNUkLSKPANySD7tmI3YpzYQVKATYGg3I
	7Fi2E/s3zz/tyCAFjvkauJqUzjsQzlDsa+EzHFEtAxm6RiXQ3WBJioeA1OZQ4MNo4n1PATv7NI9
	6i5qx9nkNq6CwaRk7uLimlOhzEALlfzt35+ku1WkqhYcchSIIzrxbhBBPgMmXPKoD0ekXccdCuu
	W0uq5dHYY1lgr9Kc5FFwI0jQnOHA1nN+buKmfiEEwX44Yd0sHjFgB456yc1f9a58SAV8TAZ/sMJ
	OLDWUJN1jUCNIayEfHLAzJ7tGuuxSvn0HCHpCYCDjli9SGi+iKHe5RpXf+ngdsdGF85MY5qLttE
	7WqLuobqaxdwbQf2mu0wDA0RxART+5W7b4h+Yyg+B8vrrsAC1s97g1B7hLGCloNCjoR+q+nT/gt
	qx6tQhZ1t8HGY73GciJsw+pNhTR9mimNvpWyDR6/2hxPqw1MdCs=
X-Received: by 2002:a05:693c:87d6:20b0:376:40db:faec with SMTP id 5a478bee46e88-3856f65f251mr5325289eec.10.1795265687669;
        Sat, 21 Nov 2026 04:54:47 -0800 (PST)
Received: from [127.0.0.1] ([57.154.5.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm21088188eec.11.2026.11.21.04.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:54:47 -0800 (PST)
Message-Id: <pull.2481.git.git.1795265686332.gitgitgadget@gmail.com>
From: "A4-Tacks via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 12:54:46 +0000
Subject: [PATCH] completion: add blob:none etc after git clone --filter=
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
Cc: A4-Tacks <wdsjxhno1001@163.com>,
    A4-Tacks <wdsjxhno1001@163.com>

From: A4-Tacks <wdsjxhno1001@163.com>

Git clone and fetch both have similar --filter arg,
but currently cannot complete after --filter= in clone.

So add completions similar to git fetch --filter=

Signed-off-by: A4-Tacks <wdsjxhno1001@163.com>
---
    completion: add blob:none etc after git clone --filter=

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2481%2FA4-Tacks%2Fcomplete-filter-clone-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2481/A4-Tacks/complete-filter-clone-v1
Pull-Request: https://github.com/git/git/pull/2481

 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9cd9c7cadb..f8f7f40a94 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1841,6 +1841,10 @@ _git_clone ()
 			--cur="${cur##--config=}"
 		return
 		;;
+	--filter=*)
+		__gitcomp "blob:none blob:limit= sparse:oid=" "" "${cur##--filter=}"
+		return
+		;;
 	--*)
 		__gitcomp_builtin clone
 		return

base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
-- 
gitgitgadget
