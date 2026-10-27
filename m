Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793103243;
	b=fD+yo5BOdVUaOCwbtdoByxUpILl+YB/RsD0xZoxD7xjdddy50R8ciJ1E1ftbKwguquOf
	 nhXVcDMxj+9BKJpj4yP4NBgo4evfVjdYy1QlQj7/JDkuYctZfHlB7xw1iqEE92kSrBwQb
	 nH2WMpBhGwGAHFNXcBK5wm2CqXa/7YVr3mZTR+pFj8LFmcz99Z1jbs/06ilpLckaTT4XW
	 NmGe+eSjCV248neQZlzo14TDBsXuKDD2OqhkOcXOR45hImp0me1l3T0uNe39dV2TXyFRe
	 4JpUUT/C4QjV3GdSR7/sQtcuMiVTD0JUiKijbwHPsUlcV2vjYvk+BnvkBt4Gh/a4UOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=jA+rtbV+ng5MYRGBj9CrKaTko3+PEZiJAXcyD6hHMfc=;
	b=HCVIIyI2jXCmnHli4l7Ej97dyi0ECqdghfNHkwDj5uSk7V9oR35eFBwm0U0+kjeDbPEq
	 2qRPqsal3X4NsyB1Vcee1U22+xRMtd03bdAa4e8gDbgXO7LlPY8w25gpfuVTTBnW6wAkf
	 oCWpXy+zGqE4/hfxs2px65DFZJL8kvQEN+Rt0dAgsaiVq+GAuqM5hWF1iWMwEbi9Dstvm
	 5obA0jpIdm6dXn138xy80GunbZjf7gnxbqTKNqpYG9xQHtyeCuyAJUZSkM+dsiJkKH6Dn
	 RZ2WjWaDu1cCux/GaSr0i+0ytWTlxLm/oADTCBQU9JmXdsblzI5K9DyTo1Z4fc9IXpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SrliblqD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE2606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BE2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SrliblqD
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4a6bb779d13so2059577fac.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793103242; cv=none;
        d=google.com; s=arc-20260327;
        b=Un2km/fkV5ZWAZUrUcCB591E7rIwA0hcnCaojrh1eKe/u8Hk+MApfDl+P47TblV8KR
         /PQRVOUQWFMkbVpDmHeTRweYJbITWiF7IKvzihDBHcqsYvUdn5M0zSpmBimPoo+LmLvi
         FD4Eg4e/hCBrPY3SHXvHLmbkxQVty1sU07FkXb7rGqlBh3ZFHsc/VHUdVhZ9uQB7n1J4
         zs9UxfxF8FftyszyZmUVYSXnf5y1Rw7cydO3aFdtMHXgPGNMHt9sJ6AAOj5yMe+zmKu6
         DI1NHnnQzEwl6zmyPUMZrZRQdz5lh0bSHmRXHCN8SVS6fDnppCmdO/mPjHoPAxnpnyZn
         8BrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jA+rtbV+ng5MYRGBj9CrKaTko3+PEZiJAXcyD6hHMfc=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=LbQrTmGjRIcOlG4YUQ+6G64ElPTln6ow1cSezz3Mvl03LKH+J/kAiQcBymVF/odqA1
         SgRjqPNDs7CgmkP9OuIIK2XVUBcTZDrCYQNyu0NUGTzzCks4+f3Bm+7+Br1KfB6BQD8u
         lGPn5uAUJuW7QbuHlJwn+mw1whsqeLV4bHmbnPCcYeC1meiFIsPZ3pEtyt/HVzgVK1Fp
         9et6xbe+ivrYOc4hq6SyMVP9P2KROUFhmSSvSwC9K50bDobMz0vAIspTBHa8sqIlzmLY
         IpT6FSpsfF0l0NwkgDsrBViusHHr1IISxvfKMhbwgMvsN/5sVNK+ulXItSspy3xrfRn0
         cPzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793103242; x=1793708042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jA+rtbV+ng5MYRGBj9CrKaTko3+PEZiJAXcyD6hHMfc=;
        b=SrliblqDEvNWZVpoa46AimbUeyAvbbDLdnrTaKqQA+C/nD1P3Eo1fjWURBoXHDxkey
         ObplrLarFwhjz2lLqTsBSiHJafVbheith3HeKBQ3cRC9AMt1tDH+da6bAO+AlyR72LWT
         56Qk5CUvd7JTHy8WPN9ufIKeOSts5mNVIlsbi1AN5yu7AzRd+uENpV1+8+RB15eZsbYZ
         9SrPzdyBzuS/VT+PiCDD0Kd5rfrAu41J0jUBtf4Db45PAm8xwI3GSUPQ+B/d8btZSlQq
         NNanxQISQUJfF8Y8kUVo/83XWWeNU9wQ6iz/JNjcsvAhU2d+vW1nBSDMZUf7A5ZDuQYb
         p6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103242; x=1793708042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jA+rtbV+ng5MYRGBj9CrKaTko3+PEZiJAXcyD6hHMfc=;
        b=1CZFUlS5Xwcks8NTe+2kIuPQ5jRPlCGvC0vlf2V9Cj2SZzx2NlyxOoxhjeHtzVOUS0
         TxKhJOVmctFIvGM3RJO2MzrCY9++G8N/FdN6VwWA9wkFJRHePllmhQbi6uSd3UxN3Zzu
         3jvwALcENWrNaLUKLxLbGKTdMy8/bdFY9WnDJvBmSzaXxQZqzKDUCc0CjbdbjiRO3tXU
         X9ODeMnefmNEN4yHVLQ/cLg5wvIU9t2aIO3YTK20D3+Rpra89Wbwqnj6XxsC4imAq6X/
         ygMyoSXAZxV8Vj0JfvcG7NDCznaz5L00YHhMBsOW+bKJrEMFCsf22glY2jIWhUjPPlVg
         6tzw==
X-Gm-Message-State: AFq9FYKYLGdOIE0wRpMfwErCdc8ZqpXro48/Wxf/18lJ4zxJuXtgn2/W
	k9lwBvPO9KuknN1QMRNYu1z5TXp5lG7xLvFvU11QgMqCWJiaDbVzZWmUNrBkbwDgSjibLgwvmfg
	r1xg/SjmHSX1V3RmogvMuje00W9GSOimfT+Ct
X-Gm-Gg: AYBFou3ZO1NCHz+fIGtjAWV/dxSvp03i9iVqzpsRpsYSENkMYH7w2ylCXPreXmyH1DO
	+neG+F/cPDx2JEoVodfbpqajELhseAQY594bagdXjnMfifhtA6zbmpt2+IYfHwAABrtfDEWri/r
	PZDMITiYkKzChvDgpJMEkz+UZV5o/U6wnuxBuyhINdxGmkxZlUfnLr9m9x74GvJSUDqZrKibz1f
	eACGAvXRLPPhVK6BECsFeOq3aBaK0qinVgnO+/ZCU6fdnS4oTEZOqOL+/PvjXI/bCMU+Og0fN6i
	3DWgj1zSoLnAYbXEOof4U41qbAQtGxkJWq37oF5MMyKz+hargH1O/JW7zLer0ZAMTl1Gcu1ZtvO
	mKA/awSAtpNyy6TbyNNRRySK/ro0p/SSmdjUAXD2bY9rBwOHQw6CeFqd+GQbX1iiN704RxofhtC
	PxZUm0ziq43GVOevRNtzp3qHzAh8g0aEHq0A8kNQKnBSkIHv/kfmpG7z8dHk93oMT99B0/9HfIi
	Ulg1cdPCoVrluIbxrxHqvuO
X-Received: by 2002:a05:6870:ac08:b0:47c:f23c:31ff with SMTP id
 586e51a60fabf-4a83f49f8c6mr6641163fac.11.1793103241999; Tue, 27 Oct 2026
 05:14:01 -0700 (PDT)
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
 <20261023-pks-odb-files-reload-alternates-v2-4-30559d7ff43b@pks.im>
In-Reply-To: <20261023-pks-odb-files-reload-alternates-v2-4-30559d7ff43b@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 27 Oct 2026 13:13:49 +0100
X-Gm-Features: AclHuK_nVwGdWswTBFQg6s48C6obGX2T_XXkXbuLV8X9BTXqpwWy4s-Ys2ENkog
Message-ID: <CAP8UFD12rSyCh9xhfcggvL4nh30KyWSZhGWrLVmVa051KaJdpg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] odb/source-files: simplify directory duplication detection
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:

> -/*
> - * NEEDSWORK: we're using "core.ignoreCase" to deduplicate alternates th=
at
> - * _may_ be the same. This requires quite a bit of boilerplate for dubio=
us
> - * benefit:
> - *
> - *   - Duplicating alternates should really only lead to regressed perfo=
rmance.
> - *
> - *   - We don't properly resolve symlinks or mointpoints, so we may stil=
l end
> - *     up duplicating alternates.
> - *
> - *   - The value may be lying, in which case we might deduplicate altern=
ates
> - *     that are in fact not mapping to the same directory.
> - *
> - * We should investigate whether we can remove this whole mechanism outr=
ight.
> - */

Removing this NEEDSWORK isn't mentioned in the commit message. I agree
that the boilerplate is reduced with the new implementation, but I
think the points regarding mount points and a wrong `core.ignoreCase`
might still be interesting.

> @@ -55,17 +50,17 @@ struct odb_source_files {
>         struct odb_files_dir **dirs_tail;
>
>         /*
> -        * Map of object directories, keyed by their respective paths. Th=
is
> -        * map is used to detect the case where the same directory is
> -        * registered multiple times.
> +        * Set of directory paths that have already been linked into this
> +        * source. This map is used to detect the case where the same dir=
ectory

s/map/set/

> +        * is registered multiple times.
>          */
> -       struct hashmap dirs_by_path;
> +       struct strset dir_paths;
>
>         /*
>          * Whether directory paths shall be compared case-insensitively, =
as
>          * determined by "core.ignoreCase".
>          */
> -       int dirs_paths_icase;
> +       int dir_paths_icase;

Nit: I guess this is to match the name of the strset, but it could
have been mentioned in the commit message.
