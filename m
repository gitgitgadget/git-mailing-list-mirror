Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794755605;
	b=zCMVqJgpfi4wFDuje4f7p5CPQdHE6C9prEguQ+JN+GyOLpQejLWFs+5ZKK9x2KL5aVT0
	 aBfaQA4wDY8babmuRAxL45nXx2x1jLksBt83uhiJP15gV76mUQaYxmmKtnjCLqWWVOTgG
	 XRWJ6N+NhBFDs/GUqlc/Md74FBo2Zto1PRibcC41PM3j2Hu98dTteDM4Njp96uhTxIQ5G
	 k3Q/U2hQZKLEo0LPmTR3qmKOBpdudOQBBtsFIUU+77wbMMWWQDiLKirc/WUvV66E4FFeT
	 e6GHMUriePiDIXx+jONNkXyqKm4beHrgtYpxLjNSDFotOEFYzUSmFPze0ASQPsasQkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=uBP39W5kEMpUGQ1CFikLlPapld0q+0Oqc1wBAygUhjw=;
	b=tbl6a8v4l0b1sBdBH5p6AkhgFd+I1oHIHOznVvsZ2PXIIWLQq2NzVbcIz45lOrjS7FK+
	 0uVGHy7e+sMxp7/m/v9rxPOmA4NhM1wJYaeR21CpeL2IxYPEZPU0TGanNGkGrxaCN/7+C
	 WKt9IZ0rRBUKnWYJ4ngxBN+q3IpYyjepJkMmeAoBGL2G6zITUmdmjKa4j8wcYk7a8Q0CN
	 bnFiMe7RDCFD5rVvIKd5wLmJZL7ClVJxl9nRl1JEH+osMfAZnvMmJA5/+Q28yPPY/BhjH
	 lKNIROrWJsC3Ky2AR9FI9XqkphDubjhGChSEEuDIluruw/DQMDLd6EcI7co7YBzqfxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ttUmEbFU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB78606A31D
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 15:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FB78606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ttUmEbFU
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-677bc4704cbso2560987d50.0
        for <git@vger.kernel.org>; Sun, 15 Nov 2026 07:13:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794755604; cv=none;
        d=google.com; s=arc-20260327;
        b=Ugf9nY1pYYxRiO25WDgrUHRyNsBFu2vWfRxejBNuvDBsrcg744aSvWyfBCM0d7cnLe
         v7dOohzkhUgLtJLAt6u0C967Iqr/dVTm4rZeMrv4Pdi1oblVKmtnBGGM5dU2X8NUi78O
         SJ7JrG/1XeUIypC53Lo/BmpJPw2T1fL4vvw04R5RksD1aCdsrcjUKI2wd6eWv5JwQLwe
         Rp16LfggHkngX1rJi3wqU7HiX3GzvWFxf43oecLOk+84P4pT08wP+LWb1KCGSljPFmSU
         WGHMrEKRzwdqNe1fh4hS+MEXSaosxlXfANcAf4JvArvSug3aeDVSzIUYgjrmE5lYZ8Xr
         06HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uBP39W5kEMpUGQ1CFikLlPapld0q+0Oqc1wBAygUhjw=;
        fh=IeFnzBTmwIJp8Dv/+kFoBDJb3gHqZ7ypCOUNkSvfZ40=;
        b=VnwcKf8mvXlz/b6brwrK6A+zEne1fhOz2baJNgHo0QdVNAJwYfEYSMCDQfTuoL0de0
         OaS31fVWO54royJ7eiY75h2eYbNcWXXBgRrLFnhC/xzwtj3opVm6bKBeTBdbqL98jFQ2
         uN52nHtig08ybV7QTjUFBZ6nPgsMtZctvKF/N+7y3kayZnxaI43zCtdqlNqOXjlAXFdX
         jA1pSgGIVaDAPPKNd9+zo9Ux4NAg96zHo3cUDcQC1n2pEnK6p5BpkcfN4hM+NJcvYbxX
         HY+/8mI+dM00GmQ278AZDPbKmfRlRH9sKoPEncCKyZ57CLUZkUwaFKECakb+QB9skHhU
         kvrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794755604; x=1795360404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uBP39W5kEMpUGQ1CFikLlPapld0q+0Oqc1wBAygUhjw=;
        b=ttUmEbFUvd/CfgB1tN4+EsUO4cH5grAwj8mft/VK550LfVvdBdUQbA4dwkwkZvgGFd
         ELYQjlOsl0zAN+XhbKdEKd6FORZ+X99UO/q/iFksOyWeubszCk2uRf0ini2dYTT3Nyvt
         4GBapW5uQm9zfhzm6ybIsoXueBPGMZMHB8wHGW0rHedF47d8mDY8kbelAODYYGCOCIs/
         cHdJIEEUf55eNkq2K1l2K90H+eXN4mgdG6vkpRZcvznwrCmRwrGzgJtok8comTL5Agag
         zcl3LDjeuiylpi5jWE5XuJOjuZnC/NoAcz0OLksvNXHnPFwBlxJp+OdiINV1YSRWjBD0
         xtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794755604; x=1795360404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uBP39W5kEMpUGQ1CFikLlPapld0q+0Oqc1wBAygUhjw=;
        b=HjhU5tKSdqqL4ckOC7gh6a+YQ2nCNBgc+K8CsbWcNvZmVh6H1kVQSi6crFKRvCMv0p
         Ef6aGh/+A3M1oDd6/ERBNCJPbgZH5jhXOQVeoiyNwGvkZGl1CAZV04gDdqDKlrMcM7Hi
         zFyKEuNXZoNpD25hLoarhJinIDP0X4e8UqqeiXnfqVV1AaUJHsj0U5NoKmhtisG9oQOW
         zw7o90tTkcufOFiZCgosajjxLoX4kMNsWJIM8V1F812V1H66rjimbgnzOSceeNcan4fs
         HiR3MU/o9jgmd0gXamwTT2JrMVawNKROC7tNKn1t7K6j8RNdKSWHp9gJl7KddmjzUSAW
         EWLg==
X-Gm-Message-State: APuU4Z/x4xBQgp0Dg4sd07LqSgFdTTKbNeegK9HHrkVhWNSXkXthp6KW
	+LAfdgcX7nq4VIAQzyZoUF+eMkpmFq0nEC1JNCXY45LZPGFJK8lW2NXmJcwV7mJL1kAkXAHQyAS
	x2dl5NCJ6nXzKi4x/RnEkrSfCdGxfvf0=
X-Gm-Gg: AYBFou3pSTpXUxkkwakrxEo/F8gFqaN97zmds7JijIq+/n1axjKPQ+JVXcpNIgxteGm
	vphCg69MTeqp00bw0FjuJp6wBP4rTph1J2b911K1sjdfBOfZff8ktI+BbBBR3fhJIMPrCn3/Z/W
	AxeYSyVfEZqU9LsSO1G2VHceOHcAwbwnDo/aS+arFmdGF2xya1/g5CD0JgZ+6yxQqmWG2tNQkU5
	LFC8+VwoCZvVCPlbb43OXc5gc0veYl1MNmWdeGbhLhSUFNHiyd20EXjdPpnNgF+gX4RmZpmQS4l
	F/dgTYwqE4ZwdiVOBj/UREVHN1Sf0C4i/Qw05JDFTDEnGVPrgUDnn6p1LXAQXWFdJivLu513mRs
	xjd7zt32ezDqlvSHyAmGOtcGG+SobGRmXQsdYqMi8dml8iy6GJ4UVbQoekDUkYbh0AUc9XBCDRo
	YxMv67Aka1neWp19Ycf+uTK7TlmVe2zndAJXb9YKurqhTCkrVFDg7/7fCSKwAuAX6W/IPWuWF/b
	Hh28hVaB3u9yr04I3FvHx4fyAAr1eTIWV9sdw==
X-Received: by 2002:a05:690e:4188:b0:677:b426:5072 with SMTP id
 956f58d0204a3-67d8963a4a0mr3271680d50.47.1794755604225; Sun, 15 Nov 2026
 07:13:24 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014232739.23021-1-okhuomonajayi54@gmail.com>
 <20261016212216.58000-1-okhuomonajayi54@gmail.com> <xmqqeccphi2p.fsf@gitster.g>
In-Reply-To: <xmqqeccphi2p.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Sun, 15 Nov 2026 16:13:13 +0100
X-Gm-Features: AclHuK8gfTPwusbA1rC4FwXTW3o-6Ta0Ff-UTxRvOtttsbiE1VRISEm3bevwGjU
Message-ID: <CAFpMFfA8ikP5SGprCYvtgAQCT1y8UwCDDjpu6us2OWDkq1L1Hg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] credential-store: add lockTimeout config option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 10:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:

> Hmph, does this change even make sense?
>
> Sure, there are many variables whose name ends with "timeout".  But
> are they all measured in milliseconds?

The other settings that retry taking a file lock are measured in
milliseconds and do not put the unit in the name: rerere.lockTimeout,
reftable.lockTimeout, core.filesRefLockTimeout,
core.packedRefsTimeout, and core.configLockTimeout.
credentialStore.lockTimeoutMS spells the unit out.

The value is still milliseconds, which the documentation states.
credential-cache --timeout is a different setting and is in seconds,
so I am only lining this name up with the other lock retries.

I'll resend with that reason in the log message.

Thanks,

Okhuomon
