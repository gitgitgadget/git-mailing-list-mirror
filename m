Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994812;
	b=pAvQgvf4NRH3/qLzZ7oQoqUeldgjSRrhxuT3Bz2aTCfEOJNa0QYMALhOxcfM8/Hi0F0/
	 PRYKhrF2vR9MMnBn1CPwdWqGKb1iiuP9Tgm3JoPz90NWTQ/nntf57LpAC2kggYfz1tS16
	 ChuWs/SE3poQ1w1wi7cYYQzPiwxzexaEUI/eJEUfNyKlBf0A4Omkl3ZVnA0xWjAIOGwur
	 Gq8QU4ctG5oXFRwZyQYjKkWZYHqdcsqAPsoqyG+68a6j0+aME08cqVFvLpTxLMVUVf1rT
	 WoWahYBTF87ZwVcSfpsJPi7M4Tq0tS7zrs5SojP2JanFah8Z0rtttAu8iOSM18u9UUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xzJ1BHBjOEY4CFITVJnemZ0BRAxWPNg0g46UizlUnTw=;
	b=mhHYHmO70YW/fehDhf684XyjviMgtK8WAaHARhRRKVve6szsVwlcZb9Ko8DQYBnsNYLP
	 iT1+N26HEYolpV+0oShXaJQv7DV9V/wjejffQmIid4Juoc9CuOzLFVseHxCi+o3WtTaQo
	 56PWvbD4quoZk0M78+jSJ2zC5uvcDw89Y1IijAJE9s9GLnuPr64mmV3kA/McY7QoMY4bx
	 UPNUFZDgI1NZLcDht/8b7wL/ffp2AXoks3FGnHVQ3lbJWFxiOITQ1j4MGkcnyX+UtOKrI
	 g3L8iKIM3LmLeJNkS1psMAzdG+/GCVm8tjVwc8qUJKmmOQqMnyBzxVDKea6PWOm3pcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QRfoKMu/";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBE606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 19:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1CBE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRfoKMu/
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso7233225e9.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 11:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994810; x=1794599610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xzJ1BHBjOEY4CFITVJnemZ0BRAxWPNg0g46UizlUnTw=;
        b=QRfoKMu/G3llzebgVgaReUJUyNump3Nq8zDlH6G8pmKUFeLqkB1Cl3EgB9mtARVkR+
         r3eFX9YOO7Oq0P67fNZLVBXLIhcPzYWQ0/W7KffPOABdFx+dZpiXB98VlB6wYBgzu259
         1wFT75ExDBx4mBHs4xD7RMRK4GKRiETRZ04ZTyMTpqm+VOvJjn7bvic913tiEYagPIuf
         DV5qjpXN3Nqy82muwcFHnqvdkv0eA9u2iyNluBSQbHPWg1w0z/8zmulos5qYzNlK4/oU
         sdUky16+1gQozh6376EfuI/s9bWeKjthyXAl5uRD0pnQ44n6jPVhsN+tjlpRb82r4D1Q
         OlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994810; x=1794599610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xzJ1BHBjOEY4CFITVJnemZ0BRAxWPNg0g46UizlUnTw=;
        b=1AxK+HbDlgy43IVE4PzwFs8P+Bwe24kIoooWxLSP9xfLLYamfVHZYi2RbIm34vsSBM
         ewfttU9BefZEllH1+Dgc/47cSN/8/TnJgIpsy3b+hHnoafLt77Yf1mzsq/3l5+sd+o6Z
         ACIlr5KEwD78RislewqagSaPe49lVjnXZIrFykYWSJi5sMRIOtT3WQpPNVm7EK3XwAuW
         /Y3f+GqfuDbyEgfKN3hvnWJBTJUoNRoqG8Yk+6vdqEFF33pK3eDkteMlRJyBh2e0QYEb
         gVITp12VqStPkOE33O64E6RU7Z3f/ySWKIXF5Kq+Y4ii1Eu723AaGPPf6NbHNpl2zcXz
         pR0Q==
X-Gm-Message-State: APuU4Z8d/H41Xy8JBSsns9UTt5LhzJZvpUP0y1nSG2M5feGPUhFz95YJ
	Jq6Yw2k6R4bcBBRbW0yRXCRPuHlST1NnguHoUv+TlXGtyxKShUWZR5Tn
X-Gm-Gg: AYBFou1L7YkT47F66WvnRB2VPpYsilD5S3gJvwznZ+fG3UeihMtGsvHaAjhGazX7lWb
	wt4F9xP4i61Vi6keKsHDEMaYiGjQa/l1Elp8+ZyJ1AeTEVQI8yitFwx9g7Q+Ni9wlrm4LmYdAni
	scASYCMi9UMlXrbeDwt+kggRzouUc6VO507zS9lpMdBvVNpWfofU3MzkmM797YvJM8zVOeIS8fc
	wJ5HE5OPKvsoPSQutDmruXU6ybdjzQKOGzMGlAbfA6ANdtsyyh9UuSYPrJCRcWXUqqDYrU5NQ4X
	/cBxiRLHj2ei9hPwW9gJ4dtqq+HcAyM3aTShE4Tddcv56T0iHZqRwGwXW9HYooIotA0/TG5IslR
	w9rB5RnhRbYJzZz7WyL7IndW3Kycgj3RpnI22aSGY+FXgx3/+Y7Vy5qJEtTXdv5zr611Z4rQL01
	VJSEVOsr6/M5jsM5SgKOeCRE+jptrHNPFIx6R5TQDfDEvcKD0T3QYp8yDYz7JAcXi/7j2GZwjo5
	fPxQa3tEuy0SfsQs03pp9Ls5ptQtxgcSOe/46xGUbg3f2G/68I5Tj6L8JQUEh5QNbxXHp+74xp0
	6ofS0YQuLInQexiDSR3se92aW9BLc2lIhxWt2PMqZuBgO8ac+Lc=
X-Received: by 2002:a05:600c:46c8:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4b6dea69526mr64286485e9.7.1793994809921;
        Fri, 06 Nov 2026 11:53:29 -0800 (PST)
Received: from GODS-GIFT.localdomain ([197.211.57.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7d54d6f93sm8345925e9.0.2026.11.06.11.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:53:29 -0800 (PST)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	herroyalpriestess@gmail.com
Subject: Re: [PATCH v2] api-parse-options: add missing flags and macros
Date: Fri,  6 Nov 2026 20:53:13 +0100
Message-ID: <20261106195313.1015-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
In-Reply-To: <20261106-kn-parse-options-doc-v2-1-453ee7155348@gmail.com>
References: <20261106-kn-parse-options-doc-v2-1-453ee7155348@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Karthik Nayak <karthik.188@gmail.com> writes:

> +`OPT_ALIAS(short, long, alias_source)`::
> +	Introduced an alias to another existing `alias_source` option.

nit: s/Introduced/Introduce/, to match the other entries.

Also, parse-options.h names the third argument `source_long_name`,
which says what to pass; using that name here might be clearer.

Otherwise this looks good. Thank you! :)

-- 
Cynthia
