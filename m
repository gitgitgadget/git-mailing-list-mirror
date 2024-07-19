Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B715D1
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359887; cv=none; b=GPEbXIabf/6ilLYcvmosonVbjiIKalZ7gedFHDnRbcVxIQYZ83vqkfs45B188AHip3Xx3U6Y1aX2GEPYpSdUS9Qb2hsMjnsdUM+qEtM0rtCaQcUDCb2EcLaWOk8LIHVKoIaaFR/Ih9fxAQs8ZiVwd0ZV2Y28YGPH14EFl5PkY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359887; c=relaxed/simple;
	bh=SAAKOXOSj3byxWbqqVav/MNxoMMBRUNE+zDQzN1CEZU=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=fzXMp5aXMRnMfA8Gmnf1IESE97JVi2ccUDOCX6D0Vh5PPa39Wl2HE5lhY/Hcdy7u/xefnAizA0R/L5drzcpxnLju9aIYQ4e3GKX4GYoHkopVdACkY0oAkMl9YChoNQjaSNsIRo72bCgc2WBSKqle1U5YiTaKduuU/Y8SKU8LWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rtzoeller.com; spf=pass smtp.mailfrom=rtzoeller.com; dkim=pass (2048-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b=kCxF/yuO; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rtzoeller.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rtzoeller.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="kCxF/yuO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtzoeller.com;
	s=protonmail3; t=1721359877; x=1721619077;
	bh=SAAKOXOSj3byxWbqqVav/MNxoMMBRUNE+zDQzN1CEZU=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kCxF/yuOZjhVCGYDg1XwY+DBKc6aemZtKjWvzS02zx3enx8H91zX0rViQBkqg1nCF
	 rWyeVIlXe7Sspo8xXD+VtgXrgkWMUc+qvSHFaEalpOQLULhNzRrwNRqtf9CEZT2d68
	 MXKatiufDv83xFfstodxBESAOEwIjogwpTuFKlfVDlcRPWIdd6tcE1aae2J8l4ipH+
	 Z8gJZfhQImKykm1cn++fDujcY572w4D5zAsehTaZFi3Efa0rDf0Jg2JD5phyMg9JpD
	 CLUwA8sgZxolJOxH6zIqx9HVC+hQtV1SyhC7h6bahATgcxoY8E4oDT63KDedVAOoM9
	 20twFXCEpqHkg==
Date: Fri, 19 Jul 2024 03:31:11 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: Equivalent of difftool.prompt per tool?
Message-ID: <wglGbP7resY1dIKhfKqMcs6Xxu7f8iWSZ76k-MFC91eKTEWN2Aw4D6TqNAEndu5b1VZMVnOIS8m9HNoZPFxd6NZjKKmW0OmM8h5bAEuwoVY=@rtzoeller.com>
Feedback-ID: 1203212:user:proton
X-Pm-Message-ID: 79edc639af3d6132743010a3c5a96ce1a75287ef
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Is there a way to specify difftool.prompt on a per-tool basis, without manu=
ally passing --prompt or --no-prompt to override the global difftool.prompt=
 setting?

I generally want `difftool.prompt =3D false` set, but one specific tool I u=
se has a high startup time and I'd like confirmation before launching it.

If this isn't possible today, is difftool.<tool>.prompt something others wo=
uld find useful?


Thanks,
Ryan Zoeller
