Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD322D5412
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139092; cv=none; b=n3nfzH0qWUKgEYOKh3fMbkibxsBbN5CC8GJx+X875Amy9GiqRlr7AuBR+QSrZ9f23Pdud/oZ7aJCMufFBzY5FUGXKgwnCNuYRfXv2bufnpj41qHtmC1fllsghBoY1mYS2dyWhT3Xdpj/Hlnf4/z7/qpD6gwjTHsUu5DfBhaGeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139092; c=relaxed/simple;
	bh=KItqbkBAw6/pA2yhv7MPqq4FCcyChJiAw9HCOruLdwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dt58gVf6eyqgT8DaylgB+l2MDpkk1/eYSZ3vib7y2DDTSeT0uVo/3rkZ0WSeQ5zxcGKuRurq/2NEfCjtaERWZkJE9YNOAirqcaJtyF2xZ6YI1PAdWhvOZeZ/CuPwHpposvpUENVhXYAesJ71gDwNyUfX1j/leuLbAcmoKRT/ouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzXOIrfk; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzXOIrfk"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38dfb789d7fso67230301fa.2
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777139090; x=1777743890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KItqbkBAw6/pA2yhv7MPqq4FCcyChJiAw9HCOruLdwc=;
        b=VzXOIrfkwVq3rtnpe198kmO0DFvMTgsyaaN7G+2YiGp9QXmZ3MOVtWEjZ2zwcm6WDu
         1j61K01NFdoXD0EC3qA4c5j97uDG5/XV0OF4KR9Gg5ZVNctMbB4Yy8YiFh4/ecls+Ycw
         o9CNlAmBUlTo0dW9j5V0jeEDuT6WW+V6G0HtjMeV20iaVsXtckOXYUzP+gUTv2xEZZqX
         Gc0l40vD9A8LTZFIqdzxQ9L/q48SQC+UOqNkLsPIYy6h9exI0t+xwvHyMbHVnS7DD76X
         1gYsRKpjsnz4DkDK4ioVW42N6Yo9ukaFb1AXH4ug/yKZAgKZPyMDlllkByqW/jg77TSj
         oNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139090; x=1777743890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KItqbkBAw6/pA2yhv7MPqq4FCcyChJiAw9HCOruLdwc=;
        b=mpfqERidU0SPLQd0+xeEiPBihKITu0VMe4j6BRdnFoVUbqnhm795aIvchXyKVK13LB
         YowtDX7ovIJSRwk3T+vjgqgsWFl33jLhNqv+FMewgyiUVZadE0ZN5qtVV/mTH5OReqi2
         XOc1QlvpI2g/qSrtd/EbZBPTMG85By1091SJApuDakPggUoeQRRqzBqDc861UxySxm4v
         Zn50LQ4fNH3kaHzOT2NHgWuRo3aUwN6p5Omqmxwf3nKLe2VREv3CRwQme5AMP8SU8hX9
         m8kVZDZFY+ZWPB1NQ8Ul+rGRJrCJZFiGe0QIiEad1DxlHdOUskZ/b5PLUfDWVnvYapPf
         7Vkg==
X-Gm-Message-State: AOJu0Yy46oPDMbt61SgtwcySVRmesjzrO4Bz/3FODzjlxSSz0jaB9g+n
	zyZy71gylmVbrQh3LbBf+em/jNeeFExfQnLIecCWpfWkSEN8JE4shWEp
X-Gm-Gg: AeBDieu9nblCvLJO4wHTFGWfUdXVihqvZlyRI1ib6e6+3HrjVFmSF3ytm4tN8mmhK/C
	FNouq36pp9T/l3OzSaIFAGeVsPpnFgnW92JDIkJy1mFduMExmRrd/4SMHmAHO7oK0h4zqeNqw1b
	Y9usre1Ec2H3ccYlBQbWqmZ4wOxsGHMKzgExWp3mSnmmC0sFhOg7nRI9wm30Wc5uFaHEAN+pjDY
	aoWR9UpKeg1rszV6/JaAA9u+xNEGtnmUHycgSxVqrN/8t50KdIzP0y+fP2AsKnGYddfqIGx/ZM1
	CeUMXHNOJ1t8h+qfmkAvbWWpVwdFFOYekgCoF8G62tv5rV9QxJTLK2b7jnJlESymZaE724/NH67
	L/h2AirPazZ4dNP4o50kQN1EaOFDYMbaFZkLLgbXQUbj+hc7bXXpSs7eX7rWpV73SuERVtiyyyh
	/UKVxd6eb4FtjesWn4I6s9yFc0IE1mGwpkM2fmjNibbYbfWUTvuE3Z6BaGH5h3ES9TG1wzoLhj+
	XRqarDLhZzPfZcMB6xWKNXMOaY=
X-Received: by 2002:a05:651c:1584:b0:38a:27e:b931 with SMTP id 38308e7fff4ca-38ec77f8174mr89714571fa.6.1777139089778;
        Sat, 25 Apr 2026 10:44:49 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb75e67dsm57263951fa.40.2026.04.25.10.44.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Apr 2026 10:44:49 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	kristofferhaugsbakk@fastmail.com
Subject: Wrong subject line
Date: Sat, 25 Apr 2026 19:44:48 +0200
Message-ID: <20260425174448.45681-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <20260425174157.44868-1-haraldnordgren@gmail.com>
References: <20260425174157.44868-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I know you are not Ben. Forgot to change the subject line from a previous message.


Harald
