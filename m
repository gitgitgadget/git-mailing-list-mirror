Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063D372EFB
	for <git@vger.kernel.org>; Thu,  7 May 2026 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184891; cv=none; b=HXyDXT0lEpW6Bz1666C1uFsYXGVCNx9ODMXC6Fe1jmE1kZCpW1UJbghaupDUHKC6h7fnAyTP2/ho4S2wMZb0NZg8OV7/1QoUdExXEB8Ag02d4su01swA9LTz0Yl/LD4H2SooPlXCjRYO5lzm7zb4DMIbPOu+IGwc511Zo+rqQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184891; c=relaxed/simple;
	bh=JC8kTXDusvFJhEFQjKCyHFN1npRBiYxjUYPHIsjiMpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqZKWsj6b+TXDbZvYl182vEE0ivqw/fnCke+7mu2YJIhaftSWZAeQuW7R0eOTHQv7jYTB+Mx+7fasxPcdaXjNMKcZB4cb4yt2duVv9DveKIYN+lMcqT1q9ZA/Ro5nU2DH8FZHr5wzCcsby8tCEEZt0P8wZl4pjGccVKEaJv6Kh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8vvvt1Q; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8vvvt1Q"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so1554859e87.1
        for <git@vger.kernel.org>; Thu, 07 May 2026 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778184888; x=1778789688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC8kTXDusvFJhEFQjKCyHFN1npRBiYxjUYPHIsjiMpA=;
        b=F8vvvt1Qwd8yzf2xLST3CVjbVDSnLAwFUEbwbJmKKGvwuIXVDkgPtQgPLgSBN2dsM9
         v+1FQfJF2M4ClY6hZkjufIvZtGsccaAleZQonJit06tJ6VmAYwfH2csp97UtF1RBVUh4
         iTNY7HAY2RXNZn4AqtYwMQTkMkKTF0wG+hacU315vE5WChif3nrCvCc2qo251ECY5Uf1
         BpalMS3YVIdOJhD/uS38wtsc6sfk8iQEEDtCbWp4RxyCrcr8Mf0NJ9BkanN9LgW1zT+m
         lILFki2W+kmcTYVAbTfOzs4kTwul/I1ZSKB3nAyUBgw32D6UiGm8t8zQzznvnXCOvZOV
         vLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184888; x=1778789688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JC8kTXDusvFJhEFQjKCyHFN1npRBiYxjUYPHIsjiMpA=;
        b=P0BiUktpriG1OqFJBhn3lDKW2XQRqJbLhreUP7gXoPJlcLhq04JQcXTyxlywCUowsr
         PKwNTfa7qGU+8DZTSyjIQyFtwPGubet+c+COU+E/hGWLeQq7bJ5twxnvuOoDAtfNE867
         Y+0xPptNfG1bQVXHb954r8kIJHrLymORPbXvRMgCkEK8Imx6A+GUSeV9FbGjQ9iLN8fa
         nptwFeF27HXnGhh3JCXgNMb9IqWDQprzFTV0GQP4GRl7Ax7tqFbSj9ZZVCj3gBt2LXJG
         cxS4uoasJeDB4UxfeSjP+5KPrdueQh6B32bVs05nZpaG1M/eCOwaF37uwvDPPv/FBJle
         i0AQ==
X-Gm-Message-State: AOJu0Yx6BfCjGF45KPDxFANbE7oAs73paWGqaVnPBBUCmBkW4GsUuRpi
	hpO8FeF9OW0bGIifrIdJiG6Oo4r8y/+BjVsFWHWdZqT8KDkDbQU3QJV2
X-Gm-Gg: AeBDieuDlzvGFVhCZ5LrM9mrACeC7Pl3pkLVmWtrC0pnfsUCVvfSrmeQWG+ll0ze19z
	bnnkbxxiQYZ0feK+8iWoal5Fr0rA+9s4XfeyQQxRKU7vur2K4nuwZQ0+N2MO9v1phOq7ndbgjjE
	Qjf7tToPlXwP9mByEcj0Kl3bwkDwlHasNVnLQKcyd6x2SxW21BPlAXO1krv0QKsZRpKbmWe09sO
	JP3ShOp2JeZkQKZxh5diqm/IVyXsxSYgWQVeY6JUGqT6bJmnni+Xri0XGaykAXRaQnBY7xL50n+
	QZtGVyZ3zOMYHLJBe7M0WYiwJXALyaHv2cdWltYeVndJlJD/qWqSBECf1Ck3AF4HhTlPSW9+XKm
	DFoNcPJkczIaLXYg5v5a9AD1uOF050W2cWeGXnF1Sm+tHVw9ZQzeuwUlu5hcPvBl3Q0KL6qBf5v
	sYKEYfp5oOqTsJuCHZpZ/TErTW2Y5DRokb1uTMj83e3Ot9qPXZ48nGdzPNILSo6y7bAI6QfQm8J
	lCXd3RBmUaQ5T/6
X-Received: by 2002:a05:6512:3f03:b0:5a4:19de:eb70 with SMTP id 2adb3069b0e04-5a887ce53a7mr3385028e87.28.1778184887901;
        Thu, 07 May 2026 13:14:47 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a4403611sm193843e87.34.2026.05.07.13.14.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 May 2026 13:14:47 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	haraldnordgren@gmail.com,
	j6t@kdbg.org,
	kristofferhaugsbakk@fastmail.com
Subject: [PATCH v4 0/6] fetch: add fetch.pruneBranches config
Date: Thu,  7 May 2026 22:14:46 +0200
Message-ID: <20260507201446.41771-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.6.g690242d89b
In-Reply-To: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
References: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Can I get some more feedback here? I have used to on all of my repos and
it helped me clean up a lot of branches.


Harald
