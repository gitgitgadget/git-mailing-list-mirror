Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06A48094F
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557604; cv=none; b=YeD82PoC4r5lkeE+W8rudg1IDm2emo3onkBPRIdT7lCvZzau+8OI3+atuj6rMkP/m3pvRLD0Opg7SFbAN5k8PZIQAxSE0xOE6eLDqHdtpugxqwBLF5rEB1EG1QFK0xOpZPAM7Jmfj+9qDngpnhdOKzo8lrKapMNjvFyR1rEeZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557604; c=relaxed/simple;
	bh=h6LuXs54pMSsekmvT3jikECK8fWntqIsmqeGq3TvaGE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dMawj38NXb+sacnsp3E57qYFzcJgrXgyb/Xd9x69EkoyvaYE8pshXhY+SUmP15X4udaOx3mbx/TffcHas2OAfxaEJYtKOFmCtm8vly/o1xULMMLc2uLa0NHdcVtKaMBfuV9RAIb/oSefT0TvPMOWcVUXJKKbQWlW5QYZrF1So5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwOhz0j1; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwOhz0j1"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92f03daaa97so84082685a.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 11:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786557601; x=1787162401; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mM7ivQ/asZAQyoQr+1Fxp1/XIRVB8NEjjH4JU9Uu0UY=;
        b=TwOhz0j1AoUPWWEAB4X1sR6AUC2iARwXCz/YST5kR5WoPbmjypt1ZARMrLbAJg5KPC
         gUCj8/ckfzxyVpupTRgoj7vgiq5uFA6rUHg9eZOI/GnoapNjQTVkl+Uvk2AktADHFPJR
         Hp4Xr5Jlci7uS0MkgSRXvONllSxNrL47IuEILegxSu6NyxXg7O0FFlVmZeeBQSWjWHJt
         V7HjZfwEGnVSVp9y9oR6fVQ6sauSjoHuVdcBDol4KIS4o1HFV/GNscVV+mY//wKdZ+Rg
         hsHEPG5stwiXdhl/iqfb1NrL4BBh6opZatX4JxC7Y1O08ISEsxEmbhKJ8/SeNAsoxexM
         2LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786557601; x=1787162401;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mM7ivQ/asZAQyoQr+1Fxp1/XIRVB8NEjjH4JU9Uu0UY=;
        b=VJYLmpOnBdgD93kHNHNkTDTbnfXJv0oamuIr2qL30lfEsHW2z7vaaMbCU302fZDjtU
         IuWfb5CX9Y3Pir67M6agTB+GHvkfT8aVWrMDFhKz6m3Itz6GZGyCpQfRhNfuwKGxSz9q
         DFXj5O8513Ux1zIzaanhY0zeYxia0q5XGWzxp/euEwlUQm2TIBG6yePICVBg3ohTAB8g
         dKsrFhnWXCgx29xRj2FRYsdsACh8AqNgV4/Y97aZ1roH7zOCl6SV/6bZ86Gx0HOrcu4Z
         9j5yE52PlSBfangAoPM+HJdm6JuvHI0u6pJKSH0JCbLIsnLN6bCZttBYN8v50PAc5yoo
         98Eg==
X-Gm-Message-State: AOJu0YwywzS1199IMotcsQ3Ddct6AbUmwcu2xoSlXRB8dtfdBq83txi5
	gdD9KLa8un65E6Qiaoi9yR6Kor1ZMdNXAga406DyW6E8lBAaYM5F9tgLCriknD7K
X-Gm-Gg: AR+sD12vtuktvgYLQZsbQIvtfe1EQyQhWB4nJ21WQw+SlBm/BAKgbBYtldLmwsrPWkf
	oiT0MFbor5Z+pJn3ndt5KAgYA4HrCyPZYjW2xxD4pn8r1y20QmuKX0Laz1QT8DB2NJeiQY9CQb0
	r9G2NCUNbx/O7g8SVK6zDtZKBuZdetyAHfvI6h+vY/L9AKRADw0u0NunOQU3m4IfnQOOa/0AsNN
	ZsphUtqF6kxGgAtM/r9jYNzuKF2ztCR6yq9PQCnA6+wvvctNauajRJshl8qOlcGoO5pf5D16Okq
	M1wDbGThAB3TdE2kwXl/B3cjSaRcFybdFWySeritIi1FOM9Z7BMHZ/KYnPu7+WbHZzazZZjgxSO
	E+eRTPhccCqqN8UM487MkZT5PXzF0DhuXXJjCx5gScR5GTj0c2tljeldhugEnYTeW0ifcDL3ieH
	YO5YtEP+TqO07a72FA4LVBbFJxe/08Qj9uiE2sv0+LgE5JpaQubPM1KhHI8dS1
X-Received: by 2002:a05:620a:319a:b0:92e:e3eb:de54 with SMTP id af79cd13be357-936b3a344b5mr594263185a.11.1786557601422;
        Wed, 12 Aug 2026 11:00:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.94.54.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5f720eesm180971785a.47.2026.08.12.11.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:00:00 -0700 (PDT)
Message-Id: <pull.2201.git.1786557600355.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 17:59:59 +0000
Subject: [PATCH] mailmap: map Elijah Newren's current and previous work
 addresses
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    mailmap: map Elijah Newren's current and previous work addresses

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2201%2Fnewren%2Fadd-newren-mailmap-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2201/newren/add-newren-mailmap-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2201

 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 48c34797b9..e3fab1df9d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -66,6 +66,8 @@ Derrick Stolee <stolee@gmail.com> <dstolee@microsoft.com>
 Deskin Miller <deskinm@umich.edu>
 Đoàn Trần Công Danh <congdanhqx@gmail.com> Doan Tran Cong Danh
 Dirk Süsserott <newsletter@dirk.my1.cc>
+Elijah Newren <newren@gmail.com> <newren@palantir.com>
+Elijah Newren <newren@gmail.com> <newren@github.com>
 Emily Shaffer <nasamuffin@google.com> <emilyshaffer@google.com>
 Eric Blake <eblake@redhat.com> <ebb9@byu.net>
 Eric Hanchrow <eric.hanchrow@gmail.com> <offby1@blarg.net>

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
gitgitgadget
