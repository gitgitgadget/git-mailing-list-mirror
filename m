Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049147;
	b=PDt/SjbG0f+wC4SmdZnuNfJZEZkj65tfjHVReJJW84bSeVc1JKAaGX+KHrWJkh4oiKct
	 gFhW/wRJbil+OrRr8u7UowlZ0Nwihk5I+6GUuRdnCiSLo6Y0GZEPseG/ElWB05YkNq1HY
	 XOjH6aTKTRE8pXY7wwMLcIUT8E3udrigG1ahRohtMkQ/V//3BpaC/BTCodnmHRLCpfW2f
	 kE9jVaXtmh+mUtM/xsXWPpOaDZ77C/8SoHhYmGvbJkzDPxOyqZOAMuIK4zS2709Oi1EKL
	 P0XxiQLgI0vtLGi/VUirAsXzDVj14zqsddWr4PFcXwdMOgk0D6/G3DgQPNDl1O24Eng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sKZzte2XyB0D8ZP/vkIUAyqCjOKQ4/Ps1Dze2dt8gvc=;
	b=VE//JkYP9EbDn8ibRCqS41Ma7fPJVrz/h0Zf8DOKQl0wMIJ/ICBuossCikH+g4TwKeWp
	 2HpaabCn+WfJOQ4I2va9NF2iw5atlG5v+gov0jZnKhzgnSMbX6IKxHy6/OySJIdilk/C4
	 rvLx6j9JVDyY8sitydy9Y23W2Mu1eMOWhO8hQhlt0CQrYAYnkXNJ2cOY1y12oIiD7ps6Q
	 V4e1pu+Z8rhTQbLXUAt69BJBbAii5XI11KFNf3VnmiW6bUGK2+2ZNdE89VMHGD2/tCZKY
	 JlhmBwG4XgcImaYmzSbUaf79hTpjNX+wyg9pZzt9agIrQscH31eGO0JfPM9zq5fA+xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p8yhF3+T;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D039606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 21:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D039606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p8yhF3+T
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1907768f8f.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 14:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793049146; x=1793653946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sKZzte2XyB0D8ZP/vkIUAyqCjOKQ4/Ps1Dze2dt8gvc=;
        b=p8yhF3+Tj3MtffmHmgIpffOMxuVhiDZWetkP4cxzd3RMfJV2Z6sAEf9P1kJ5WJdpHL
         E9NtXD2dyfsNQsSpoO3Bms6xwR11jtr0BgNbEC5uW9S+xmDC4YJ8TpWZAEl0BAvpTHbq
         dKFk1XZ3QMG30H4CKRQvb+7fYmYSxvSJczsCKTSyhuenX5+ZgHltW90mYINYsc0tIgbm
         tVGMYvuYItqaa8LP+spHIUQ3BGbe4BGYxcsZotOsow3xDfIEFTISKHcPFhPnTiA3KtUy
         LpR2Oh8gJO+CeCO4JH/fPVqPzskK4bn8BmB6/16+rXn6z2pe8FC7U241oUZykZ7cT2kr
         cELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793049146; x=1793653946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sKZzte2XyB0D8ZP/vkIUAyqCjOKQ4/Ps1Dze2dt8gvc=;
        b=vxgPsc0+ZnpRRrjwrjQYbN5c/G8izuhJmxXtUPxXFrKun0xoMmE5uyKM+T8tjcaDqD
         4TJgpTpM9Oaq5z/bQT4urzqcMhRYW/imZhT6QKSzFC+UqxHZIlLYkrUs5Jt4ct/Kfz12
         QaGuKcIa07w89Ej0WT5NQTw0vDo7nZAnZSklN9IdwB0r3rZtOYSChL2bhszgEzHdXsbs
         g0vcGnHDJAJnu5wF8UwuUFeNwFOReY2/k8yS4M7BF9szzh/4tO324R0RcaDwojC1vGpb
         cZgMQhsKu1kLhq3Ja3qeWtRy2A+rW8dI9DuFdo+jNltXFOtP8yt7jpcBf8POnBvfk0lD
         sHyA==
X-Gm-Message-State: AFq9FYI+L3EsZnvrrp0YRZs4lCGOCmx8KTPcENId65DbddolnhWN8iya
	HCQU/0u/4lKmC81iM6AxmhnKNPAhWvbg2t8csyfZww1LtYPNZuPG2tj9Fg0HPmxdooFI90ZeZGQ
	=
X-Gm-Gg: AYBFou3tww/ctKMKM2lpK+xXdPgIYBIxwY1tDr9/a3BB1c+hxYQ8PITJEaz1GY4yAWS
	xTDBrLVf4ArrZPlfseT/qlDsnyi0axZsp4dpj7okjyLggx8u0WpIEGZk4AlCa/NAhjXlB5oql33
	MY8LOEz6120e+jqIHXeI7LTFFIQV6BgE2PFnp+tE2oeupX8MZU1gKgtOY+DB6PIcWUdYBEAKAJY
	dt6nqmybnrnHNhfu/cOlrs+eUhhcPQqFsIN54Sag/5Udf8ViI9QGGdsDHkES71bFlD2ESeO3oG7
	jvEsQoGsdxfGXBdeqwxP08Kf7e/ZllWv0FuQq3Krx5eCZVxIAIREh+8qC8BoFZFXrqxsn/pDxqR
	JQDhFB+AEN+4bzWa5jLGUSiiQxn+zeKkW0bEM13NdIris5IPWG0k81JG7iRMhdsN+V64A+JYDLX
	gjBvBmQ+RfNnAJuhdlvvXi6gfJZhagjuTyfplk7Rr1u1QIkIM6Vdcq75uyhYxro33Kzb9QOICSa
	b85bCI/uCWCS3kD78aiD9IxEGUFYVEk/D//SOo6SvuxOW5UpbHFmYf+feM6vPtrGg6s8zBBzHBk
	Pyd0NdRy4gCr9LXMYzoOmbhJQm7abMDFiDG4iLgIgAV8HGdwR9/q5ito+r9NRJxeyAGdzZWx/17
	8xHmM2JtHEwJaSy0K/k5uy1quG6YpF0dQqGutCPzmwbup7w==
X-Received: by 2002:a05:6000:4809:b0:48b:11df:c496 with SMTP id ffacd0b85a97d-48e3eb8ecb2mr15193383f8f.28.1793049145717;
        Mon, 26 Oct 2026 14:12:25 -0700 (PDT)
Received: from DESKTOP-GBO6I0C.hamlet-koi.ts.net ([169.150.218.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd37f4sm21762029f8f.44.2026.10.26.14.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:12:25 -0700 (PDT)
From: Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Edson <edsonwasswa54@gmail.com>
Subject: [PATCH] doc: document two-pass promisor remote fetch order
Date: Tue, 27 Oct 2026 00:12:10 +0300
Message-ID: <20261026211210.1941-1-edsonwasswa54@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The implementation uses a two-pass approach: first try accepted remotes
(those advertised by the server and accepted by the client), then try
all configured promisor remotes. Document this behavior to make the
technical design notes complete.

This patch also clarifies the security model for server-advertised promisor
remotes. Advertising a remote does not, by itself, make the client accept
or trust it. By default, clients reject all server-advertised promisor
remotes (the promisor.acceptFromServer default is "none"). A client only
accepts an advertised remote when the user explicitly configures an
acceptance policy via promisor.acceptFromServer or promisor.acceptFromServerUrl.
This prevents servers from arbitrarily directing clients to fetch from
untrusted repositories, addressing the concern that a server might inject
a brand-new, untrusted promisor remote configuration.

Reference the gitprotocol-v2 documentation for protocol details rather
than duplicating the information.

Signed-off-by: Edson <edsonwasswa54@gmail.com>
---
 Documentation/technical/partial-clone.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
index a1104930fb..f80346729b 100644
--- a/Documentation/technical/partial-clone.adoc
+++ b/Documentation/technical/partial-clone.adoc
@@ -199,6 +199,10 @@ until all the objects have been fetched.
 When a server advertises promisor remotes via the protocol v2
 "promisor-remote" capability and the client accepts them (see
 linkgit:gitprotocol-v2[5]), those accepted remotes are tried first.
+Note that clients only accept server-advertised promisor remotes when
+explicitly configured to do so via the `promisor.acceptFromServer` or
+`promisor.acceptFromServerUrl` options (see linkgit:git-config[1]),
+which prevents arbitrary injection of untrusted remotes by servers.
 After trying the accepted remotes, Git then tries the other configured
 promisor remotes as described below.
 
-- 
2.46.0.windows.1

