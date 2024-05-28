Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5B16C6B1
	for <git@vger.kernel.org>; Tue, 28 May 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896379; cv=none; b=hd1P5teZfNtLz4GK4DXPTdL4BiP2wM2dLJc0MU6wGkRX/MkS484Zd8VaWR6VBaOCrRD6p0o5tMy4wZFmhlZdhyshG2OT2/t7gqFlpP8XDrgEUDUpre5sJzqeBX4+lOFzLjdPZorBm3kopFgECacdZ3y1ntUHFSB+m/zrDLkt8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896379; c=relaxed/simple;
	bh=fKPHavjjDeFA5+e/RziDEDC0Q5qsdPTXOW2Qnr0OqL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePCgq6DObxmYpfbGLDfuY28Bie8agFkA1su209aXtU9nPSPPDcJddTAKtqF9504Cwx/+RWDS5i1ZYuiTsxwoJcbd1N8etEwicacyjwaMouiQDFIUNUDJDiUpvF7rgFgh43IzWgu+npT5e+jYeiZGgQ9n+fVPwTl8Xa2bcX1uHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNgelkOU; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNgelkOU"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-373d996847cso3293655ab.1
        for <git@vger.kernel.org>; Tue, 28 May 2024 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716896377; x=1717501177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKPHavjjDeFA5+e/RziDEDC0Q5qsdPTXOW2Qnr0OqL8=;
        b=DNgelkOUJOahne9h0cF+XVr9YmCZzq3JJCHsXwyK5TlOQU4/sxqWBQNwZD9cveaGZ8
         piJjdNE/xaSucdpiwFTnOxZGHAgLj+FSUy5/v9S+c3AEqyXUbsvVdTmxkFWQbhoJb1uG
         33DtpZd7JUSECDdgPMJH6cGfRQP3vKphbAB8NKtgAbzi0RCUqLk/BWbEz1+pQ5iv64+C
         YXAplYvSNe6nxF2MOCL8znkCPsRwvx3YeAPX58NyEJiKj3+rTNDbbeC8NR/xHB+n+m6S
         ++3cWeTzBL7pPzOaV0BQJZehlQLLMh21U2w1OOZu/gHzbK9RN9zMZAyZOuM/2mldfxIG
         zIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896377; x=1717501177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKPHavjjDeFA5+e/RziDEDC0Q5qsdPTXOW2Qnr0OqL8=;
        b=gxaxoTEW1VYS/ZXDNy51wUHfxrh0PlBbxj5joexn5H7IvS7YFT+S0Du4vtfj24Godv
         Qne2tTsPCvz/ZTsa5TPAXT6brCA6HTFf4ZRu4OEb06ypEErvJmX34nLy8G32g1yJ8gaf
         vFEmam7F7+OoPKfJ9LHZRnsyJZXJ5TWpih9dq1nhyCbUsbJGLoh+SeWPV7rmAoIAZLr2
         Fs6lvCHtGJisLCYpA0Gx5XrOJm7jpr3iL2OdkuBPZlFNd8GhY81XgvjFrgqO36NTnbaE
         s8zDeOArBT1UcaaEFIf1tMRvuio+tiukkHT0cqChMre4K6fu/vmvGCEdOW/jT6aEGdw+
         /JjA==
X-Gm-Message-State: AOJu0YxDz/dKaL4AqkhUrLtTKmefL0qGDKsmYX1oBXcGosyawh+bfCDO
	z743N+E6oV0yBxfqnor5FzeEak6TTRtxzZllboXSWsm4Xjyr/oEC1Kc01iYw
X-Google-Smtp-Source: AGHT+IE2qnssmqHDwIywPZxeszquJb54IoC9yABJhb63T8qVV4zrd+oFogcSZ6S4iNwFi6QNYiJ+xQ==
X-Received: by 2002:a05:6e02:1a26:b0:36c:5124:eb35 with SMTP id e9e14a558f8ab-3737b28aa45mr141102165ab.3.1716896376524;
        Tue, 28 May 2024 04:39:36 -0700 (PDT)
Received: from Ubuntu.. ([171.51.165.3])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-682229ddfe5sm7375738a12.53.2024.05.28.04.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:39:36 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH] t: port reftable/basics_test.c to the unit testing
Date: Tue, 28 May 2024 17:00:01 +0530
Message-ID: <20240528113856.8348-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
testing framework written entirely in C was introduced to the Git project
aimed at simplifying testing and reducing test run times.

Currently, tests for the raftable refs-backend are performed by a custom
testing framework defined by reftable/test_framework.{c, h}. Port
reftable/basics_test.c to the unit testing framework and improve upon
the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

