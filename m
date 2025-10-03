Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F623CE
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476635; cv=none; b=N3nqOlliQBLAsh95IbkyrEBwDaUFmfKB33iI8JnIz1+9kKc0/epoP7S6eIj6juddemZNQ/srb1sorh1OaOXJ3DKSdUDPLIeVhKXcboUKECSXzVn5OW7aoLZvo7pGBmXhTMVX2HEvjevyakw/68wMWZvnhGtXWBeUj3iBua8deWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476635; c=relaxed/simple;
	bh=NPUpOqGve9r+gkBuddat6AYaq9By1QP13VhNlAIlur4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XA2pwPwv4ILEuuthfDRf0oTmMhLdAIm4z3ANXwMCn01CUBv6YzMRlvQHXyTrU5qcu2hkB0GYiMYU7khiKNGg/rjOJAhVTtEFFvtzvSW2GmBmOc6oxNi5vDWbQ82ZlpqoGswqEdgY9luf6pPTPlTUI+vnixBYQIUHKsNDIa8uXtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxURf+Mm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxURf+Mm"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b48d8deaef9so234490166b.2
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759476632; x=1760081432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPUpOqGve9r+gkBuddat6AYaq9By1QP13VhNlAIlur4=;
        b=OxURf+MmnN8wIw5PfsD4m9bqfn7W3KDpehvYALaOusu2mM/XWu+2N01RT5CKfKxV4C
         0hxiaojxcKAB/kCZ6rvbeTkHNNGYF/EYuM6XvSyY2Ll4Ag+vxAVnbRoOdW37JD0HTkUP
         JY6Tup0J4XOVA0eMR6rIHGpa7ICnB30bMD+7uvYV1g8Idd67+yXFWLBXMvIT84zRPEym
         NNxsj98/m3/viYXP/eUIifO5Nlld2DiVjq/0rPEc1zItHm4ENMUeVX2PxUM5BMKwW2Si
         ANk6ZtZxp/emOwyhVm2nZG6pxKo8+ItQlaTu5OLJ+daNLUsHHsZDC19AECdxrdacFOiO
         J52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759476632; x=1760081432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPUpOqGve9r+gkBuddat6AYaq9By1QP13VhNlAIlur4=;
        b=X+UAHrFzQqaAYr3z7vtmn2/fqR3rQdHOUirF1Gp6U4rVY49rAiZve7fwB9akiNcJZJ
         98NSIuXySqSUnQXsR//cbagjUg1GgMRl4m95sNBZ2nUkRGi9YpJMaYJSP0UrBpQsa84M
         tA9kGbiRUkpKWGVUEGuV8StBO5h55PeRTZkMwAlw9B4VuegOqSPWhxAcaHc3U1eo0ib3
         A1nBWV5h6kxiFGXlaZ5mtArdU9r8haX1AYfUauVmx+3bZfG+qKGd6XhC68yQR4M7dkyc
         VL19RRytEXrJge07pkxkwETPbQ/6Ln+h5SZViJhd1AGWpe80hzh4PDU5U9KvKchrie5C
         8mww==
X-Gm-Message-State: AOJu0YwElfB4OfmczSyEWTeRdwECF6CD1CmsVIJeXb+5h+iTljyyjirz
	2c0bqBL4mfk3pTIkcw/da1k/hGg68eGIhKUthmkeT1FlEKI+QjfVZCOqG/GVcNbqFLibzwdfMCA
	Re5OsWlqOiZSv8pHcff4F4VQKq3xFzws=
X-Gm-Gg: ASbGncsulxfNNz2Mqd9h+agI0bkAQcsuYbyKTcXTaXrrJMVdRTLOM4gV2DZkUB0dXrW
	yJAqp7zDrt0ArZmvkwE7nQLvQvmCK4+h9Eu6wizIghdK71QD15CR18aKg21Z2RAsnTx6C/IRP+B
	rLOOnMk/haH3UaAjvNigQQBnDztFa8HDIdOErcCRrMk2qAowyOpNBwI1QN35vOjkv4Y6lpSbJp5
	A/VcMBiy3n6InUwMptWOteiMROTiWo=
X-Google-Smtp-Source: AGHT+IGnZVvqeugXi8AU2k/PQeIlyQjAj01UyPvt8FIdzm1eYe3CJYfeJcuSg3XBhl+hgls3tjpS6sq5Os6+7EClVbg=
X-Received: by 2002:a17:907:3f8a:b0:b2c:fa41:c1be with SMTP id
 a640c23a62f3a-b49c408771fmr228781766b.61.1759476632026; Fri, 03 Oct 2025
 00:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com> <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CAP8UFD0POvYDgGtEx8GBhvKkd8XzzWQsy8XxAKL9M3+uz3ka+w@mail.gmail.com> <4a5eaefb-79cd-4b7b-ab3a-cbab648280f6@gmail.com>
In-Reply-To: <4a5eaefb-79cd-4b7b-ab3a-cbab648280f6@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Oct 2025 09:30:19 +0200
X-Gm-Features: AS18NWAcmyN09fTsdxj6pxXg_24B0otZBJyfRN6dLT5Y8H5GwZ7SpmCyXFmDGjQ
Message-ID: <CAP8UFD1Z1waDT6jxYrfzxuEVz1Jnb2uwP7YbB4a6=AhmtLKcLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, newren@gmail.com, 
	code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siddharth,

On Fri, Oct 3, 2025 at 12:16=E2=80=AFAM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> Thanks for the detailed commit message review. You are absolutely right -=
 I
> was mixing the patch rationale with v1=E2=86=92v2 changelog, which belong=
s in the
> cover letter.
>
> Your suggested framing about considering an --atomic-update option but
> rejecting it in favor of making it default is much clearer than my
> approach. I will use that structure.
>
> For v3:
> - Move all "since v1" discussion to cover letter
> - Use imperative mood ("Let's change" not "This patch changes")
> - Be explicit that --output-commands and --allow-partial are new options
> - Add full stops to the implementation details list
> - Will add Helped-by trailers for Elijah, Patrick and you ofcourse as
> suggested.

Great, I am looking forward to v3.

> Quick question: for the C89 compliance mention, should I drop it entirely
> or briefly note "uses 'int' instead of 'bool' for C89 compatibility"? I
> want to acknowledge the bool=E2=86=92int change but not belabor it.

There are 2 ways to look at this.

1) If you think it's a significant design decision to not use the
'bool' type, you should talk about it in the commit message, saying
something like:

"Using the 'bool' type for X was considered but rejected because Y."

where you replace "X" by the reasons why it could have been used, and
"Y" by the reasons why that was rejected.

My opinion is that it's not a significant design decision but only a
minor one, so I think it's better and simpler to just not talk about
it in the commit message.

2) The other way to look at this is that it was a change from v1 to
v2. In this case it belongs to the cover letter in the section about
changes from v1 to v2 if any.

You don't necessarily need to include a section about changes from v1
to v2 in the cover letter for v3. Some do it, some don't. My opinion
is that it's not very often useful, and readers can relatively easily
refer to the cover letter for v2 (where it definitely should be) in
the rare cases they really want to see it. So I would suggest talking
only about the changes from v2 to v3 in the cover letter for v3.

To summarize, yeah, you can talk about it both in the commit message
and in the cover letter if you really want to, but my opinion is that
it's just not worth it.

Thanks for working on this!
