Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0782521FF4C
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386106; cv=pass; b=SqM4ZCA5STkwqAXmgYNYn18pcm8EVIYUUAvRynUKtERkMqE8tuS4oW9d5sg0FhJOykg25gLyisAuIPHgiRH57lNpjgIXaV0RmRVkt7GM384E9y88vQGVBMrM2pdQ+6qiT7C3TL9J7CXhZyDHli/mJAfYZ/7cDeXcOfUEaOcYivk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386106; c=relaxed/simple;
	bh=1Mc4obFJqKJ0BsAwM/wYW/Sl9Cex7kY07NupnFJhRY8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JwbPg0VU3HbEmRCVfnTgvalcN0znTN541xUi3ks6OA0XrnpsdlUYJmlNZEDgcxbkyCDgqSFs1O1c8+J6j7Fini/gdcAjsZ9iTAaAp0rW3z+P4F7A0jNbzzzi27TjErTsJjDNeVNweMs83oKF/c+nXoM1JM8Z6uFbUIuvoHcW5EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I77Klait; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I77Klait"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34f62e71769so928817a91.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 02:21:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768386101; cv=none;
        d=google.com; s=arc-20240605;
        b=FkHSoKr0VWvM8iDSG/c/Uo8/gaF9nI9Am/M/0mOJf5qrx+p90mtg7ozaw+tB2HHhnH
         FhEcOFPitN3SRaJGGKBIakJbbDFP81g3DY+FeN472j7VB48fqFSikaD5+JbuV13mFfnO
         +qkoVG03KsTu0oh5rW4Ydu2Wgm+/nJKnuP1KMOm/7qgm5M9KbrnHU+Qzq7p0mQDZNh7/
         KKVGRI+RmJcYaeRbTL5VB6CemEHvm1OoKz1FwE1XPODdmRx5NStzNdDNTBzJGQWY4C/3
         HtkjGwqG90BHrCcTWLfwWtzbMtNty3eh9af9NXoMcCMRxajBdKXM5Rqyx08NyXxiMndr
         cH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BVo5Sz3+pFBP74oN0dqRuytdJPfRjBHc1gdePe/Nb34=;
        fh=BuW9i8pcHqMLkQXv+ndvaIANn5EyFbPqLAWkY6rS8cQ=;
        b=L93Q7DIFWHy8Wanu80WslfRkXGYgKLrcSbfjJ7f27mG60IThwXrzCFcw54vutMkvXn
         UfHiHDMD+1WieELkQZB4QiN4IzQLMtFlVnjLv9xDLZzCvaVNpm3S31Bj9KkTPDS6cmdc
         RNpw/r4GtQBKfyQS3xQBphPHWI+u43nwF1yTpHWo86DrVGwxgUQUxoptxKvC9XcYNOaX
         f2t9HXTLkDUz9r/5oRx12nyE3tUeVbWpqaqDpaqZClnSIBZRSD7TDhwWmXSXlJqrKzkP
         jSAffvehbhuL7a2Wna3v85SILWArQ0tFQd51bKWgyGOD4YzA5Bg04GL20zy2jdDBIq4m
         EU/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768386101; x=1768990901; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BVo5Sz3+pFBP74oN0dqRuytdJPfRjBHc1gdePe/Nb34=;
        b=I77KlaitvWxuB+5sebz4qohq2LB3agBcz8N977ZxkNkYN/Ou1QyEsbPVN8rGmMomMd
         SMnIBapmo8bVPAIlEd8+6t1J8eAhvqqTzeWuaNDLcOhjSqGHKb22EUwzlafOphypwWQO
         hEQjwKbHoudO3YN35AnTfTxaU9ZKCJ4T4Nq6gVOpB2bQFOiuJIU9b/FaI2tN1z/OGmyN
         4OXVxSywODYVikQQ9O/Wxp6sjRHhiuSRtQi5rSA6iHC9K9KzF8lxLsBxFK/2dGgZIEmv
         wAf4XNgYRxW+hYJQrPSdUT48X69QwuyZFO9UtPcllh9wiQ6IONPiMxvCbKo7huyZKXi8
         h4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768386101; x=1768990901;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVo5Sz3+pFBP74oN0dqRuytdJPfRjBHc1gdePe/Nb34=;
        b=D7iYNhnH4btEBXCmPVnbuJn1HRw+ScwYp5/vw0FtlMHlr4VOY8rfKy5bS+EmH/Mduc
         BgwL6axfcUQgUF8nNhPcqEqjrLnmkn9whTQGYPeOPkCr29hyzJ7prJhYovuxLtlCp+cv
         r82tpxTLb2VWvtJUBd3ALYSox16+q5gYmObRNsUS7sblRV7gMog4saxysUJAWdwiU7GW
         nqxB9XEH7wrq3r0dFAiQ4I4Bg10nS9ShTz3k2J8efjiksZ9mwKFivHX0FNa4vLxrz9Gp
         TDnBCLOZvTIzols9WH1UcvwoSO1a+MqVGMDeoQvHhtOYxbCQk88hcFieMIulyVaHu13F
         oQrA==
X-Gm-Message-State: AOJu0Yyd2SgjCFolG/Ccm822vdoAe6YSzQGs5CBOKy4/MZ4UyQSNFuWW
	ShzFNpiGX2pmnhggIE+d7TUHJdlH6xGJJoBU2ZKgxFdVoOnGUUJQuUMRKM3iA7s4HSDu0jlLKd1
	g0bEDk8lqbAtABM+dvEN0/H7Hp9DpwDZ7kFLU
X-Gm-Gg: AY/fxX6DBs1otUacO6TQkbtg3tYeBVIN7fpW8favzp3Tyj32xL7NxeNVzBLMP5T/rF3
	XCXpLT6R773XrXxMVrXK7K8eHUpRNp3hmTbG19jsd0cyz1L6mbwKISwKpmuaJOQDCbObts6M6Hz
	c2rTMyKr45f1tvYM64Y81r40XJNvIpUfjpEDZdWkqI+1KnillwyKKFxWCLHuwvn/7wFJxDe8Nq6
	5Vq0cUB7y6/C3kEOk0qIPHs1kBvNYbn6YcwZsVMleT1sxsfHSly/2U/hvgB0qtWTuGfPqhF1Wjj
	yBL1CXPPcFgydBONIm7nzdzTmuUKY/ar16wuSmSHye8NKgOKOnrSmGO5OYz6axhzKAI=
X-Received: by 2002:a17:90b:560b:b0:349:2cdd:434a with SMTP id
 98e67ed59e1d1-351092aeb2emr1652937a91.5.1768386100828; Wed, 14 Jan 2026
 02:21:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: M Hickford <mirth.hickford@gmail.com>
Date: Wed, 14 Jan 2026 10:21:04 +0000
X-Gm-Features: AZwV_Qii82Y3XiZZl9rphsD3-JMPO2PdQ7TGc-cYjOGJLRvlCaHbLP4-jhJ6XI4
Message-ID: <CAGJzqs=0Zr2iqsTUZdjdwpbtaS7kuBOf=E_XT=vbdfyNTKkjNQ@mail.gmail.com>
Subject: Documentation problem: new syntax for git config --get-urlmatch
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi. What's the new syntax for `git config --get-urlmatch` ?

Docs Documentation/git-config.adoc suggests:

    --get-urlmatch <name> <URL>
    Replaced by git config get --all --show-names --url=<URL> <name>

But when I tried this I got error:

    fatal: --url= cannot be used with --all, --regexp or --value

Any ideas?
