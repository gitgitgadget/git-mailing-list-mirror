Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D415B576
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365826; cv=none; b=oamhTVsiQyeD42PCbLsBliGlZSBZcDzQNJ+oTvLniHTy9OYIxvT3sIzspQL1Jl7rLJ+7XdPbTX88Yl6GJJBNtYFRCX1W1yB/u6igSMQJxtrchlpv6TDbnhRGPjgYr/IvcYm275jp1qgo88PsxVNvE8JGMGVcnhJNh9td52XJ5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365826; c=relaxed/simple;
	bh=+m0cUBac6IjVMbd03tV/VdNneQRHHgwg4b1Kw4G4ORw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaftRyz8j29G46f6zIawBiodRPNnYuLxmt+BN5iQgblPf0Hmm53aYEkNfogndxcw5eqlQxFN/SbS/yVXToRfSzhzjNtj4ljm8FCHuCU8BUxg8OMH6ybc2xxYzklzBg2tO1vUPhP4iEL89ue1e1gcslSSHFwFl/UCKmLxDjHeq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUFBUcyI; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUFBUcyI"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2220a3b3871so2097774fac.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711365824; x=1711970624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=29eI+FRPZzpEwa1IsQGn3SUEgn7XxGB6hCR3DyAzUi4=;
        b=hUFBUcyISiAQJHwVFrlfEDSXmMejEKrk92pKjYuvYvvQnmiWxnUAIRn0RosGd2aTga
         W9S/L9OMVhHE2nHkoU3DVF3oJ6cQmxA/b3c166murghi7qP6U2I0qRJxhuMwKBgGu4gS
         iHhHAJ3qmzCjwTdRE6z+WmrLw2PgH9CJWI83zLrbOjns6L7MTVNPoF8F64oGR1vHhUaH
         znCYFIFKFvjcT/tQCwd0blj22RWIzGpceeHpl8rCFGpJDr35UIcXDSQwC77iQwOYFOZq
         ITAhdkws9gQoZMUmUSSf8op5PnU9yRs5NGvesawlKuKuW2HGddFnXqzm9/SRfXxWldoQ
         4i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711365824; x=1711970624;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29eI+FRPZzpEwa1IsQGn3SUEgn7XxGB6hCR3DyAzUi4=;
        b=DRFzKYYDijdxX9PtmRShs9fIiiajQgR6XA4Mhh9Wz4yx8TOb6x3NpX9ng+6Z9oazCG
         c4YjnF6Dy1JyMBuMTtq2w+cNZNYXgmnUOc+xuJFaEIiVW8EPaceX8zgyu/et6Uw24omD
         wk/G6XemVE9ovwv0an3YVuVLiKrUazAiScDSmgtSc8WcPOBrjnmh11xmsWdH0GC0NdPW
         ONxth6KuKDp2UBiXC6VqO6uEiCN/97EuH5wr8pqHtoRktGkLGQcIdkIlBrJq7zLlGTtf
         m1717XR5y6U+9iHidomBSlnnNgUx0lkUuUUy02Ra272CpPVI8Uvp3+UgCDrxpBBSdcIb
         UZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbYl8atozqx4xTZ4HDZgWWct9vhmSn7/bpChbaAKrt5Spa6uuKWG0O5fTP2jTBm6hGifrBXUROuW8HBsx6O3/rOicY
X-Gm-Message-State: AOJu0YzjBPQLN0mxvf1e/rHCevtDILOClUr87VD1Hvt0XSuZUByJZn9N
	oItwNoYrlIqufpk2Aw9DZsir7f1JIuvDL8o/lJgcddKNB5g7LJ+FzmecHYq37/nm7AenBa8J4Az
	jzPr3OT/twl/pvl2aiOsUKYMu+Jc=
X-Google-Smtp-Source: AGHT+IFOvVPfkzLFCvkdURIBu528iajyvrqMS2OGdKBIILmWTmjpR7mXMA0glOGvN6vse+YntG40fdizHZXrzknli1k=
X-Received: by 2002:a05:6870:e310:b0:221:b185:f8b6 with SMTP id
 z16-20020a056870e31000b00221b185f8b6mr6706909oad.36.1711365823606; Mon, 25
 Mar 2024 04:23:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Mar 2024 04:23:42 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im> <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Mar 2024 04:23:42 -0700
Message-ID: <CAOLa=ZRAEA7rSUoYL0h-2qfEELdbPHbeGpgBJRqesyhHi9Q6WQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] refs: introduce `--auto` to pack refs as needed
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ff765406147a67b2"

--000000000000ff765406147a67b2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that introduces the
> `--auto` flag to repack refs as neeeded to git-pack-refs(1), git-gc(1)
> and git-maintenance(1).
>
> Changes compared to v1:
>
>     - Clarified some of the commit messages.
>
>     - Adjusted the stale comment of `stack_compact_range()`.
>
>     - Added a unit test for failing auto-compaction.
>
>     - Clarified a comment to explain why it is fine for auto-compaction
>       to fail.
>
> Thanks!
>
> Patrick
>

The range diff from this version looks good.
Thanks!

--000000000000ff765406147a67b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 712b7121cff08aed_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZQlhyd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEpjQy8wZFZYZ0JlbHl4T3p2eDhkTHVNd1dqNUJYbQoweVIydDVVMVBF
cWRyMDlGdnk1d0hLRStFUXRCOC93eFJlS2dFR2txN0ZuUVRSNnJNamsyd05DcUI5aTJjUHpxClA0
VjU1cy8zYmxhUUZ0YUEyS210amxkVksvN0dUQngwYlNVOXVaUTROa1VZSjBSckhCeWVnYmxEMHNm
cmx0ZzUKMjBhY2ZKbHh2aWJCZmNML1hzTHRlNkwvMXlxeVhLdDQxQzhTU2laWThxdlhFRzU5WmlW
N3YrZERXQTdtUlU4bgpNYlR1S2FST3lFK2VNaGx3dDJuRit3U2IrREJvMXJ5YlZRcGp4ejZIaDRM
MDFQa3ZZU3lZWGpOdnJUb1dsS2l0CmdhV3hHWXhHcGVDYnYzVWw1MWp2L0thU0xKNXg5N3ZSUVJK
Zjl0NlRWdzRvbkhDVE1OcE10ZTRBTjFFb2JEcjIKdWYydCtqODViTEdsSzMwUTBKTEZCdXlEWWUy
RHFBdjRKajl5NlpFWVhNWlVOaXZxbWJlWU5TSytCT2JhZHJwaQpWbnRHZzMzSFN5ZW5OS2ZlUTZm
L0NIVkJwSnFZbHVOWDd0STNmN2RtRFNqTUc5WHphQmxYVTNVUWwxYTBTRTV6CjREeXVlNTJGREF3
THBVM1czU1dHWEJ4N3JpTTE1V095eEt6UkcyST0KPWVXY2sKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ff765406147a67b2--
