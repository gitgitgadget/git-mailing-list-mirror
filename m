Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7E366045
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453998; cv=pass; b=XCR3BHPatsOm8Z6eU1dCYaNI/HLShw3Xo29xzg8VduEhgs4BbanlJ0kveDkW6J9iOe9+n9Oe0gJP/AFpXASAJPou43DwlndQRfG20AytpzsI3BNEPnFP82kybuopTY7Hpf5OAiPrboEnBOAtAPRdIPBWeV3IO+lx2dimHxpmUt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453998; c=relaxed/simple;
	bh=mcgD+hsZp04ZaV50PhBvVnr5Ol7JSzVYg+asOD6RBhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJIiwS8XtCIcXj1CvlDO77xLj8dCOUHyVPPiexwvNq62cc80VfwLuxZBmEsWzFcEoUvjqV8PQarh4FKZIRngAitN+DDyxD+NgftrvBOt7UPYHf0RV91ICaGY5NVmpeoBwATAr80KRVtj/TekPdblAXQnMHGCZuBNyCHh408KXx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLrcF8Ev; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLrcF8Ev"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8111c0c7561so47848457b3.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 12:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783453996; cv=none;
        d=google.com; s=arc-20260327;
        b=Q+WAgXb15uAlOiLwsCuntlVzfuIc8L/a/a4q8B53tKh3hD/XfQKi9Kq5Gq/ESpERa1
         VRLBqeNLtGbkMuQG4invLim99vkOFsMr0Iwi1I98ptO7mG5tXNMY53NAH8Pt1G/YA2re
         Lzn7IrVcGTLM0+mqkEDJpTASOY69pEi4+E1opcclpWOJSaO+zUJYEMaH1lCsUxklZ3dP
         GgdYyH6mgAud6UIv2uorDWsLshtW5IDRG6goU8cKoBqJ+MY3rhOwLTp2lXw5MIIRseyu
         VB2yyQNfjA6kSs/h1bq/FSf5kXPiqQKhshpCHINuwg22r9a3QHEnlsh/H/TGFEknGPFX
         lzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p8W4KgQYwhU5Rs1M/hZnbBblyVQyG6tKyD8Xp71MCxA=;
        fh=BY0PJxl/9NWRhq6Hk5NfDhGbQiIoMa5/xMUI66hWeLM=;
        b=M6VyeEkzIqdETX2K9LTufufdg7dRzWhGMPzPwQFIvzgEZoDy6u4zd0VfQldDdPYCr6
         JrNQuxMUGhTs9Jwo2aTwo/6jGr9FRzMNXHVGH/cmkEQ+H5D7Os4Cb714SGdWcKJoJtFP
         qdrxOdlHcBV1vp6BzzbeGOGqW+2We6AN3M5P6HWm/F44Nt/3JcB0EBSFiXutUd+zQVAm
         ePq8MsGtikdHuG+uqNaqggVL1+hSabOx8B3ins/nLYlfvRoF9sQ6zMGEJ6ncPM1VfVGx
         RsDNnyskSb+XsCvB9UPcaA29RS6giCd1gNboXwL/ZMyFPAg0mMcBuF3Ua5za0D+daYb6
         DnVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783453996; x=1784058796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p8W4KgQYwhU5Rs1M/hZnbBblyVQyG6tKyD8Xp71MCxA=;
        b=gLrcF8EvcV/n6R693ILVtnGjDv2LmRNo0VbviIDnros+jvw5vyKCU7CU8LEcUXDFy3
         F38T1H7NnrVEGrCK7J76nfylRvylld2zhxR5gzQFJOdqoX8+pRQRnKWQ42X1vWOtSu6s
         HMsYUnobzPRBTRpjeb+MO31YLQCVzk8e63VN9gP0GTVVa4TPpG6USVu23fd0bYP4p3Qe
         hDFLgD6esIem0oYl2V01qQU/9WiB1nIg21OT/SRfrmZ8zi+EN0G8jVHpUHob7WYp01oz
         CmCXTlh1Z+bHJEQj4fqWX8ADZ81maSJAP9PSRiHgblEJ1BM170qdXdEc1thh49HtjDiu
         qYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453996; x=1784058796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8W4KgQYwhU5Rs1M/hZnbBblyVQyG6tKyD8Xp71MCxA=;
        b=J1pv1lm3DWgnhaeIBCLcjwi1kxYJFESTsIkh5zxS/BuKu7e419VB8NNs2PlbmvonN8
         2VNBh7zyqqMkO9q3lK8S3TKiz2eCLgrFa6yqoDGwgAaPRtZKQL+rt3XXjOQEN9HiSVJC
         RdI/SKyY81+hsYDU7Jd3yxE1xXuL3FaHbxah+qJBIuuOrX0h5kJBg+7EKhjLDukglPEZ
         xYMKXnEmV9gz9f6xXgSO1SWQbyDwBYwFdpiD1A4uOj5oJVdKSjAszMV00ECkXiMTpQAV
         wvLUU2JR+Xne1QBeJA2X1dEfsRI0sF9kkxg3eR1wu8W9fy2/7WMZjzq4jMKQnmhvZaqe
         PKyA==
X-Gm-Message-State: AOJu0YwsdPpJ+YOLx24u55wAv1d0a435QWWFzT6v3aTzPqEUPOsUv/As
	oQhc9Kfq55bkX75vl+Qzhnw0jda4HcZ5fthwnpcCRz6ACqpwgDErKf5E6d5/aSk1mHJ7WA4i5U1
	zfW4F56XVe68s5hHsu4kikjwTLMMyCQw=
X-Gm-Gg: AfdE7cnfV8/XfQUB2EW0CeWptBE/ijRW41EjxsxH2hh9kL7+s4Q9noqxJ45ITwboCxL
	MVQZRE20jYSBKNMcmtfMdVP9NC6Coz2grQoTSQ5IjUPK4PS8p5oMEHLaNxA8WbsxizTZrHhsXsZ
	SH84wabr1KixsiCrwuL0FLREbe5m1R3SnSjO42VQgRO5afJrIgiUJdJuB9Vf8VwRSJNeVDo5PO6
	Y2KDkjZdf7mDzreLHiLpmsqoNx/+QufHjcRzzBeUhMzG5PvWmMcpLC9i/WSPP0T40LI86MhXYlO
	WnMKNRfqxQqvQb9iIEWkjZAegIOZVjYi+uk2pHqD0MEgDjsUkZrKVbVSmIpmw2khve3T0dRTj+I
	xe4W43xxm6wF4Ku6SG+qRmxBG2401z/F347TgJU4AG70ojJT+m6yoeGhKmUrhyJwmPdBJ0w==
X-Received: by 2002:a05:690c:650b:b0:80e:2592:5218 with SMTP id
 00721157ae682-81be2c82126mr53409517b3.50.1783453995744; Tue, 07 Jul 2026
 12:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260701-ps-eric-work-rebase-v15-2-c88a43b63917@gmail.com>
 <xmqqse62obwh.fsf@gitster.g> <CAN5EUNTYeDrQMor29eYMhJD0jcdRQq36ZA6BgupV8gG9xs9rFQ@mail.gmail.com>
 <xmqqcxwy4qp5.fsf@gitster.g>
In-Reply-To: <xmqqcxwy4qp5.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 7 Jul 2026 21:53:04 +0200
X-Gm-Features: AVVi8Ce3fnKmWcoUNNn4bJ3zmdiQBHbN5DWRBcuhjxULnF6jmm-MWk6ND7uIiB0
Message-ID: <CAN5EUNQ=2qtKXSJvxQiNLYqx0N0m6sfyBGLLXm4FB1kwtOsdbQ@mail.gmail.com>
Subject: Re: [PATCH GSoC v15 02/13] git-compat-util: add `strtoumax_szt()`
 with error handling
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, jltobler@gmail.com, karthik.188@gmail.com, 
	peff@peff.net, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 7 jul 2026 a las 20:09, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> >> If you are trying to more explicitly insist that s[] has only
> >> digits, which may not be a bad idea, as that is what we generally
> >> expect, then
> >>
> >>         if (!s[0] || s[strspn(s, "0123456789")])
> >>                 return -1;
> >>
> >> perhaps.
> >
> > I like the idea of only digits but, even though in this series I only
> > use this function in base 10, I want the function to work in other
> > bases, that's why I left the base in the function signature instead of
> > hardcoding it. strspn(s, "0123456789") rejects bases >10  ("ff" for
> > base 16) while strtoumax does support higher ones.
> > I think that it would be better to explicitly reject what we don't
> > want similarly to "-":
>
> Let's step back a bit and think.
>
> Where do we plan to use this function?  Remember that being a
> superset is not always necessarily good for a helper function that
> serves as a format checker.
>
> In the output of "git diff master...ps/cat-file-remote-object-info",
> there is only one caller, which is fetch_object_info().  It reads
> into object_info_data[].sizep.  Do we expect to express the object
> size in anything but an unsigned decimal integer?  Remember that it
> is better to be unambiguous when designing a protocol.  We do not
> want a third-party reimplementation of whatever is talking to
> fetch_object_info() to send object size in hex ;-).

No haha, we don't want size being sent in hex :), I agree that it is
better to be unambiguous. We could hardcode the base 10 but I feel
that calling the function strtoumax_szt() when it does not support >10
base (or I hardcode the base to be 10) lies to a future developer that
tries to use this function thinking that it behaves as strtoumax_*().

Maybe because it is called only once in this series it is better to
have a static function close to its caller that explicitly does what
we want and it is unambiguous.

If that sounds reasonable I'll move this function to the commit where
it's called, call the function parse_object_size() and keep the strict
digits only with strspn proposed.

>
> It may also be usable to parse the size of the object payload in
> object-file.c::parse_loose_header() but notice that it is already
> even stricter not to use strto<anything> system function and instead
> handcrafts the trivial number parsing.  This would avoid system
> dependent funnyness, which is a good thing.
>
> > if (!*s || isspace((unsigned char)*s) || *s =3D=3D '-' || *s =3D=3D '+'=
)
> >         return -1;
> >
> > About that, strtoumax works fine with "+" and ignores starting
> > whitespaces, but for consistency (we reject "-" and whitespaces
> > between or at the end) rejecting whitespaces and +/- will be better
> > and make the caller format it correctly.
> >
> > I'll do that for the next version.

Thanks,
Pablo
