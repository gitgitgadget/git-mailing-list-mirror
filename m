Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC345979
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117907; cv=none; b=MioCNtXGPwwPppaGZLxxACfJXFyEepxReiUiThOpznqHzRrJBGAc3H1YDvHY3y+aSi+666hyG3iwN5XEinWe6E9B2y/UlMWq4Br09j6Y1PcauwVmo1okn6WDMa4oJSVpYM+Wv20QcH2QGmvxxZ7kytdXACEUz7dIWYw8uz7zyHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117907; c=relaxed/simple;
	bh=ItE2XverIZLqa8Kn2F8KOdjch5Y8+eb4Wg4dH0tccUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOru2kXjRFMWqOiUCM7By55clJqfdH6pKEaEfj6LGLq5gXONPiacYKBlef2IW9mzJGUkIIcq9gCNyx9DAxcCKGVrN+7a9kGHFfMPzTdqcj8yGtuj8CB2JkOTr6VpcyT8gEMYCcxHBeXpnK5RbcplibuJTw3mWjHqCU1+7por4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4450292a50bso6942761cf.1
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 11:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720117904; x=1720722704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vlU6+v0VEKbO+v9wpl04TRUNaI+QxRcIiqH5M1SvHU=;
        b=swENlHuOsUQ3G5Q9lzulk6YGhggnc1NRgQtAht75izxn7xxB0mPdblTKbnBfgU5ppG
         apoXNV3BdjnC3szE3Ky6U6cRHR5r9TVwJYLAxZeRD/We/S9XtZJZH7bfTl+q5p8SPP12
         Ic9v1INZzeVC11qXZsVcBwkzaiuaBjaAxeP4ZmS3iuezukzpsWSwCdwzpag5e1HDSr60
         PltuF8tXLNStGEUtDd5tzV/DCCTil97MtuTnc+xdsE9BUA5Plyk6w4q+xb/RVOIAud6K
         vl4+0+M8puVhTYlQ76vXEkEzoAuL2gmOFtMBwX8vaeeM2AefDo/Rf4+Qi2gliMPYSrje
         aAjg==
X-Gm-Message-State: AOJu0YyHvzYU0AcNBEXMbBbO1OHhquU8UV14nuk5mgMyn546Kq4LGX5K
	soaudD71UD9OoQS9PGAEyAVUW3+auIuBMFx/qrtIcK/GTpALzw7oQUrKGzfDd+4VI1TB2q8eoqd
	9syCJsAjEiWh6QmgOxn1CKWOtu2E=
X-Google-Smtp-Source: AGHT+IFvJvpJfSN9m9TOpi3YJqd4BHRj9xzu1yUaIiiJBIpj4hh1dzqxWRuy6MTidoIw0bDibZy4xzB9+2cjaL95oAg=
X-Received: by 2002:a05:6214:53c8:b0:6b5:42b7:122 with SMTP id
 6a1803df08f44-6b5ed196d97mr27053076d6.60.1720117904385; Thu, 04 Jul 2024
 11:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
In-Reply-To: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 4 Jul 2024 14:31:33 -0400
Message-ID: <CAPig+cSHoHVUGdEDk2h5updMqaPqQMkAvypFLK+S2qRYhw=CWw@mail.gmail.com>
Subject: Re: [PATCH] t-strvec: use test_msg()
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 2:04=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
> check_strvec_loc() checks each the strvec item by looping through them

s/each the/each/

> and comparing them with expected values.  If a check fails then we'd
> like to know which item is affected.  It reports that information by
> building a strbuf and delivering its contents using a failing assertion.
>
> Here's an example in which there are less items in the strvec than

s/less/fewer/

> expected; the index of the missing item is reported in the last line:
>
>    # check "vec->nr > nr" failed at t/unit-tests/t-strvec.c:19
>    #    left: 1
>    #   right: 1
>    # check "strvec index 1" failed at t/unit-tests/t-strvec.c:71
>
> Note that it is also reported in the third line, i.e. the variable
> "nr" contains that index.
>
> Stop printing the index explicitly for checks that already report it.
> The message for the same condition as above becomes:
>
>    # check "vec->nr > nr" failed at t/unit-tests/t-strvec.c:19
>    #    left: 1
>    #   right: 1
>
> For the string comparison, whose error message doesn't include the
> index, report it using the simpler and more appropriate test_msg()
> instead.  Report the index using its actual name and format the line
> like the preceding ones.  The message for an unexpected string value
> becomes:
>
>    # check "!strcmp(vec->v[nr], str)" failed at t/unit-tests/t-strvec.c:2=
4
>    #    left: "foo"
>    #   right: "bar"
>    #      nr: 0
>
> Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Missing sign-off.
