Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6DF31984B
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196361; cv=none; b=Sx0uN+J36Pslb5Rbc+x63ZFz2HaQm7V8f4bvoRC5Ji0daqHmQS+0nreYQY2j56N25hQ+wpZdQ4H4SrAVZW7546pQKv3Igr/YU92xseQXte2XKKH7enum9WchB7kgUFYX467UaDrE2KhOc+07zjLAevJDYSllJ1KmTN1OFDkmMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196361; c=relaxed/simple;
	bh=uWtps9ezMBgdMr7VhuB6d9yPdIr/t653dh2fglIapAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4vKjBryBlqxTXWyeBpyscnEz6MTlXUaKU1fS+fW0rf8GFKt0JOCoaAhd7WtlgMbubeEG2ofD/1DA53MeD7P984CAdqN+SDjxcD8E2DMqHsN634pTTxxaC88FyGCGccLz4czDXgdhD2QR6pKfcwNmKgZmhhguaOaj09jF0dscrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70a9f5ec05fso1361386d6.3
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 11:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755196358; x=1755801158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdvPOnemdXIx6GrWWKPUFU+Wggn/9yJ6y9w1nciukRc=;
        b=mdkYcnSJaMXDnYrrCIib1h0mHLa4D6zP++ChEujXxy1NfLTx9EH5EROpbnv2T2qoYQ
         Ohkxu6sx00R1XLaDUHHGwJaRIp/aKUeAOxE/wGvYPwIK/VGcZSBfy5hgulmSylYdyawT
         c+3JsUXjN+8a9szhzlXXwS3KGuwCClmrwquTHXuBUEnpIBgaaLXAHeO1fUvvPGE042Ex
         5ztsVzmhQo1mFNa8hJQKuuxDzoJM5R7XL5baiSM0hDDxq26BJgd+VUwoynQs5lLoE0vr
         yvUIw7UO0GPOMs6i0yV2ohropztIf1U4pL+LOxq3qqg1AR9GUSJzixElK1ZoAblYYmwG
         44oA==
X-Gm-Message-State: AOJu0YyyerD8nFjoIj/wXa/3t5/54ppBnQpWHFqEOp/v5MfeWg7dkaMr
	jtHPqFbIrSFXA0CKtLRqZmGTPxMBGyV29egl23Ci/d0jvWi5xZPfOMToO7daV/xnbb950gc3ohS
	+CHxKr3e1PjEwODmUdjRlJ3beFFmniGk=
X-Gm-Gg: ASbGncs6x8AZG5TSXoqEz+ABjeXqMXP3xVPL9it+rD9jOexoDEaykJxKQfGLbwgjTmU
	F2JscY5dT3nBW6Vk89lHi2g78HqUk2CpbpQgerOAiL/u57uIPONQz19jizRqHntwWIDcn7xbJ5u
	Da8pBfD1t8AEYEW/7X/5/Ip/6B4KtE/0ZLsnZY8CZX4sbOvCMMkcugTls4qpuXg+CHhb3mg1Pvh
	LUnzntNWqLR82Liibr6jbs3nsOJ6Vn/klmrRZez+zOAjVm8rhs=
X-Google-Smtp-Source: AGHT+IF/f8RTfB/T9AztKDJVQ9K6rH/SvP9388W0SuOhn/Mwmy30L8tUxPeIOJ0GadtiDlb/98XP3dMkX/0XdZgP0P0=
X-Received: by 2002:a05:6214:62e:b0:709:8842:56f5 with SMTP id
 6a1803df08f44-70ae7011913mr29013866d6.3.1755196358279; Thu, 14 Aug 2025
 11:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com> <20250807150239.6987-4-lucasseikioshiro@gmail.com>
 <CAPig+cSBg6oQC4Y81ieH25-A9cHRTfbqC5i+22RSBcbyVo_qtA@mail.gmail.com> <BCCE25CF-8546-4320-AB44-9B729C3D6DE6@gmail.com>
In-Reply-To: <BCCE25CF-8546-4320-AB44-9B729C3D6DE6@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 14 Aug 2025 14:32:27 -0400
X-Gm-Features: Ac12FXzSqHVMs_b8nE_F1q1BR4KenQgrOFfKtfCXCIt5lY3-8dtQZhwwsKJbTm8
Message-ID: <CAPig+cTQdEDZduG_UmdHn1JNfj7iTw0=jwdkX+VPJ11Jo0jUGA@mail.gmail.com>
Subject: Re: [GSoC PATCH v9 3/5] repo: add the field layout.bare
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:23=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> > Since the documentation asserts that the emitted key/value lines will
> > be sorted lexicographically, can we also have a test that verifies
> > that behavior?
>
> Since we agreed to return the values in the order they were requested,
> I'll test that order instead:

Yep, sounds good.

> test_expect_success 'the values are returned in the same order they were =
requested' '
>         printf "references.format=3Dfiles\nlayout.bare=3Dfalse\n" >expect=
ed1 &&
>         printf "layout.bare=3Dfalse\nreferences.format=3Dfiles\n" >expect=
ed2 &&
>         git init --ref-format=3Dfiles same-order &&
>         git -C same-order repo info references.format layout.bare >actual=
1 &&
>         git -C same-order repo info layout.bare references.format >actual=
2 &&
>         test_cmp expected1 actual1 &&
>         test_cmp expected2 actual2
> '

Rather than the above, I think a more satisfactory and meaningful test woul=
d be:

    test_expect_success 'values returned in order requested' '
        cat >expect <<-\EOF &&
        layout.bare=3Dfalse
        references.format=3Dfiles
        layout.bare=3Dfalse
        EOF
        git init --ref-format=3Dfiles ordered &&
        git -C ordered repo info layout.bare references.format
layout.bare >actual &&
        test_cmp expect actual
    '
