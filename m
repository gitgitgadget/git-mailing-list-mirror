Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795321182;
	b=lVZ1ifoLhcUz8c1bW+43mg4PbWB4cLJTktSm4cLPIVbp93WOKqZPL3haMEpZYovupYhN
	 ttLnzwC9Md/9ZGMtVRRtwr9WhFvz0jVRHpDXuQCiVCRki/ie+xIjYGSbOJpz73VjW/6XF
	 jCqc2kxA++OSwoA0fbb+aJxyoZ/r8CFlky2bi4sSPSexRnLzeSfBjpZsFBwp5CTM64NyC
	 8o/Mcia87mfnpskWa1ReoeJjWFYrRYFei7JM5GXhsKgmMCekM3OE+/Yg8CWCDfDOZciXB
	 TA8jfew7NlakEyf22nJbPjbazTKcMzG1FmVJz5v0U5rSIYTteAXQDFgxAnFw580PPcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795321182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RmPKd9qk7pm5QlZbVu/uwecclXoNgeYFzQxWQme2bqU=;
	b=Phm/lxcTohQdsY6+I+ztTTp8P9pgQwZQ6+gIxQ2p2jBGh/Imx9sdx80asryCo7pNboJV
	 jZf+/rJZhPl14ZpIq/HqwA9Xx2ME8WbH6oNYSGGTi8n7FXFEjgXlyLBuzdEWNW7zoY6Ia
	 FigkKJRdb038Wxa8WGQhLS57vVnZ8KgDZmYBFv8l/Rsdx26WckMnY4NaU+2HLxOTqHDBO
	 rE/PEh3AysVtwfazLmhGXL2v9Iz9h/Eek40OQUzvEHWc7Rcj0LIvjTm+MAYkV+UNIF9W3
	 IAecJP5qIjaTCCg7OVh+MMBQbxbgQBiur9U+SwU8yBse3oivGQ6ZJLy5k07D6xGRD4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=FqeTXHeC;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62B606A32A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 04:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A62B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=FqeTXHeC
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-921342fae7eso25550316d6.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1795321181; x=1795925981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RmPKd9qk7pm5QlZbVu/uwecclXoNgeYFzQxWQme2bqU=;
        b=FqeTXHeCIPWkAWff8Mrpaunc54gizCUxo5yAyuU9CCxs47IKIqQ8edB9OQEKfBwAUt
         ogtjMWtvGY++aOYCSIFJNn15yzlS0zyvW6+1yujyfWuF3ksD0R8O2rFXKMSqUy7soQSZ
         efHIgoHNkvx7q7f85gP5KblhmRNIibkB8ZUjgPbGcyYVIR/ZjNJeX6VH47QnbPRKP0F/
         jRrFIAAwPQfxaKbk9lwDZo0Z7g0ZeLv3TZwLCcbxuFHcGXWMMOIqcS9n/5DKRLAHyknG
         t94cO0DlCdYSy8pfpME8BusPsC6J0WQ7o9UIA8a2nL2w3rLSw1o+0sv7wVa/Tw7vS6Ac
         D7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795321181; x=1795925981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RmPKd9qk7pm5QlZbVu/uwecclXoNgeYFzQxWQme2bqU=;
        b=HwppxsaNlMGQzeffHqsrZJ+lJGx7irv3Jd+e54XYuSickRQbmclSVNjSQ1o+KnE5JR
         D67PSqCY1LkEZfT2BHu+Xiuvm3fu/pcQvQK2nmqHMMhCLIbsyvsSrTQsfjDMD6mGqr2/
         xF7GrblhBIZJi3/yBwKFw40KOj0zwpAAuHUjAVJwPU6LWU6xUN5OQUr/gL5a6HZT2JEZ
         pkI++9PjtPtuHxOYxMOBEzEQFLUxCDNREl8Wx2862un5Ei34OJg4yFUn42lF4cdUyJTp
         sQu8iSngZ06c3prqK9pdccwKbnPWcWyrkwZ+lmj9mq9DJvK9XX90Jcj5X2eaH5CMaXFt
         aXgg==
X-Forwarded-Encrypted: i=1; AL+hErEFDJw9ofRh/UkTijOfaYODKSLlVeUdVNcniHHTUNfyiTsqLsmqr7JnuV8kWv9W+c93KAo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+33LXbd39jEJyDgwWvmbBeqbzOGKjp8Klq6ZeA1SOn5mD7Dm2m
	kWN2QXuZTNSvBY238380SJ2mZwA6tothnD5HtlOCYWI4igZxEDs58Nbm9MOsVZhK3PQ9Jc+ZQP5
	SFISZgFNwgysMMrCSVO6VbuC9fFbI+Bzf6maP9c/cpcQbsnAear5yoeUa5TMK8CsnNacA5A5tyP
	VjiJVmaKxxoFNWyHHYuANqFiNc+oVtQk4=
X-Gm-Gg: AZFdTZcvucpa2byKJzEugG+BYGLgrx8trwkw4rZesWCYboq21ROsyG/ob6zVxEuApB5
	b4wG+iWNHpuQFNn6aSv/09Ae+cLSsSI5mjJru+hYESFQeIfF5Mrj9/vxny+NQxhK84Zawy4ZBbl
	nkJkx96u57d4n0WCoYzVqVRXVSWcJaoGDjzAq4hHRdLrlJUeiuoQry6RrfWEuzEpTtJ11sbdzRk
	3C5oq9nQbLUA9F1o8qtmR1pffNkr9JH08iCmcwdn9rMTkLkfvlsht4n8/T/dBEhz3LfgiX4C13C
	paOrqoo1sgN1ogsDB5XBBAkrQLz305hgRvryP1rZMRLVqcsSASOB04njSuJY7xp1drTkiSm4wv4
	Hnj8Dg7haK/u3eFTcT9AQZVYKjpfDcCgbrGlSW2CTjSsUQ7b81xDW3Xen+WE+gmQfkI2DsAEhDG
	oUfEghMtm3NWukxQeJ0lGdc4YhCBr/104BS5LCfb8efgOV6K0laE/HPS7WY2uTKmC3MZxkeSciu
	JDmlNsLwxezN3nbMOplO3KIlKj8ZRp8gkaL43E4ybL2YeYJ0Y8t/bAiSd7F3y39weJM17I7763o
	5QnsDrgZrnSr6504Ipcm5pb1gEad1TMDUTxBqv31e0vWE6FhI7DKvMI0osRYrmWk9+8yrlCUWI4
	BZ8Qky3cdPEnhZHTUkqln92I8J2l/mjQwwP2HCVeJoDlZEmgXCZ6hf7gKBArXymG2QQ8x4rv2wt
	TI6M1JUhRE1yG1pNvqyJf1SoXV4S4bv4D+euGX2fgGOijuqZ3Z6OX12iiV+PHjhj20KYtgRFlqQ
	+U8B61PMMM=
X-Received: by 2002:a05:6214:62f:b0:921:2010:4a0a with SMTP id 6a1803df08f44-92134a38eecmr133013206d6.19.1795321180903;
        Sat, 21 Nov 2026 20:19:40 -0800 (PST)
Received: from remus ([69.43.65.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349e602asm69501416d6.24.2026.11.21.20.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 20:19:40 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: haraldnordgren@gmail.com,
	git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	taahol@utu.fi,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v10 0/5] branch: let --delete-merged find squash merged branches
Date: Sat, 21 Nov 2026 23:19:37 -0500
Message-ID: <20261122041937.9584-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
References: <pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Harald

I built v10 and ran t3200 with my earlier keep tests added on top.
All 215 tests pass, and the build has no warnings with DEVELOPER=1.

I also ran two cases by hand:

 - The submodule case from v8: the branch is kept, and the command
   exits with 0.
 - A file with "merge=union" in info/attributes, where the branch and
   upstream change the same line in different ways: --dry-run
   --delete-integrated does not list the branch.

Tested-by: Jasper Mayone <me@jaspermayone.com>

Thanks
Jasper
