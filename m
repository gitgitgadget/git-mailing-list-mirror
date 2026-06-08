Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E6032B106
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935313; cv=pass; b=Him8xYA9IsR0yv8oxj05+pH6rRjUvIwHgqNglUSHVGdK8cPKwKVlic/Z8+WkC6LWtJW+Xjmvnuctw7Dt4vi2PiXZLAPLtqYllAnqYFf278fVtbm/WuC0CYQHBGGNDt4fi6lmqUT8VlNnSJzZjnAwdN2nrDc6g5zNdlJtjQTF4rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935313; c=relaxed/simple;
	bh=8wuoYMaZ6R11lodHVu9dpCP24UjLscPV1fMa4ClMHnM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=M3iihv5U2tNx1KhXONy8kYk/UbKWuG7/zqSTHk8W1UYp8kPuUPu4L8diBisnrDuoqsn4obQnONy+7tlEXVfzMi1y0JZIkIu+wqGwGV8G8dmAvLX3+YaQkLxo7SSqxSDImINBNEp4luoCWHc/AWTmnp/O6A9UYAVOWAcRa1KWfLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fybPfBys; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fybPfBys"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-6c79d2bb687so3752079137.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 09:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780935310; cv=none;
        d=google.com; s=arc-20240605;
        b=Zh08V1wiCJygNJzYWuvMr37DI2vPmFAoR/gUNfkdsk/Hd4FgmbF0Z3xA09H0qcZz1N
         dGfl1fFAPL0KYDGVoFJ6rchNe8eXKhp+yA/toEdtCqtH6Ky+o8MBpYAvqMCQMaQfqlrH
         LD2rhqDfd+zA5qOD5XJlo//2omKonyP4ihzAocn0h3531SQ4kR9tiZ/B/JESFjEn4QHo
         F4nQ7Iiwa4ftUUFmsEikntsve6tUZs4diHvVzWqhEBuAMnrtmHrHj6y/mPA/in04CJKn
         s/Ml7E8craeVyW/vmTejgfK4cq0s8y2tP/fuej7q8r1k4DXE6ibKy75YMDRdDvTjYu4q
         hsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=8wuoYMaZ6R11lodHVu9dpCP24UjLscPV1fMa4ClMHnM=;
        fh=gFzB8jSyyKjkLed9UrRt6oR+z0PmHHGFt3rYHY8gJ9Y=;
        b=di17utYX0LV/r72YhGffiNfOLV1Xf6A0uPjZoKPcY0ghgGZAv3xoVTP1rnRhMqmvVb
         8oIEE118U4LQtQYmDFSH63CtLybbGM0rY7OPg1h7DXdD9nlRoZaoPYujdJoqnUbhMPw4
         BwXt4xnxfKQK8eb9f9zRPk0WyUQTJdmMmyQecIMYbR2o1JqtQJYa3LcD0Ffwmqq+lcE/
         PlCzoGGV2vDW0hOt9ayKGCouNQeVnLwCqIQY3+y0WcdZGJimAyHe1bHe/4Ig3Z0BWMB0
         b9DNuzJSWoQAF8x6dDHkw0lQ1y04qko+eKdJZsS86EijozDFahqO+hdlYFeB6DANCgMK
         HRdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780935310; x=1781540110; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wuoYMaZ6R11lodHVu9dpCP24UjLscPV1fMa4ClMHnM=;
        b=fybPfBysW5tm4fwJKmPH1GUJ4u2NXvoIqRtI/37K7l1ophcGEjiQz+q3gJnlEPcXWR
         LJSE/opa+JzQpgBrNDWlslDEuHhGaqv74u3dpfLuM++BJuLkLjmKe+2TY0px5HhJPHlk
         Cpdn5e81Tux9JMT84nCJ4K1bJKrSFbhk+phuxrh04jpiWmCZjBo0XFJupEAOCHgrEGfi
         t+m22kY7H5T+Szcu7rntVVpzInLWA6digF0LswAQN8LavbSxKlNkYjFEa64ZaE1VRd9h
         XBisTlPR5KX9ra075CV/LR+twWJNuijEjrqMuxqUoVhnGptKM3jDrW3GfWdL37WeQRhP
         qyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935310; x=1781540110;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wuoYMaZ6R11lodHVu9dpCP24UjLscPV1fMa4ClMHnM=;
        b=E7HAwtd8EBxP2iowFafNNcJ+r49N9fHvHl1f4ja71lnHm0cfFI1LaoCr4w+vkUdMZ7
         t3vZSo5V06KVDPp2FMARV/w7KfMY6j3d75G4yNoSJnvwoM8yNjUQHCKra12G4ewXMQjM
         tj0TJCsf2Imm56rxKIPMfzRpCHHoQ+E9F831iqpxvQuVKW51MhtA+trR9ZcnzM7L+Uuf
         nwfArhLNXg80VTB7Vj1g3d8aPsTgZmGpBK36TUBZ3sS2/814bJ3ZeA6AKTIEAq3PaUVA
         bCYg6ZbdKOVfdydNNxyISjM9wEe28CvKkzBHM5yzCYcbvcRbsjowGRi8KqKr2kddDpvZ
         /edA==
X-Forwarded-Encrypted: i=1; AFNElJ/Zbg2qClNfAKuohSsIYZo0WImVHPLncw4+wIqTJYUXCErAXa7YJDmr4IXG2sqXJouKAdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmzYvP4NxX2eFSW+iOtUKHChaK67av0pJyLHDcsj8CXVLpnyb
	lFFR34O3cg08Nj9UAxn1Z+r7+EXBoIWB3whYiD+tqzAPm9EGHOdKjuR/NvoQeXCI044/0/gUvAU
	hEj5Bk7S0ZgAAfvLAhNHjOM2N+kzD+mA=
X-Gm-Gg: Acq92OHq/BPDWXfmN0FJrbKySntysUeAif7YCVQUf5SYIBxZa6/T0iaXPVDY3waISRJ
	ufHyPDNML6dSzWYWW/nEEsdk9fyY7CNBwTz4jQLN7M+F3ZW/iVHEnPzHfRJXvIPhHBXbzQIy5li
	N55cGX9sX2XfwEdgU1C5Lp8iV8kC310subs82XakX8w9GzVO9AMYl48hY0TSjTbMXpGSNRmPn/D
	q5Ez1P+JlGVMuk0KpsDO8KrtFeMoOErOo9T3hpVui9Hafn4mK5VQXHFYVRE68CK6Uc4g9zorYk3
	PpzKzjfgLYez+NBMXLZ+Mydc8IcPdzwp3ShArt69ltS6hO0qy9k/i+XsArF7YeFq6uDLiRicZ+k
	ATq4n+Omq
X-Received: by 2002:a05:6102:3ec8:b0:604:f029:224c with SMTP id
 ada2fe7eead31-6feef48708dmr8741542137.8.1780935310515; Mon, 08 Jun 2026
 09:15:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 09:15:09 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 09:15:09 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jun 2026 09:15:09 -0700
X-Gm-Features: AVVi8Cd9LqE-g7JFsHRxmIxGcm14SO4GFMFaNXiPadNHyIGqNBdTXaWp5b9ue7A
Message-ID: <CAOLa=ZT9PLFeVpyKph=jQOz_BHXhYgKO=-3SV_VP6p4oXLxZpg@mail.gmail.com>
Subject: Re: [PATCH 00/16] odb: make packed object source a proper `struct odb_source`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008d50760653c050cb"

--0000000000008d50760653c050cb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series converts the "packed" source into a proper `struct
> odb_source`. It's thus the equivalent to [1], which did the same thing
> for the "loose" source.
>
> This series here is unfortunately a bit bigger, mostly because I'm also
> renaming `struct packfile_store` to `struct odb_source_packed`. Back
> when I introduced the packfile store I didn't yet have the full vision
> of how the final layout will look like, so I didn't have the foresight
> yet to call it `struct odb_source_packed`. But now that the layout has
> materialized I think it's sensible to adjust its naming to match all the
> other sources that we have.
>
> Also: I don't have anything else in the pipeline anymore that moves
> around large pieces of our code in the vicinity of the object database.
> So after this series got merged, subsequent changes should be of a more
> incremental nature.
>
> This series is built on top of 9ac3f193c0 (The 11th batch, 2026-06-02)
> with ps/odb-source-loose at ef4778bcba (odb/source-loose: drop pointer
> to the "files" source, 2026-06-01) merged into it.

This was a good read. The commits towards the end are mostly simple code
movements. Overall the series looks to be in good shape.

[snip]

--0000000000008d50760653c050cb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cf702827c68cd83a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vbTZvd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGtjQy85bE9YdTRZak8xMVpOK1JmaGZmeUNNOEduZwpBcFV5WUxaRkhW
cGYreFRjRWFNZzJNZVUyYnY2djU2YU03RjFUdFpiWnV0emJ2T3d3SVRIa01abU9VZFFXZi9JCmgr
T3g5TUxGeHdsdUlSMUk3V2hhbkwrbDRUUlBuUWRwcVRpalo1dDY2TXRZL1pzb2JpbzIrbnBsSEtV
YVIwUFEKRkp1Q2dKRjJ4eHZCeEg5QVo3SFQ2L0RwWlB2NVRoWWNTRVYra0l6OXkzSWlpemlLcDFI
YUZEQ0UzNjZQT01PVAorVk9STm92ZHNpcHR4eDlGM29TWjBwcnc1aWJLRVRWNGFmdGpZdXRub09N
NFNTODA3d1BqVFYzSGg3TjRkRDBpCjJ5Uk5BSENDb0RJMUxXTmIyOWpIcnJBb0JWTzgyUGRnUEJo
aGFJVnZXcEJadUkyWHgzdDhZUHlUbDU4bm4ycTUKSmFyNEZmb3M2NTlobkpTR3VIbXBNczZJNXBK
cm4zclluczlkcW92TkJENE95b3RBbGFQaitPVjdMUGI2aHBBLwozNjBkZkV3aHJkVm9hTlNWSGNL
dkw5RzNmaGlIb3lkZll3QzRlK1ZEMDBLZEEwc29wWW92aGFoTnVVcFB1VW9HCjkrUnBzNXhPUXI3
ajV1czFobzdzSGFzNGxCRElrOXlaTkpxWVJjND0KPUJ2VUMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008d50760653c050cb--
