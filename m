Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7123228E8
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744513900; cv=none; b=Yoximq31YYWS4yu9aWp/9h7NQ3IM6AH0oOed5hsW6sjFNk0ATOGhiHkn9VxqcCqFiuPWVq2E1IlCfmmrSl4aaenyeYPXseiRGNmVmav3Jnkm2YxiEyJtLVuAK5AztksI1eBLFgvgFCv0C2DSxEAhRLcosLOyRMUYylzf3mrzMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744513900; c=relaxed/simple;
	bh=3AMTjyYDlAExu7DLqNudiVgfT4DyV2Ncey9zdG+ocPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mp9gntTPSYqMpXxPlCyI8xzrSxExApdUcl7tSdNNmZWh/jFcb4B938tCof63uoOZh8Ibu/nHZGNHzQXjjoTZMsl6fWYVdjw8es8pL3s5wkEWXCVLA5h427rggoAN0idNHTg71x7v+1TZaLv8fLJkJpFziM18bT03giFevsgUaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=gkXaGGJi; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="gkXaGGJi"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-aee773df955so3477162a12.1
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 20:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1744513897; x=1745118697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AMTjyYDlAExu7DLqNudiVgfT4DyV2Ncey9zdG+ocPo=;
        b=gkXaGGJiRCd5wu7J4r+00l/G+WfwKRmlzRLf6/ur7HA4K1bhQLT/hpWDk/G3b3OXEB
         XvKCGFqi8wEsU+nQ9/BpJFX2VmUd3x5V8ymzlZvK8Fra+4DqoCoQNg9d45+IxncMB+nb
         iVYUo6S0M1WH5EN//Nk/xzN/Pl1YTi2Tl52cFLxd9jRnel/1jCNKZSlduAW6tp5WbvGp
         YyUhKQ3JewHHN89r+gwDIbdyq4wPGPsLkpL4xTDcUsySfNSb5e2ikjbKGqLf+EcO0xPH
         k05whWjKjKxKN3hYB7z8js4P9O0qpnTqzTKZInZ86t5DgGhQer2KOyhPLSnp88ynEZzt
         6wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744513897; x=1745118697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AMTjyYDlAExu7DLqNudiVgfT4DyV2Ncey9zdG+ocPo=;
        b=EB4sUaJIeGOVxXZ5NxA46aPuB5hkqZyTiUFhLl+FdFEx+OFX4qSZI5r02BfnjwbkSY
         AuUVj554/51/5cs/46fk8vluZAxW+WHAYbulHtW998R2G06O65+cAKvqj/z0JPo5FEEr
         JdioJDGsOFOqa6rN2F8Cbc8wPCVbop4dErT40yqlqdAtAa9F0EpDLazsQJOpjbJGiooz
         T929nr402yTrToxsyuBHnNdbpbP7+w2dzBW26BWCAe4Guyc1LgBwnVcysw25xLgirAhE
         aUzQJHhg+Lov3SNKMLqyEWx8/pgEq7V4wm+gIyHMPU6PCX0ZavuL2saiD53XaS3Ob5Tz
         UMHQ==
X-Gm-Message-State: AOJu0YwipB5znSL1yUXoN+ZCHdvn8USg7GrqbPRuqz18NNiPCyQm/U1l
	xtZ7oPa99wpdpXkt9JvVN6hzbkwbEfBzveSb2xTAa/j+dMu3noVL5hknX3IrbNWuocWehHWksRI
	jlYWHukZHdrYk55byeh2gTxBSLqFI61kJW56UlwklRQO1lTsa4pKQ+zmZF/ig56VcFiV9Au9P+h
	yEpCMQhaHhOmDUr2D8DNJcejHH/5mD4Q3W3cGPFst8gjjPiNbb1YFEA8eJmTVF+SxV7OxLWfKNV
	eBEFMYcpMD9a4JXvap1Wkud4xPFnVWVOGYhyqZpiWF8AYEy4eCbWYgZKscO6GWF5aZZei/uojbq
	cMhe/s+8GjygvipqBBBpU/rQ
X-Gm-Gg: ASbGnctb8mhunvJaua7D3nCTrmYxkP0Ae1E1YVKqKAfNXjJ2XSTA9ykCvQI1ICB1PBR
	PRVqbvB7PytAV+26QRkePSL5U0bgVMxSnnBovRwTFhGBnjPLJfDg+bIWStaYwz4QTceXZ1P3rl2
	CvyD01TXfsSyN/bwoOsk+Ohvk=
X-Google-Smtp-Source: AGHT+IEiTr+UI0f4ANZIMDgWV1lglsGpSkTPmsuSkCiIEhl5YIoMs0AmXDyOp80vkLN9QEQR4u6lKV/gJimqWOulp14=
X-Received: by 2002:a17:903:1b25:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-22b7f93cb2emr174086555ad.26.1744513897207; Sat, 12 Apr 2025
 20:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEbzv6TfMai+vu76Jw157KyMNScwW6pUZaDXbN_u-XRKz_3wnQ@mail.gmail.com>
In-Reply-To: <CAEbzv6TfMai+vu76Jw157KyMNScwW6pUZaDXbN_u-XRKz_3wnQ@mail.gmail.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Sun, 13 Apr 2025 12:11:26 +0900
X-Gm-Features: ATxdqUGMJnM0B8EHnYBF9-PrtItLlbAGXwHW9_QFCd60zh_HnXcbQTeWGi03q-c
Message-ID: <CAOTNsDwaVGrpcuT42RUt37NPm9PwnrLz3dJv7JEfRLd4krY_KQ@mail.gmail.com>
Subject: Re: git credential management Mac OS
To: Lukas Michael <lukas.23022005@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 8:14=E2=80=AFPM Lukas Michael <lukas.23022005@gmail=
.com> wrote:
> I want to know if there is a possibility to set my GitHub PAT as
> credential without the need to clone or push a repository at the
> moment. I want to setup my Mac and store the token for further git
> clone / push operations which then need the token.

You can utilize "git credential approve" as below:

cat <<EOF | git credential approve
protocol=3Dhttps
host=3Dgithub.com
username=3D$USER
password=3D$PAT
EOF

Koji Nakamaru
