Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27691A9F90
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771660925; cv=none; b=BfMXw22Eu8UuOzqd3zuGy6CynURD4D6LXHocx17sLsbP5j3yXPoIDZWuvP22TyjEOBZbutGavD6U8zOA4gXzRgTkcbjmVEL6N3pLhzWNpJJP0X7kgEQrNw3E7SukmE93UpPv63eCn67JZk42TCkaRkco93YeCixJOiSA9PcGfGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771660925; c=relaxed/simple;
	bh=EMezMcZ7Cnpxy6tKkXOdPnd/mjPztuFS/knvswVlaMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7eM+mRJ928FuXYXdHGaLEnEIcUvgOmV5y4KgcchewG/ONdAYiioa0cWI4BBslhjvqHKFOdQQvUktdKQcnxJ+2p6hzmyYZ5xcRoE+5dlPXFQJwR4+LD3sStOF8Mmr1o0auAk+Swa1gb+8zPyL9BlqtFFwsXwzjdflEL4UVz7epw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9cza94e; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9cza94e"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59de66fda55so3092397e87.3
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 00:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771660923; x=1772265723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMezMcZ7Cnpxy6tKkXOdPnd/mjPztuFS/knvswVlaMs=;
        b=G9cza94eR1tNmwHTws/ZYjqkt6inslbpg+uVFPWBK1ATSzHFNRkW4AyQ0mauZUy9zC
         Nzjd1lW6LM+xlRMLLCQoCaXzJ5rVak9ilHaQ8It4RjT51W+WOQzW1Ztdh9yu8JdW7yw6
         VjmM8Tcy1Gky2/XylVDGbd76w/5V5nQpCKu5KrCPKqhttS5YIYPth3Dk8ITil+3eKvOB
         vN4I1WoC3cnmYURCyli8E9TxsyinWUWmVZAZCNATsVF4xPGUxGBynfD8egDzHLJDYPPc
         XqwpxAQ6x4I105ZvxifNJ8expnsz4FlvYAfhEyVMswAqE1upbxhSckAWGfbTkFe+MYlV
         +YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771660923; x=1772265723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EMezMcZ7Cnpxy6tKkXOdPnd/mjPztuFS/knvswVlaMs=;
        b=dT3y2RhOQDKemtary7dXzw8uuZf/R543igZ+Jh39Pk4yIKHYo3m9FOVLLnIU8FJEkU
         DnEzlSlLNFlt834A5mmpz9JFeyWZnspYtjVpMmLITTXtOiYVipUwl4u8ZBcN1V939F4u
         40cYznZZ7fiR7B1yJMYaktYGFw1X9AAht+evzQfGSacT7Xnh3Xa1qek3z0tLKIS+Vrqj
         uSSEBfqmfZQ7ZOVJfFSYa/ekIA+eX16MN0qk03Ed8eIgaS7K534p0fm94JIobgK/bRZI
         eNjvvl3XmdQ9gGuKscRujr9Fhp671GRra1Cn3pFM+dR930LwGinZpTcHyWDQVI6jd61S
         75lg==
X-Gm-Message-State: AOJu0Yzfnqs7sM6AdhucSITyRxJS02VBcCY3hshqc5pZvJ/kodahlYVi
	H32sVKvlcoH9D19uoosw7f8GZ41f4D1uZg/3FUgqLBW/hMbaOqdN2FUG
X-Gm-Gg: AZuq6aJCd0duBgoX1LiaT5XYBaZt3EebTz2CVDvrtJYGSSbiy9a5zLjFAmRstWPC/NO
	dak1GBVgRNnFoDx9zrBGBR+NJ/ONEa91gR1MXgpgxl3MQSRss0/DVDfD3kqO21Ythom2LHKK7G+
	el4Au3YuokbUe88KpZBgc+JP+JBDT2C5rOJAPxoE3MqEvEDMlyxHVUZaXZTCuG9f4HOFTAUdGez
	FM4sP5lMtEsOflGLbUij/TTGZcpUD/XkpVsWH1qhDaT2GY5+x7B9lBhEkXo2wWPNiFcrWSW/5X0
	6o1OIujMBjREGB4mjdUGvKxSJX9kGo6Bu7p+e/O8xolcMeFIMgugj4HjGtqKgw3BmHDvKyxgG5P
	+WuIx9dZMiXj0oADKpWAjA3uEQ1b3gXhZzm6CKORw2O8+xxPV9/OxbhygYQbGSIz5ZjqMZB7TRO
	38lfDeEZekOVJdysMzL2gqy3zQ66Kbn0LhB1oH5dGF/3dUW0OszfbQ/rjs6k2EOrmSYh18iTOUq
	CESX0mTzeodDgK5F8hsc6bltAo=
X-Received: by 2002:a05:6512:1306:b0:59e:6447:f520 with SMTP id 2adb3069b0e04-5a0ed99d856mr685271e87.37.1771660922698;
        Sat, 21 Feb 2026 00:02:02 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb3eaf1sm308476e87.53.2026.02.21.00.02.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Feb 2026 00:02:01 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	peff@peff.net,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for multiple branch comparisons
Date: Sat, 21 Feb 2026 09:02:01 +0100
Message-ID: <20260221080201.7847-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <067978dd0946732e00e4805d62ea51348fbf336e.1769112471.git.gitgitgadget@gmail.com>
References: <067978dd0946732e00e4805d62ea51348fbf336e.1769112471.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio and Jeff!

I see that this topic has now been marked as "Stale". Isn't it time to
merge this now?

We went to several rounds of reviews and edits to reach something that I
think everyone agrees with 🤗


Harald
