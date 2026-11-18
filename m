Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795045580;
	b=DNZ1vXyCCBsD5xsI8X3hFFQPTSo6POo30AIL+qVM0zyRKUGbEUJpJ1thNSiTlJUhAKQd
	 NVV9zcVYcIwnSEJH6TJO9Mn5rtBhO7vpyTj0+JflSgh3h1E6fqNfzkFvGuvBzpgETAoHe
	 hwCEnn01l8+UqWnjB38RRXktn5sWXUiz2Nqm8l1i9Eex2RoL1533iMCngsX9RX5FCjvjI
	 F//B2wRSYO0mwrXs5icMtSfIMFzEfT1MQyU8nvRdVsazvVe2gwEVhsO6yBJSm65Qe/NJN
	 aJPgoJV9cq1VAnw6fgPrk14rk8h/8n7dnz7qTnnkeEwX4Jx7AvF8wS+MLK7+a1bh8Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795045580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=sq+XIHGzCgkgAROLp2cEe5shflRlo0lNphrsiUztsAo=;
	b=tcQTwc3jmBSci26cRi4y7mG4PYAne4BPxMT0yZAtdZ+6DFAajH8QoXQgn++3DSstIdTa
	 TMpuLtbKRtbB3BgwyWJnjXA2xs74twftCTURVfJoW6QBDAGUBD+0kIINJXfFiE7/FS0cl
	 fUukE1o77oZwRSJ1/jF8mErY4bgUpNGaV5q6cc/90+Y0o/BcsLJoaApCuBOjaOGnhMSSN
	 BiTuxT1xrD4gmUZct+iDUTGrCVLXyindlOQDTISOzf71D/DbXPnn31021g9vIL8/YzmhB
	 6O9+iJNKD2So5IL4V3rgStUQVQdmDd8qEKzo+fJarfeYYNB+AzROFzjVnDtwdipff/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=noam.me;
	spf=pass smtp.mailfrom=noam.me;
	dkim=pass header.d=noam.me header.i=@noam.me header.a=rsa-sha256 header.s=google header.b=XAH40qR1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322B606A325
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 23:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3322B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noam.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noam.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=noam.me header.i=@noam.me header.a=rsa-sha256 header.s=google header.b=XAH40qR1
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso280896366b.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:46:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795045578; cv=none;
        d=google.com; s=arc-20260327;
        b=f1wlSrD6O1RA92OiE1HN+4qYiOFBTl7jwVsQmlKzUeegu9rzwSNWRErQO9CjXKluLN
         y+iWIMFFbuCNkWUrG/XSuVTIKHZ5MgXR+fl9PiYAGv/OKjxLOPc2LhQtLjsl5r185UML
         eL+NN6jnyJXclZamQgdKcHTO6lI4HUoTDu47w95iw53BHJAnMnLDknqIoL6V6QBW4549
         jM+owgHh+M8duL6HEv/4iNgnynryv7qrN0RkzDYc3lqy67U9nkXqkxNhYxP7bazmY/Wv
         U5swZsSiRpENyOvDXnqMkei/FUKWl3fOCZp4At/cmfughunMbTld0OA5DdGCyj5n7kiE
         bzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sq+XIHGzCgkgAROLp2cEe5shflRlo0lNphrsiUztsAo=;
        fh=EWEqutMSy2TipolHUCSaYlfyeOq9uDJOmSABdyCDgYI=;
        b=M/RYbs545h/sUJv4wyNsdNDvqzaaL2yf5n30GVmY11KsjxUUnHuJ05/MpvKdATnHBK
         IPxybIxl0ozqNhS5/kgDDBlf1nAX7QRLnShOAJTWj+ZrrAZ1Jl1Rrbc3sLkGUH+RnfHu
         7Yr30sZHnDd+HNwCrmDdBnDRE2ljnt1nqERwe/TUqBMGokorIIJOFFC/3MBd6HsAfqUA
         VFtK4fVc1T+stn4VWTuxGy8tAUdG9sTinANljnp6GuVFCgL1dj/lwjcbHU094ROaLs43
         78nG9My4E3QC1l570ShlrdYZbbrf1Af+OniSm2JAxEdK10I11AGhlMm62j3LmJkpMwCC
         kovQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noam.me; s=google; t=1795045578; x=1795650378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sq+XIHGzCgkgAROLp2cEe5shflRlo0lNphrsiUztsAo=;
        b=XAH40qR1kfM61dJeY4jbEoHmxNDqpuXM8Cyo6x4g2Dkx1JN/+sNxHUmizf1rd12D0H
         /CNqBLyCRbiQQYu+DyO0cefZyGJWUuVHrQMt6Cm4r1oXnDUvzAvF7DkTiEP0o/WMGbU0
         JWEc3v4eSyYeneQpngjXB7SDyWh7CfiDtL/tziOKnAFYxwAJuS0Esfiepnwtq+9uLIqR
         2GXEcAKhUrkWHOqLurjG0CPsf9rIAl7pXjxeGS3LXKlPBhsOGDyxaHmRTORILg5udC2l
         XT5owDCcmwba9XnPT/vTk0ZxWDekMsD3yGaCEzzKu0ukARestUpSUeqKkgSwzGQVWnzc
         fzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795045578; x=1795650378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sq+XIHGzCgkgAROLp2cEe5shflRlo0lNphrsiUztsAo=;
        b=2w+YbURy/lhGOwa2vhigOrqIHb688dXP7n7MNIWtJ9mszJjGR3m8sYxkA789ybRCXU
         nMyHZhu8m+RUN4VTNNh5l0uU4q/x1YYEbBJCSzb6ZJ0VcqtSsBskt33BO5qUAwZB/982
         JUQgfvIlqsZtQHC1/8/8sfi/qyFzxlq7R2hw/hRCPt701jPgsVxSaKu4oEnpxwShbce7
         aDm7d8mRjggBfsZhc0aepqodGWHnuhmJ612/Echi9MzkiPRzRmRidYsLvA1vM81FSftX
         /u7z7KD1k9MfEyC2BELFEPJuZw/lFYoB+X4N845e0Fx/K72vMavTc5YleAoTdTEXpX9j
         YH0g==
X-Gm-Message-State: APuU4Z9B0sMZC2lxRPf/92yFGlfsUQ49Fhyfqja3A1f31Qibs+NiLpWK
	iEgIGdFcWInEnOwnhUkUnKhA1hcMW22Q91uRw2pPereyQP2SgUKGVFnbqRFPwEeaxnTpPBAYREY
	8efX5gR8PABy2MN8AmIb13nQVpDtpXu5HQUUCnceVPA==
X-Gm-Gg: AYBFou39ayUza2XejhluP5kGMIZ/t0GnfuhKuEPUXI3OmFlfUCOInLqghIk2wx1f+oJ
	Cx+dnoLIpJUlYiD2N23hxV2fHiE2Ya5GNCziPIgaaS9jSfkoGPAFzMGals5mE4t+uWSQvN/foeh
	mGnNRkW9ABXuHFWrefthk18qenV6cZuddIXVBTlth2tXG3lO6P5hi9UEM0Za0IobiCN2jddR+g5
	SpNo/npoUUeh1eW4fMK+/cyri7jwoL4QdjI2uwTrEn2Pnms44+GDGH7vHSxYacoXo8idbA9YMmU
	A5WV+0NjLy5fd45iunxlmEGUI7O1liPrvAWIUGuEPAXEOAJuFOVoGf524feinNlhO9UEE5g7w1s
	87SfcnrxQFTnYwI/Gs3OUKGJbuHroaY8T2QBCHP1zcGoVh5Mlgi+hqEfU2pFchAKWp0Aq
X-Received: by 2002:a17:907:8693:b0:c3f:e414:d35a with SMTP id
 a640c23a62f3a-c510e358f3emr354033066b.26.1795045578439; Wed, 18 Nov 2026
 15:46:18 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-ls-tree-format-z-verbatim-path-v1-1-718987241861@noam.me>
 <xmqqcxs120c8.fsf@gitster.g>
In-Reply-To: <xmqqcxs120c8.fsf@gitster.g>
From: Noam Cohen <noam@noam.me>
Date: Wed, 18 Nov 2026 18:45:42 -0500
X-Gm-Features: AclHuK8Bo0mZTQVIDezCzJQfrxJuMiTdM1kTr_TT5hsJ-wU7wteczXl8k4dlyRQ
Message-ID: <CAJeEYUaJt49oz+Fq7qwWGyB9p=Hibdzd3113FBhbK1RDn3oHug@mail.gmail.com>
Subject: Re: [PATCH] ls-tree: do not quote %(path) with -z
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

>>  test_expect_success 'setup' '
>> -    setup_basic_ls_tree_data
>> +    setup_basic_ls_tree_data &&
>> +    test_commit =D7=A0=D7=A2=D7=9D
>>  '
>
> Do we have to really use characters outside US-ASCII?

The only US-ASCII bytes that quote_c_style() quotes are control
characters, DEL, '"' and '\', and Windows does not allow them in
filenames, except for DEL, which felt too obscure to rely on.

We could avoid the filesystem and synthesize the tree with "git
mktree" instead, which is what I had at first, but that made the
test noticeably more complicated than a test_commit in the setup.

We already have tests that use non-ASCII paths, like t3902,
t4012, and others.

Do you think the test should set core.quotePath explicitly, rather
than relying on its default?

Also, should I just drop the test, or add a similar one for ls-files
--format?
