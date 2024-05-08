Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CEF12BF04
	for <git@vger.kernel.org>; Wed,  8 May 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715192067; cv=none; b=Mwi/rJHtrU4eCm2oqD5k5oTXFpP2SuFxMx9hKA6V0c2e0PPHR/PszMPCioJvZyVUhaafR3Iqhhmt6rSJUCTzjoZzKZiOuaJWNX4uMBjBYSI7GZWsF76mBbjCd7LDRFnPndI+tI2GCZFXMk17fmHFCGQaxYCUtaRimOe7k13E7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715192067; c=relaxed/simple;
	bh=TKy4Z+8NSGCFoiO44rvcLi06KkT73OoU1Q7iCKrCC0c=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=iqTTrnMMeENX0eXDiY/eXp9cuP04VxbrpLVEtGxXetJVUk1SlLd2Xdy55ToPPMs6cx7W0OnQ5p4doXUTj/e+4U4yRCfbjSbTm7Aj+rwsPpO8jZUMFMBPCZOvex8Jne3QTaeE+NO7bvTkmeuBVcsCD58z6bbeZo34RCH/tXkwUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gearset.com; spf=pass smtp.mailfrom=gearset.com; dkim=pass (2048-bit key) header.d=gearset.com header.i=@gearset.com header.b=A7gbUt/i; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gearset.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gearset.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gearset.com header.i=@gearset.com header.b="A7gbUt/i"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso5668566b.2
        for <git@vger.kernel.org>; Wed, 08 May 2024 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gearset.com; s=google; t=1715192063; x=1715796863; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOb8G1vHsgoDZIjoeicJ5Ipq8Dtv+slzE4MqbeL3gJ4=;
        b=A7gbUt/i7OwXqw7nMRxwKTB25SionNQwkUhv0HifyEPQqaV6azm/Rh8N9YKy0TeLQE
         a+m1Rt5W9yGFuD8dWIlqUhrUFc2uEEYZ/hCE2Le1sz8e/vw8zU1UhAcJUgfaNHR8wb8M
         95zV/sY2iMLgYg7FNaXOEnDF7EkA0cYBMVPPFsmU/15OKx44U15G39X4+UiU11uevhDM
         KULkjb2/+cH8yWMWipugplU40tlDnHEMhwD0wWKvE28p66eg1Jwh3OLrGP79zNTx4Tm5
         SjCChJindJbzle6+AqvD3lZrrUHW9XAVs6pxSNVHs4uIGN1FyqrfrZpDPOAiV0ByL41S
         vvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715192063; x=1715796863;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOb8G1vHsgoDZIjoeicJ5Ipq8Dtv+slzE4MqbeL3gJ4=;
        b=XPoV1ykM9cSL/PXWk58tddjkbvIH/ggOULU7bNiib4zbtkDb37JYPm2AEpKNQdtFz1
         mp2PlmTfv8blXMeYR/gkgHCXU3vMOUq2GCW27ao7t63UKNCeN06a5QpTaK+b3cGpn+Ak
         HyGEwqZCSXdTtwlnB+sB1G1WdXUda7096KIQchQM85fi6yzSIhJqLo88ex6SIXB59+AR
         dAZkJeiZAdR1xv11WqjlzkjAVqvw1HJpZDcK8x2My3EhftsWcErlpq+EogUB758OVHpC
         z2JmX0kZUniszeNO7KLPFYX5I8nlQ8E/5Nw1LvFW/aQ87T8Qs+fI86n3IVDyBY9N+rSc
         wFHQ==
X-Gm-Message-State: AOJu0YzjQLTl2KVhs/iJ8DLCpJ3KwFjxwL7QaMEHxrrSI/NG3LVPRekZ
	ARuHueFoOZsWhq5Jr87ApgMOm0zKIibTNq2wHBgxG1UY5jAjhCy7VcqLfSybm8sVOspoPzkXdMX
	96rrQWw==
X-Google-Smtp-Source: AGHT+IFMNVBXRCfNgpWMwf181ghJBD1RHbBaEmMGJLhuBV7BPkKmKEb5/mEwlupfYmwOsSqGP57tkw==
X-Received: by 2002:a17:907:7893:b0:a59:bdb7:73f4 with SMTP id a640c23a62f3a-a59fb9d60d2mr241518666b.61.1715192063575;
        Wed, 08 May 2024 11:14:23 -0700 (PDT)
Received: from smtpclient.apple (host81-140-166-74.range81-140.btcentralplus.com. [81.140.166.74])
        by smtp.gmail.com with ESMTPSA id oy29-20020a170907105d00b00a59b077a70esm5218570ejb.2.2024.05.08.11.14.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2024 11:14:23 -0700 (PDT)
From: Matt Cree <matt.cree@gearset.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: Unexpected git merge exit code when killing merge driver during
 ancestor merge
Message-Id: <B2E03023-18FF-453E-91F0-9A55D430EE31@gearset.com>
Date: Wed, 8 May 2024 19:14:12 +0100
Cc: git@vger.kernel.org,
 matt.cree@gearset.com,
 newren@gmail.com
To: sandals@crustytoothpaste.net
X-Mailer: Apple Mail (2.3774.500.171.1.1)



As time has gone on, I=E2=80=99ve discovered when we do have this crash =
during an ancestor merge, somewhat unsurprisingly there is an index.lock =
file left over in the .git directory.


I=E2=80=99ve taken a look at the code and I believe I=E2=80=99ve spotted =
the issue =E2=80=94 I have v2.44.0 checked out atm.


In the function `merge_ort_internal` function the ancestor merges occur =
using recursion. If there=E2=80=99s an error during this process, a =
negative number must be set as the `result->clean` value and this is =
used to terminate the recursion early =
https://github.com/git/git/blob/184c3b4c735f1c1f0f811fddcf3c2676e7ad613f/m=
erge-ort.c#L5052

In terminating here, it means the code does not continue on to the final =
merge which uses the merge_ort_nonrecursive_internal which would have =
been called in the non recursive case anyway =
https://github.com/git/git/blob/184c3b4c735f1c1f0f811fddcf3c2676e7ad613f/m=
erge-ort.c#L5068=20

=46rom what I can see, that function will correctly reinitialise/reset =
the opt data structure if the call depth is 0? I am guessing that is an =
indicator that the merge is supposed to be finished? If we did not clear =
it here, I=E2=80=99d guess we=E2=80=99d run into the same bug I =
identified during a non-recursive merge. Therefore, back at the point we =
first found a negative `result->clean` value, I think we probably want =
to do a similar reinitialisation of the opts i.e.

>		if (result->clean < 0)
>			/*
>			 * When there are ancestor merge failures,
>			 * the merge_ort_nonrecursive_internal() cleans =
these up
>			 * so we must do it here too
>			 */
>			result->priv =3D opt->priv;
>			result->_properly_initialized =3D =
RESULT_INITIALIZED;
>			opt->priv =3D NULL;
>			return;


I=E2=80=99m really not familiar with C or the git source code so this =
might be wrong, but it would be useful to have this case handled by git =
rather than myself as the time between an ancestor merge and a final =
merge can vary wildly and any kind of =E2=80=98short circuit=E2=80=99 =
logic I write would prefer heavily to use discover of conflicts during =
an ancestor merge.=
