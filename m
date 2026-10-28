Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179125;
	b=x4X5ksF7aNft99Ls92tvJWhmxW7Qgh9Af0oZOF/eLiJucE3rW1sErL5RSD7G4MBa+ZGI
	 wRLMdofg11TDIIi8CpTrn2ilTUpMYpY66ppfqqGcvbErwTPmWbr9a/0ZPSWRtEqfwGNRE
	 Q2c+rOpGS6gSGw3GfvJLuxDeLMuJRuNpozPT8oDUiZtC99+PBVy1CqDjWoN5ZaK9ynwwA
	 +yHIHF71NUMBUIUZOu1ETZhe3rstAIZNaQVOUSAJWwZIPs4XWbRaO4jUauG2Tj4PhxbfA
	 n7XUQLfZPT4+TjNpKqEhYwGw1izQIm7SRys8b0AoB3fcLZsvW0FbY8w2/C6A2s5I7Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RPph4HpvZQcx2g6WCase4u+AfwVSyPbUxbd46ZQ4JpU=;
	b=d5V/qeGPJUVRSZ/UO/knrILZdsDCvHdG+WYW985/iiZXTyY1MJ3scstcAJSHkXGnMRTt
	 lNBXkm2Neq4Qibkwf4obG79NYv1w/6mK5QzppJ2qqA5g0DdUgPeUcB+EjCDjzQtvCJEmR
	 U700QpmzIj3zWrxq2By7WrfwttA+YZFynCiCeNjgqjceGXN6OwQ7z1QwTGjSOu2yufiJI
	 CwRJAm84igAo1sJekQicFTyK0C8BM6A3VwbwMDbQgaVpUhSe4d6lHCWliZPkGyDCcmDE8
	 0HS1/w2jq7cUPI19ym82ZBqC1Qb/2InbUEQBb8CcOglzd7fUHdPUNHM0Wbchosl8kIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XUr6qYE0;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D6606A323
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A8D6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XUr6qYE0
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso5122155e9.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793179123; x=1793783923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RPph4HpvZQcx2g6WCase4u+AfwVSyPbUxbd46ZQ4JpU=;
        b=XUr6qYE0ZsWFaFBju1NI3DYdUb71p+6fy0vy6vW4Vy6+1/0xIDsgDIL1tZo9VSXg+i
         PaQ2hCwevnTNnI/flHwEuPG9Hen75FgtT7jZTmi+/6mEZa8/doCZY8FM1bfuXeMSJi+i
         U3ejuq2fLrg42IvNLyylh2Ub6wHPVFdDjiZtny8IUroEOeW/+LWBnqZS9AF0UjbETdsh
         U1SwXV37jlFKDw84qRUkEdgs99PSnhm8Gtf6Ata34i/3RlM/YBPAVu0V+grh1PSxTcyf
         W9VROc6opsHg7EQqLAMdIpaS41SEVhEPqSgaIm6/yMm3kfekPTDPYQLYHBe7LcuknzBj
         jd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179123; x=1793783923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPph4HpvZQcx2g6WCase4u+AfwVSyPbUxbd46ZQ4JpU=;
        b=v69lG2tqHglHeviTSmlt7N/FiqrKvU/ArKBmRn2qlqn0+Etq5+q+dSQndL3tN4wIve
         AM38/GtwFhgYk9WT3RQmC8bgo7Ifr06ccS2wxt0f4v0drW+y77TTePqrc9YESn8LLPDN
         kR2aM0IiKgWF5inSdUyBZD7M36KkVYeWEGiYvJA7FvoZH9GJcHtghcnPdK0NAal4Mpch
         5eRA9S/QU0po+GRgWpILfKQYNF75bCCj2nsJbu1ds0Lku2WCOVM6t1gNp0HD69DC/tSg
         0EJnFT7eUqiTypEqWO8UTQRUOQPf66PwdVPHY6PrVKE4D12wyhchBTowC5SN2KtQtWgB
         +jYQ==
X-Gm-Message-State: AFq9FYJUS261VJCSzuVF4I/IHrOcxgHrlonQOdoLHhFOt1mJmFkeNcwn
	GVyzwJT3FIApkYPAHZzI5u/nWKfh6/FGRGQYG3osktrc0Kilf4Ds4ZRgUVFRxWe99PYhFzns
X-Gm-Gg: AYBFou3hOOc/KSUKQTXHswMbA8dFilPx655q4QIdmcBggmC5LdjnYwmH/vs2gX6Pfef
	qzZtizxfPYFairsKpYZxksEz96Vq7MGTZJSQPydeH36Xueoell/hOFKDFh69iWOazMjBsgcX9te
	e3vZp5RsR4hyek5m1O2/odCOzQ3cUPIEJipsgVdosoM3b53U9BPFr8zJOny4PrwVFy7saDpdn/d
	nq/w+s3bhWIyP3iaA/jUWUDG3O7IOiUNv+5utrwJFj6MrhFJRYDm1cMa79Tl+2tfUfDECZR2Iv7
	V516nDX2I4xbOS+dtBrYiTTw0uGyKh/hJ7cVFYkdmJ+606r7IbTHQnq7TZ2fZ/tw7Gin+m8k+o2
	l7OmJtgeLZWFfVuQ3pFyoJZFdL16sXj60LaBOBWBKhdW6pwp6z2+mpbLaQhhikC9UUx34igGy3P
	70IhlaslvxBAGuGn9ZajabLqangZ7uH/yqKQRWQXHeE+/HB0PCB9DRHCy5pZYVEtBdC5s8yIDkX
	4/4PQDlfrgQykzL7mu101fLCc4AZ5XBiEklqLKxVd5wXC9e6ZufM9qL7yJnSEKXMksgNYZkrEQu
	CVbX+btX5VJFs/iQGS+T1UY+FL9d/w5cYwIvoH6CrG1hSDfUTpws4PKzDSZ9irvnOo1zq5WTCOu
	QYhuRkRaq4eLTIlMZjKZt3kpvYAcmfNSJz/rEHU6wrqJ/KKYgX8XOc4cGcQ==
X-Received: by 2002:a05:600c:524c:b0:4a2:a9:ed56 with SMTP id 5b1f17b1804b1-4a9661ab67fmr35472715e9.8.1793179122652;
        Wed, 28 Oct 2026 02:18:42 -0700 (PDT)
Received: from localhost.localdomain ([169.150.218.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm28207490f8f.9.2026.10.28.02.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:18:42 -0700 (PDT)
From: Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Edson <edsonwasswa54@gmail.com>
Subject: [PATCH] doc: document two-pass promisor remote fetch order
Date: Wed, 28 Oct 2026 12:17:49 +0300
Message-ID: <20261028091749.1948-1-edsonwasswa54@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
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

The "Using many promisor remotes" section in the partial-clone design
documentation describes how promisor remotes are configured and the order
in which they are tried. However, it does not mention that servers can
advertise promisor remotes via the protocol v2 "promisor-remote"
capability, and that such server-accepted remotes are tried before other
configured promisor remotes.

Document this two-pass fetch order: first try accepted remotes (those
advertised by the server and accepted by the client), then try all
configured promisor remotes.

Also clarify the security model for server-advertised promisor remotes.
Advertising a remote does not, by itself, make the client accept or trust
it. By default, clients reject all server-advertised promisor remotes
(the promisor.acceptFromServer default is "none"). A client only accepts
an advertised remote when the user explicitly configures an acceptance
policy via promisor.acceptFromServer or promisor.acceptFromServerUrl.
This prevents servers from arbitrarily directing clients to fetch from
untrusted repositories, addressing the concern that a server might inject
a brand-new, untrusted promisor remote configuration.

Reference the gitprotocol-v2 documentation for protocol details rather
than duplicating the information.

Signed-off-by: Edson <edsonwasswa54@gmail.com>
---
 Documentation/technical/partial-clone.adoc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
index 18718a3840..f80346729b 100644
--- a/Documentation/technical/partial-clone.adoc
+++ b/Documentation/technical/partial-clone.adoc
@@ -196,6 +196,15 @@ filtered `git-fetch` commands from the central server.
 
 When fetching objects, promisor remotes are tried one after the other
 until all the objects have been fetched.
+When a server advertises promisor remotes via the protocol v2
+"promisor-remote" capability and the client accepts them (see
+linkgit:gitprotocol-v2[5]), those accepted remotes are tried first.
+Note that clients only accept server-advertised promisor remotes when
+explicitly configured to do so via the `promisor.acceptFromServer` or
+`promisor.acceptFromServerUrl` options (see linkgit:git-config[1]),
+which prevents arbitrary injection of untrusted remotes by servers.
+After trying the accepted remotes, Git then tries the other configured
+promisor remotes as described below.
 
 Remotes that are considered "promisor" remotes are those specified by
 the following configuration variables:
-- 
2.46.0.windows.1

