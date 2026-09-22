Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14AC3655F3
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039897; cv=pass; b=feu4koHfVa4dFU6+7RRLuL/+fCb5lO/r8D7z5lbHS6xBnDi7H7LgsOHDgSO23aaQC3vXvGTpbEny4hDDkaQJDDQ/KbUByb41ggUtUNs7Spa+aHjgAzN5MymTZkCBvr5dAL9K2ySbboTS5Cih6U08bM2yOHCNzZJZimm08FWF+W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039897; c=relaxed/simple;
	bh=Mg4QCHnLptxDdjZbERGAUQxRHp7zu5SUAoa6mht4220=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dP0vIWEmK1qv4zI66mVh0e9mnaI6ZpB0/fYNdbeK5jXZth+4mIm1rLY5IqXyaM8VbuMf3vF81MpYDkgnNWFPZHIGymmypDRz7UDINL6cEF7sLHEFQ2L1L4JRIsPP96tBKbPRFNRpg84JHXPijXMfWTg8N3RGAVHbiyhZ/NaU62c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUVRSCTQ; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUVRSCTQ"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16c72so2896154e87.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 18:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790039893; cv=none;
        d=google.com; s=arc-20260327;
        b=ZdY1HJi7gZ6uc8y4+j1hEWJpxV9gktS/vfx5t7nd4oXEKzfmZvkox0YV1hDFhwziAe
         OG4AXQZ1eb/whPDZzwbMyGRPzj9V+cxF9hyMb2qKcQZnlaaBoKyqlMjXiEhA0dA+oBs5
         j3NOlTbOeTU7x0x/AIFicuHtnK1alJ5G2QB8ys55qqkTykTU6jCM/jkeTmY4+6v3mwcJ
         lG+O+QrXhJHMGchr/HoX19D0+b1cjCnliq3jWECTWlyvq3XcUhyYEstYHNyO+C9L3sVd
         UlJi7HVtU+6H26V6khqZhS+vlmMOCao04b6wx6PDhJRryYby1at+G3s1siy7b3NJK+ri
         katA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mg4QCHnLptxDdjZbERGAUQxRHp7zu5SUAoa6mht4220=;
        fh=XRDFyRJ4NgVcrOoxDPwGRClp8BXvB/k4E7iVchK+EGY=;
        b=oUYJURM5lVX3Sm180ToK9sWM6kHekAYxGN6rWQBmvUmAaJNyhfZa9JkJ5msXw6RIwx
         UV1vvkl+4+UG8XLd6aDVUc0CEQh6awyfqbVMJtBtQeBNpAFoVdR/E4jNvHa0G7A0JUd0
         sXVJczxLlQed/vF6LBl2eOkJyI04RUbFyclm379yA/a+Wm1LsscLgVIeZo1BGxX3u8mt
         CuhU7pgTszwuWuXLChZ+62rWTW8ydFtxfMOtcS98W8vPUx7rNur2ABEQxSRoXTpavr01
         OE7NnLT8ybmdLsO4CJz7zFdiDa3ZQQWCVP5ZZcVknTRJ+7xWEO2jC/R2hmsFJME4DrUs
         2uJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039893; x=1790644693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mg4QCHnLptxDdjZbERGAUQxRHp7zu5SUAoa6mht4220=;
        b=LUVRSCTQPRgHUuFkjRp0Au5CbmB5L06rl261jMzBFP/0YkvQTMt8l6ui+4qY0E8xL3
         FaLhfkpuljftz7lly7G63n3Z16qFTnrcMmb6ZW2zU0g3Bh+Aqi2QdAOjU+vJQkyXXDuN
         OThZAMSOELXJrlH+x4NtBUe4VXoQVqwIy6R2ufCTjiAWIAg51IKbJ+QendT7MWUpBXS6
         Pab1cvf1gwLI673B3FdNHWrSmOKVcdP1Pjqdi+iO1wYPpPuz6f2+HwzoJVOvEbdrEmLo
         uS0sCzbjSXKn2g5B12iY9ZjGb+MDaMibDFaLDDv8pbEb3j1bifwGlHlFQBa8x/veCvjs
         WVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039893; x=1790644693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mg4QCHnLptxDdjZbERGAUQxRHp7zu5SUAoa6mht4220=;
        b=xEnPf9S4YepTPTgbdmJ+TM7p6pNHmfJ7Ro6jqcnh5MydchoAGpc2NdwyNvR2anlrU5
         WgBMEVmOuJJU9dHVzGr99+ZiEOrpynBaA9o2ZvzdZSYDRrJBvUUim79NsXkqH2LRMX6B
         1gMvtGRTHpCJxvXttEUZkJZUHM7UN5LEqMaPymLo+zb5QIOV99pytA2dW6MXsIxew7VF
         PxSG8u7LTZMrfhLOVgkMylTH0eBwnaqIMR2hyU2AWb5Bfvaj8BIWs8Pkj7QMn3yKx+XT
         rzpjlaNDFZi6sHzqFDUYATwPbbIpYp0CFKwDNmeeMdMrxp9tfe6Ipg8xVVw3gAgLC2Xc
         NvhA==
X-Gm-Message-State: AFuF++kiQS7AGEOYJDwwBeIurej7EsyT1Qzr9rDP+AJVcRl7o3HxMECG
	5fLS8T7GaChFaR33Y4QHwXfszJfnPnc5iYrPMQzGpvlaCKQyopMn3DHaULmcEMR0pI42Au8fSKj
	zgxcs6RhxbNKnU6BxVcHVErLqsn21ncXcYg==
X-Gm-Gg: AYBFou3zJcmDe/2XFhoTFmJMFKZT2HOs4xwYxKKcCKFErqq6qQb9armBKSYnhVH43rd
	m8z8FLDWEtP8pY6dtPOenLzVMTRW9R7/JEpFg7MvGHVHgn1ln2a75zgZER9hjg1Csr4Dcd5/xyt
	cNHGOi5CqQ8PGBaUN3wfh++lImNf/HvEggzR5edtSaj/jptnMNlM9t7AFglbf7tAgmpI37yLyuY
	ji7aiZfVN1LywXKRkv6TlZCooaV3/nueWB2Ga2zE9uFNIytM1mp/IQ60/bj0LSCt6mDSdKdEdHw
	Rnkamb6Ll2oPqYAfPgfZ8YxhVa65bQyirazg1oXyzkFraIgTQbCUi0pf
X-Received: by 2002:a05:6512:2c0f:b0:5b6:1a7c:fd8c with SMTP id
 2adb3069b0e04-5b8c1967f89mr4659643e87.50.1790039893232; Mon, 21 Sep 2026
 18:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1789994808-30642-mlmmj-3f9f948b@vger.kernel.org>
 <CAPx1Gvco17vf-rmQsqumLdX8Gcjnu0Qx=e7_PdFw0p7BDRLU7Q@mail.gmail.com> <9d1ac51b-9969-49a1-a911-7669872d28c4@kdbg.org>
In-Reply-To: <9d1ac51b-9969-49a1-a911-7669872d28c4@kdbg.org>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 21 Sep 2026 18:17:59 -0700
X-Gm-Features: AcwNN1W5WaE0HqRD_HlRbC220p3o1DgvFFeuF_wuOd1grEIovJ0AZDJmpPCY-BU
Message-ID: <CAPx1GvfaSK-rUqKAPz37D5K3COJ9orXNKSkFtDmqVocuvfaNZw@mail.gmail.com>
Subject: Re: [PATCH] exec_cmd: RUNTIME_PREFIX on OpenBSD systems
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git List <git@vger.kernel.org>, brad@comstyle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 9:43=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
[re the multiple get exec path call sequence]
> This caught me too. But notice that the calls are chained by && so that
> the first successful call determines the outcome.

I noticed the &&'s but I somehow thought that successful
return was nonzero instead of zero.

(It didn't help when gmail went a little wonky on me,
either, hence the accidental rejected HTML email)

Chris
