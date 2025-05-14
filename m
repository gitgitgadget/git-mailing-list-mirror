Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74941F3B97
	for <git@vger.kernel.org>; Wed, 14 May 2025 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205005; cv=none; b=r1WIbmPu0/xIES1ioQ+yDBnhcQN6qYDXbVGw+f7hengl5k3/5BV6lTQyJWG0F2UTuL/DrBrhjnAOk28pjyEjH1Zq22cNmFyPkdh2CtGASP5ed9IpIR4MG3bA+NpUD5806i3i5WyAHH9Wlfof3mlIrco81scgxMck7HJORegrfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205005; c=relaxed/simple;
	bh=8FAr7rtBhFC7LPwio+r0i/n0XZ1u08wdRAh+R7c02T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUdEdkdlha6Lavtlav6Cq857HdW5gcmTeBI/X5NZ6rYE8dyGl+Jh7VK1GmLWDx0szwrM5d4JYX+AiiLzKs0/Bx3fwcOjZq+MWhT8tU1k1t6GpqkFg12cRBmgodoMPuzu3biUJHwKm62VaxX+VvbiDcqftMoVcVrQMThAJbZEoVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmaK28LV; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmaK28LV"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7304efb4b3bso3944698a34.0
        for <git@vger.kernel.org>; Tue, 13 May 2025 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747205003; x=1747809803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/6G/wT9eObDwv+qEC0LPiwU06S3t88lZz0CLmJt3Zg4=;
        b=MmaK28LVA7CY4ff61aAlb4ZIDN65rDgcwtxCkfX2QJ0rU1S3oUdviZbeSbtlJ6OMRR
         jKGRI9hQBVnmyqVXRjGBNCEVZR/Gc3OOcgZjhM3hRnJMxdKXluVQKnwtxMpj2L9gzz2y
         UcZelAWNbcwfqb5K2npuOfaQq8au/g+QoMGKmdXtsX77D7lJCE2G8PiOz8OJippQHJ3I
         0ogf/Ov8KqlC3VsBZDIJ1Vpt28FB77vH5Vn3Ha7gfee9m8bUd0GIncR7/8rn6jOHBiw0
         nERQy2aVbk0sTXPuJpK6Xoz5W3sry4qPxPnkXqyPU/HXyyVfdkk5bCux4Rw8hJtGRwEw
         HNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747205003; x=1747809803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6G/wT9eObDwv+qEC0LPiwU06S3t88lZz0CLmJt3Zg4=;
        b=jbDoRItvSi35mLIQ2KERa41tC2a6uaLHYiru3FxiZt1GDc46mM8psVX8vHYDVWVDsh
         I8IcnkbruFPXuEYqwg/JvF7bJr73s9GmlFp/IvhC0GPWpv+5ct6X6agY+eGz+Fyo9+V/
         /qTQp7g17Zp1f6w+7jxAs9nkOPAEGk/1MPFsaVWIORqdf6Sp7ZCg7Ia8F34FS8I4hXne
         w3Yn9llL04yOpVR7V+Rck270WCl8aX7BZMmNo/ZugSitZ2ags0twa8rzMwuOKoRc2gCe
         lvRfF/Z1I9ot4VR5VQ5iBidvLPNXARxCh+O0PxRB+Yxh1yBKWV2xvw0gtwq8jUi4MRcT
         y9ww==
X-Gm-Message-State: AOJu0Yz2Y1x/b+oGnRqPlv8kp4Vi+SVYbCO3MyxY3Req9paIpSW5TeSv
	Ii0yrg4j5eiPFiHzHS/RwPG3BI9Vd5Izgh8eET+rHUPUcNULUcpkNz8v0wKeNNXRRGu86x8qr/N
	2ku2uku2ccujXqmLDVaR9bej2zHw=
X-Gm-Gg: ASbGnctClCXWcM/MjGhMwbn/oLALD+t7zoo/7UiE3iBawy7CnUdRozuYwqqnKHG0olp
	SAn6pdGwP54PiZ/k/ylX1CJtE+Nq60dfFKWmP75Ih7EZvKP/wkuI3A5x6FfsTe25ZCQEklRYr11
	cAicZvUMaUtAKzzd50atXssdgy0LvEGaXjo5SBncvFmdpnO55qQ6GtPZxu6jUDVUWhBco=
X-Google-Smtp-Source: AGHT+IGgmukrayiyZ3FCKlttZ2bnZlDSQKd1hzr7bqFU8nvBcv4cZEhFj5U5ha5OQEPydfZ8gEW/dJmvu/Ql7R+6x4Y=
X-Received: by 2002:a05:6870:96a6:b0:29d:c832:7ef6 with SMTP id
 586e51a60fabf-2e3488725c5mr1108550fac.39.1747205002700; Tue, 13 May 2025
 23:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511125809.14180-1-dhar61595@gmail.com> <20250511141101.18450-1-dhar61595@gmail.com>
 <20250511141101.18450-2-dhar61595@gmail.com> <xmqqv7q4fipn.fsf@gitster.g>
In-Reply-To: <xmqqv7q4fipn.fsf@gitster.g>
From: MOUMITA DHAR <dhar61595@gmail.com>
Date: Wed, 14 May 2025 12:03:51 +0530
X-Gm-Features: AX0GCFvxbFf4GxONu6k9_d-VjGR3uqPgTdQ9OvC-6CKnLsB8wJKhmjOj70XJo4M
Message-ID: <CAF=ncLaYAXF-bFjMaxa39oVFNNmk=-gUs0Abdf-dxSAEiD7Ltw@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] userdiff: extend Bash pattern to cover more shell
 function forms
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 00:20, Junio C Hamano <gitster@pobox.com> wrote:
>
> Moumita <dhar61595@gmail.com> writes:
>
> > diff --git a/t/t4018/bash-posix-style-multiline-function b/t/t4018/bash-posix-style-multiline-function
> > new file mode 100644
> > index 0000000000..cc8727cbcd
> > --- /dev/null
> > +++ b/t/t4018/bash-posix-style-multiline-function
> > @@ -0,0 +1,4 @@
> > +RIGHT() \
> > +{
> > +    ChangeMe
> > +}
>
> Not a review, but I am curious what this test is about.  Is it to
> ensure that the pattern does not get confused with the backslash
> that does not have to be (but it would not hurt to have one) there?
>
> IOW, does
>
>         RIGHT()
>         {
>                 ChangeMe
>         }
>
> get processed just fine, and the above is to check the corner case
> where an unusual "\" on the same line as RIGHT does not break the
> funcline identification?
>
> Thanks.

I realise this test is redundant , The goal of my test was to ensure
that the entire function header line is correctly captured, even when
the opening brace is placed on the next line using a backslash.
However, I now realize that the test case Johannes mentioned already
covers this behavior. So rather than duplicating that, I think it
would be more useful to add a similar test using the alternative,
Bashism-style syntax:-

function myfunc # RIGHT
{
    echo 'ChangeMe'
}

Thank You
Moumita
