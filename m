Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793120208;
	b=t83IffsFf5/mRABOaOMBg59haOeat2srzahFhhCRmM8+OUcx79JE3RlZRL1v0s84fBF6
	 8oPyZAmQH/FMJw0xK7VVGfPQN5jRerdWvmmyFvpvzPEnZq1vxhNmdq4dC9C+dJczdERJy
	 xy+liXs8bq3wHsMg/Pey41Gw0+MOfsGLC3dMViIUjjBQ5pnAKmPE/MqIkuG+I+bJVor58
	 dFobM/0Sqv1JMfztgyn/M693k/4HtH0xfCN/a29Q9FP82tGZoMLt4lcqR29nwaTN1zPC6
	 icL8f9NOA1FuRUYDXVP80JDCQ3l3qdDIix2cm+psvsKYKjMrLvCNXYbgtgiqd77TmVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=A0FHKbB9h63rLWp17hQ9TA7Sl9ZXVTU8Qvfm38Wftj8=;
	b=1AyqusvrZU8vZFYjfeB4o4OA6PuBO4RQjvThzpmTHUgGtWDoq3a3Q6Ggqh4wN5MIBbYO
	 yqu/4wWMNyhs9wbVyN4IoRAWLbmEXKthZUvPFx2jysMtFcGzzodjX3YyBatlb+DcFWzhl
	 me29QY8XKcpY2E3+YEUwtuRmzB4yufmV4wmGcOm6jrmtG6SQF4+dhsNqaSXCEvOt7dYmN
	 Ibf1rq1K3WFhQrCzrvpr41IVD9Dv/nH4cPueZlkM9ufWStY/a8rIUiezhI4KI51psCfWK
	 4j1VGh6CY1CaLilIBI8GG5XM8QN7MPQ9t/o6E8D7OQbJ5zlJZkNHFXUOdRzr/ECrGqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WinVugnz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34401606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34401606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WinVugnz
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1836566a12.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 09:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793120206; cv=none;
        d=google.com; s=arc-20260327;
        b=VSpzNEoUKDE0p/4Muus7ptm7q2g4gQE2mmk2FI4AYSiURS6Ll/aovJ8t8H36Hoqijg
         IObSJuLq4wvw0BJSBtRtB0l3w/WYPjy7Tvmztlx5UZwTCRTNYsTE3W7saAmqF8CEVieL
         lmCxNBMHAK6gilj6iHaqVpHXX1Cu0qAvOM57Ij9aG4Sy7Gh18V500vrjyBsmDItDl4sA
         1yyX+Q143zlcvdDN/NXTgnNfx7/VB5IAMDqY8wenKYCB2+VOwaG+6t+Nzix5ktTk1eTf
         Qzlwilb5Cs1FHLYtiWp2iO5eAPXgzbgwoDTsOhYmy9Vqa2M3UWCKnO2CkCWxjyub8JZP
         7z7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A0FHKbB9h63rLWp17hQ9TA7Sl9ZXVTU8Qvfm38Wftj8=;
        fh=A3ctI0EoHpqLC8F1j5yk33Cn8HJHPBDM8TW9vmUlGdc=;
        b=A+9mGsABxyO8Onvb41K64pPzxiVTW8CqpB9o5uo/qW4ty2ijPKLvR4sp+KeScfSdLJ
         OZOtEHnhSkxbgmvb9gxxoxsL+2mtlTT3wRuBgOdfBt8aXBg9FVyU9Pe0uYkeX9wN5ytu
         QRotmO1Kpke0T2a2+dDlhCTJye6T7qnNdk3q7wX/fm6E8TDcV5UPBwWrcADJVaePs+i7
         UvMMltTBsPJiZ95XtTzgFiJTDX7Guw5rr5644Y+R9VzlZwT286tx3Ynjxqt+Te+gUMT7
         OUthZgOb8q2iFtJ2NvZ4LlECDKThVsaj33FSK9HmJ2h4wMd63ZNoJtiNYaM3ja+88p60
         B0kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793120206; x=1793725006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A0FHKbB9h63rLWp17hQ9TA7Sl9ZXVTU8Qvfm38Wftj8=;
        b=WinVugnzq7wTF/SNa0muCGmaQlEv5pWth2ZcyptRav3GJISoCct++vXYuP9ZUv8HHt
         seBSkRoLEAYGCtZ/76d05LcKOabR+TbhNQgqxaFdILWtjezzy6tT6BTwSBolzUJ+WDKc
         KMIclV251tmNCNL/csV6QZCOiQ+l+z+fUaFwWJmf7wRno6oUK6+kfwQEy2C5ZTtNBKDk
         rHF38qXANnAWdO29CoCu4cTw/m9hB62PTR3BwSmAj7ELa0FgfEykfFNepNHF2Gw+U9Yn
         CEeAzhtq7iGx4uNfeSLRvwTMpBHOvxVLOCQmFO9wGTZqgMka/iBUyjve2EgDWeoLkYZ3
         78/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120206; x=1793725006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A0FHKbB9h63rLWp17hQ9TA7Sl9ZXVTU8Qvfm38Wftj8=;
        b=WMeiJA1mrdjykszylOMTJbLN0UN0lWRKsGCd8+iNmHY9AwkPTlQ7Woqq210MgHVpBk
         4vQqiRWLpMlzs4FdekG4PJ8jAXQ9/xo7OdI+gGnteLDJw5V8KSpPdr5IIQCy8mQsrvnw
         4aNk1cZc3cCGVraOiWPo8SmGVHm9arVFDclZm1ETHTq24TFmbcZmCtNO91qvrxkI8NRY
         FtLBqzd+bqN36+J3BgqLxlQrvjNSQHqJR3LXmSVqDXCvn/DoGtsHyda3nEIF1Ip87zPd
         u0ch/qbCU7OcN1EJAdo4XT45YYWiLLjG1g9jv49Gn4kltXyWsKLcRrRtqNabiR9a4/hL
         7pFA==
X-Gm-Message-State: AFq9FYJFyLFCWNLbERKcmusQpj6fwmsJhexx2VYywFJOiE31QMzu9YHL
	ve9FtR0vqpu8r/+claVG0chq/UNbCKlDkd757CRwo6JRfIayw3lN2335stZCTRWJ0T5GrZRF4ax
	6ph2aReHp74994PRSIFNUd8q/VMJcVjc=
X-Gm-Gg: AYBFou0WH/mFye0AwLCTZgBMh6PHou26JJBo6SymeKv+nLdog9O/6oREl4N2yjNH5UD
	YYDlOou3GvnC6AQwbrSOTwL12IC1Bvt4F2GUQABK6uR0+OqniGVyLYB8LQth5Q3JvYuycVXmgX3
	9qYd0JwDW2O9txeNJUW5spjnv5kBHe1J8AJ2ij1rlxzyY8msQp/xCiUf7XTfx6xlmiigaSGixkM
	gUMF40IRF6YdPa5JPOHgBKlyaV+Q6C6cvMAUt01qgas+sPjuh8oQO0rE/ek5XUwniolMJcxaRpX
	9wJDxeYBoxU8y2keHwDlSps5c+lInoL4wQhBKyA4iwY8+BZs9mV4aJA/ztEf7BLTkT/DKwAF9Si
	1xZMgH0fcsPHU0zaItZ32GY7y5/IZr5er+hO1P3AkqNGw6dvFZHz6skvAi7DGLHs4RMh3
X-Received: by 2002:a17:906:478b:b0:c3b:1f73:fda4 with SMTP id
 a640c23a62f3a-c49a735d504mr323306666b.10.1793120206399; Tue, 27 Oct 2026
 09:56:46 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com> <20261026102017.2689-1-ogundipesolataiwo12@gmail.com>
In-Reply-To: <20261026102017.2689-1-ogundipesolataiwo12@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 27 Oct 2026 17:56:33 +0100
X-Gm-Features: AclHuK_OEeS2Vd1BoYFOFYuxZmC6ZC9devTRAdiGMmiipFm0XuExW502Qq4OMyo
Message-ID: <CAPSxiM85tDse=qD8cEP42uyGFV9JTJYV8_98SWTm1wTmWj7kPw@mail.gmail.com>
Subject: Re: [PATCH] t5300: modernize test path checks in t5300
To: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.cogituder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 11:20=E2=80=AFAM Ogundipe Sola Taiwo
<ogundipesolataiwo12@gmail.com> wrote:
>
> This commit improves test t5300-pack-object by converting old-style

Could you rephrase this to avoid =E2=80=9CThis commit=E2=80=9D? It's redund=
ant in a
commit message."
Please describe the change directly instead. Also, I believe, the term
patch is more
appropriate and not "commit".

> path checks to use the `test_path_is_file` helper function.
>
> Signed-off-by: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
> ---
Apart from that, the changes looks good to me.
> --
> 2.56.0.116.g6de20f6092.dirty
>
