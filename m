Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735451C4A24
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891967; cv=pass; b=UbjEq6T+YlbINb91bJtKRUSaUzKHXB/VYUDAtl+SFqnx1O/EpBq5iKgVMWUNJ+/Ce7AFtzpiFRGR4uDMSVlbz6nz0cPczIMttSJv25UZWwqd2hPrUK6duSqudRuI7z0b0+equf5EZqsQaD9CuR2gXivEoY4HTR1RDZ4Dv79m//Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891967; c=relaxed/simple;
	bh=X2KNaCB0EdxQ0Gxe/QRA8a3eWNq/S1HLZntFRd5NcHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIr09QJVnPT5POQQJ19YhSzhx4t9Bt2ywH5XJiy/+1KgBZAkSyqjMIJJhkPG+4PgylkNk6vqq/tzhs1OR05zluEUqsM3AJbybgIU39qegU+/5uGXTF4w2SqyXku+mZtUUve4mSFGaJBwbNz769UWt7CkPpRA+zfgoHt1+cuJqE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWiFZIo1; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWiFZIo1"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5662c2937fdso1585335e0c.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:26:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770891965; cv=none;
        d=google.com; s=arc-20240605;
        b=RRiZbQ5sq5o8vUwKY6fW0TomoZO3DKFPATIEpkLdmnVoyvTk0YU29PpIzRDmRD8wZZ
         nI9QVy+R/CgfxmwXO+im+PdO9oTzP5/h420lBkzpwWIn8NXGBKrpn0CWvhsatgUivKk2
         UtqEjnM5lUFByWcQRFVPLRw43miU9cnH/u9NNzF/+6pQFykOzHbdgbNUmXZxrtIPo+7U
         UNeSGNDgZHIjXb79Px1IllrZIAlpab4d1BWWUIPRCrFHzbgGTzQ0eaIEb3YQu68+ghMz
         /IT+pTb/uFP5GBIzKFRhh/mWVerUVVKbH74IjLRfw1gKH60cgo/CnW5IQEJnL6GOhxqc
         G/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QbqMzX9vi92Zs7wvX5dVsOmMIkIq56D5RYeH+qgLtW4=;
        fh=luVqRYiSmskSxDQ5eTucgcD9/jhvmorTnjC9+SNJx2o=;
        b=RQP2UnMwLRUEOa8Wg1vrbA7LG6tqeTZA7Ynmyj6AXqO9F85UD/VvGxZYEWqKcHl7sU
         aMTs/0RbdYs3jxPwLbXjsUuNvN2h34NU6BTBeiIwWKe+E/jQiaae05jUF24/caqy7jeu
         QCjivHdaxkHNUsChz2kt8/aLGP6LnexxcLrvowOcTAxL57+dqfQeGtrhKRcth44Vxw31
         k/L80h9RXblVMjvc1m0ZuWBfOGcC4Sfi9jg0m+Pxx5Lb8O8XQF7ELJ6RqMuHNFTeA37F
         TldoKlleh/xGOHLKkde9Z8MOak1DAPjZV4Hk4jrbJx4IBaln/RpVfQr88oTsdUN64q3k
         tTBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770891965; x=1771496765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbqMzX9vi92Zs7wvX5dVsOmMIkIq56D5RYeH+qgLtW4=;
        b=dWiFZIo1jFgptDiwFuml2VlHgmcIZXvUQHDyuWQjozI1RQjEPfDBOaNLI9bvdPpod2
         QaeJT91aoTLU5VmMeBI14fOMTAIqFO0Wq8Oj6RXuSCFw7oCsn5t1ZNVfQ8Ko2l7NWPjl
         LclAK8VOPk3aQmws4eJJFR9YIVzZ/hrJhJIRV19jGFRHtwEgOgF8Jsu0hTbr6giF7OFO
         Il3qpX8TUHQuFI7iM9eU+wSd2UfgQTRwg4ZF/CT/fQiJArjFnp/0WY6Z36Y3InWyPbCO
         ccFsNQKAcwAtITOa3+LRqvlvDLwJh6zBTyQO7YmSMuDbqsKLNQ8RmVtf5pO1qjNASqhu
         IhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770891965; x=1771496765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QbqMzX9vi92Zs7wvX5dVsOmMIkIq56D5RYeH+qgLtW4=;
        b=D5yucFSyRKqmx3qsHlTjA8ClOpjEkQ2WmZUCopB8XRtWtqmVqWroThjtQxBDRmA36T
         i9bJ0z9Osh24n0qzAUthqRqbOHXiqbKrdS79jHlWdMdBCwg07eq67BYaEdxmZ0JOY6Zt
         j/mIFin5ykUHxzg0zQspic0CG+1CfYWTu/4hN+iI0gYdOgEXeRTzWrXgfJOtieK3PZje
         LCgDhc1uZt8SCPY6YuEsFFUaVoK//25FNdsZCgPP7pNC6ykbLqJxhFiI67hDYMZXAxeb
         CK5Ma3Str+R+sstrHX2FaxN3kjbf4oNSyKDhzCsFKacL4AYb5kkN02yfukPECsV22KjS
         HqFQ==
X-Gm-Message-State: AOJu0YyHr+4j+94inL6BLjsm33OElurGCpXZwjjPc94qEIbvs7JlO9lq
	/DT8HomabsigAlHWWY0lIImTCmsphDy48xLlI2L079u+n/aCARO+otXhJRQe6cZpzOtT4U7KgMf
	+jUOK7sDKGgfMQPGEjs65diRFZBcwfyU=
X-Gm-Gg: AZuq6aJy6A7UacxouoFeXHyFd/StW9MXlZfqJx2/00aTY4ITa28/iROiA9A3pGnMcEU
	ouCYI9+5lGjA/CBfmKmKzlSkUTqnYRXsRHFjHAa7RzC0/BtQy1Ap0ZnjBSdx3b/f4xIAbVHPysO
	5kvCr+IST01iZDU3TYBEwihsEvCPlEjPLEGYQW/anoq+X0YrF8SdbbPoz8BjOyPXwOe6HLfvYjY
	Tda+meqnpcJdrvUYHLZHrlIoF7kpOG2smifBQx11+o0GgYbRdoaGVpS4DuVxp6LR3a+7F2U+2LP
	sgzVHO7+lvw=
X-Received: by 2002:ac5:c997:0:b0:567:562b:cca4 with SMTP id
 71dfb90a1353d-5675a227f62mr468332e0c.3.1770891965311; Thu, 12 Feb 2026
 02:26:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5x84xms1.fsf@gitster.g> <xmqqo6lvrost.fsf@gitster.g>
In-Reply-To: <xmqqo6lvrost.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Thu, 12 Feb 2026 11:26:06 +0100
X-Gm-Features: AZwV_Qhx0qZBuRzB4ykGGGX8e9zOLCgB5KmVRKzqSovmshiJtUHdhQc9f8obRno
Message-ID: <CADYq+fZhiBsDrnRPs0vvcS2Jj+AgKOCWkAWHyN7ea2btsAzvnA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2026, #04)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 9:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> Sorry, but I need to fix a few obvious "oops, that's embarrassing"
> mistakes.
>
> > * aa/add-p-no-auto-advance (2026-02-06) 3 commits
> >  - add-patch: Allow proper 'git apply' when using the --rework-with-fil=
e flag
> >  - add-patch: Allow interfile navigation when selecting hunks
> >  - interactive -p: add new `--rework-with-file` flag to interactive mac=
hinery
> >
> >  "git add -p" learned a new mode that allows the user to revisit a
> >  file that was already dealt with.
> >
> >  Expecting a gitk update.
> >  source: <cover.1770390576.git.abrahamadekunle50@gmail.com>
>
> No, this is not about "gitk" at all.  It is expecting a hopefully
> small and final reroll.

Yes. I am working on it.
I will send the update soon.

Thanks

Abraham
