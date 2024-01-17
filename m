Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E924A00
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521160; cv=none; b=Ds0Uh2J0S/4XeodML2ihH0/RsmkfbwstOaaimXflB4mt1oM/HVLA41aAjyvB81PR9uWMYHrh6zVnP4/pXswP4d0fIluaf5d45oIzODcdZaEyXeiMsirtPWeLht7wKdJv1iVRvLXq+KCHDpW96e+E0wM9ZOZkv/7Y3SDOGN7ACIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521160; c=relaxed/simple;
	bh=RoxdyeC6cpOQLjPIp6RXwh6Y/LLzeAzU8RMOZR2wtUI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=L7nYMBWigst+WQ9j25gGWekOM7XVx91OKnC1YzlRp8kMUvvVHuvzdn0vwW0ymjHB0O3cEQF4ydLi8AVHFvLQsr3hNQ7ht6inTif0TgILJuYk3attG16lfLOw4EeoDoODV7HJGkcmqscQcvGnHEKaAznlz6anQU486wjQZfLk9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEBwp+Yv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEBwp+Yv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e884de7b9so14958615e9.0
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521157; x=1706125957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUk5maxfA9DavACZ1/BEbKnbdW5wjnD8zLg2BFTrtDU=;
        b=AEBwp+YvWrJHrfCIL0VwaC8Bt9VHI77K4D4bEjx+cfCG98knKYQvsWCHYkx7JUXVmM
         VzacOcMU2krT2rKoO/WVUls83/tDZmZzkRVYQUP9jqhPOF1z1bdew6Bnu8Irtbd/NlNQ
         Jq3ybb34IR6fVstHUZI4N6sKwzMCwvEeEEAKpmCVrJLryCQZwcwCmMEMIr2YB/lNCOgI
         m5C/JLuZ/OhHWYOCY/uGHrIe6soLPrfPi7W+zcAIAbogSRrbsScT0xsPJjOYROSrsm9F
         Fl7ZBD9zRNhvd+6n9/rU8BU5CRhYkTyszD1/E9ksiHwxYYL4Yb6dpPdJMGOJFkKnT3zw
         YHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521157; x=1706125957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUk5maxfA9DavACZ1/BEbKnbdW5wjnD8zLg2BFTrtDU=;
        b=JdCKEMJDhFIwWrJgnwc8+5GTfrWwI0SlY8MPVeV5Lli+52gUM9HULQ6av9ffQbLbTY
         JH/+o897/3CubyYah7K365FkD+gJ31Qd/1c5jQv34iznyCFIweTJF96AnazYabLy/tsc
         2jcJDgPM1viYpK5VXipDMNHTz79qY3VAz2GIuafarUqvTTRMYHsweDT9uprMOGIuiGls
         sCX0hTVN5YoXcqKR/mFgPFJoZNzemj83w/zgHjq8Uzc2LwUKBE5JlHPvWR8UjXoznNhz
         l2c+hAAqJFPWMRnZ/MgZTfsS5l7gyQUNJw0jdaD2zcfX8tBroWDTtHQ5d7RskyvLNwoi
         SL4A==
X-Gm-Message-State: AOJu0YzjPuHK7PUdvBE1QQ+tXvuRRkqjcJ6+LPHa6tMAUsM7qU4RGZbL
	d4MKkJDOBMQw413dvmTExdGTX8KJKU0=
X-Google-Smtp-Source: AGHT+IEwI5hMz5Rk83Gc41hIcDE1dS97SZY+QOp3DhOYHqXVy8+Uc2DZcm4VpOfoneC6WatTNvJEcA==
X-Received: by 2002:a05:600c:a297:b0:40e:4a29:d267 with SMTP id hu23-20020a05600ca29700b0040e4a29d267mr5002368wmb.227.1705521156948;
        Wed, 17 Jan 2024 11:52:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b0040d5f466deesm23331022wmq.38.2024.01.17.11.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:36 -0800 (PST)
Message-ID: <0e2b6e197ab2fbfc81a42fd601b6aaf41e38929f.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:24 +0000
Subject: [PATCH 01/12] t3210: move to t0602
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move t3210 to t0602, since these tests are reffiles specific in that
they modify loose refs manually. This is part of the effort to
categorize these tests together based on the ref backend they test. When
we upstream the reftable backend, we can add more tests to t06xx. This
way, all tests that test specific ref backend behavior will be grouped
together.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/{t3210-pack-refs.sh => t0602-reffiles-pack-refs.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename t/{t3210-pack-refs.sh => t0602-reffiles-pack-refs.sh} (100%)

diff --git a/t/t3210-pack-refs.sh b/t/t0602-reffiles-pack-refs.sh
similarity index 100%
rename from t/t3210-pack-refs.sh
rename to t/t0602-reffiles-pack-refs.sh
-- 
gitgitgadget

