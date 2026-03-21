Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB30D2FF657
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774101420; cv=pass; b=gSPZTGCs+XG/udVvtx/FT06Phb4zHAz4eKTSj5pyYU3f5uld6KN+Ch4kLKRhxLTyF1cHKElmZFjIOq2cLQls4pk1SU8jJAmS16OUYSONc1EEjrCH2woISVCd5DDfHApKwi5lVk7NHsOlsw+h/jMoE2pYcsDCmPT32r8ErsdFrt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774101420; c=relaxed/simple;
	bh=oYt2cMzCTbohvL5FdnFCpNym2LkxAh4C1JMARfax95w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqiwwdCmDP8XoSYuDAh8dpDckNJogSYbKLAiI4Tlj8JcKMLn+RCsj0+GH8B4zHb8ZiYU8Vq3LrNCYQQszl/VBNEMPrpfQRqi9OygKFa+U3nmm7jx1MEljecD/MkeoMUdBi8WNsDCNo8X0AY/xZlQX3PthgnxqzOFI7+V7msm84w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pzp8r413; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pzp8r413"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a0ecbc713so32422596d6.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 06:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774101418; cv=none;
        d=google.com; s=arc-20240605;
        b=kfbR5wmnu3LmrZUmhmWkC9ORlq3dqU3jafMYs/ietdYxSbio+ITdkMqQhDiScuuYgj
         iIbi3RCezNRS35yw3hdXC+MKPWLgfdwSlo6lIX966IhPtyJlH/YKnh0bw0cCqfxOJlL1
         pi+uiL2gMlA8EdAPfhI3Bpafl778DXPkYrVJQqCudbFPLFSKvuus1sL6PpeAjH82y49J
         1cLUSL2t5LhmMSuUpBsYqF3byXMUijdB/bNZekOXtpDCXupCfC1Zwn+Dc40R7xVbUKbx
         3HpqnenxpkFfbozwgkN7arLCeBLt/lVLWYUNVEEcenvo9DbivTfr5V9/bBVJ24x1LX5x
         WXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oYt2cMzCTbohvL5FdnFCpNym2LkxAh4C1JMARfax95w=;
        fh=qisQi0zCme1vRaxgpOWYmI+FizgBj8QBMRhMtuzhyX8=;
        b=NQ2fdDGbSUQvnQxgsO+2tcFi8yWPvaOQ+R61ThCBcWcY5Wd7tcwyHmtB+78OA7sq8E
         stb0jttOVr8qFxK3jPP0CMrT5p8HAVtWNgVrZ/J9TRf5MCNy39hZqkEv3xhfqFuozC+4
         au/FZNq3Xm0qcUYJYM2vyD3m5McsYOR4997Xtb+WRoyKy2WwM3isHPIdITknzcIv21us
         fQ+AyezOXycbP1I0iokcMPt9GWr9sl+KV4gHwbYoJU6PV+wqGRWfCFZWttPrviQh3skx
         8ptF0hry1cY9n5JkimLkngMhg+rpdCx0PIRVcCTmkZ+rYqhXg87StPFeSTZAS6dPe1P7
         T+cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774101418; x=1774706218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oYt2cMzCTbohvL5FdnFCpNym2LkxAh4C1JMARfax95w=;
        b=Pzp8r413ld3banvR/gnFl/faWBHcWhi2FBqOg4xP3b6/Ob0adup7xEs/EGu960gH6W
         GMQLAs2tcTLOgqbjCFkTeObcu05SeQHaq+LxefnHd+vrKBZTe8CkKz9PtKSRCcVc+wXP
         3FrqgHUv0T0/vpnTbS2Rj3vJ08Fcj1Lomn6QzMcVb22UJl0QAGMeFIXgN7RLynDHY6HU
         RJwX+ZebRxYL5ocXCLtS6Z4Sl5blYCLO9FEAQsufRW5tzY/DlNb267xlbNIK3icclZlz
         EEDYEyJjDp/Eg80Z0nL1hmZUYEC+IFqXZbM1dEzVPeRr8g29JrbdkMSjqT5wdKjM7cS7
         zucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774101418; x=1774706218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYt2cMzCTbohvL5FdnFCpNym2LkxAh4C1JMARfax95w=;
        b=UpQ2n3r7oMO6wbBiWqQOQJZZPzR/RXR8+JqHaWH3CKmyksgU9E6u5tz3sFcUdGTN9s
         uuX6AO6zpQE/XySyCWZ4LDg/atTac2Rm57i+pvqasuKir4HvDoEEdEteKPVXzW3jUlsb
         yT+wajHeOM8BLzdMIoB6Jaip7uP0rKDV5d9aUw+70ycIFlC5GeLSKB7y8l+qE7Xfn3D4
         6dY7XOhnzhzc2SyEiFUBGPOJduL8nL1h2fIzDCd27MR1X3GAkMXZr3cuseuR2pNI/dRP
         I/CDtV4S86YsIRjZjotRa8y6LyukrCYwSQ8A56Lgy0jiCGGPsia06I1Q7PoCRYjNvL2a
         Y3IA==
X-Gm-Message-State: AOJu0YzrFw8/ujO464ntV+OkIoCXslZjqVcJwgXlVcwqxGulP+P0uffD
	8JQ9MYfIaW9TtUpw0sA/x+0dg5Vj7s+c95LYP+I3JzWSHqqnAHH4+KICmS63UXhfPZ9obfhSRSN
	LC5kiDgHMIo16DG9LyXS4Ipk56+x1qg==
X-Gm-Gg: ATEYQzxsToS/dcIINPmbceCpxkuYL6StSh1pXp+khc6k1o+KpHbLuWR/lt15sCctxw8
	YE8WDAVYnv6qJZAqsofbQPwOtPOvdON5b2q0UNmRmSdpVSJAVUt9HNnTq0+eKcVLOETCPkXAvQu
	qdd0bMR8eZh0yjntUA7I5oIsWaC4XPQ9L8EYni6bnFjTKGHYBYVokrDtsDDytAn3/8TKqjMcmy6
	nHoflEL2I06Ya+3J/0r2uFvfC7yoAAznNTMGFlqzNF1FuxwJNA094oEDwn7lciWP3IE8Hs/t+AF
	EM3OEGHfELv2p3dQpaqa6Yoqy5xgiCk6+HY1PQ==
X-Received: by 2002:a05:6214:3f8f:b0:899:fa7f:7144 with SMTP id
 6a1803df08f44-89c774750b0mr152862466d6.26.1774101418642; Sat, 21 Mar 2026
 06:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEaT9_9jAoXkxKn+2+q654aKybC1=bk6p7xiVHmcy+YDDe7GXw@mail.gmail.com>
 <CAP8UFD1H8ZsxfGSnnvX9xkKLSSpDjA3e3KNZ7eHN3ruq-sC7fw@mail.gmail.com>
In-Reply-To: <CAP8UFD1H8ZsxfGSnnvX9xkKLSSpDjA3e3KNZ7eHN3ruq-sC7fw@mail.gmail.com>
From: Francesco Paparatto <francescopaparatto@gmail.com>
Date: Sat, 21 Mar 2026 14:56:46 +0100
X-Gm-Features: AaiRm52h8QyvypGcQdM-v_PNG6c97plBAxIPtLxZSfETCz-FZkQOIJI-3sFUI7o
Message-ID: <CAEaT9__zLj+9YQCn-nWqRL6qF=T4rUnY2r6Un=1cjZEFOP8dmw@mail.gmail.com>
Subject: Re: [GSoC Proposal] Refactoring in order to reduce Git's global state
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>, jltobler@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

Hi Christian,
Thanks for the feedback.

>
> For commits which graduated to master, please give the commit ID of
> either the commits you authored or the merge commit that merged your
> commit(s) into master.

I will add the commit IDs in v2.

>
> By the way there is also this series from Olamide Bello:
>
> https://lore.kernel.org/git/cover.1773127785.git.belkid98@gmail.com/

Thanks for pointing me to Olamide's latest series, I will
study it and use it to map the remaining repo_config_values
work directly in the proposal.

Best,
Francesco
