Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FCFBEA
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTlCJiaJ"
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A00ED
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 07:09:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cac80292aeso21820535ad.1
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698502170; x=1699106970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhkTfm8QsizhC14zSWc6GJWZzxkyxRw5gBBATW4zavM=;
        b=bTlCJiaJDf3Zqtnu+pbVFEtCNCvZW4AdbQrLvvzBzYQlC2ynaP1HFto2vFSWBNlOnE
         eQc9AaCnFJVHPthaQ0RoXNZeZ7aQ8X+JGQ2PbPqjZfYhwW3NjnNUjO3RNoI5+a7Rw57b
         8FEDpT8I73Z0rL3ZXZ4UuIHZsRM9QCXPI/lYsYjrvWZeLnTSPSVTTV/5oQ3yYudUp6Qq
         CajCJg9ZtwAc/vH9ucYQvGgiH97mY3qk1CYFGQnu7rjVlOtUJ5bzYwoXpdaXBYeFelgn
         TtSs9jRE6f8eVAtFjDD7JI/rZOLBY9mPXMyhkP7VfciB5S1Kj3zL6ktQz+oLHeneVJzd
         x0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698502170; x=1699106970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhkTfm8QsizhC14zSWc6GJWZzxkyxRw5gBBATW4zavM=;
        b=gsOfUTMsu96IGs8cAUE/VeB5MnRe5CcpZ8YgNIxnTup5DZZpe+bZCNwQx72B3InuHq
         pr1cDokHCtI8u310py4KiM2eEzemzLGwG1f+KhQYU3PhipNNKMyQOpS/c7tAZBD1WCT9
         MDiLHMtztA38DBLcGfVox6k2YQvXg/6xsy7qZZeFZeLKGynw3qkt5O2NBEc7do5P8Fiy
         XNYCy+04iUepJNBJShSmWaK96gJh4nH+PTr/gbJiPPDc1iV2YSwiRguUwfQiyfy3lqXb
         ZBdqRtFVCNKksKHI/6cD/s3jvgXGRsiHLZFC2K0URk7AFxHW3gQ0zW24yd7L2SAcPCzl
         0n9g==
X-Gm-Message-State: AOJu0Yxo34+1amJTNkrUYnUARj01ji5TShSs/TTqdL5uq8JS2NYMWTIx
	HPCjJzyvveWSLAarTbypN7NOR+Ttl87qWpSKdmhnb4UAUh6Jdla8
X-Google-Smtp-Source: AGHT+IHrt2IcLEiCM3Adu7uZarpqm8Xt0vNRWLpoyfmNgzXl/CI3FFX8v7Jy+FWA0l7kKWbjCE82pLYpzC7+XMP6SBo=
X-Received: by 2002:a17:90a:1943:b0:280:2d12:81e with SMTP id
 3-20020a17090a194300b002802d12081emr433548pjh.27.1698502169772; Sat, 28 Oct
 2023 07:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHH8bEfM8KmwhHX_Fmcb0A2zpr8L75vgNhfvZy-uitpSXNUvQ@mail.gmail.com>
 <CAP8UFD22EpdBU8HJqFM+=75EBABOTf5a0q+KsbzLK+XTEGSkPw@mail.gmail.com>
 <CAJHH8bH0gp9tbDJ4DYk3jkNPD5_dZ9s62D9ae3q33aBP0ZL9Lg@mail.gmail.com>
 <CAP8UFD16OAPiRFJfjZN=soAe3WzDBteyvzv-b3CD67jz6Haqyg@mail.gmail.com>
 <CAJHH8bGK28Fc+VG3uxgC5sGgFEAw6_6AEtusgmw7c4Vz0iGF_g@mail.gmail.com> <CAP8UFD1+aWGymjssk5CotPjEmhu5sMcTy-b7eJc4fw-UA41Qig@mail.gmail.com>
In-Reply-To: <CAP8UFD1+aWGymjssk5CotPjEmhu5sMcTy-b7eJc4fw-UA41Qig@mail.gmail.com>
From: Isoken Ibizugbe <isokenjune@gmail.com>
Date: Sat, 28 Oct 2023 15:07:58 +0100
Message-ID: <CAJHH8bHCfx3vknPCGATbLZeTA7hYrVVtnYqfE1avWkiL1PvU1g@mail.gmail.com>
Subject: Re: [RFC][Outreachy] Seeking Git Community Feedback on My Application
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 1:38=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Oct 28, 2023 at 12:41=E2=80=AFPM Isoken Ibizugbe <isokenjune@gmai=
l.com> wrote:
> >
> > On Sat, Oct 28, 2023 at 9:07=E2=80=AFAM Christian Couder
> > <christian.couder@gmail.com> wrote:
>
> > > > #define DIGIT "0123456789"
> > > >
> > > > static void t_digit_type(void)
> > > > {
> > > >     int i;
> > > >     const char *digits =3D DIGIT;
> > > >     for (i =3D 0; digits[i]; i++)
> > > >    {
> > > >          check_int(isdigit(digits[i]), =3D=3D, 0);
> > > >    }
> > >
> > > This tests that isdigit() returns 0 for each of the characters in
> > > "0123456789", but first I think isdigit() should return 1, not 0 for
> > > those characters.
> >
> > yes, that is true. should I send a re-roll?
>
> Yes, please.

#include "test-lib.h"
#include "ctype.h"

static void t_digit_type(void)
{
    int i;

for (i =3D 0; i < 256; i++)
        {
            if (i < '0' || i > '9')
                check_int(isdigit(i), =3D=3D, 0);
            else
                check_int(isdigit(i), =3D=3D, 1);
        }
}

int main(void)
{
    TEST(t_digit_type(), "Character is a digit");
    return test_done();
}
