Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67D13D503
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148938; cv=none; b=tMelzTUv0c9Y/C58nbdgkmNTxr6W6NoPSmrkKY8EQ0vYOfgaSceWE/R82w2lityOq1Dxi65J27uwTC9JsDE1OtOU/Zba/CD080pzZwuj8g1ijJqETYco31Irbw1tENrBm4HmLU7J7VmshoNLi6x5OY+jw/FNgMsPyuoAX/aMnvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148938; c=relaxed/simple;
	bh=isU3cKx6z+dmuFOPqBLIPDnV5d5B3vjWzpGiSLxKUtQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=qnCMOMV383ckDi9RlYDUKkIlAZRutR2/EUa/sHbHLzUILGOWNfHS4K5V4frwVAbyQrmMMqvwTQ22ERyIYQYspt5Qt2bQsTQBvPEhNTm7c7e352Ke5IEkDLv+afBRTy6x0kCmYurg3BxL4alDtP8vP6yI4AkdU4ccmT+0p/iNRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkXTkZRd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkXTkZRd"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so30313805e9.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756148934; x=1756753734; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wPLU0W3IRTpUatJPZDzm2e9XdWbVB0/tcSeFm/4RxLk=;
        b=nkXTkZRdBqjHTAG6NGYy2ULHkHpOEyVi9VdRj8hHasm97FNI1JByP/3dp/z0UtYaXs
         0z+veNmm8GInAl0N8jj+NCKj6wjyj4aQVAbvk16HsLzAUwLM8djiGXRdvk9khLye/SYt
         JXCNndcvDG/WCK2AQydwRHCHGL0Q6rSJU9k9pGGiBEHQ2HP8eeyI1FJsf1Wj9KqbSMO2
         8KdpQVOPAnYuk8Fp5tZA3ap8/9DrWYxZ6qfUmAiexb6bcN5kGkeKcJZi7X56suEc5Y2x
         G9EJwklR+mSP56Qx8pOmRIATvM1WKBdk/jW3sq1YuH1Sn4N/FnN67H15Pui/tOS0BUwJ
         r3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148934; x=1756753734;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPLU0W3IRTpUatJPZDzm2e9XdWbVB0/tcSeFm/4RxLk=;
        b=Jzs7fmOYh+5Rdl6X4N6zhtGRoPbPc7eyFdfR8q5sAQfKPU0wchBFw0G70+3iHzsaTT
         tLRmHoGI5v3TQCsmj4rdhxbvxAs0Wz4vTyOXwRlF7bqBlLHGh0Nj7oq6GFIigV6mcqfi
         kW3LNKmP8mWqistay3ZkAn8HoC8NMLLyTO3ZWr9qCkArlq9ngoUGUQZMam7biluSleV1
         Bx3uWOFcs1a8g/Dxkwycxua1R3Ng0GtLcmt9Kq7VfN5L60nJkCS97VEprKsiIA2HUOyB
         73gTVKLg6EUO3PxyS9CufFSxmDLMr97SMXzfayQD2rWQZqSjqBG85bDLYx/JFd9fGIou
         0eag==
X-Gm-Message-State: AOJu0Yy65NMZp/VWUjFVj71trEuA/gKz47RnI/qUAjIJlWwb1IzDK8lZ
	QAML5TxVwOTyMn3xI36tHMxhKiQZwiV8+8DrTXt56oAoaTbHlksC3Umll2WAcg==
X-Gm-Gg: ASbGnctDuUsrmt7gmeUURLzPHpXBtZDj3KaA+PqrdcGSRKy/hk7y2W7lx61JN5EPQ3r
	SdPM+29Q1AXFzEnoOVLYq0xuFAXQtlIjAij9XVJuvXhpJ4ACoD0msano84FK+Nn0uu1V5EEiCO4
	OLoyhC1uFAoE5Ir7RhIOXqS0k4pOlYkKhtfBT5jK4OJkaVckXWLCb26vG/dQkuJsT7amTf+ozoS
	/a/+8MAkWNH6hpjj76X9lKPHrZLHe4gD+0DCH1flPn06ABgoIKwouWQXnTWIawGk8YiWYByFx1D
	YuRXW2ob8sbGjNonT3AYdqv7IR4QjoELqJqcsCeOnAh/AqbLo1YMBo0sacWzBtNRV9CCAX3i8Fp
	gV2gV3wUNh24r9e9p2L5QMPmRjvM=
X-Google-Smtp-Source: AGHT+IEUT5vrnoXbK/5BcpTCIBJbQZBQV+3ctlpN/2MEEUAR0W4gHHTzRfbcjFSWDHTs+S9v+97V8g==
X-Received: by 2002:a05:600c:1ca8:b0:45b:47e1:ef7b with SMTP id 5b1f17b1804b1-45b657d6565mr5264655e9.17.1756148934242;
        Mon, 25 Aug 2025 12:08:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5747sm12542969f8f.48.2025.08.25.12.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:08:53 -0700 (PDT)
Message-Id: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Aug 2025 19:08:48 +0000
Subject: [PATCH 0/5] doc: git-checkout: clarify DESCRIPTION section
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
Cc: Julia Evans <julia@jvns.ca>

I got feedback from 21 Git users on the current version of the git checkout
man page to figure out what's confusing about the current text. The goal
here is to clarify the parts of the man page they found the most confusing,
while accurately communicating the same information as before.

About 50% of the users who gave the feedback said they've been using Git for
5-10 years and 50% have been using Git for 10+ years.

Julia Evans (5):
  doc: git-checkout: clarify intro
  doc: git-checkout: clarify `git checkout <branch>`
  doc: git-checkout: don't use "reset"
  doc: git-checkout: deduplicate --detach explanation
  doc: git-checkout: clarify restoring files section

 Documentation/git-checkout.adoc | 94 ++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 47 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1962%2Fjvns%2Fclarify-checkout-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1962/jvns/clarify-checkout-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1962
-- 
gitgitgadget
