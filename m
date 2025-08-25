Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F221F5619
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756149399; cv=none; b=Eg6ycaXf47gLGMWx2sA3hg2ZqWYi0wqWDIwmvsjHVXEpUQDs5laHjg7b4uYbkbBklSNBRsUl6rMeCo4LBKpiyN3A4jsCaFWLY+25S/V6QlwGXZQE0hZdF2GNPURfC6itxtrKXRZJc1LN+iWKe/dkN0a2baIwAvd+1am9pucdNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756149399; c=relaxed/simple;
	bh=YYKo+ED/QAvz3na657FvzuwqG5936VhA4LZ4XeHHkXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rknXjTEGOIQTYwzmOU7Xvh7V8EbPiklpNRU4XBwCS1RBiXawubfMRt3SPT1IabZIA+7vEHjoU1Nm2akq4g1Bd8G44eRUTKEhFlRjH/i7FzCoU/4jI1y5SiT7+jsR/7LygSHahd8+OHWxEOfZW4n22vIrvQrEVK9Yen4dqZtOv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhw0yEl3; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhw0yEl3"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e854d14bdaso46926805ab.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756149396; x=1756754196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rvHWKUf3JZQ14uuIpngysybWXBGrMYPWoefeD6KZoo=;
        b=Rhw0yEl37LhdqyusDiXiRHI7FExFtMQflzvDJuESiJwpmhjulVMJQ/XZ7NA3qyG0DL
         iRr3nlWd/JWRVfhpQr+I5UGj8AEfBb4j2a4RGihBpWgsKPzksk0OKYxU2UuanpR7Fvst
         dKwg7jjSNBM201NY/Uo/PXN9OSoB8cMBmv4i3l429Hq4lfpNMprQeYn1DdJnDSmiob5h
         snZ9yQUnM15uYmP9aQfDb7lulQZbh3Kony3CdHavGuZ5+twMhWHZBiY1sfveZDlORr/4
         mCT96vKU8A4kiUeuntMsHEXVkwqDKoyK9R8UDCWtWolgkQBytuQ7k0GmpGpGdfGdq6j/
         SCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756149396; x=1756754196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rvHWKUf3JZQ14uuIpngysybWXBGrMYPWoefeD6KZoo=;
        b=gauDwjZyMWzNw57rabYsmtJsHPeH/fh4QXo8PtPfoyKN4Dol8It9ut9Vp3dgVeSZpt
         ZY0Cd/sYAPwrrBGxP3KLeleOiUXpHoVKNb9fF79+EqeFaktyLur35Qme1a/c1ygKCVWY
         HiTw5GPH7cPrO84RtZxVnZWAPTPMvlz9LpA0+XcY7Dqb/LjZDmlUHoebXiM9WdXC8p0h
         heemCHnjuPTp6vf7UV9kbqCTsoo/vXltEY8guCBNWby4obCIcqZlYkBcXOk5TdumtJd0
         rKVmcQu+QFm8nTTMJrKDeqY8Q6dBDu1DHYajg5a9noJvAHlGY1A5AUXLGjO9GzCFKtoI
         q5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiCFv2239UhEDHtUTY2BKGLITCmVZCCblhBfe6O0CkY4C9WgBodY6oLBydaS/JJH0YvC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGN5B3aPQz9gout+5F0mbK3kqDHF5B6impIzq+hIrASPR8t/uK
	vuuUpkrWoqkfP9xBVoTNMzAOeU8hMahP7795EiV9tanHGL1ZKG/KsJnYuZCmWIPbzdrpdWnQiFA
	Z+PgRKwODIP7ilgjDuiqYhtZFJ10CaxM=
X-Gm-Gg: ASbGncvf9RCtkzf2kBDrTf83tlzubYfqFt6jpcYz43+ky5gda4sxlHxELsRxJiEFbSP
	ukWuTR6WO4NkEKl48sfKnsX+PTfb/xi9IAHrdyks2aMrWCloDWDGEiSGnz58ii+hXv0eAozcXHh
	rA04FWoRGlzA5MVx/N02hoN/u2MtNOlMdFPQXB9NAyxDbdaZgaH6b/kty+WeD6n8BgBbT3D0gIj
	trhKahNx1NaxM2VwDFPrWjP5lm0kPcA074SVhE=
X-Google-Smtp-Source: AGHT+IG5fwnahC054VwOtp0QJHl9asvGxvOs8DrFaQIn4qhZmfzq9GdNQEjyWFtNgobLu/IyW2epv/RZHEAFIqM2qyk=
X-Received: by 2002:a05:6e02:258b:b0:3e9:eec4:9b53 with SMTP id
 e9e14a558f8ab-3e9eec49f04mr165195565ab.26.1756149395983; Mon, 25 Aug 2025
 12:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com> <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
 <xmqq8qj9vrpf.fsf@gitster.g>
In-Reply-To: <xmqq8qj9vrpf.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 25 Aug 2025 12:16:24 -0700
X-Gm-Features: Ac12FXwwiC-87vmfUJ_XU-kB52b3mzZY8Hhc4YxiVqL9v4B9XSUyGmGWG08S4c8
Message-ID: <CABPp-BF44xgh5uJhCKXE8aSN5otyHOAJYNqB_bfLj1Z7_FANCw@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is interoperable
 between C and Rust
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Taylor Blau <me@ttaylorr.com>, 
	Christian Brabandt <cb@256bit.org>, Phillip Wood <phillip.wood123@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, 
	Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 11:05=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> > diff --git a/interop/ivec.c b/interop/ivec.c
> > new file mode 100644
> > index 000000000000..9bc2258c04ad
> > --- /dev/null
> > +++ b/interop/ivec.c
>
> Even though this is a shim to somebody else's code, it still is a
> part of our codebase, so our CodingGuidelines for C programs should
> apply.

Sorry, I should have caught these in my preliminary review before he
sent this off to the list.  One question, though...

> > diff --git a/interop/ivec.h b/interop/ivec.h
> > new file mode 100644
> > index 000000000000..98be4bbeb54a
> > --- /dev/null
> > +++ b/interop/ivec.h
> > @@ -0,0 +1,52 @@
> > +#ifndef IVEC_H
> > +#define IVEC_H
> > +
> > +#include "../git-compat-util.h"
>
> As we use -I. on the command line, there is no need to add "../"
> here; just writing
>
>         #include <git-compat-util.h>
>
> should be enough.  Also, if this file does not depend on the
> services compat-util header provides (and I do not think it does
> from a brief look at its contents), it is better not to include it.

Should this rather be

   #include "git-compat-util.h"

with quotes rather than angle brackets?  In particular:

$ git grep include.*git-compat-util -- '*.[ch]' | wc -l
362
$ git grep include.*git-compat-util -- '*/*.[ch]' | wc -l
125

So, we have 362 includes of git-compat-util.h in our codebase, 125
from subdirectories.  Of those:

$ git grep include.*git-compat-util -- '*.[ch]' | grep '"' | wc -l
361
$ git grep include.*git-compat-util -- '*.[ch]' | grep '<' | wc -l
1

Only one of these include statements uses angle brackets -- the
compiler-tricks/not-constant.c file (which appears to be a temporary
hack that we'll eventually delete).  I had always assumed <> were for
system includes and "" for project includes, but a quick Google search
shows the actual situation is quite a bit murkier than I'd realized.
Still, our current project practice appears to be double quotes; is
that fine here or are you suggesting you'd like the current project
practice to be changed?
