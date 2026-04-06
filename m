Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468D27144B
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775457383; cv=pass; b=Jcr279OWTppVkUg3TdBa+K5UKDs7+Q2tv+eSL4xkC93xr6TpXIgcjWdDp9Mu3DNGxcIziObl/oi1o8fcCfK54+ZpnLgix9j2QRg7za/Wb5xig18ZodsNeEnBkR+CtDLrGGM6VopHnATdT/oegolLjsewSt30E0d5iCxMj3hq+do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775457383; c=relaxed/simple;
	bh=/FgqALHQ8zoMKBkF0zVLJ9JMu0gC1P18sNVxxWkmNxA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hrv3cElodqyhMDz7ws2GNMKHQ+dWk8bHLhQhRNSRRFUEeW/XxfgU/Qi7dU30FP4HHL+SRfLlmkXlE1xCWzEnGk1EC+Rkq4WcihKwfAKU1fJWbDnaId62Sm8OJlxNB8cbpjBgIAr0aYbJIjrNK0QPDE0Omhip1ZoGbJitlwXp6qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwAoqAPf; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwAoqAPf"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c01854477so597716266b.0
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 23:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775457380; cv=none;
        d=google.com; s=arc-20240605;
        b=GCJ/dIU6fEaON0jsgzFQCPfvSaROGFInupuUfKxFQo79S6DT0w4neIunt5UJw8J6uk
         ih4VcIHVsz6aWE3GXD8daVOT+7mMYnSKu4vbZwQ3hb8TzQg/IOsk/LPDb6LSUsspT/gq
         rzNqAA6FsRKdEF/1IPfgyNMXrBd7bfbGmzO1N6mbhfVYA8RpMgYbvqm46MZtkAt8WuAO
         WKlG2Vl9iiRhtBX2TeaISo/AZuCC1/NfykIN08b24rwpCmk9tscbhrNBDX2baD52Hg76
         k301j+J5XD26wNotFnjX/QmELmsXpFshHRUTawFZG28wJVMPmiKoLzH4X3QZXxdAiWsl
         at7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=/FgqALHQ8zoMKBkF0zVLJ9JMu0gC1P18sNVxxWkmNxA=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=fJZwYGgOMxB/ddw8OsdGqA/DgCMMhhuI7jImrWCm6la1DufXPKx139Nj6NmX8H6wBX
         e9VbyDJ4M35X0N7tYmMsxBuTU/YwbXAKazWmM1SQ2QNfFBtdG3UcFQRYepsiMPHJZkMQ
         cC9Jn6GZHkg48P3fVZeUGXCmijzj5rgD/Z79Q2/rb4ZJo//xbpDrusUrr+lfKqhTX/jv
         6Mvgg4ChKaSn33V9DcO0+SAE1/vUNqOsfyTADrJ8htVzdiZI9Il0bsXNnrP9hEYLqi7m
         c+06pWQZJPPoHsQ6hs32qSVcm/fG3VHNV7o+zPDEcKM6dSW987ffoZ3GU4oDLO/dgB9G
         AtPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775457380; x=1776062180; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/FgqALHQ8zoMKBkF0zVLJ9JMu0gC1P18sNVxxWkmNxA=;
        b=mwAoqAPfdFRBiZRb0/uWX98VbEt7VJSs/1w66+DDtxROv6o/eBt83y+e/O6I88DsFs
         okLxKr7OYYkaEnkIyY6s9cX9jtU/WPGuimKftZYBQZafCHFlEP5kPMcaYFy93A8IgpRk
         kovZ8lnuBgaqTZtf86n8W29RCOd74y7qQ9NVrXINvTqO8/4MmYt0eBnH6xh+ekYXTAD8
         yU2tK7sQOjtktoY7K5BgcqV4bmXVEQ2mYrUJVNf+VKe51BgE2Vkvs2k8ilkNW3PW3/wb
         jL9Z/ODHtPa54DetraRkPlWADAio0fURaHQ557+vh9oiD7wbyMY2BVuW1E+LxSOcVyFp
         TpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775457380; x=1776062180;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FgqALHQ8zoMKBkF0zVLJ9JMu0gC1P18sNVxxWkmNxA=;
        b=GdP0auj9zigaKZKVVbGJ04yNiJTZg4c5V3hwLXyGUsGSlff0tUTvsHoFSDVpzYTNh2
         SPRo8+xSJzLnYEqDz5fw/lVBjAEolCO32S0spTX9ZSA+NZH1NSMtvhULip4x+dbariSe
         l339WCknQIPYOK37KPth8xEE9jK9YsAWFM13oFGTrAFWvCOiWFIPUcpUkqCq5TfOi1k/
         IKz+UQEqOUs5fi3u2P5oslW5vO+1KykqZb5JOuZe96iSskIWTMWRK3DD2lqlBwOn4ACv
         DwudY+1i2Jr2gZnF2rLmL8ln96H7WqEWm08O4kZsxPDTwBIFGNKptIPuRY53phvfHnaW
         Bi6Q==
X-Gm-Message-State: AOJu0Yw1Gel7bwal5Dzzx5fDEqOzaTysfrMRArWh7Pyxs77Zp6QuZGo1
	gd/XlUAnlhqYGdNoLuhHpaIFpE5Tg13/gT0Yr12zOISbWMcpziXo6sSAsDqm+yuIBXC/haZ5Xs7
	fQ/ilpDA/UI0hRqSViqPhDu/LKrRoHclKMWNa
X-Gm-Gg: AeBDievAAUMIzSOiyGvBprNuro139AevDGQ28Av1/pNDNYPz7maaB+X31D/q0EAatK7
	361O6gNRkwzSUJCwETLuYsghpHPo71LTgVMimvqIEp3zxynkfP58bs618gwi6AbLseGv8XecXa5
	l+w8PAN+qpPti+pyrjlOgpBevZIVizhofnVfU0sB8kpmsF8rChbju8Is5P6JKZlmhoUio2FMZMe
	K9FkwtFnKmgY944fAERPwKRlxUbpgBAQbyhoUFw6WhYNCG54WK3SGbULs1xwHa/fT3o8QpoxAxE
	J2rDgp23xBNpr3e3ez4u+pVQuVjnojWLXH7SlFcijw==
X-Received: by 2002:a17:907:3e99:b0:b97:7d03:68c1 with SMTP id
 a640c23a62f3a-b9c67957b45mr496477566b.30.1775457380224; Sun, 05 Apr 2026
 23:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gabor Urban <urbangabo@gmail.com>
Date: Mon, 6 Apr 2026 08:36:08 +0200
X-Gm-Features: AQROBzBrKrWmMDQkLXqsOW4SWU74uEM3Y9KCtqA8BJ08JFZPBzMfZKGPeemY_0w
Message-ID: <CAL=1hhxP08w=pMa39izN7SyFzsv+5HWZhtzhh136ZmG2dg7Xtw@mail.gmail.com>
Subject: Super repository
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi guys,

I need some help. I could not find how look for solution.

We have a project in:../foo/Project1 under git locally for a while. In
a couple of days (or weeks) we are to start two new projects.
According to the management we have to make ../foo/Project2 and
../foo/Projetc3 to be brought under git.

The real issue: we are told the create a new repository for all 3
projects (inf /foo/), but we must not lose the development history
stored in the local git repositiy of Project1

Is there any good solution for that? Thanks for your help in advance.
--=20
Urb=C3=A1n G=C3=A1bor

Linux is like a wigwam: no Gates, no Windows and an Apache inside.
