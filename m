Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793103664;
	b=wBU2OIoR+bnclNpc96ZMFFs/hXZ8YITQhjXvcr7U2SqXAMyDBnGrTFZT9o5Jl2S3/1MN
	 BeRIWWCn/cCdpTUK+1uOkTH4YBcWUfq2qocBBJNJAxUH1qlNxn78RReTYClx9LWbB06IC
	 hNo+H7o8hTANwCQ/PbLt/EfGKjR5nb2NaIFiYRTmodVc2LCJbzFOZhq2RXKoKbj3uvLz4
	 RwuukW23Q/42tIgKCVKFYSFHaqk3Ho8Mvn8WWHgw4ja+PS0hZx0Q7RnX0OMukozmxXRXH
	 v8vt7GLzjlQ6scI3XtuFQxJHCpfhMPN3G4rXSNHwA1GZSFUt+wHq3il2+67TrAC3BwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=E1ea+Rw+xaqRSzUN6t3J9svS4ypdNeEF2yKxQetAvWc=;
	b=RF0L4SG9kigXSFzg2Tq/pT53fJ9YJ8ZfYE252X63K1wQAmZtTnVcgEn9uSUhod1pJwIz
	 mibAtlz3+2Sw+rnPjpKu2eLH+G5apNOjSVv4mDhPPAJpfaO+GqB/QmS/1Y1X+nb+ACS4C
	 PnpLuIA7cWoLKMBYidvOcEjal7dTQkhEC+Mvjpa/WCsoLrTUElJtNTUa+wGSi1JesF0AX
	 4V62u6OkvJ4lHgalwzDRghJSYjF/ZzKHNzcRY1flOkby2lrt86n8UMDzu0U9R4eC668/a
	 psMWCAY2inEnWn+5c/4v2T2lmePGOLkjkvAFO96SOKNsLNJG9qu0qXPdcnJLeVl4Xjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ImTQCX6I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9857606A320
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9857606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ImTQCX6I
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4f699fe49b3so2481707b6e.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793103663; cv=none;
        d=google.com; s=arc-20260327;
        b=Xfiqo2LfZjWWCxG6FmMpxfXS40ppcvq7SIqK+USgHaWw31RqyRFKmoLaRLIRmIsUw6
         4YSs+TojEyw/JaYwxF8Y7uT28KePeCJFmNpoZTUI2oowgd9gYX2YfnieGzl6vM1Xzywx
         NSF8ZGcWLZIK4wweqITMOJ0QGsjIpAV4DGNEnp36KV5l/R2Gb4GpyC7D8E4Dzeto+sRV
         wGxWwbYT2FFQ1Mwqq8C4nLJCFE30hTfdt+XJTSiQ7k5EWywRCIpYnbMc+0YmrvNx5nXR
         agjJcbjbfykgG+zOpL2wu04yF7ZaV2UWbLwNvNa2UE90BnP7nGOhog/dpaZafx214HhI
         QoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E1ea+Rw+xaqRSzUN6t3J9svS4ypdNeEF2yKxQetAvWc=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=My4Y7dknIFZlDjaFjthKYMCS7LuTKn1xI+o2l0pIWBBsAbanIdqh8qNl8jPlkG/Tsm
         cHaqKR2Z6uCTp+5vTH5IEmGJ5SxsiCPoCKf/LxYEzdJ7ahx7DNq4PMeaounTyqtuwffa
         hW2RGhhVxnOVKUFECC/p462dhnLO9lyt/ueass1Q7bn17oXJpvGDLQyPv9UBHQxpKZF1
         xJq3Kq6wlTyIjjHDTewokCNi03HmEU/J1DBKhb9tszZ0iEEUBr8BuQuqIxaBo5+1bWvM
         NBuSYcz5FH6OSPZ4DoD3PcnGRbwTNeKJDwpsT308dGSbGzsvyOroN0lFpirR2CpA2839
         3iMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793103663; x=1793708463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E1ea+Rw+xaqRSzUN6t3J9svS4ypdNeEF2yKxQetAvWc=;
        b=ImTQCX6IgTI1E0OKVM2cMBYrbwhg4QZfqAfUCAR9OYPrFsPN8Ui1mRQK3YB8AUfrJB
         1uydi/9QlsOqy7D6Xpkx/LY4JZxUxAVuCF7ggy/8/K2qUxNqPDAkIt0xtGPilhAh9rtN
         unGuZliIrKi2Revb8PmGt2jcTa08K07ExhaFnF+U7puoHv1w/BMgviy0xv1yYTZhE3rJ
         03sSo7mpVsBZu3g83TjxNl03yWIEt6vBg1XzBis0AReGbBu201TpaTnSlawAfc+Ctcz8
         kOya+q6IUMqXn8fsfZRGVRkAOdL3IBrVMdV/f8pr88Q1PCmr2dKQHMw3z7qvZsE/obPe
         xu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103663; x=1793708463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1ea+Rw+xaqRSzUN6t3J9svS4ypdNeEF2yKxQetAvWc=;
        b=KS0ndOb9dbl0FQSzQ8IIYElyqw/uPSglFXSol5OjeLIX5nHveU+5lNssU7jeEXRyLL
         v+pw3vxrKbn8hz59137PtTADDYsHXR72BEqgTT/kjtzIIoDOK2eaTkzGEHjzzPMzjsEe
         3MTZgpEHqkX7jmC6KgkH7TUYr/KLtSuqsIiVXu1qVwIT/dbMFHABFGup9NAT4qg7sNmV
         Cz9PDc6qENnhxdnDdmSrJwrDGG9OoGbN8qV4Pk50HvGcDbnsL0HA/CriExw46EZH2+dL
         yIXkb+49DjV2Zh9zbFmaG81NHWG1dV+Np3ukQkv4IdII22NwrOHLgBjStQh/6aIQrWqs
         +M0A==
X-Gm-Message-State: AFq9FYJlnG/i3XBxABBYnOx8yqmKiFtsRicioCJ1qZ2m0xlM50eMA5fA
	Yz5tuEtgb1MlLZpklra6FAgVPHlwn8O2Z03yAOKsSG0p6CXsi9SLUj97MZf/PcfbHBN0rAdpm3d
	fXDrTllCKe75k9vT4T4OLAsJSY90CBipn+tWk
X-Gm-Gg: AYBFou1YGXkdjBRM0oOqUN0XqCV/WifizeL0kV+lw7KymR8EHHkFjL5aG1QK9OIG5Ua
	imp2NTEXqSPgdyo9D+8wcZ7nFKsPubl9G2QlQX+UHoZaWlWL6SZZN6PwTJ0msBURDklvMXuJJTx
	JWjfwHuViZpjuxyv8nqsRp150ObMLwvAL6Hgxp7SkyCxNYVK4l2sFYBDfBNRLgglsv1u49gHAuk
	Vp0wb+MBsRikTPLkVW2tbXjN4k1AaJCVvrxrZboF5cw8qYYbeRas6/WAZV93Zrgz8PeORft+7q2
	ovg8uia4n7tpKGCNW/mwmfxJOoVhY7r9Q1EE56cnYjrME3kP22BljBWwPw720nbDEHhfmrlggia
	yyfHHWhrtQsCWXR7su5+NN53/gANEUwb70/VTgew6fm0rvEPqJ/vzg7qqOOCKUqfSzvrI3Lq3m/
	XOjLmvH29rpE6qqeRdv+bJoH1SxxKAo+Z0cpovCwP+TXLiat7VbxvrxYuG2h4v9x8yORfpK8vKC
	o8qa/IKWAPM/a5B3AEdW6DA
X-Received: by 2002:a05:6808:13c4:b0:4b9:a8ac:480 with SMTP id
 5614622812f47-55c002d14f5mr6782388b6e.30.1793103662593; Tue, 27 Oct 2026
 05:21:02 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
 <20261023-pks-odb-files-reload-alternates-v2-2-30559d7ff43b@pks.im>
In-Reply-To: <20261023-pks-odb-files-reload-alternates-v2-2-30559d7ff43b@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 27 Oct 2026 13:20:50 +0100
X-Gm-Features: AclHuK_H2CsxnLujdldarrPUKq_aD5e_BkzSAQYbvzEuwFaMVDRjHB6NvLVQnZs
Message-ID: <CAP8UFD18E0v6fBeFaW9YKkf1w2_grQa6iUcLpZmMF44ts_Fw_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] odb/source-files: always load alternates via
 primary object directory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> The files source tracks a list of object directories. The head of the

Nit (to match 'the "files" source' used below): s/files/"files"/

> list is typically expected to be the primary object directory, whereas
> the tail is the list of alternates linked to it. This assumption does
> not always hold though, as transactions cause us to prepend another
> quarantine object directory to the list.
>
> This is not much of a problem now, but in a subsequent commit we're
> about to re-read "objects/info/alternates" when we hit a missing
> objects.

s/objects/object/

> So we may start calling `prepare_alternates()` in situations
> where the head of the list is _not_ the primary object directory, but if
> so we would now try to read alternates from the quarantine directory and
> not from the primary object directory.
>
> Fix this issue by instead using the path of the "files" source both when
> reading alternates in `prepare_alternates()` and when deduplicating the
> primary object directory in `odb_files_dir_is_usable()`.

Yeah, the change looks good to me.

Thanks.
