Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA931AC448
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712953; cv=none; b=QuIu/LIrsXfTVEEvLum8AlUDQqv1VdG3eHMO5Q7FGl9ml6SaD0OmM9RtrN5ZxlRDf43LRhjY/pwc54KSpuV6OVkjw6kW83h38Htxs97sxYAKvduoDAEDvoyTk80frJUb86uAIEulWGJRB80i+78RTfOskMnsY4ngGH182Gdew/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712953; c=relaxed/simple;
	bh=1ML7lTTlK96ShGY7cJal4IWpog4T/q0D/I3XTEdou1s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+fAQckfeQ6MMmCEFndabgFlkMj9cZqlqqp+QwpzFh0kmNNy9ypNYiUuJpvNH8RbKZ5Soy+huRQH89ORN0j8Q0LRXyyg3xWXP+kF7Sy/8dOWSmz6ozVle7egIIIudF2P9qCXmhsqK+qaMa35vhMxvxPtIyeICtVB/setUU90QmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sox9hOEb; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sox9hOEb"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d46cfcbc1so1377979e0c.0
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730712951; x=1731317751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAIcxIDKDzpv7KCdHDKvVdP0+ouUIQPsEHCNTbWjPZ0=;
        b=Sox9hOEbuiw5F+m7PHIISQ1g1/0swFZvKnNEPFfvhmerPqAtItgE4GjKOuMMUiz8pn
         UkpEDNfZJqem9b6LrekJg/kXWFeQ4yNifWFoxgKogjDx8PN92TylfeJvfVy+vbpuUL0b
         xsXv+ljKl1HTxCzXks+M7SVP8joSLAEmz3cPKep4QEcnDfmE+2tJ5Cf5yWFGq5p7lspZ
         HlnlbAtpPkL1jbq8umu1nRJhRXdvDGAhaXuEPmUeuUNxZPFngFWgYyzt6KhO0EfM9iNK
         n4sDQBaR40lwk5/92NYPpIYQNhkRgZVihRpWSUsnMgCppEuG+vzcEKp7OPygr94zyY4Q
         pdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712951; x=1731317751;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAIcxIDKDzpv7KCdHDKvVdP0+ouUIQPsEHCNTbWjPZ0=;
        b=w+HV16PR7KYmjMZ7ouvRKk0RHShQQSrnl4PMNds/esaZuMcKS9Ig8j1xayVYDIp4bc
         buMwkfJv07d9zLSVEviRQ7unx8aQUvkCXlGX+Gkw2GzK7ILyV4pY5z2WZ2PzVeTNdWUr
         xbYv3lHBQ1QiFhMc/6B82n7S9/v87MBluukeiI0Cci1rwojcnME+JDCJDtOclr8r5eHC
         dC5tg8xoLJ5vzZz5GL8hhjVweM6SSiJI9OiR/vobtuOes9ykwfZQBweV2CV66nYYYgbe
         SqIKn4sjqB+woclDWqRnZamhANYNu0yAgJsaARmfCAb+H0SQQwFXsDWh5eTFMPT6WFSp
         DePg==
X-Gm-Message-State: AOJu0Yx0tlEirFEIDg/66/91TyJbY6kBp0cb7A96lHMa3x7dyWQrYfkT
	G497SZVX7WhKlBrlusf7fJ9oAMTCThq99hwn7ba9Ul9+cSfkyrDAx6SbUWOPpo38wqNRnibprPt
	daH4e/vuxfxO275gKVw5I4tFTqGhL377x
X-Google-Smtp-Source: AGHT+IEIC8pTELXaZS9HdxB9lLGcCaswF7V4XRPaKIeb5Bm2hsB9pgsB2rQIBwj08NIpCnpA893Wf7tDmnqUVTvWopE=
X-Received: by 2002:a05:6122:c97:b0:50d:56ee:b9d1 with SMTP id
 71dfb90a1353d-5105d0fc9f4mr17337918e0c.12.1730712951033; Mon, 04 Nov 2024
 01:35:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Nov 2024 03:35:50 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241101174547.GB2337295@coredump.intra.peff.net>
References: <cover.1730366765.git.karthik.188@gmail.com> <5bbdc7124d58526a7a2d7b3bdc807ddd204a6df1.1730366765.git.karthik.188@gmail.com>
 <20241101174547.GB2337295@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 4 Nov 2024 03:35:50 -0600
Message-ID: <CAOLa=ZSb929S97H_UPY7-wNUeE2Rx-Ez7FdEcZPG6fCUUUFLvQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] config: make `packed_git_(limit|window_size)`
 non-global variables
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, me@ttaylorr.com
Content-Type: multipart/mixed; boundary="000000000000a7b1e7062613025d"

--000000000000a7b1e7062613025d
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Thu, Oct 31, 2024 at 10:39:51AM +0100, Karthik Nayak wrote:
>
>> @@ -652,20 +688,25 @@ unsigned char *use_pack(struct packed_git *p,
>>  				break;
>>  		}
>>  		if (!win) {
>> -			size_t window_align = packed_git_window_size / 2;
>> +			struct packfile_config config = PACKFILE_CONFIG_INIT;
>> +			size_t window_align;
>>  			off_t len;
>>
>> +			repo_config(p->repo, packfile_config, &config);
>> +			window_align = config.packed_git_window_size / 2;
>> +
>
> Parsing config like this is somewhat expensive (remember we're going to
> hit your callback for every single config key in the system, user, and
> repo-level config files).
>
> And use_pack() is a relatively hot code path, as we call it any time we
> need to access bytes from a mapped pack! This "!win" conditional isn't
> quite as hot, as it only triggers when we establish a new window for a
> pack. But that still happens at least once per pack, more if we need to
> move the window around in a big pack, and lots more if we are under
> memory pressure and need to open/close windows a lot.
>

I must admit, I'm not too aware of the pack objects code base, but that
was my assumption indeed, that this conditional wasn't the hot path. But
even once per pack seems like quite the regression then.

> I think we need to parse these values once and then store them somewhere
> with cheaper access. Can we grab them in prepare_repo_settings(), for
> example, which would cache them? We need a repo struct, but we have one
> (the same packed_git->repo you are using to call repo_config()).
>
> -Peff

This seems like a good idea, I will amend this commit to move the config
to `repo_settings`. I think the previous commit doesn't require any
changes and can stay.

Thanks
- Karthik

--000000000000a7b1e7062613025d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bfc578651bdb6aba_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jb2xYTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejVHQy93TUdEdGRXME5aVit2Z2d1a1NQUHAyNFpOOQpHMDgrZHgwUWdO
VGk3MHhISXBaQWRqZlZWcnJNbTBuRnY0S3cydFVRazNSWFJ6YTNJV1pRRi9zbE56RkpCdlV5CkJW
ZFJSKzVlS3duejVtdDUxQVRtcmJ2OVZKQXhFUkU0SzI4ZG9xWW9KbTU1M3dmRjBqUEFXVjc4c0dK
UUZ3bVUKdXJlNHY0OXRVckJ3bkNJaFNzbUp2SWtGYU5IdXVRUmhWR2FyQjVsMnBEU1Z0a2hNcWJa
R3Zmb1N6SjR3UG53RQpsbDIrZFV6dmsxNGUxOEZraFNFUmxsYnNlTVJFUnpqZzlaWXR4ZHhiSHdG
WHdJcStGdlhlWTB4dkoyemlaV2FNCmdSMEkwMldYaEFYOTZRYWxHWW0wTlJPdXV1SEtVUFlRKzJW
clF4RS9aQ0x0N1ZqK3JPYlBKRlBNMGRmVElZaC8KZ3JKcWM0VW42dWMvdVNNcEZYdVZFK0pqVlJG
ZEtXQis3Y2d1a3B3RnpwMks3RjFMc0ZSRytNcHJQUlhXYmtBcQpHdzFWQmJsd04rZHBqZWViTEpz
RjRqZS9RTFJYQUlPaTBSNXg3R3VOdmNSRll6VGZPY29uUkdpQnZOZmZybUNKCmgxbk9KVWR3OS96
dCs5cWp1TmRaS2kraGJ5QlM2ZGdzOTJpTlE1az0KPUNOR3IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a7b1e7062613025d--
