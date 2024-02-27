Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1B13B2B4
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043691; cv=none; b=Y1K2GMHAEvTs8sR+pCvTgD/wz0e7YdrDVANJBQTlWEFeaxsl1sIDQHizjRta2PDGQT159xVJtoEjyb/9iy72aUYtwtH1yGlfNUtYUarMppPjeOSUKM62eh5Lj4j7bDd7pNpdALJCjc57veUE12dxv5UGfGSWvC4+UpHJdASC+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043691; c=relaxed/simple;
	bh=ps8vlwXFHsU7qCXXZzqsCV53qUaRhrLWQI4Ttarbb8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAZEQoRuCjZLBcir9Lr4bZ0B7XGpXWxBc7Qb/u/j9l/eQEPgVbHbHlSh69Fii5QbezqVJ2l8VR5cx92Uc9SfPBNxaXxFw+PE2/6aJ2ddZoluyXzbSOUh7J7EiMoi7AOdb6+kEifpUwwUB6GRlXYXdl0e3r4Z6z1AwAskeqpgsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfF3EnBS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfF3EnBS"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso47094631fa.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709043688; x=1709648488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdooa3LzjwUrnvNzdigz7bMVs3sVljNeXHivJXGkO14=;
        b=VfF3EnBSUuP/LLvdM1JO/tPn7xMWXz4Z0zcmBwIsXppUttTfK+WxK7FwnUCO1hJ3U+
         cErjw7x5Ke/J4umX6sSkOlKzfnOviW/ubA/qAuHmCAhtJZ6ErtnwycT+dCNCQfx14iUA
         008UCVB+zVtzwyzOHl9gQ1aYzF9jPSgkigUI3UGNQr0F1hhed/AQLAhjgH1MukjB8MEW
         0WCBnWyGRCdnLevjb8DulVgbTXQjx1bGYZwHJ4ApTUoCtt3W6+zMYsxVrN8AnGJebb6L
         XwOkCgzMNKbolCPCmFFmpRFvGSoO4xXhn4kIUZxhn58bgCd0ggY0yl/nN1jseOG22YVh
         kvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043688; x=1709648488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdooa3LzjwUrnvNzdigz7bMVs3sVljNeXHivJXGkO14=;
        b=TrpY53KhDyWVBOevGlroPcRKzdh7RwrmTrELx0kYWpBCOvSqcOZC52z33KzAWVwx6M
         xp3FRNSTsXOrlI7CLZzzMgIHGhuHEcorFfQRQ2DCMWMuUgTiWzKsuF996fK9Texv61zH
         4ydfKT5i1r4Xs/4I2A3JqUXMi6hdkOMUfZdiWZ74XIClQbRggw/UbDrU8hdY1BBvRWgL
         ACb+k7QGAqCCxx/13L8D5s8m1McwrmX/4CIZAh05F1HR2bGAe4An00fJicXHsgK0PbTH
         vs78PGZjDk+HWS8anNMi2RiKg9RvDDLuN/PSo/FrLSFbS9uBikvB+iMVlgRswgkVsVbG
         539w==
X-Gm-Message-State: AOJu0YzXJwyWG6yoRWtkOvNr0XuQrMJhjtzeZccofF3LNAER2vDXRH5X
	dsqXlJ+GwaVLllk5m8cxnVEKp8lT0xnoog7UW0tjqOp21J0UzZeH
X-Google-Smtp-Source: AGHT+IFTrl4XgMRU0h/eVtgJVMdfDzDE5jLEaMFTYTpf1QeD1Qc+ceVHzGDBdrwtBmUAt1WhJ6slaw==
X-Received: by 2002:a19:f719:0:b0:512:ac3a:7f27 with SMTP id z25-20020a19f719000000b00512ac3a7f27mr5359877lfe.66.1709043688321;
        Tue, 27 Feb 2024 06:21:28 -0800 (PST)
Received: from host-sergy.. ([154.72.153.222])
        by smtp.gmail.com with ESMTPSA id lh11-20020a170906f8cb00b00a3fb62260e3sm810127ejb.72.2024.02.27.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:21:28 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
X-Google-Original-From: Sergius Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
Subject: [GSOC][PATCH 0/2] Add builtin patterns for userdiff in JavaScript, as Microproject.
Date: Tue, 27 Feb 2024 15:21:19 +0100
Message-ID: <20240227142121.72518-1-74214119+Sergius-Nyah@users.noreply.github.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firstly, I'm so sorry for the delay between selecting the Microproject and sending the patch series.
Learning about regular expressions took me a bit longer than I expected, but it was all worth it.
I'm very grateful for the opportunity to work on this project and I'm looking forward to contributing more to Git.

This patch series adds builtin patterns for JavaScript function detection in userdiff, as 
my Microproject for GSOC. The first patch adds a regular expression for detecting JavaScript
functions in Git diffs while the second adds a test for JavaScript function detection in Git diffs.
This new pattern looks for lines that start with optional whitespace, followed by 'function' and any 
characters (for function declarations), or valid JavaScript identifiers, equals sign '=', 'function'
keyword and any characters (for function expressions). It also considers functions defined inside blocks with '{...}'.


 t/t4018-diff-funcname.sh | 25 +++++++++++++++++++++++--
 userdiff.c               | 17 +++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)
 

base-commit: c5b454771e6b086f60c7f1f139025f174bcedac9
-- 
2.43.2

I would greatly appreciate any feedback on the patch series.
Best, 
Sergius.

