Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713062F24
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727838286; cv=none; b=eajNvKiQAdBaU+wKvrX/tExq8ho/Icl+vYW4rBziO25VccxMQyJkRjijBphlYRSpP16WKruIJdqQ2defPY/sjvUZgCu9ayTN/DPw/bQKdRiAb6e+WC8gLsUZttHMAB5ovwrXB1fT/CfSjNnZf7Tp27mxuOo8iKXg1vf+UMAIhYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727838286; c=relaxed/simple;
	bh=AXTCyp6fgUjWZarOW973gAvismNjs8k+Ab6Q4SgykL4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bNC+AQLCyd4b6UtW2NlhbuIkaS21mz7+02qeFRXh56LdNHLeVm9c3+VciOOfOwP6qoeeu0mKTgPoIvxjHuVN15VcyIpEDgrgut6wqT1vO3Yumc1S0t1dSfcbpI/8xdIw4uHjy2Uy+Scght0sWmxDEPGvZyyHwPNin3FdcWJ06lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3DeGHny; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3DeGHny"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50790d1eac0so110748e0c.3
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 20:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727838284; x=1728443084; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AXTCyp6fgUjWZarOW973gAvismNjs8k+Ab6Q4SgykL4=;
        b=H3DeGHnyMs2OdmCqUofQSemxHsZL1mpinpfAsHtUBnD3k980bNOOUYhYb6SuaLDwQS
         lWzBafeoSse9bayIEBu+dRcOloibuAUtRzb+7po2nZsHYoX/y3rYvBMBrzkWIHRqiP76
         kdjhidTyus5IuEsFf18nbmOnKi5aGgRLbA5x2wBCSnzE7FXquyalSRqTgvinV2d8BwiL
         7mlgO1H89Qv7OBkXYIxU6NHn2IRDVD7fJxcVLZT/9Q2qzLt78CnGkSuc1C+8THIg5gvy
         gCMote4/ZOwlSvnkdpJWiYe6hJbUGRu11jjiArgfZSVn+YhsByerAxdrsID/dXnoGlJF
         1OyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727838284; x=1728443084;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXTCyp6fgUjWZarOW973gAvismNjs8k+Ab6Q4SgykL4=;
        b=enYyX98nZpA89BQ5CXFxlDPNirH7SZ/ooF8QS6Gp//2AAOp26YUX1NW8x4Q/ptEPiW
         rrMu4g5zJ8O1lJUMJPyoftwtvxXdJZ4jmvvBG/xbi5uaJfwrJfuvlcqDs3M5dSnJ8aHD
         buiOpcGoen1XmD71Y1T6eqKvkdwTY+Ar9lbncHnKQxUnv/yZIFDMk+WLdXR49X6WAG/G
         RMX+0qNzJqz69O6WXltwxNGuUyl2Iqp8VQGKNJJEKVQBFt4ch0A9xt8lky4QjpuGztuM
         ZhvYFMCAMJHQjzaA8Da4wCcuStmiJBddnf8FNj+t+XEBiOTg0tcqh7drN3+S6JnQFAAU
         EuFA==
X-Gm-Message-State: AOJu0Yx3w4DENOXZ2+AhZs+fFi4bsse3+Y4dmthJbJFIuAMiToyGGw6Q
	FGZ+wFYHMhxho94eStHt601XL85oi4yyEBWaasGi6GE2dIrRhjUUdx+ankpm2ZiauPnKUyaQo0y
	Fx3CBxj7QZv17aGMME2SD4uBjMz0XUY2NOjE=
X-Google-Smtp-Source: AGHT+IFiCFD8TOVtN7bK+NopUlv7EIesbLOuxH6bo4Tf59GMdOUSDVos+PYIoId/mN0GTfLKiz1zBe8qsUUgTNev06k=
X-Received: by 2002:a05:6122:927:b0:507:908f:9b95 with SMTP id
 71dfb90a1353d-50c5828b738mr747200e0c.2.1727838284047; Tue, 01 Oct 2024
 20:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abraham Samuel <sammymore50@gmail.com>
Date: Wed, 2 Oct 2024 04:04:34 +0100
Message-ID: <CAO1n884e13_9FZDBtcFrwU8oCyv+0_WUT-c16qN0W9c+D6k2PQ@mail.gmail.com>
Subject: [Outreachy]
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I'm Adekunle an Outreachy 2024 intern. I am most excited and
eager to start making valuable contributions to this project. Thanks
