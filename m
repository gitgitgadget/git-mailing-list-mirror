Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA91A3166
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193005; cv=none; b=AJ9P6BhhXr094lnrfJ9HP0I1nYrdCRlTTfTVPg5vA69wCJCJz5rvwqQXSjPWKBJ9P+FQo3bEMvjCo2ps+nT2c3H1jFwRD5+yADHbEZRgdXm4R6d+rw80AYh+VHljL8C0/XrBL2vm2BZq1AdHKX9wY3Zw7caFQaXjZUfhWfDDTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193005; c=relaxed/simple;
	bh=xFJ0r3CmoJZ6UyRYai7mT/5QLSk7pyhzgXhjzS0bmeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uY+8PWcvlFchs8pclIOJyi56rb0ZghY4XxMd1kmUorYwLzqoq5LfjLwoiD7Bhq2xDPV7Q7w3HPFe/uBya0wysJCqiAH8IzrCj2ZCdd68CNgE/UDnz7V/DGdXEiMyA0dosAIwIW12T10P3JP5KO7k9aG8l0GFdm4a/Z4wSioB89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsFCxXMh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsFCxXMh"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so5331847e87.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776193002; x=1776797802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD4Bt6hysdxBpW1+ioKiRamafgVedNaK05iC8vwjISQ=;
        b=RsFCxXMhglBqxj9nkiV/dgyg2/e0GJNgOAs6oLJlHdk8sYEW+klcIacLJrPu8gAYkF
         TCFiVOPO3O1OH3h/mkebMpcVS6qt97PTIhNupYP5XWacy3EQj+1zLYT+LpBmtgWtTXdW
         hwP9Ayds8e/f8nLflRas2UCjjRUSTTagALprkyPFDyZfpJ3zQDsLn+xHhKAkQKTLJiDm
         TBboYxrYEQoKvqWgGFHbPM6DCU6FO8+G38zm80tzoTlfdOyTeyGUvP+ZWJtkBPhVYvwB
         +rK/HANqLPIh/2VHYyME785lrEjqcZOxK6PbNtwyE59ueyLOQj25mcq7kSpUO3WWh25b
         QhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776193002; x=1776797802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JD4Bt6hysdxBpW1+ioKiRamafgVedNaK05iC8vwjISQ=;
        b=H4Ds7dewfgPYevbOkZIpYkBDjOvXJQGb/Ftv6lqe8JBObb2IunqQK5xtbhG9ZLmEM7
         Kr5vFIU/MmBF4Zk0Ag1H6y8FaLiMDJQWmgkYdKxXZ20BLv9AfmX6uPEGzffRJRjFpagV
         nE0AVOeUPc+/bO18FN1z/DJQtye2sRcDRNO+oKoYMfEXWkuuAH4BDvihMa6DulfZOzCY
         Ks+nXvZFlwjjYV8q+pLE7meKujsa8FM9znXRIpuWDr3c3k78iBuUuU+Liu8yV6bj3ZpZ
         64m0z1jdGS98m0tTdsMhRiR29mhJkDwBOx/DLfG0NA4F0scG4Rqna5ZOzBXZ5wwRbO08
         0fjw==
X-Forwarded-Encrypted: i=1; AFNElJ9ua6C8BRJG9VHTP523iYJo/4Ug8g8ycCeZAZXY3ucImEYAEfi0T6+gmKk325w+VaJF+jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxONzMMCm9os2ugqgqQxH3C6OlJr14tDXt1gKyiZU+jlJqKU8
	MDbJ1tDUOayunJjZAp6fNYtd5AlhTGNI6QphhnVr1ktmo/XO7pK2pAEv
X-Gm-Gg: AeBDiev7wpf90ER31thS77jQW+Gj2eZtIMpbbmnVTEeRAADcKuop2/oGABDy/jzb/p9
	6spu31v3eeo7QJ8WOkbp0lvVgblgL/18751psibry/WIHDh5WPR0eg8zQ5W7FNB0vVwOZgrP/Xx
	SseXp/P9douRaOFXa1Mv/zWRcgWhku9KkE7GRoLuwqFHN060Kyfe5NYHBK3bLuH/gaYzqA6SHtW
	tA8WLgiECVTDJk3xNJtEvaB5Tr0WgT86Br9WsDvyN+ZuZsfuSktttsRmjXUbql7wviRx2tBR4w7
	DWNQ9Xi2wZ595OwhJoyBNeHTP1rIbjqBDZ8PKRJzYvXghH+c9HNrNVh8jsYLJOHSHX6YuE8N6jU
	XqZbIH9kgKc5s8TGU1hpjdRN4+7OKGSDpBspHauS41q6VfZoiNCGDF4vlvZ3F+JUHWtnfqOD06s
	R37PWmW+iQdV8x09it1X1IONppAaaIPhfXioqzNEPPBv/3xSHe0a7txeH0PH2uY2eGjgOn7UzIb
	Wj7LbP4GnO2/54i4tpE72COV4c=
X-Received: by 2002:a05:6512:1250:b0:5a4:74e:5f75 with SMTP id 2adb3069b0e04-5a4074e6028mr530014e87.1.1776193001975;
        Tue, 14 Apr 2026 11:56:41 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eeef3620sm3447224e87.57.2026.04.14.11.56.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 11:56:41 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 14 Apr 2026 20:56:40 +0200
Message-ID: <20260414185640.16609-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.77.g97a5d87c81
In-Reply-To: <d5a47638-545b-44b3-9da5-803c06b3f98a@gmail.com>
References: <d5a47638-545b-44b3-9da5-803c06b3f98a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> There are only four callers of do_apply_stash so it might be better just 
> to change the function signature and update the existing callers rather 
> than adding another function.

Also a good point, and I will update it.

Harald
