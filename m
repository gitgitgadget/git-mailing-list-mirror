Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57822F01
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770542030; cv=pass; b=m8gqWT/OWOPzhCy98xWmCHeFWfC8MVq25eO8hSiWpTVl/tJnosYKKNoqxuFRYcmUE6oInAd4OhwnG+CRl6wgJhVNkjRClKfFxc2b1xuix6uDikWZXA17YtsLfBdDGHVUBaozsCicoVmv0GGlAJ0ECGrQ2DmvMekzyGnBul+57K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770542030; c=relaxed/simple;
	bh=kXv7FU95bMNa6stO1/kqqAUJcC/mu3S+U0lCuxdIHvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+LRK5a7pMDMOWvVNRBbWJIK5v1i0IqHAdQJozesdGyfdma+sQAuLOVT8VCiIkCBFuh/4OZdnbelYRE2cAeKdp/MPb5zEA7HR5w4kFYtI06k3hfBwZWUMmRX2lu9o7dV8c6hrmMNu7tLq9qfRjvgy1UiG2KFu8+1EOKH08Z1/JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j71MuTgq; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j71MuTgq"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ad79df972so879025d50.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2026 01:13:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770542029; cv=none;
        d=google.com; s=arc-20240605;
        b=Zla2i2nIan8T1E2tTPqUR/Yv4XcMJTwMiG4jc+mB/zVol+x9P7jPjeOFW4GHwuA480
         fFWR/eNlUuXBm0YVJqgirLeJNH5MqzDaQ/ZkD4LlwVEi3XTdO/hA0LV8EeL7o9QPRoPE
         KqgABLykBQw71MOFUVp5tk0tB2S95Ukq+Kvz3FF05/Z6J9j2vWfApbC7UPZfGo5Ahmld
         kKP9Nqb3Mrjuylq8E5aZmbLcrPrSofeYR7D+8xUAHNdQf01aADZdDfMDBIYDmOnSf71h
         icjesKfFoYFXrTkARyI7/a1vvYr7WpBIw9f5Wwf8NN6MJg4RJMKHy3STDfWTYstd+FaL
         YAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kXv7FU95bMNa6stO1/kqqAUJcC/mu3S+U0lCuxdIHvI=;
        fh=xVMIxISUY/RdXpPx1mEUvTSih6h5WjicUO0jcPODdF4=;
        b=XGkfoXri+tTrUgvWYnVUb/dL0Z2PMy4vuH7PxeDsW0Rup3aaLZeCe43DLojQehOTJm
         AuKXqujGKbhrSscb5zJrG1x3VaAynN1/6sEyG5KAI/E8Sdk66l3CnL2kzBfa4ilO6rNZ
         RKSUpe/EKEXwXbZAqBMtDlfM88gsW6wMvRjLVbYv7iPOmpOQBkIa2T+L53tYwROmeleY
         BdYLNiyVZipSY1lpjMBm8owftOm4N1xsmSNHT3Od6SQdefcQg0E4GogvEQc8E+7Fqj0S
         OHF8bau0RxACyFoB8pfGdK4c+FaMqu+FLalub4E5JJkJiWtkTZJvSwrUDRWFsvQutl+2
         bujA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770542029; x=1771146829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXv7FU95bMNa6stO1/kqqAUJcC/mu3S+U0lCuxdIHvI=;
        b=j71MuTgq0J4fs8XGO24sBrN1qpoC9/CdhnesuCrxQZ8SXpwFtY9AVEHu7va7t0ljS4
         0bsRE4xHj9e+APEDbhtP/R82WluzOAHQj1OYRleqYmcIHZFIVoIVXmA12YJn9wKF+msV
         tcDHVqtYv+DjhcFFM1YgrC+ETJpiOFHb5VGL8jHQIFivlj4dj3qkVKcW96xtZ4tcbvUR
         D+5/Ovz0gakntcQV5UfdqTbRyvsUJ7ZXybpUdmZjXz4Cw0CsAPXb2eDmw8KusRnlm+NL
         GPCv9k+td8GR7oJHjDi+MQyl0+Ir3v1ilR0IjUgIe8Xhx3V3xeyngVqizl2wxBKTvGLF
         Vr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770542029; x=1771146829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kXv7FU95bMNa6stO1/kqqAUJcC/mu3S+U0lCuxdIHvI=;
        b=qk1r1XtWzr/RGTPHNYBWzop3aZSLig6eT9/v2Atf+xq6TvvUFRMKA6U3dtSxb01EOf
         dg7DkKEoqbn8tk6dlMcC9zotKCORlHy/WfV0YGYVLTEdxw/fF3ToRyLT0ZRX7yns3rwF
         0DWEsjIlgC+4TS604VpjKukk/WlJrghaNDA/M9GUsJpJl6veC6x7ro5c1dA38F+s4aqU
         bGPVb7+gA3tX7D21F0eFsuUK2XzshLrsEwkyF4HXeBY/iKnlzWzSm15okJa4DxGqY4ns
         JTyNvE2sSP5broUtX7GMFkzo+GdEnqCtfEi+9Fv8dI7IwJvsiZRUFVZCzuDr5JrM65Sy
         gc4g==
X-Gm-Message-State: AOJu0Yx42CezcemQ3RxPorllSwAwBaiSvznTGFFXpn5+3ZDq0DJI/G84
	VqV355XLfyOqDTFBC7w7vnUW6R+xWCEtHlA64J41V/jgMbY/+bgJxrRCcQb3jz4Rn8C2txc0u+X
	O7WuIroSEJbES8JhuOn2068a5YQ1GxjfW/vYkFJQ=
X-Gm-Gg: AZuq6aJRlLmD3m2lcyZwUe6F6u2ZnpXHOHAP34rLT6TVJR6kXHZsW9Kbbyj6XKm+LAH
	k6SGAr5cUB9+17Eq5KrCh4vknakeL89U4ShWUz1NIo4pH08Yq4KZBbGvu2sbI2m60UlieafS6E1
	aHnlWQA8iVNUgns0Xlty0MtNFrWu9rfqoV1Pukd2s8R3QRGxrW8D6tlAtQ3T/xunYRbiK75I4hS
	Ya8S5/Y4ZfZamEwAShXlfKFYRpUJEaAW8cVe69D0istaRzLNwzgL1FyL2Vr6IbAJ40lCoztTcIX
	vth2/A==
X-Received: by 2002:a05:690e:1913:b0:64a:db6f:e682 with SMTP id
 956f58d0204a3-64adb6fe81fmr2240653d50.56.1770542029628; Sun, 08 Feb 2026
 01:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPHqhPmiMYLE_v03i-CzsBmonsNiY2PeeaGgP_AUthKhK=NoCA@mail.gmail.com>
In-Reply-To: <CAPHqhPmiMYLE_v03i-CzsBmonsNiY2PeeaGgP_AUthKhK=NoCA@mail.gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Sun, 8 Feb 2026 14:43:38 +0530
X-Gm-Features: AZwV_Qhqh9EZvl6Ia7w7lAswh6kbI5NE-yyhNQ53kx7Ys4ePzyrBNhZzf7AtdcM
Message-ID: <CALE2CrR_Xrei32pc_gJ16mArZPjZ-+bNWWFnsJ3i+OGqbxwPcg@mail.gmail.com>
Subject: Re: [GSOC] Is adding 'dart' to userdiff.c a valid microproject?
To: soutrik das <valusoutrik@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Soutrik,

On Sun, Feb 8, 2026 at 9:50=E2=80=AFAM soutrik das <valusoutrik@gmail.com> =
wrote:
>
> I saw that the 'dart' language was not present in userdiff.c's list of la=
nguages.

Yes, adding a new language entry to userdiff.c is a valid contribution
and a good way to get familiar with Git=E2=80=99s workflow and review proce=
ss.

> Can anyone clarify if this is a viable GSOC microproject?
It=E2=80=99s fine as a starting point. For GSoC, it usually helps if you al=
so
follow this up with additional small, focused contributions over time,
but there=E2=80=99s nothing wrong with beginning here.

Hope that helps.

Thanks,
Pushkar
