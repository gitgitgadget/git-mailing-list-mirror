Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4E34DCC5
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629696; cv=none; b=CF4DcdQWvb6/LA7fZLuSRP2ZQdmREnn0U6gAG3zI2nI6r7kVVgiqEt+NuhMBNgX74KVhc7Q0INbSn0FOMYlxG17qZ+joQa9Zz6nxYmeJwN0QYX85UQryDHvlWJefZAxLkmGhFd8518D5rvYzlwtH2pz0K9W0L4cKKcyg12gjMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629696; c=relaxed/simple;
	bh=blFxTJSp3QrKHUaYozpEVynfSTeaNSG0EjEZbeYD0sE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=e8LO/y/VzP3KC4bas84lTySgMHLTdNyFdAFW4QSezxsgttUoT65SA9U3/vbd647t75YMw2NRXmD6hfg9+VdInfp18wAIbN5MFyAz5v9vFhfyjAEYt0UlDiLHNvph1TKlm2LZjO/neW7jGnkmxlVvxHKxpB/aHNE4U4KNcIyXDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT46whJq; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT46whJq"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88f239686f2so117588085a.0
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629693; x=1761234493; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=et9SDuXae3cQaYIy9nAdF4jfNtet8TBinIwP+Fd5ejc=;
        b=GT46whJqtA9cRYRqxuRR1WKOFvSgOMXo8TCgihEW1/HstZWEyPxa2IiCyHbg1DO0Qp
         QD5ZYwDNC4dAuZeRLaStyaZvz3rD4rohLqtP7mOWDwW6+e6kJzcaCquDSiifu5fKnZFh
         iUuqtjTAnu5WzZVoTm22dBeHLIKjVuzw9KIadopx++57Fb/ITv4xjcBCVP5zkGW1qnFz
         ZQGfax/S1SJVkAogE972ITGLxqVwryFyYrD7+r736nBb43DD0zCPXJrxxlzrL4/OUHZM
         EdhJi2ihznFIif59IlyB0rkseGx3OlQjGxm0KEUgMtT76bMfTMVaSuaYcvtZZ7W+xp09
         E/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629693; x=1761234493;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=et9SDuXae3cQaYIy9nAdF4jfNtet8TBinIwP+Fd5ejc=;
        b=PNVeFpoeKC4YFWcx7cK/xB8oQSbXl5Q5PEB78uU79CgM0LOW3DS5jOd7A12YqN2sSJ
         hyFnRBUkEkzvM0fe8GKd0WCo+A7ahYKD9nuxm1eO314CLLR1ONFCR3fLTYCmEie8bRtK
         SPluFq3szFQYbP9Khg0+bUN20IKbJkdb4ZOZHjeyPv66cth+Qsxn4zjeTCyuubtzzalW
         f2gUPM3n3wV4JTF8J3OfYcliwwLJAkG4amGYRyOHfyJNQOic+p/LO9T5F5gYVLWDfJi/
         +uYTzXArRsyQXwWmexiZChmQpR9Qpl5tgESN7lCXEIfCcNHSto1VZ4XmU8mSt7wqPrLQ
         Y6bA==
X-Gm-Message-State: AOJu0YwitMCGeIs5gkCEBtsplI4Imnqpp038GXNxFOTJTFt2s4UILUng
	FqJ+jHeoypfHctNRz2NAAZ6V6Ac0VX/HeIIFi73vzJFPQOXFgqIwPEYNLXxJ5A==
X-Gm-Gg: ASbGncvgiv2DyojtNaRiafT56ceotb7Q++yu/gbUoDGuA6/bI2Z640Ke0BNnXZ27/XH
	uRPAsczIeOsynwuHUdUePI4uKS6qz6TFahXbEgEskP+rl0sKgxvBHjM5y/tvv/yYHymUFju4L+H
	UzGtpQB41Wv1zsmKoa7MebWH3zof+gGf3MqosyzHEnGl/jIAE7S5ijlJZHZUOe0wmTi2T7XWQsL
	AtRjuVY2/Qtp7nkuRxxgspdheK26k7gsaV4ghPqKvwWQzWO38ceuD3iw/en6ZjEf7e69PahkvhU
	B6O5VRM7RedqT8FZPyuh0kiyiTBGh9c/9kUeFtdbzeqtoPpd6mgEcBfW6yN4Fy2hoAPqeaRIX74
	vwKp8bIgFcblljiZsDs+thQ86r9Z2VDtDzIu0fVYfrpNybxDX4bI1mZgIqcl8Hwj4LeWS2v0m/T
	ZZAbPMTaZRaSJm
X-Google-Smtp-Source: AGHT+IFX7SeQoiLyLPJBJtUxWptgOwSvU4C2ix/2sEsWCXq8Kl/WAQcKDJ8+ZojC/UCOetA4UWwdJg==
X-Received: by 2002:a05:622a:50e:b0:4e8:9a81:aacb with SMTP id d75a77b69052e-4e89d21c537mr8766481cf.10.1760629693393;
        Thu, 16 Oct 2025 08:48:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e885a8e10esm36376771cf.11.2025.10.16.08.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:48:12 -0700 (PDT)
Message-Id: <pull.1990.git.1760629692.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Oct 2025 15:48:08 +0000
Subject: [PATCH 0/4] Upgrade a couple GitHub Actions
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

The Dependabot setup of Git for Windows suggested a couple of version
upgrades; I extracted those that apply to Git itself.

Note that I took authorship of the commits because Dependabot's email is not
exactly meant for follow-up discussions.

Johannes Schindelin (4):
  build(deps): bump actions/download-artifact from 4 to 5
  build(deps): bump actions/checkout from 4 to 5
  build(deps): bump actions/setup-python from 5 to 6
  build(deps): bump actions/github-script from 7 to 8

 .github/workflows/check-style.yml      |  2 +-
 .github/workflows/check-whitespace.yml |  2 +-
 .github/workflows/coverity.yml         |  2 +-
 .github/workflows/main.yml             | 34 +++++++++++++-------------
 4 files changed, 20 insertions(+), 20 deletions(-)


base-commit: 143f58ef7535f8f8a80d810768a18bdf3807de26
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1990%2Fdscho%2Fupgrade-a-couple-github-actions-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1990/dscho/upgrade-a-couple-github-actions-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1990
-- 
gitgitgadget
