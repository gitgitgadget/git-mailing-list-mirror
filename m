Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F55330337
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787624; cv=pass; b=P9Vni6coV2/gLBu5ZAkIOL/cDccqg0dEdAINRc5NhcCwUxLCYSYUYnI2KOeZlMwUgQeqXAoTSXZUbczsGl7czc6oSm7+DbeDCmRxmkVfjr7V0BsTzBYKhImFSDnFx9oDfdeMaEXfLaRT3Kf6JHVZ2VH5W0sF1MzapVlSwvy4y+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787624; c=relaxed/simple;
	bh=KkG2Dxw1JpIg3WOt8y64KDe/LJFXscokKGjArCQj4kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Obw4GPL6S9N+IO1/5s/593xOlvOebWATSAcCmeRoCkdGmxGAplB1irb9FPrEIfVQd0lwAUnoBuI0ZRx/DS2FjN9w7KSeAdEUdnrbNFdc2GqJwYJw3nnx9bigV3mMJINnpSqD3l90NxyMZor0A2NvfOsEjqsH1zD/D6z3+1nb9cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViWSYuyi; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViWSYuyi"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b876b5c69baso10232966b.0
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 07:40:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769787621; cv=none;
        d=google.com; s=arc-20240605;
        b=GwNxR856NKFrZqRN6F6x0KcCIxPKmRfttc6f8TfJlnMcsjuz9f3Y++NEXSOlqwQSkC
         HcQLWRgViVmPQ93SjQdVQtKO7f8L0guImFunMhgiwoIgLgKMj+Xh97QGDXlcoGxCuneF
         CjFptPR1jwlwjjwqeAu7GlrlRERZ0zN6HcSWfiPX9+++5jikmagQE6XyvfoIFXJ6i2ac
         vPFJJbJf9ltU7m1yLQSvEDoPw7hBpmQ8v7839Zm0CC6NMrR++Xm/SgL1V8kjHFtCwYIo
         FlmZ+HzuyEjKd9AXg7EEn8uRxbi1l1glW/xOiDuC/ncgnwYChIcZe0j6nsXS6Yho9373
         eVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KkG2Dxw1JpIg3WOt8y64KDe/LJFXscokKGjArCQj4kc=;
        fh=dCMKzY9fmyPCO0VnAEWi8jTdyBsoABwO2YCfq/YCqbA=;
        b=X7DdpuAlvq/LSuaGwhpgz9mqD/pSjnDBt+hoELlzPSdsFXnaCpuCxwi5ZIgLsqBSRM
         cDuHRxJX7OWx6R3kiQURby4AdoOe3roGVIYQXT8Cf5hM/Uw1h0FNWyl8j8ZcIe6BcRFo
         bK4n9nwlZlwYAqMkuj/srRBkmf/q80OKxxANkFk1yaZFdnV6utdjiE+8p2ZtbOWY1+lo
         RozHF7D2XneMZSQXNK2mlpmdYQ1jjanLb9ggNYWZTlx1ECnjjSljbKG8onTKZwvYh34i
         3BWmF2ex7gFzA1i+Dh2UDLq3pErPdpWJ1b1bWNDIz6ckNf8pq7bUJafu+UDsGqmC/v7L
         tGQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769787621; x=1770392421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KkG2Dxw1JpIg3WOt8y64KDe/LJFXscokKGjArCQj4kc=;
        b=ViWSYuyiYEUeTbIfS8+ntqtEbN4aKQyl8XXXZbT2ELsmaegtjnM6ZDnxjAHYhv0DBI
         xdCEPxCIf9QtB2cJr8bQds6q3R3YEwtpoQqv+8tV3VX7+z/XAJ8ax4ct8TzBi8O1ooeo
         FbQjiwQfS9vYvR3VGPMjfuSqVgBICbqBYQEdpX5MzdiPtlHMftEknWBbjfvNWt9KEaWp
         woGIq3sp1dh2oUpGwqiEUSp/jYbvmHIxbdP/HaS+4mtTeEnqnowlo0ZsvsJCBiYZ2nHc
         iWLteZUKoThlPO7GuoX/yRXN3dOgqkKGAjUbtVSRsiJIitbEoQhCCSu3VzztJLrzkYTJ
         b3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769787621; x=1770392421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkG2Dxw1JpIg3WOt8y64KDe/LJFXscokKGjArCQj4kc=;
        b=sBonx9gR15RPTY7lNoM2yTgbORiYXZhtbr3n1WNUr3PLDa5pfNOxpBJULEgMKFj/YZ
         fldWZCHvVJNXO8GnZkVnjuw8Qp+uKqhiUnJ9CgeKPOY97lpUupoczUnc//pqMTJX1xgQ
         LMs0Kf8WICNhaF/6jqKSXoHzuOpeGXpgxmTVnbePIAEVMHbaJKPLjzZaJe10O+U65aeY
         r+X3kADst5Cfu2uK6MbPiOWsbWyLNIFyvOLCak1JjdtIlNoCetwtIAO547FgEmCq5VXi
         uSX9HFaROVqX1KyDVRvO5MPAU7lnTYH7ckPWt6aiSSI6B5A7K6+hn/O5PrZPwNEl+8Fd
         vomw==
X-Gm-Message-State: AOJu0YxeJAL3hn7NbXAvhVdabxstQo0uaKxXruLqZ00Z7NHuHQsRZPuD
	31/GwttoLxZQ16JvwzE/AJs/6pCuW4ATSHv4J9Qk8TbVAynFSCpPxlc+rn/V8HYQYj6uDaJkxMV
	6IdIGdwvqPBQ3jooDrWXzLOG1rkS0CsI=
X-Gm-Gg: AZuq6aIPY5tBF2TG6Tnil4xvIGyzxmWUf+W5RSzgcAL9g3VVB6NP9aBcQWjwr2tYvq9
	239hNyKODHI5/6yxqAq28p3Eq/NkrWMiJIRCVHPvpKbwGM6M3V1CmUwWOjghk58VVV03pHmkvLd
	C30n1ceGQTv4o6l1K5nOB4/tMbpldK5f7nhAjYfAXya9PcitVPt8ROoKPz2WViHzC/IKtovdwu/
	yv+wc9wF5pt5khdY5SKmDGDwW1yrl9mfvvzSV0meZ71mGFDc/1ux20ntnQ5qH6gQocLPg==
X-Received: by 2002:a17:907:3cc3:b0:b8d:e6d2:6440 with SMTP id
 a640c23a62f3a-b8dff5a48c7mr115937666b.2.1769787621139; Fri, 30 Jan 2026
 07:40:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126165618.596944-1-a3205153416@gmail.com>
 <20260128160717.611391-1-a3205153416@gmail.com> <39b421df-a2cc-4ab4-9aa8-b79c5c172d86@gmail.com>
In-Reply-To: <39b421df-a2cc-4ab4-9aa8-b79c5c172d86@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
Date: Fri, 30 Jan 2026 23:40:09 +0800
X-Gm-Features: AZwV_QhhilWu79wnMKRYbqVS7H5RgPhO6cnKyP78h4m-hCQlSoawF5QBwATjNHE
Message-ID: <CA+rU_o79w=LPqRZyM4hWt2U6mWMr36Z92ebennrs+P_Ge9JpVA@mail.gmail.com>
Subject: Re: [PATCH v2] t/perf/p3400: speed up setup using fast-import
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

Hi Johannes, Hi Phillip,

Thanks a lot for the detailed review and the great suggestions!

@Johannes: I will adopt the 'sort -nr content_fwd' optimization to
save a process.

@Phillip: Your point about the pipe swallowing the exit code is very
insightful. I will
 implement the '--done' protocol to ensure any failure in the loop
causes the test to fail.

I will also update the author/committer generation to use test_tick
and the standard
environment variables, and fix the "reversed" typo.

I will prepare and send a v3 patch shortly incorporating these changes.

Thanks,
Tian Yuchen
