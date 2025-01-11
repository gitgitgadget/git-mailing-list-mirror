Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E218C018
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736579706; cv=none; b=cB1pJFZuq6cGBAtbVFyWu7nqLEfhW/6rLxqiVnBa4bnTulgbOe+WOQKGgSEIqcXxG4wsTduDmU9aaKZLqM1HGxNlPLKzhWzcA+0DhduyX4K2dVErJpeMYER+P3jlQSByo8bqM622mfeqDPX2XkGsfPXL7NQfPNXmtiR9zAFRahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736579706; c=relaxed/simple;
	bh=eAlHIaNP6GJdjmR0Cz86eEd7/cRXPGL8hMrUoQo3r+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ll1zUkm0HDYzXjvGH23HqEhs+VpYHzUKnafCOguCmyw0GNoT205Xrej+lyzCnmFZP4fPtJ/oMognhGKYDCvbjzo847XNpkBRRiGu3oqiiSKPzAQLrnfkuVDzF5pzBx6B58uNMlzAlxgbeMjKdKQc4xXgKW9VGsxYP8bXFSWYveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaxfE3Sx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaxfE3Sx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa68b513abcso482318766b.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 23:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736579703; x=1737184503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7HUSnofDg3B0fibMTLbUOdzuyL2oU5UJYq5yLEQVvs=;
        b=RaxfE3SxOILi7kzN0FDRIZB8UbKS9oNy2pTCWeuCdZaszWgjKKuMF60smWrECdm9/u
         b+TfQYI23Qbjleguu/+D/qeUpq/ZeH32I/uM7C5IGkVWOiAmLNfS28mMUTlp1tx4987O
         F7Swnrn/XWT5yL1Jwk9PsQNoLpbR9O5tml6HXyBjf0tXCs8nGVmCU+ZOuyDdFNu9mcRW
         PT01XTq8ZlgfzEUhnlrEaXY7z3YPBGrnrj7Jj6JFzM3gjxoLR4YRLyLfXQQZkV7trxOg
         8fVrFPKeTVWEqYVN911Rzl1GxkSjsaidPjZsNCVZOD+rCz+Oqgn/207EfCmYeGt67Zwq
         BXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736579703; x=1737184503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7HUSnofDg3B0fibMTLbUOdzuyL2oU5UJYq5yLEQVvs=;
        b=uDVx4ISKFKTdZSn6y6cWmhX7XVfZ/DSUcKzRUkTL9zpDV8IlRPaW/yxYCwkoGxHdAK
         eBPMZbNyaPJBUFL4bXbiLRe0vdXRGaImW7wrYa0ZEb4hCDVvUw0oSgHSESCtcElOEE1a
         z+NBwAWkUjaIjSYJy1tx0XqxEvaQu49EP/AR2ffwCSrwSKaabkbGYT8nynLKcrx0cT9c
         h2v30XG/92c98P3Ygju8w+8Vodm9NjxF7T2gk2MrVZi5NkS2ITchgCNLPu+2/UIkQzJp
         XtCmrQrDqYXptckQGkCAFgBo/miknIMaFRLDSulKuV5VtNIRZFsKSqRY+gQls+1Sib+V
         oNBQ==
X-Gm-Message-State: AOJu0Yx29SNmVYrH34fTDjRo73xjhC4uKsYvOWN14wj0ceZyJagYLnJj
	osMpyGEVcXmzFitCgWWEaD8YY2zo7oaSrQeC+VWpHLMUVPOTviNGakymB3wr
X-Gm-Gg: ASbGnctW70FV4o8wo/wA6lcst3HmxsRvrAzXquxUkZ0xsrmAd9j1vCZyKL9My/pgsiW
	FMtEzgXM1ieLjYAlB2gBte3cLglbeod8nj7OwhrEgqX93rG/2GNjG/D0mWXEbbQNIpgab3davXd
	xu1HBUqrNWLjduCoqlPYJgK/BLgnAVqglOezc2nRqE3+nyNoW0Ps7yN3yEfu9EZgCgl30Ml3629
	Ja3v4fE3bSBvqpLN6SgLfpLhlJKpadEORsX8zVlU5E6O+8Muk3/3FBbuqKWBw==
X-Google-Smtp-Source: AGHT+IFQf9O2UC8sVIrAzbZ10cr3cndiJXI5/UfI300CyiaKU54nYmyTuubRyVtADOLjGQ+l3FRLyA==
X-Received: by 2002:a17:907:9814:b0:aab:f11f:f360 with SMTP id a640c23a62f3a-ab2ab6a759dmr1175929866b.2.1736579702727;
        Fri, 10 Jan 2025 23:15:02 -0800 (PST)
Received: from localhost ([217.156.233.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c913430esm242564666b.88.2025.01.10.23.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 23:15:01 -0800 (PST)
From: M Hickford <mirth.hickford@gmail.com>
To: 
Cc: git@vger.kernel.org,
	sandals@crustytoothpaste.net,
	derrickstolee@github.com,
	stolee@gmail.com,
	avarab@gmail.com,
	Johannes.Schindelin@gmx.de,
	peff@peff.net
Subject: Changing transfer.credentialsInUrl to default to "warn" 
Date: Sat, 11 Jan 2025 07:15:00 +0000
Message-ID: <20250111071500.710169-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.48.0.rc2.32.g01723adee1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Including plaintext credentials in the remote URL risks inadvertent credentials exposure, as explained in docs https://git-scm.com/docs/git-config#Documentation/git-config.txt-transfercredentialsInUrl

Config key transfer.credentialsInUrl defaults to "allow", but if set to "warn", Git warns the user about plaintext credentials in the remote URL.

    $ git clone https://tim:hunter2@example.com/example.git
    warning: URL 'https://tim:<redacted>@example.com/example.git' uses plaintext credentials

In order to nudge users towards more secure practices (namely, using a credential helper), would anyone else be in favour of changing transfer.credentialsInUrl to default to "warn"? 

https://github.com/git/git/commit/6dcbdc0d6616d7fbd2445aa2237b22e3c172ea85

> This change currently defaults the behavior to "allow" which does 
> nothing with these URLs. We can consider changing this behavior to
> "warn" by default if we wish. At that time, we may want to add some
> advice about setting fetch.credentialsInUrl=ignore for users who still
> want to follow this pattern (and not receive the warning).
