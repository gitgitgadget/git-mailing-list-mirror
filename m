Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792460367;
	b=1UdLWr1zkLV90IMc5p4e5F0482ZBWR4DgwA8OePlJtA1zUIsNDc1ogwAEbITIFVNVeOM
	 HluykJC0BkkUIJo5ISOgpE0zFMzPgqoL2Kn9vewMSJUKJVyGkmnjR7nk8SEN2aoirQSdA
	 Hi2hz2xyzdajy4FDkwoaVp9PrDmIXsk/ZlZzRSNXchx8ztQdrh8h62J2CQo/8mnMOk5/U
	 RVs1n9+i4lHeTgsESWWpwXSkUEQpnOVOspfwAANPLuIemMdT4sl8M33bYSUha8qap3WR/
	 fTtJ8FuOUD9MGwxPmfa0MAFUzINmaBm1wqMjWSafCgCmRmvxPKCPs5DHXXS75nBnPKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=6g7yqwmlHR8AOtetDXE73nRfr0ocmV6DOXEFGxScss0=;
	b=Kc6C17rrz7HkVugyvR/EPZptllyDnoz6bUahyiOZqAOzwwep8q3ANht7Rrr3HtKtEb90
	 EOdAVGsNoYU6jr9T339uVua4tpfnTrLBAJCNfhDS+/8HMIVL2/5UprEE2ZKfUPEUQ/fwo
	 F+PZUOQu+zBIv3rWcwTq//fv3Ifg5RA+7sFTG3DDmd4/3r3NMEJG+kkIZXxHaF1rA26WW
	 7DOwGvPnCQrfWC1rUZqHA/TkWn83+4xVjx/QCtWh1cmbHPr1rj2SAKcKhl4c4Qc2QvgUJ
	 wB3CoPf2HjCK6FHr+a9VXahn/9hwMAi6lpfl2PfINhly+wFCjJTrlXL5HGZrPqTIPrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eePOV9MY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE52606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 01:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eePOV9MY
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91bd6ddb149so6526086d6.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 18:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792460366; cv=none;
        d=google.com; s=arc-20260327;
        b=l4Dus+epMrbbTOrbAfawY5q3TR59Zifoi6tNxbz5ERSXJ6Hy0LARc+jEe4dgac4HUU
         rlhst/DN+mQm9KeTuUVh31Lvd1tRl53bX5CCCm95OCTvgoJ8chab9heJ2PhwvXwZUtXa
         J6FQ0zpXgwBUZXAoS6msfXkWwq2e0yhozAIQTkhwtnPMQjgc0EBo4s3v509+F3Y8CowF
         zj1yM0TDsKcRl5fN7y379wg37Vyl47t7maZv/XPDQM4B+aE2QJTJBi7V6gVAXEs9LIR7
         dMIM3E5yywxUhDwrnfozLthxAyG/Km5rH2zaWrdW1bD3W5ow02cjmFiQPiOQ4apJMvMp
         iRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6g7yqwmlHR8AOtetDXE73nRfr0ocmV6DOXEFGxScss0=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=CtS5vhwKPP719Z1BuuXXbDTnBisqNquAhtUFrw3LRCwWcJieTJRy3z08ZV02kxMykN
         clFvAIlcDuQAkXR81jLcOlU+A9OXaa8/Q4qbcikE4PEs+n/Ivzis9wmseBYziuj4vdXU
         CA+k2f5zcUcvRbnOh4QFu+ygxoM4REn2ql/EwQqCcFH0+gNqYf427pK65gUqGSqJhqs6
         ggI3lNFpyevtZtCQ4/gKxDhEdHkrXgjxJioviHdl/w4CLs2XlX8QdnoRpk5TYWSADJ/N
         Z/WCx124dQm48CbNKlccgga0N1B9mopBSk8Rgii02u7CH5RsElBWjyLkaz31Rbnd598I
         0KnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460366; x=1793065166; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6g7yqwmlHR8AOtetDXE73nRfr0ocmV6DOXEFGxScss0=;
        b=eePOV9MYJlo6YEukgOJdXAQ1/ICMWW7cYFR6S8TiB+MeUx0irvitkIgDDNjpvW5lW9
         Vt5aDhMAHC8i2oHfn8tN4FWHEIDA4jgNDQLWeVH58QbAFbLtyMEfa6JLKMaDt/r9Hcus
         JiQ4EgjzIu+2LehN+a7iyKXY3nIqiHGkymlWWmXaRNrjjL7SA+gRhQYs0UKBwTOFywYp
         eEJBHPz8PBnU/LFVEohIjqHvl7Mkd348bTF9AkkTo850lI3MN5Hw1rE5JVrajCCAUYhT
         IVPIClF7BnzL2zIIZok3zl6Llpqj0ZnbfvfSNVqb4PbIO6Oj1Hs/bReUS0NUpCu7nSfO
         9nJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460366; x=1793065166;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6g7yqwmlHR8AOtetDXE73nRfr0ocmV6DOXEFGxScss0=;
        b=Qf6D2le6NeeCTKnvb2Zpaj8pXhAqTiM4lQ0epEwFGBwelaTMaPRV52sBeixl9WR/JH
         HqAoBDb79MK1V2WrO9JcIgkjRr/HeHv+w6iRUUhUnlCzxa8U5JrVgmbh562UI8vPx/vl
         VD60WIjcMlPo5yG6R/kGUBTpv0gsKunK2oNUXB+2ul5dxsv/pbQgpeTdU4gUNDBwQFvY
         FMEDOe5wipJTSS8YTEiDpGFPViSeXzOZ9r5IXeQ8DmnBMu6GrtkOYhKni/J4h/zCpXv8
         Wxr5H5xWdx0kIQJR6d+p3d5tMTJez8MOpgB2YH1QEvx5bziqTikGsXIQ6DqcFlvXee+8
         FNQA==
X-Gm-Message-State: AFq9FYJPRv7cbDXGYrwCsaAJTfQ8VxYWoQh1U+0OcMJbMEXcXsc3Phf2
	rtkwNlSIZMXq6GN4y6pOQxoSH4OiuUdMaZAjU4hsvcuCZsUeChfK/FhZNtSuJOXeEdOfqZbX/De
	A/DwV4ZPT4L7U1B17X/tCmBBCcVm7xrO0RyoM
X-Gm-Gg: AYBFou2MDDTHfZb1oERJG7hXfyiv3v13DoBn8iulTEw+txaoAwVnL8iRLwI/gBclwl2
	jb9oJkEGlnkISp+tjRqbilcyiVRDEthaOGnmMFtPZ9AjTua0MfQzJE6XS6ZLQ63vPpHGwuXBNOm
	HuG6xzLaomCjMvrQHZO6rZcca7dPPaRa8pMqFoYoyZA7cISLCKv8aFf15hChwN50RFNx58Ytwiy
	GNDM1nYVsGaaLYjLcCasB9LNjnwJg/L60AMOfigVO0SE3d1RwV1aspKPNumKx4mPpiSx5PJt17K
	0CGlSaycPzTnm3kULPDF7HFbUi0ngpiecmgGwGKoLZ3oaWZcZjvGhQ==
X-Received: by 2002:a05:620a:17a2:b0:93f:1a1a:2974 with SMTP id
 af79cd13be357-93f29e1748emr1706696385a.6.1792460365713; Mon, 19 Oct 2026
 18:39:25 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Date: Tue, 20 Oct 2026 10:39:14 +0900
X-Gm-Features: AclHuK_npVeFd8XE21GoIB-qSuRMK9pBREuBGtuZ_WwNWzyJ0kyqiuwlaNyOIBk
Message-ID: <CAP8tz2JPXzq=Skokn4OtH8t6c3b+p1Wny1iX6AhXReUGvsBhuw@mail.gmail.com>
Subject: switch/checkout stops halfway when it fails to write tracking config
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

1. What happened
When writing the tracking config fails (e.g. .git/config.lock exists) while
switch or checkout creates a new branch, the command exits with code 1 in the
middle of the switch. The worktree and index are already updated for the new
branch, but HEAD still points to the old branch. The user then sees unrelated
staged changes.

2. Reproduction
git init -q -b main up
cd up
echo one >file && git add file && git commit -q -m one
git branch feat
cd ..
git clone -q up work
cd up
git switch -q feat
echo two >>file && git commit -q -a -m two
cd ../work
git fetch -q
touch .git/config.lock
git switch feat; echo "exit=$?"
git symbolic-ref HEAD
git status --short

Output (git 2.43.0):
error: could not lock config file .git/config: File exists
error: unable to write upstream branch configuration
hint:
hint: After fixing the error cause you may try to fix up
hint: the remote tracking information by invoking:
hint:   git branch --set-upstream-to=origin/refs/heads/feat
exit=1
refs/heads/main
M  file

3. Expectation
I expected it to either complete the switch, or fail without changing anything.

4. Scope
The reproduction above uses DWIM (git switch feat). The same happens with
switch -c, checkout -b, and --track. With -C on another existing branch, that
branch is reset before the failure, so its old commits can only be found in
the reflog.

5. Root cause
update_refs_for_switch() -> create_branch() -> setup_tracking() fails to write
the config, and the code calls exit(1) in setup_tracking() (branch.c). At that
point the worktree and the branch have been changed, but HEAD has not. This
exit was introduced in 27852b2c53 (branch: report errors in tracking branch
setup, 2016-02-22).

6. Related
The wrong hint printed for the same failure is fixed separately in
<lore URL>. That patch does not fix this problem.

7. Next steps
I would like to work on a fix. Should checkout finish the switch and only
report the tracking error, or should it fail before touching the worktree?
