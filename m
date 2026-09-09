Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724EB472F7C
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948065; cv=pass; b=gcg2lh4gag1MNzt+DyyBWBtTUh8FTOkAvtN8d7xo+Spa1n5HuSAA4wD7m5mzCz0O3SPWWMDCLMh4DEvREqSfeqtTzLlSV+gDx3tdDNPeibSlOclJqDYsoov/clzR7ddXBEJXnc2ZTSn4o35+vvSwIbinbuSvXSvNWzYoAZ75pcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948065; c=relaxed/simple;
	bh=cOrnHSnRA4QtE6w9b5k4hz2XUFhDH30VvUwwmIDlohI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTAgLg6UQCjUVDPt0oXK0ty/EaSsrXmD/V5SWZMWCoOjhM/DULUlTxXd/egYu/FuNbxEy++f2XWYCWNTo4KEdz0V3PTlfFn1X92VaXBRlY0Ln/jdW8GXHYgzxPw0DnUstKS7/xdmNjfcAdfa9U0P84p6L0EFkViAj/gGB8ypyR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0u1X5k7; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0u1X5k7"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-395cf2535acso5623661a91.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 03:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788948064; cv=none;
        d=google.com; s=arc-20260327;
        b=k7Akg0r7z45P8S03aYzhIiHTsqOCAhIzmDaMzhFAUcd04JaAT6jPwmI4FY+j/Ss0ID
         WW+y6t76OCY9PK2UO5oCaqPWbZoPQgsoPGdSE0l9f4AGUe+LOT0CQycvm3OJkYssEH7p
         W8HtD3voAbVQIaCYFRjiWiURGeaq0WIbpCNOHGIisqQcBIRVSiVkc7P3NhLozAad+mI/
         xYoKd7dJF1HpUE3s80k7qO92YsHYxwczccJBNaLLkkFfA3QPObA3o6vQTyUBjkcLjR93
         55y/U9d1OGVt413SX0upCROPbe5eQ958nJFgZxdKd3Os3Q8TtNpOeKjriLtTX4YKQeZs
         IHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mxYWGaxGXsWKaxtvZDQzb7S4bOvE+7HZtSnNqiKWHTk=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=OdOeJZubwJ3niVbNMdRXiAMaFOfSmsb216Ip8aIBMdsW/BvmK+KmsUCqWNXEfFzGkG
         mRCGDXwSlhAGbHwOFCYTUwc47tePVi1bF+iNSy1ZDV+kFKApCr34hbcR6/JKAzGHAJHV
         LASqb/cNhw8u9lIPVFrTsuD0yuireCSkhTFwLVEf1PgV7klkBpbsP6LO8AfJrIj1REQe
         spLWq6BOYT+YRbFp4P+IeqaNJsZz4UE54j7VFQNm1/IwuD2z96HAhUGvG6XOgF//o6wJ
         lkfDxR1SOVBtJSeO/1hRv6uIoLFYn9cDt6BFKgHEKyEfFbLjjok7kcu8xBr67I/6GNai
         1HTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788948064; x=1789552864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mxYWGaxGXsWKaxtvZDQzb7S4bOvE+7HZtSnNqiKWHTk=;
        b=e0u1X5k7T2EOov8sLpO6KYx/IkIy7Reyl40bdtrd5+2tzvvSDZ4AgRcnPsPve4o1ZD
         4HR8RgL7x/bTY+ATlKGBGX+RGH/a07EVZ7fZUVdxCHcrwSwh7TR4b/dQimi8E6Ua7nDx
         SNd5M8QCNW5PVbeHxBSCBLtgeluRehBMmx97DpnopDldSFFof5KFD3XsCRtJ/DFsbimt
         ufubW/KvGy+PwP2IetSu/XejuxHORuvCDysBENTynxivat8wky7nXcPtdox9plIDiWNr
         erofSmVaDaju6Xuzv4cqO81k5eRVgpog5m+2/q3NWwTCYdJRfN1NklChIP6xetVLMuHF
         4GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948064; x=1789552864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mxYWGaxGXsWKaxtvZDQzb7S4bOvE+7HZtSnNqiKWHTk=;
        b=ZnzEhWJCnZ62WupA9+tg9uGFB1cSMoiw/cCY9BZ4k8T7AJtTG1AZbgETVY6B/xTIMv
         2YH16dHVeppX+McqUiL8YjziEJKZbuV6KauXb2ws/bkP8hp1t8UOk5nkyN53p4c62rop
         2yADX/a0WSjU71PtjQDMKBAmtdvsttYsDRt8jYW5yKUljw/mDpU4+niv3hr6zJ/WT2vX
         nFRu4398KVcC7ESMWKgBBOmBV93Hual/CJYSRhfwvpjKxS0yGsvladIYjkTkeCc6cQUH
         fwuesXBOG0k7tUjW0S+njujBdmGhA9hXsEB03sGKzzEmGqOWALVVZZJ8xLQyGyOJdpld
         VsTg==
X-Gm-Message-State: AFuF++n1+okVrdnipOnK1wIn3hrtjkESbTur/5/6lDOqB+eQbds/GJ4W
	5NlaF9J+l9SadbsG9fdiqB30nFXg/w3oaEEza5AUCqKrJawfMQ9bOxLbCzKD03vuZyUuZbo8HkX
	urF7T9Dx8+XFdBPmGvXIS6RaDDvwOPvs=
X-Gm-Gg: AYBFou2KVdUqDYUfG7SRMf54wkCAHn9SH+9KQaFacs3ZK/BK760mizvigW9atSdwCDs
	7TWee1skccmWNsDozmWYQ0X6w+N/cIjy2ZTTU+3fe7ml7YjsRrJrERWf0fWB/ZHCZdu8k7xev+n
	uqEODVbE5tW1/RvlCzg4K2Cqd52yhzWWHqiCsGP0MNEwdKlJblrbJ84xs9lvoXPSLaK5Rlft//y
	3WUyV3v32MMCKFOgeqMJcKZj/kzajedY7gUw7ai8fWmKFgGICxfPpwqWkeyATkQRQX6s+SrHbVa
	AElH7yGNo4j/HrDhtxMfRl4RM9dGGcWkBR2jkO1FRotDGuUGvBEBCozslz9JlqjrmXouPLQ2fHl
	+H274CHBtSDyQmfk2Ch1ku7lVqsVoCv0rSJJNarrzFoex0Wq4rXzm5RC5OO2inY+e78aUJg5u3+
	0H/2OHMSAvX0US3e0sJ0vCHcz+DtnX7vxjZcPBl20=
X-Received: by 2002:a17:90b:35cf:b0:398:9beb:a2bc with SMTP id
 98e67ed59e1d1-39b0881d765mr43623778a91.30.1788948063719; Wed, 09 Sep 2026
 03:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813154748.2378747-1-christian.couder@gmail.com>
 <20260908164129.560396-1-christian.couder@gmail.com> <20260908164129.560396-5-christian.couder@gmail.com>
 <xmqqqzj3wr24.fsf@gitster.g>
In-Reply-To: <xmqqqzj3wr24.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 9 Sep 2026 12:00:51 +0200
X-Gm-Features: AcwNN1VAceDd8bv9m2d37Sq2z10-bvq3EhO4y4C1syLotA-ZS-66sLMkwUnF6Hs
Message-ID: <CAP8UFD0WUQX4ts_US2Ehdp7hBmEs1_ztjJiGJMYA2ek4awduMg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] promisor-remote: prevent infinite recursion when
 lazy fetching
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 8:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > It does not recurse forever in practice, but only because each level
> > adds one more variable to the environment of the child process, so
> > after a while `exec()` fails with:
> >
> >     fatal: cannot exec 'git-upload-pack ...': Argument list too long
> >     fatal: unable to fork
> >
> > To avoid this pathological case altogether, let's use a new
> > `GIT_INTERNAL_LAZY_FETCH_DEPTH` to count the recursion depth, and let's
> > check that it doesn't exceed a MAX_LAZY_FETCH_DEPTH limit (set to 5 for
> > now).
>
> Good.
>
> Does it have to be "unsigned long", though?  Just like oid_nr, I'd
> prefer to see a number whose range or signedness does not matter in
> practice be typed as platform natural "int".  Even though one could
> argue that "anything_nr cannot be negative so it must be unsigned",
> or "int might be too small for some platforms" or "int or ulong have
> different width on different platforms", or even "anything we count
> we should count in size_t", I do not think any of them is a good
> argument against it, especially when the value we start with is 5
> ;-).

I agree that using a plain "int" seems like the most straightforward,
but we don't have git_env_int() while we have git_env_ulong().

So would you be fine with something like:

    int depth =3D (int)git_env_ulong(LAZY_FETCH_DEPTH_ENVIRONMENT, 0);

which is similar to the following in builtin/pack-objects.c:

    name_hash_version =3D (int)git_env_ulong("GIT_TEST_NAME_HASH_VERSION", =
1);

? Or do you think it's time to introduce git_env_int() in a preparatory pat=
ch?
