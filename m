Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECDC3B8D56
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900810; cv=pass; b=kZ+cndgMgGVSfxT8trNHNhxErwPddqT6Ayhmzi9HFUxMYgixFlP+b1df2BN4K/4JgH79szTER8utC87v8V1OV3n2/h5SzmA2r1DtJxIrkkgSvzS3hWl37JcqcyL30u/F8mRX1p7sQtPsG2XgCnRkP+ogukUWFwqCQUtIafgMRos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900810; c=relaxed/simple;
	bh=z62LBxMGwVgWGl+jlUusH74MS/lsCmQUuUZe/9sRWjw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=f8v0u+biwz+82CBqz5zju8hefnb+1NY1wOWSdjmMAlXxpe7EfYpDDPPIiCfh5xgnH6yCSOocqxI4sud5HFJxZzGR/p1xs9sLKr51coX80vfUCvdp5wjdYTzYXu/Pf9N5TTWJCA8AVji9b0xxcRxp2T1oKVeZ3aK5rH/3CEMdACU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYVjCD+a; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYVjCD+a"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5efa4229bd2so3372536137.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:20:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768900807; cv=none;
        d=google.com; s=arc-20240605;
        b=SO5FbV1Mlm42N9qw1goSSFgJ2m8JdU9lcmaEpDDA5HHFs741u7RPHL4IHXUN8IeUXe
         70IdzoeLxJlI5nwPvlioTjA2MjdzChgHzuPxbyn4H0UuNHIXdgSxDf36TgXSnubn62x6
         0hYkyaGeifsZ/fsHAFXZoXO4y1omT3OIZEDWxWAWaXiyDO5R6w9J1X18fEIdJ0z88rZ7
         5a80druODhZXzFugdzTJzavRRTs8Ttcbyf7Kn3aVp/aP8LhzrcI+XVpBYjGkC3ThyQ27
         cJoFCW8+lvtMK9HBt14gzZIsvx6c+A42HCWWRuC+8DdEPdnTGCDqBD/Le+PztCqw30k5
         Qg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=33Brbffs9wvQIhTiKZDoNkuf2wRN1LU9EgaHBCNvFNw=;
        fh=BXgRwoLsY1aObvar3H9yz9TRHQNqDxFThVVnK6NJDoI=;
        b=Tp7IOSbcT3MhtaNQs7eXyUxZqlna58ZX+ZVasfdD1deQLAIOUD+jNgcaqGcu0aF14D
         jxjnrBLut5gS+MVV978VH7BWAC2xGhwLko4lmoRnSubzbrtOX399/sHrBBDcrxBD7dPa
         O1bssjNUe5X1pO8q1BVqNQl18ZqCFwJCLMgBp83Uofgftv0gbUZ3kTItQyW0UnS5yEMz
         yQkQDxd1JTvDNZ/JD414HqTpDuTR8ZwMaPMEjUrCma5377jsN0Dj+et72WP4GikqAgsF
         3+Ij2+eKX88JdQvCaPrjEQtnM1qyNFFijGjxRQssNLbDQl1FTRivOnKnPeqKul/9EaSy
         uNCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900807; x=1769505607; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33Brbffs9wvQIhTiKZDoNkuf2wRN1LU9EgaHBCNvFNw=;
        b=aYVjCD+aQatOFdOovwdJwle96WfgSVD7mofBa7pE9rPUrfhv5tIcreFcRB1iv1fbRd
         fyotCg4G8Fr0VGRtE5Ufq6IEOZ6YNiSNS49nIcVqMvib91VAIFu1sQYiY0HoEihE2ch5
         dm4iwjM/1iDwcAloI0WJdoH/I0m8luKti6iLW9u3LV43BDoV2eSTzraARHzTcsPOoFwk
         ymBUqPoXhhdOOTdQrx8/eUNS052dpoN2EdI5sIHWdejWLdYGje6ZWsCycENa+6guODgX
         SbbxABKDr3uGJinfD38QcdyYLooSemKfHEjCyi3GzPO0PI0V7UXvMkqtXOpY/TnbYEsJ
         FHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900807; x=1769505607;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33Brbffs9wvQIhTiKZDoNkuf2wRN1LU9EgaHBCNvFNw=;
        b=dysRTxvfg7m4iAdMnGLP+W42I+QT8tm0TJW7NUTM0EWn2WdjQGTXdor27WmZnDT4ND
         ASrmRd8FhhTuAg2p8EdnrIxcAlagjisKw1in+9P8wezldob/Ki4kTfFQRCoV1osfK0vy
         LADqALAssX0t+rQthaqPSMCzd63eIUoXdUE/sMrZqkbWs/1J00WbpB6DSW0KMs3IiTZy
         KLJXJm0F1xklQFzdUrE3YE0S6hWa45XGn0p3Slu3xc4eG9dpJ8wGccXqn6bSfP29F/65
         A4wfWuU/gEgeOWXllFIEM5A+t30hcy8/M3+fyI7o/rgQDNGnd9nH9J/GCiccIcsLyuq/
         g1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUdWeKFpXXxUQn9F9YIoqWEkC0NHmTBy/+6rsvPH0UWY+c8kmOGj4DjeJyHQB9Su66Wk8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw78lXvzqkUz9IOUdKRwByi+yYuT7nR2KxBGR19YwLVOmpXC4DI
	o3LXoSQEvDb3/NZJZ2Ini8VUK0dDHvKM4h6IKY1VzDwIrcXCsjlVsDtcnTXxHqrbkKjciPjLebb
	3NmE/mSAmdWSuq046Q8dq+TLqwNhM+ycVbw==
X-Gm-Gg: AZuq6aJNGnQe4BcvOti3N30/6S25CZxp8tjytwlAqiMkU3UdtmWNpZ8QGEOS6ufuFHd
	PJXPwOeksI6GCdDryP/6hH86OYqyCjModABElu5cmGaLXF2zP978elf96zuvKveDNu+0t2HFd8Q
	iDfNHTEi1R53FptUV7X1rt2PSgzXnr5zmABq5RJPLrAE6MY/PsNwl6NXMFGqIvtxgjq69XKRlUO
	/lPEdtRqtXRteDDRi4tP/IlY6Cvy3JJ6D1hIY3XNerTZL9Ho1N8KbtejTqCHjiST8bgxVyy2OW3
	ZoIQT9FSstPfwfhWgBBBHL5cIko+zg==
X-Received: by 2002:a05:6102:5112:b0:5ef:8881:c8a6 with SMTP id
 ada2fe7eead31-5f50a8cff5cmr324504137.13.1768900807639; Tue, 20 Jan 2026
 01:20:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Jan 2026 09:20:05 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Jan 2026 09:20:05 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-7-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im> <20260115-pks-odb-for-each-object-v1-7-5418a91d5d99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 Jan 2026 09:20:05 +0000
X-Gm-Features: AZwV_Qgncmo5MjAm0PaEfNf84LukkARVpRacvvX58sHfy_fztRv3kwkYcj0hpT8
Message-ID: <CAOLa=ZSgODbmRAHopGejyr1swhDzRa9rccM8TBc3CW=WkRe=pw@mail.gmail.com>
Subject: Re: [PATCH 07/14] odb: introduce `odb_for_each_object()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004865d20648ce5038"

--0000000000004865d20648ce5038
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/odb.h b/odb.h
> index f97f249580..8f6d95aee5 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -475,6 +475,23 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
>  				      struct object_info *oi,
>  				      void *cb_data);
>
> +/*
> + * Iterate through all objects contained in the object database. Note that
> + * objects may be iterated over multiple times in case they are either stored
> + * in different backends or in case they are stored in multiple sources.
> + *
> + * Returning a non-zero error code will cause iteration to abort. The error
> + * code will be propagated.
> + *

Super-Nit: This is for the callback function. It would be nice to be
explicit about that.

> + * Returns 0 on success, a negative error code in case a failure occurred, or
> + * an arbitrary non-zero error code returned by the callback itself.
> + */
> +int odb_for_each_object(struct object_database *odb,
> +			struct object_info *oi,
> +			odb_for_each_object_cb cb,
> +			void *cb_data,
> +			unsigned flags);
> +
>  enum {
>  	/*
>  	 * By default, `odb_write_object()` does not actually write anything
>
> --
> 2.52.0.660.gd05f3a8ea5.dirty

--0000000000004865d20648ce5038
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3ff952676ebcc885_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sdlNNUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDRIQy80a25VK2c0ZjZFc2cwRkpKelVyS0hEL2dSeQpRblNya1d3LzN0
U3VUWm42MTJUVVE5ZmNTQ201aEl6R3JReUE0NUtzTzBHaG8yQlRVTTJPS3pEaWtDdTV3K2t0CjR5
dExCRS9GWEU0KytYT2U5amM5eTRhblNXZDg5MnEzdFFGL2Q5OVEyUkhPSFpmbS8rWEhlZlR2UTNx
Yi8vdW0KYUY2a09iOVM5SkNQVm9RNmh6OEQrMlQ5MWpvbU5tL2kyaVJZNFFCWnVvV2lGWDdUQmc2
MW1CaFNHaSs3WXl2cgpDKzJrQVhwN0NnVFJrbWF1NjMzc2VRK2ZrSlY2V3lyb3BiTEhkQTdZOVBl
NGZtZW5WZSsyZ0lId05zMHF4L3NSCkhUdXBWV2s1UW9zVTR1Q1I2dkFJcW5TbnpsQXBqc3dLVTNS
amtCS1NlSU56V2ZyMm1lTS9ZYnBlVXhSbGtQMDEKMGpvWGw4eFJaTng1U2hSYzRnUUdhelFoVDdK
N1grcjhRdFZQN0dDUHVvcnliSDJ2TXVLcm9YSW1EQzhNZCtOUQo1aVFnbDcvdysyR3o0SFN3Q1Nk
ek96L0RDUm9lOUlQdlBLazFvMHpwd0NIZzdYVFpBdUFKSnJqZU5nN0hKdExSCitwd21Oa1dJaDdp
ei8zcXVoNVhHOFVTRXd2a0J5NzErNVc3bGgyMD0KPVFGdTYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004865d20648ce5038--
