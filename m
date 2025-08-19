Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66EF257427
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568830; cv=none; b=YGGx/eGv6AGm/MXSNOPhydqrnW9xzF2vNFdGRXeUxbt1IG64byFcTrRJety9NACB/ReYJiUrPFO/xb8uw0q9JVSpuTnnVBMbxIC17sGTWul525iHT1ak4OrRZ+kBTVB6M7l4UW8sXZFdxswTYN/3/9RqGFQE/ulp7hu4/NTVfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568830; c=relaxed/simple;
	bh=3qtseDMkmHJZSL5615eLrMQqHkJc+vX47DSJiZDYmn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtBtkVXXItnR/BfcXUMlBSAPjvTqVqXGcrWBAJ4KezquuOhuwbY4YA5zZdVtTBP7Il1C1CT22wMhCt/9mxKEpA7R/ptHB8tChM2K00rw1INISjF7jUF9GZQ1uKeneeips3WKHmQn5fbGZWLwZB1xl4/+KtapdZ57Rj4GAUJex1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZcR/Xlu; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZcR/Xlu"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e66b5492c9so9504565ab.2
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755568828; x=1756173628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzuktfaGA4BYE0+/FcmXt1Mkz+7lq1wQzxAO2jt3sUA=;
        b=bZcR/XluiR8WRg2ntwPaERGlIp72RHsBcyizLalPN5/8LTGv+GXBgU0ZvvwCzxccjI
         OI71RDJyVAcFgZenRGcIRJvOdaHPIN1IclV70m0rQk/rCYDjuGvgkdqPPK1jNKdU0V3N
         ChEf1beNzO/nmwy6LEPDegtcvrQkneFTIFEsXdh+uM1vM+1cE1SV09I6EsOMhpBiN7QF
         4Zof0AyJjOI/PNnwjctRTpxC50k5xutEBv4jJSRKwAeJNJxTh910uZUC3SHwrjcvGWzk
         6OIJdAlMpTUXqsdWDjAAYr3ZS4mm8qDfBdwFoV8WE/Yaq4VnXWD1cLlH8rlnwfaspdjn
         Ju0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755568828; x=1756173628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzuktfaGA4BYE0+/FcmXt1Mkz+7lq1wQzxAO2jt3sUA=;
        b=XxcNtwFP5HXuBeyryeSO9FV/TH0oUwk8BJjlkJaqZw/IjECioRSLKmwWaqrcBMjWm/
         pPShtYCjT9fbJox/wywMSv/2XpfblEASneTRhs69sshtmN6xuhTBHoKBWmusgTiT5LZG
         Zwim/uJfsY1kOrLgpDwPavefGVrf1WFu81aXWV1UcRYLVpJ44VyThCh5HIJLC6vv3qMI
         ZCpyGmGvSg/HOZR1AzpFcSWkMRFLl3XHd9FcJbdb9q9/ZHLA7zMz3zu4IPn4Vv3nJQIe
         RGzyLCyCLyVwOZHm/5pFEATFWQH/b5f3wExpKT2OMY3XUb+BvkDMowm3knsuHn9oSWOe
         tfZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXezV6cmM7YOqaeFpSKZmUUl5T/eHBPfxxoDEUb8/TqE+cS/w8cI4OaOedFBN3t9eX5OAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSxmAWt+ZgYXsOEKvxLJiQU5M5u8K3tAe8Vd05RpaqgvJDzJw4
	Z9DmKTx2TeW832WQWB5mU59QSCIbrWRMJs84v/YJqwvmdyKFvB72dHd51x5/OfiOx2UVJpPEEyK
	BFF6JA2+9O85Vi/0SKgdaxCeb+p22pvA=
X-Gm-Gg: ASbGncv11Ck775Sn7N1bVKzqCusnbdnx2IcOU9pLmWjVsed2ifkePNCVw55ssBjbLAL
	sqtlGzNGFJlxRsc8mGE5LPDmBzY5L1xxQy3m1hDTpZ42WxC+jlhTAdwHzyG0wpBrhAOWP/XMYrU
	mu3jV8mBakGeZ0UVZBa0PAxFByfX+2hrASk2+7u4JsTG4dZlLGkmfl4c+LLKpgifRNxLBWu3wjb
	7I+ozA4v6IE1MXEZiHHEX+WUeQ35djV699cMstbxBtda/OX36Y=
X-Google-Smtp-Source: AGHT+IGFjwNfyR1RLKugDFXSZjhBNw1FnoHlmYw01iJup5qr7MgaI0be9uZxkyKHowkz++dKkNGjDL3cTfyf3Wt3FHM=
X-Received: by 2002:a05:6e02:2183:b0:3e5:504b:420c with SMTP id
 e9e14a558f8ab-3e6766555bbmr17725825ab.18.1755568827888; Mon, 18 Aug 2025
 19:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <2d5ae8f6-69f1-486b-bd38-337f0b54f737@ramsayjones.plus.com>
In-Reply-To: <2d5ae8f6-69f1-486b-bd38-337f0b54f737@ramsayjones.plus.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 18 Aug 2025 19:00:16 -0700
X-Gm-Features: Ac12FXwHICdx8D1QrEamPwIwrgRgSwtED0OWZJ9VWButKjfSgrH3ulI5rBijb7Y
Message-ID: <CABPp-BEOVBUa7_sTJybgFsgcwAUMeFFhNJEDVnYp_6TYnqu2rg@mail.gmail.com>
Subject: Re: [-SPAM-] [PATCH v2 00/17] RFC: Accelerate xdiff and begin its rustification
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 8:10=E2=80=AFAM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> On 15/08/2025 02:22, Ezekiel Newren via GitGitGadget wrote:
> > Changes in this second round of this RFC:
> >
> >  * Now builds and passes tests on all platforms (example run:
> >    https://github.com/ezekielnewren/git/actions/runs/16974821401). Spec=
ial
> >    thanks to Johannes Schindelin for patches to things for Windows and
> >    linux32.
>
> Hmm, builds on *all* platforms may be a bit optimistic (it doesn't on
> cygwin, for instance), so I'm guessing you mean all platforms which
> have CI defined. Perhaps you could mention the platforms which you
> have tested on. :)

Ezekiel says this email didn't show up in his inbox (no idea why), but
yes what was meant was all platforms where gitgitgadget CI runs.  If
you follow the github.com link in the text that you quoted, you can
see all those platforms (various windows flavors, various osx builds,
musl, sparse, static analysis, etc.).
