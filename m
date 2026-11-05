Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793890059;
	b=VrTxE+nbTh72bnxoZpYxQcAWTL4EMVO6De1VZmT68Zg7BxQ//FlS0kxz7DHHTj5buxNt
	 ihmT27+BLIYA4A8NRUwZK/I7JviTvw0Jr1Czpx4x0WGiha1BVJD5h1AUntuwmuAcP2fdo
	 szsYb2mMS0yEdvbjh14K/6/FJXAdJLphykIgiAQzSgTy/yBXM0Tsauc5sLy96Y92StpA4
	 A/hKtePPdnhHJjp2SkLzDZ+896luSOr/EE0leQkWovXpFs5qK+V98puOdEO/cEFIrsfDf
	 pubhA2ENL/OLjyNxzHcUDvv/ns8Kc7SVOXKS9H8GbAs6yZdrxWycBfF9B7jUVh49ccw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=30o+9BvieMxQUdcvP4Y3VPwpgVOKIKitxcL1vsYxPy8=;
	b=ZuJ3X7U5/QRHLnsznW/Czbs+dmTdl166nDwOIgLaz0xaFSPXKb+ZQn1NjeyRX32ue6yY
	 y/l9Zxz/ADcZOkQD4Fv4URQ9jO01d+nuP1IqFwYE7P+uLPz1SPCb/i2tPavdrgQH716y2
	 aTl+ZAuckEDf5LvvmbIKyAdCMcH7//ttp9FAvDGv/pQVDLouqZg68UmOZK/5NNlbTqx94
	 /2VfUHAQ7s6xgs9kKOBAER02owyGfyZWrd+ddk1H+GE/V7PGSXCPLTgOknBUeXui/+E1H
	 hLHqDQgPmgL8LDdhEvPLlkDQYyzrfxPyoiBaT61gcG0uJ+ZrCTr5NVQcOMyZzs+u8SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ho+vzL0f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B779606A32C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B779606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ho+vzL0f
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so13190b3a.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 06:47:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793890058; cv=none;
        d=google.com; s=arc-20260327;
        b=ZC/bDYKjFKQqWURDb29ux/VjelvfmQI74NgNT/JnDLFXWQz97EQJVfp5zmca7I5aVM
         3rJyRXxtBonUBsRdAGow7DnNwKGm1+NSJ888UOME4sUezmpZpX24NN/pwNRVdI0+xhBq
         5x1xVPYJjhgfhvEI7UCkcbcEjfdCSTkzvY2CD4RrWbwRD7mPqeU5pps/UlwMjIxbT/WQ
         6XFXBKKzQZtMH/KcY8v1RZJz4wbufrXTczFkVo3ZdmUIdkq3SWTOiiOV4UohcN8iskmp
         PohRY9EJ/kghjoE7lTY/yOSd3mGRMswFIdtV9GCAYgrTfzdozFrIs5a6ssvi5wuhvg7n
         HoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=30o+9BvieMxQUdcvP4Y3VPwpgVOKIKitxcL1vsYxPy8=;
        fh=jV8xrxuA5iTLIhaNcSloLRDZMUhsKwt+L2TvhvcdhOA=;
        b=YDizXOv1iAZVS8Gxek7T4rGX5qLdV6zoSFZ9DuYgl4nYRmKG2UtpjpvlXqXbX7Qpz6
         SYMrX817Q2qjiIJNTGG9mM6fqkksVaaROvbemwA/dKi2YKsLW4jyZyH+mauuErnDt0ML
         aCzeglelwx8LB0FOv+/zsZYclE2g5MjQwDcFsXaO56th2TUu8hMCPp3qqLn5Ns8cFNb6
         KVOyRONjeBJbVc1oYfWspwm37WvhUdv/9jYZ5mJtonNx7Uxutz/xqMyDSjqESlrcr8YY
         VvaSMuTm/VqsWHObcfH+ycAjUQ0nKNbtteZ/ZdpCR8oh/qUyryc9sKPD3sLTi15rfMMJ
         1Z+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793890058; x=1794494858; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=30o+9BvieMxQUdcvP4Y3VPwpgVOKIKitxcL1vsYxPy8=;
        b=ho+vzL0f7CtQ+jRZYRE+3zR4r15a2fHccXUnKoz2Dql9/lwUhFeCzBAxV+cHrLqGJn
         1ZDYVqlSEHRAPHSk/QPSRCEfyQj6e644BzzX0O28j8vLFD48Eb8UCfcWMID9zfNGWM76
         waziDn9lFWTEqOVX76PJwyRF1il/gSCtRJCLv7PgUC5UB/cm+GXiAd0DTeDsiwORSDrF
         KQedZqBX/8tyo7OfR+xs/12bDHoc9WTNqzl8mejdGmoKvvuEFPMWnqb+TQG7f9QmA/jZ
         a7hJ21rV4wvKxXboZMw3NeZpl1i8Ef9VohJJRsK6J++gVTRoHxtGKCGxq7As8oOA7aBn
         jO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890058; x=1794494858;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=30o+9BvieMxQUdcvP4Y3VPwpgVOKIKitxcL1vsYxPy8=;
        b=v252h8AXiawNb5n5MmnjD311UWEegBmuDJhvF4x4ZTEdchPuknHkKu7gs7KohvBksl
         yv13T2r6mUrj0URNBon+PoKma5ynMLSG22iiunlSVtb9WgJCZjN8SPhObhe+/t1c3Pt+
         pRqEtmfzbKSx98P2LfeWzHtTnxWwElRNAnodd5K54mwFVQMHvfZLSV0O1t9+iJfXo7IY
         QDehNRxJ3Vf3hADOX7J0CCc7tvP2XyYr1mkLDVIcXr2PL/fC1JdASrtw58EAgefpklzg
         FgRKHN7UGkH8lIqeTpWDma1+bW91Hi0dI8hnFex5LmxsZGn4o18T71zdbadIKmN5S9WG
         Qiuw==
X-Gm-Message-State: APuU4Z9b12zF7dyZ1YuXB18nlccUXW+5YSMTswRSWNHrPGFqRL2F/tQA
	/ZacxYliZZo1K3B0cSL+ia0zg1z+plQ8wZbgjcEWQgkyYOxounyGGt1xjezJ72pQ3EUcab31gjt
	qXemWntxfaRZL+pKTMLRx3NdQsc7Qkhw=
X-Gm-Gg: AYBFou23BMWCpVeKWUnB6T1GSZ/KCSz//EEtwiM5J0lPWv/sruravAUzQPh6TqmzaM/
	eqmFnQL7hC488+ivWOnezgvEmDg2uC5xW050yvRxI6X1UxvUuOPleFLbxioAefDi9Xf5tHof0sx
	mHVR6M3qRDL3BTcMWk671uwfu2sFp1rWixulzKbmvrIRorVTZiMaDMpsLW8+7gMgnqd3qocvBjD
	2vbp3TmT3WHGdSU9y3z5fmKAa3M1tBAvW98VWxDx5IBMDhN6BeVnzS+d1nRMaMuMlTY5UnbfFmP
	WAEbgBjzcYilbRKP66yLnOODm4LDJvllyhU8mDp7Lv8M1f95ezppeufoJrAXJ7+OV1ToLqqbQBN
	1ax92H3fngkK8klH16KsADaOi6bqbMCFPz+viYVEOzTTlH4Cwq8E/UbafdsDqpAGQmxUULyGFsD
	xWf9aHh6JeQpBVqfQBI3L3Jtn2q6D1vX5FHfKN9R9I0wRN01+U2ELiDxVz
X-Received: by 2002:a05:6a20:c31c:b0:3e1:8563:2a26 with SMTP id
 adf61e73a8af0-3eb346edf72mr11072773637.41.1793890057953; Thu, 05 Nov 2026
 06:47:37 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103043756.61627-1-eddinen77@gmail.com>
In-Reply-To: <20261103043756.61627-1-eddinen77@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Thu, 5 Nov 2026 17:47:00 +0300
X-Gm-Features: AclHuK-GLc4RjSKFH65-31jW5Zf8wKISScgmWFJll3TqgkD_ayL3CvbsXjTeCio
Message-ID: <CAKrRMNrLvPck5psPpKX1eWe26To5srfFSLFObZ4zTX09RE551w@mail.gmail.com>
Subject: Re: [PATCH v1] hash: handle invalid algorithms when formatting object IDs
To: shrimech <eddinen77@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"

Hello shrimech,

Thank you for the patch.

I tried it on top of master (0ffa3e35c7). "cargo test" passes, and
the new test fails without your change to fmt(), so it does catch
the problem.

On Tue, 3 Nov 2026 at 07:42, shrimech <eddinen77@gmail.com> wrote:
> +            Err(e) => write!(f, ":invalid-hash-algo-{}", e.0),

I have one question. In the C code, algo 0 is not treated as an
error when printing: hash_to_hex_algop_r() in hex.c falls back to
the default hash ("Our struct object_id has been memset to 0, so
default to printing using the default hash"). Your test uses algo 0
as the invalid case, so for algo 0 the Rust output would be
different from C. Is that intended?

brian m. carlson wrote most of src/hash.rs, so I have added him on
Cc, I hope that is okay:)

Also the first patch versions can be sent as [PATCH] instead of
[PATCH v1]. Either way works. The v1 format is less common though.

Thanks,
Tanga
