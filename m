Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313F2F8EAC
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787790295; cv=pass; b=f1ru+dyyKBuR0YdS8hEYi7h44f1GblY7tkVAqBk022utVMHbp9DDHqYXf0pqIk1Ir0mepEiUwKS5dhukt+FTJEIkmqwKIn+yFAPvjeF9LPUK2Ly3wDtSCPIVdv5emlfBY2AkStwELjeDGNmJpSTDijiCShg3i+QRg6SzlGQ4vik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787790295; c=relaxed/simple;
	bh=HN+R5zZBEiUbGxIXkYk7HfnxrH6C5Dr7uDfzJRQ1RyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwUGKzTHKFtArxgvR0Fqd0Ql7gNN37kMcSWohwFs6xxIa6wNq9d4r/crf0KIdb/XrbAXiU33W/FCKCxz5ABTKaqhg/aD4AxzKXIFFAFsk4zz8lxOgcEqWvuJbkuQf5yNofnc89dPJ6mGQ1HY3Z28uYB5SaPabryXXUdjvqNO0Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCaEBHV6; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCaEBHV6"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4a451915d8aso1536565b6e.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787790293; cv=none;
        d=google.com; s=arc-20260327;
        b=Ma3p+KNwWtsDNRbgWhzimazx51GLM4w3SweWEIczjohjhc3e3dHGB+OJaGjBdeik9E
         X+q/whF0Ohp2zrqthstvrGlYyrbtnjLKkF+d91FcUulQnCkYR3tEYjkLq7T4DSVS6wtW
         aONMOU9qAQVRAsCGdtVXY/5N/DIgxEghcEWaQ0AGJs1Au40FI1tUbzIw5KJRC4s8yiW0
         1kqedkvUIXljrV9Z1jiexjAKjFJ9UVFZlBjrOYohLF+3X3KFF3SJE15MXk5Vf0slr+47
         BLMKCk5RhUEjcNMiATsl2SyV9LmhmYedDt/zAk3k9vlNeMm1PHK5F7aPr0etWeG1N82U
         siTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x78NnvcG8X0RSkE4OPY+gw2cxrN06tMjfO1TOye9cFk=;
        fh=X2KZDZcaZnSClZy+GjmVx024w/uPegmH5iT+6Bu0nZc=;
        b=AnVVrTw/WQdmIVpuBC2A0tdM4qwB7FhNOrlKaBG3RV9UlG2WixHrCbAhOsrUooroFC
         k51NY/RfsxGnE5NsS1E5X30WlWZx4+Q2gjCWsZT7GFfY5C6sjj1/kURnyIMvkWaNn77F
         +mYB4qBV34f+fWf5zUNO57qpgNj3fIZti15j5Q+g8F8uzkXmCDKPGHKye9cjqURrIiQ7
         Ej+QS/qcv//8M8XO5D9eVr8lcoGKsxEWDLKCiW/A/3kefcwFP/7GOgk7XS1RwierL5Bz
         xb4Z1NHeW+MIQ8BsgzoG/TjrBCoC6c8k2FW4WalY6TDOVMhQOxhUozNInu/sKtbOibWc
         NDLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787790293; x=1788395093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x78NnvcG8X0RSkE4OPY+gw2cxrN06tMjfO1TOye9cFk=;
        b=aCaEBHV6qJTu79GmQXNfHTXy+B1ZMWcVlP6zVRTDI0u1/SDtiYxdG6opsfN3Clo7sQ
         GLn6EhFqVrXBTNuzEtl+3wnNLdCcc/udJd6QavChJ8fuTMLuaXMfAgcnUn0LXRtDSFnG
         Cu9m5LDPFgKJtM9DCASJYRxxfzI9VbE0qdrOs6ef8vJTZ5K3g3pJgm9ytcyzvbpjmnXO
         Yp+bfsGIwemTcN6kJyrsZMHeo1DwTdpurXzccZtIwryZ+MbcB4945hvpnI76yiZDWaWF
         18jxy23ZMJMEJ1dKou1OFE7fpGk+kw1bDSy/Yd9Bj0WhUJ53//kPwUwteS5uBDpgLSLm
         xGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787790293; x=1788395093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x78NnvcG8X0RSkE4OPY+gw2cxrN06tMjfO1TOye9cFk=;
        b=ceGgmUrycAP4viaKNozW5uJwo+e+FiOkqSZMcQhwCq0i/tWL0JPGPcoOn2JbfdAdc5
         MW+5kmMuBpjlhz887n588RaPX+7m/c/vfgSWdVJBG6Q5dPTBfFHPXNeB50RKBK+sm3xz
         JgHPhX3YLcNV+oKwAfQaKMI2DhlRuejTjzGZKCll6uDrNbGTGh4UqT5MFtbl0TqgeuXC
         VHPn5GptvZLlidqyHEOH+rfyN9d4ijlIHeFc7SEjHCaGLEY4BEiEmTgS6jaJtPHyXwEu
         VhXzy5/fTx+dEPpJSR4y9kkpGEGNqyRV0mllV8KqN2H2RIEOMo/T5gG1/5dM6xvP4SfX
         Jsog==
X-Forwarded-Encrypted: i=1; AHgh+RqJsC/VXQ5bI1eq+jYpCCShDRTlyl/iKuw1kzrHxOe0GooX+wnvVkRBOeEWHcFcvFiDD/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++klC+dpzEf538s5zHV9LYf8byy3+m14UbAs7MY9C4wx7goOgBQ2
	t8447zEnl81MfXeZK+0sz4atClJCSNRttSZhUDtSKTsQab0Td7E13ELG0IgkIsXQ6OBRwFKtJ7m
	QzfcArZW5PmTE+3REVjglBIJ7YNIxGzg=
X-Gm-Gg: AR+sD132pc7ygG5YsEBt4rBVam2r5kmDQrUPEiA8aXZZy+tqlyhx1cdUp9rI6AX1e/s
	grvwTYQ1P7DmTup9saQUkpWBxDbcMFqiN9f0nY+uT8WU884PwbBC19BmcZD1nndhKgm759EDO8N
	DmX/g091YCbbt+jtmA7ovHOe68fxbWnGS/8WEjaEolhEw/TjtTDQQh26oowoDVnAITQPnaPbHT8
	xUPzzMWTfUFssUlFg43oLpwoyW0qHnHewJaKlxsIE81VtUhdJw3SQYKN/crtLD81VOJ2ijT7lZm
	rChFqId9iWo8SEXl56+VciFt2oCErFQmgp68Pv4F6azWsobCaSsNfTJk2R3j59ZFl+4nOUxgMEs
	BMtfBZJMvj0OcWWJrb3ixkyuD19U/PvDC0pDamKF8rh8dCx96tORgV4rDpZMqnw==
X-Received: by 2002:a05:6808:518e:b0:4b3:1e40:6451 with SMTP id
 5614622812f47-4b366908364mr12462966b6e.1.1787790293134; Wed, 26 Aug 2026
 17:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com> <xmqqqzjkj0p2.fsf@gitster.g>
In-Reply-To: <xmqqqzjkj0p2.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Aug 2026 17:24:40 -0700
X-Gm-Features: AcwNN1X7nXu0F26aggZTAZK1nv720lQnjcSHnUEnZVvj6RufS7j5I2Xxum4NO9U
Message-ID: <CABPp-BFwN_ek_t67V5nPruV5vL0hSzZyoy3ut3rvzNsWv2DKpw@mail.gmail.com>
Subject: Re: [PATCH] commit: refuse to amend during conflict resolution
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 9:39=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -1336,6 +1337,46 @@ static int parse_and_validate_options(int argc, =
const char *argv[],
> >               else if (whence =3D=3D FROM_REBASE_PICK)
> >                       die(_("You are in the middle of a rebase -- canno=
t amend."));
> >       }
>
> Let's make a mental note that the function receives these parameters:
>
> static int parse_and_validate_options(int argc, const char *argv[],
>                                       const struct option *options,
>                                       const char * const usage[],
>                                       const char *prefix,
>                                       struct commit *current_head,
>                                       struct wt_status *s)
>
> > +     if (amend && whence =3D=3D FROM_COMMIT) {
> > +             char *applying, *apply_dir, *stopped_sha, *amend_marker;
> > +             int in_am, conflicted_stop;
> > +
> > +             /* Check middle of revert */
> > +             if (refs_ref_exists(get_main_ref_store(the_repository),
> > +                                 "REVERT_HEAD"))
> > +                     die(_("You are in the middle of a revert -- canno=
t amend."));
>
> "the_repository" can become "s->repo".  The same comment for other
> checks in this block.

Good catch; fixed in v2...although the partial commit callsite didn't
have a handy repo that I could spot, so I still used the_repository on
that one, but I used s->repo as you suggested for the amend site.
