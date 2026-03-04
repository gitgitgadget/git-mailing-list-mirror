Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F783DEAC1
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772651493; cv=none; b=A44vohL5mUErZ6F5n16ZaW/4swaXUaK03EF9fXeaUp57dqv1IimvOazIVbNIeeaGSLDrIsEVqOD5cCRSIafg5jRMr0DKtHO2izIdvxmb1KLn6P8CZWTnVtRTSzccGNHuQgu+UDERLxeTJnyawQ4aJg9Vp4SNKVmw5QoQj6ebpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772651493; c=relaxed/simple;
	bh=t7UoeS1tPInUFShWJrmzGD/RscF7UD1RtT9YyNjZbJY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=QCvo1Ze/DyCe7jE4uZq+8BSfVWi1Qw7UxJFplqgp00jjweH3E2h+8vxTE8fYZDUXbVzdKIs66RZfZ3oQutOhf2iWGxNfF4M1HZhk5+iNjXEABC5oAxAAXTuIgTfdQ0L2l/CnGy0tMrUVtaQ8gQfTaJVVRj0T5bEK9LKDctAecms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSbkLG3P; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSbkLG3P"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124a635476fso8478224c88.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 11:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772651486; x=1773256286; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p84/yUmsP+FhEGZpQcf9s4VSvZLPjLCbFFisIFaKuqU=;
        b=WSbkLG3PS6YEgbflamL+8RtzifskzHlQOmX7810aUwcOJq1iUrkWUyfthigY5e/OE6
         0Ivpsx2KIgqrtcbZwdYLufJxVj1sHoUgamWohqi+fypTGukAk6xKlnHemsw80cI0fl44
         FCC4e3VPz+KKbOK+t5VU0I//EyQG1qcr0n/Z183P9ysMtmQCx0J1zRLd+s7Exi4Y5vSY
         UsXDwrv2qKvV9VOyrHJwgmlsar2NAtSClbKrcjJ7Om/SKnTh4CxO9H8TRguLqWSxyTVD
         rlCRQ/XBJq8OE06ho6AaP34UW+jJsROgKxZ+fO5Ozk7lj5YJeC9iuZROlv7s9ylOH6Hd
         rVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772651486; x=1773256286;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p84/yUmsP+FhEGZpQcf9s4VSvZLPjLCbFFisIFaKuqU=;
        b=UjWdpP7q4w1WxZ1QvcQpqQ7xkimOxfqppK+deO5W/696gonXsMXyLeDUMWAxBln9om
         puSBR3FPCc67IxcrVeAQNXnUZRpqu8HlK6oUewdnUDqjk20f9E02grRmKye7i2pv2aS9
         JGbkSaf87S3ezBa3f/0mU2BHNcFCbtPcEznLvskaTEKeJDjrgrhXTPEFu16oPALrvIYq
         JVgRBKeJFxcHIvJBaNMlvYn2pksJKT3JrrhkeTHESZgUte8iUrzJ58Osn/9EDJRv8YkM
         8l01qGk2P2r+YrLvXSIr/fLF25heJRXo9F2OKvCLLH/YxszdK9VOs5cmPNx+ZQJrtVQc
         pgCQ==
X-Gm-Message-State: AOJu0YzrULtFbx2EWy1SYCderoNVaZtCxIU8EwPoFmUEDgBY0xKuRgih
	Evn2AFS8IAsyEaysbelFOuy0D1G1pGAx8fJK1XhdrYfhKrTL4GuQKopj+GOKcA==
X-Gm-Gg: ATEYQzzh4XMvkj+hUJSanb97qDwljOhILX9qjmK6Lnxq2ldaQCVYUomWLTMesFHOa1q
	dnxQlR5RE4JSAIlGycuEN6Q0EIQ3aOsjSEdt4sEjP6pd/m7JdqeHdkNy3f8tivLlGm0ZPDr+g+O
	eRhU03UUFkySISa4HUbMhW+/0td7A1YqoIE9TYoZOiWnAKdkpS28BEQlwbHh3oMZ50Ot5sjbiCw
	iMbLHiQwAm3uRblf7OQkpbQMIBPbEe0dseitouSx2M5uDd3JhegBlSdy+h/o8CSx/WAEClLvUWp
	frMLC8k9hJPVMHe6adoPh/go3szPsj75tZbNoXfK0cvm7MYwubGX4CEj3QxAs989I5XCIorcAY3
	ZPNEUaqjKZ59MO5mym3OvVrhxa59u9ZY9o6UkLp+zDufOJnSeM85DF14IQFGx3j71E5qkFylIsA
	z1TMxOba6aedJ/8GWEodmmKZ4=
X-Received: by 2002:a05:7022:926:b0:119:e55a:9c03 with SMTP id a92af1059eb24-128b70d24e3mr1135984c88.31.1772651486096;
        Wed, 04 Mar 2026 11:11:26 -0800 (PST)
Received: from [127.0.0.1] ([40.65.61.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a52ab0sm24956336c88.15.2026.03.04.11.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:11:25 -0800 (PST)
Message-Id: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 19:11:22 +0000
Subject: [PATCH 0/2] line-log: fix -L with pickaxe options
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
Cc: Matthew Hughes <matthewhughes934@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

This series fixes a crash in git log -L when combined with pickaxe options
(-G, -S, or --find-object) on a history involving renames, reported in [1].

The crash bisects to a2bb801f6a (line-log: avoid unnecessary full tree
diffs, 2019-08-21), which made the diffcore_std() call in queue_diffs()
unconditional. Before that commit, the same combination silently truncated
history at rename boundaries rather than crashing. The root cause is that
diffcore_std() runs diffcore_pickaxe(), which may discard diff pairs needed
for rename detection.

Patch 1 fixes the crash by calling diffcore_rename() directly instead of
diffcore_std(), and adds tests including known-breakage markers showing that
the pickaxe options are silently ignored by -L.

Patch 2 explicitly rejects the unsupported combination with die(), replacing
the known-breakage tests with rejection tests.

[1] https://lore.kernel.org/git/aac-QdjY1ohAqgw_@desktop/

Michael Montalbo (2):
  line-log: fix crash when combined with pickaxe options
  log: reject pickaxe options when combined with -L

 builtin/log.c       |  4 ++++
 line-log.c          |  8 +++++++-
 t/t4211-line-log.sh | 15 +++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2061%2Fmmontalbo%2Ffix-line-log-G-crash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2061/mmontalbo/fix-line-log-G-crash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2061
-- 
gitgitgadget
