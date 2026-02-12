Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684F3EBF3D
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770934937; cv=pass; b=qmsr0VqGU0hjO2EiXNaUVrThdLAx/TZNZdcQH3UnghZgim3VC/yCtf3R6p9TJstpky19PuLdhwTJZz1f/acmjPQmzF5LC0eC61n6wRYJn/6WPBxfaMZnFJkfLInA5IuODDlC7iAwDhV0VDcsWSGvZWRZKcvChpJ5grgOW/E55pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770934937; c=relaxed/simple;
	bh=A/c4Yx3fSLq1rpoQ1Elt54KT+XrwuAOr3n3ZAGasb/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdJWajET31KP1ZLAX3SVGaasGbrmSaPSiQ5lZnDvwBy/v8cL9I2qIlDHul2dOoVzbjxZ10/vGbX6b2oGZ+jd/24BLu3wT0+bCDm5C30+ahbLkpKUKZVTaaJPVbXFcVclWp1v2JzD5l7sb9zEVx1jSJ81PGBHmPkgddfLOmyYEtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaTL3jt1; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaTL3jt1"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82311f4070cso179502b3a.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 14:22:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770934936; cv=none;
        d=google.com; s=arc-20240605;
        b=a+iBZaLkeCQoISlYCTs3ytsS+YvEhdhsMevJKDbnQUVzgLBd5x2Nc32bsa6vJKj5DD
         2edPMHIVX8ZbtDJ8qP+Y4bygqxScoi4PO5OmPqicYfEwQnZxWdU+WHp1/Tw5ibVvRqun
         e/0ivZ0BW44bPsPmdGxZ44GFVqlBOc0Q5vNfO/zTC1cuw2jqfRg1BP2NmWZqNz81zXO6
         o/a3+xQr1yF17PnAfh7VD57j7dR5sOiDEexP7+GKKmTAydwhXPrZWlu02oI/aW/LtRon
         1JgIZMVGTImMk0gAzPCexYmAdNBiMFRPRO3QWDvECuvYf69SwMVXsJR0A7hCXwbqQzJ5
         Ge3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EqbWYKYFsQrcdUySrmnluo93D2qdVVHXg8LzipBpBGU=;
        fh=luVqRYiSmskSxDQ5eTucgcD9/jhvmorTnjC9+SNJx2o=;
        b=NELjesufDg0drtirfSDdJUoJeCvg3s9nobzbbJxY4tYxw0VUrjr0aMlsei0Lr6sS8m
         t5n+ci1NqCfQiZOGwfIfJICCkJqQ+SffMVwUoe0R2KyPnIUs9Z3L+tpnJmZDScyzqG6Q
         z+syku1wtmpNxXgP5euSFkXcpp7ul3qSJdbdJdggYlmjdfcvfsUe9MWqlmUui3LnIwW4
         IBBhfwS65WdmUgV7OE7eE/Tezw95McYns4i1Eucf1VT4VYk6nXsnN+LUlvWLLLjja0NA
         3e12CHALyjmP5NVbbYLyVO69t74/QEv0TlGmDiENK4VjX1kGsMmOT/BLXwS01sb/+aZ6
         LMdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770934936; x=1771539736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqbWYKYFsQrcdUySrmnluo93D2qdVVHXg8LzipBpBGU=;
        b=NaTL3jt1h+++CEcBZ1TOKLorXalsT22apNAzfpx6FOcOTHKYNENmkw+A0gLwoxRFCf
         SUq1VouCu0FanSLhsuiUjbsApUMhHnHYZtfcEZ0FoHKwghvoRuVAAe2+NQQFM6MPzKGG
         uD361wH4M+oIIV5K0xgtOD8rrJAE3uEiar9GoyBepG3yhP5ld4sFutmAH4GQzZe6tFEL
         4ksFpf2ZMmftjwBBUrpmcSN/RCLNSmVQQDxv0Bk7jpcoO0ot4tTwwzPArewpV4c8baHo
         S09fhwnyKALky26yZTg22cwvRP5GjtTF13CeAWOYpP2ZNxb1isQfg/b7l8UWvLjWS8gj
         UDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770934936; x=1771539736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EqbWYKYFsQrcdUySrmnluo93D2qdVVHXg8LzipBpBGU=;
        b=DCGE739ZMCGek4vWVuBGiyYVO7Z2cxN8aDLjs7JdOg8/KHgtq2NsMj319vXT+/kNXm
         TAmn+4lfDxuiWcBf4gHgwocS1HTUMcvRXClaG4z+L521ZqRUdqyTXJJ0IncGFNdsHFbz
         Xc36BJ0d9bDVSw8ONhwVaNMvFDr2G3sjLsb2e041OQv9NtDqwFBmdh7MzzP3FH+L4Us9
         rKzKJ6OZO4OhpRTqqutRbMVbAHmO+P4ogP5isy5tdIpn9p1lwfvt9Z+oJp/pm/Tu+Rfx
         v8MzdtpUCSopL1Ccrddt9yXFVBwal/Ea2HZNrQLuEVW71uCweViP1QzwlAswZ1ysXMgV
         DbcA==
X-Gm-Message-State: AOJu0YwKt9uiLvIAy//pon8/ZcTo3OG58GK1nVEV4pIQHHdO+oPEzyyX
	yXoVAWTwF0Ux/SDPJYUWde12fSXsoqZt8C+8Ry3ZIsp0BvaE5Zkbo/n4wX9hsNxRqbTJ8sZ30E4
	xwan5E7qrxChc3+fjtYjaYCzfGKMP9hDcFg==
X-Gm-Gg: AZuq6aKOMB0UOAv/E/awtBD9aeYQJ+33PAaQbY7kfdpp9N1k39prKPydD3DDt2lxpX8
	BEyR4qfyPCmC94cLaiSw/xkwMK3xWEgm3bvfEAl8sjsKN45B4kA0NEwAQzHqsaW1SKcsrqI/bhl
	+jGouNrSme5nfL4J3gkMpUAs2hX9ApuI+YppGawvOg2OnySf0Ld7+7jL80fkSosKRmzIzAzTzMH
	59Uoh49RH3srkWejO/jKRMEAHoiKpRsgQku871EFAQtNo6OHATEktNwsq+B2FwzunrHY8+tAb3n
	Du+PPS3PlHcTMfZjkJD4nhZkrbPHneY6+adxyab+W8MresgjKFy9XUqPEgb1rNch7enFWbZhD/o
	i4sEg
X-Received: by 2002:a05:6a20:cc0e:b0:389:8e40:a150 with SMTP id
 adf61e73a8af0-394669a534bmr334556637.6.1770934936141; Thu, 12 Feb 2026
 14:22:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqms1ft7il.fsf@gitster.g> <xmqqldgxmzbj.fsf@gitster.g>
In-Reply-To: <xmqqldgxmzbj.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 12 Feb 2026 17:22:05 -0500
X-Gm-Features: AZwV_Qh_SbHc9oTMJ7A9RVfCMWSIxguuF41l9fsBLicYuRgYANqHQqb3yMtD3QE
Message-ID: <CALnO6CAjd0vbi0S+giYBwsyQwFmSZoWUBQMKiUEokCEeaNTnrQ@mail.gmail.com>
Subject: Re: [PATCH v2] CodingGuidelines: document NEEDSWORK comments
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Small nit:

On Thu, Feb 12, 2026 at 4:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> We often say things like /* NEEDSWORK: further _do_ _this_ */ in
> comments, but it is a short-hand to say "We might later want to do
> this.  We might not.  We do not have to decide it right now at this
> moment in the commit this comment was added.  If somebody is
> inclined to work in this area further, the first thing they need to
> do is to figure out if it truly makes sense to do so, before blindly
> doing it.
>
> This seems to have never been documented.  Do so now.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

The opening quote '"We might later=E2=80=A6' doesn't appear to ever get clo=
sed.
