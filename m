Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794584515;
	b=dAGvVOLXBaS0xV82VZ9THQ4TSSljb6uvtM/V0mIz20lzEpbbB35+ui/O+5mwLTeeU2d2
	 6XI3Muh5qsLKdhWejK3chhT9AEnuLhjIEd2NDqXOFwdHCPSooKOIseDj8kg7TbiU8puYs
	 g4Z5qGXCRa5Zkv5UsCVjg5Ozfl0UlEuowStur6EIllDdZKbCY+RAJbuw2V2WOuVfJXG25
	 YonLzifeApGJJsngjex/zMLzdqgyhIF7C/EcpTioPONqiHwwM7tZtSjllO2+GbtHLbMr2
	 rORTcr21faT4hd0dan08/9hnMANEcolPDpxacEifpYFNnXbeYvX7o//I2NWkT6Mf0vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ppGiE7FrehG0Z5d1t3V7/PggA593KE8lD8QmDAS3lRA=;
	b=RQpzIRx5dDg3LmV1ddjUmeFKaCV8wiF061wLygF4qgxsuUj6bojZA1J8tzmS0JknRnPw
	 j7BGA66aPT9O5iToxPZOmJZ6uWr3UL+368EJEAuYCcPd3Erd9kg/37lDdv40Q6W8uSybf
	 2/uyrxMXUcP/UlYukAgG+bFMl5PMZf/LGOOosdWvuig+iGHi33jYSzrMqIkt70qPQkMia
	 wjZXSmXK81FHlGmK72gLkscGSSjONMzGfpkzNrI7SVojL4nApKYlR2Ta1In2dZeCRiaI4
	 MLm9yeQiNzXILiiLMxqAIJMH0lDNRBuNt/wkLk8D/YBkkhag/bipB5kgUYYgnurxh1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=kQoeqYBj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA62606A331
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 15:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA62606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=kQoeqYBj
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67c00f291e1so912153d50.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 07:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794584513; cv=none;
        d=google.com; s=arc-20260327;
        b=ofmIxI8P1Qz7WMf31pwtGKM5deCwLJgQKGB20/ivRL98xspnq3ReoeBIynWtsTinDO
         0HGm3OScmI3o7CnWGCC2wr3AVnC7/nmahubbESDYNcNvmiXzw6pWT8rk0/U8Rlbq+wsd
         STOTCaJ0iTQkkUs8Sg1NcHQTK+ZYlGViYt/Unz0KqPC84F3ODMmFXdwh/+SQkMwbDLNT
         0nDAgW1Gy5SGk2taamp+GPjTHbpV8k7SB/caacfUp15pxocCnhyFyRHFdOQCxxiJFk5J
         uF8QwzWNu1ncKFHNOHZyc6hpp413HLS+it0FZSkAZaRi7CCBYL6wTQEfzP4GGRl1JiQL
         X5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ppGiE7FrehG0Z5d1t3V7/PggA593KE8lD8QmDAS3lRA=;
        fh=afT4l7CFaKNMDgnRHHmQ6zQzADEj9pmNJdcxvEC40Ks=;
        b=AghLhdH7+VHEmbe6aJlqpADIrK/OUd7Hf2W4V5jr9jJuu9k0iADCfnl5MzQBH69YLg
         ovFbsP4I8hvZxo20VEBkQOY/X47h5k96OG2mRXPWbKBcsRfhVAFkP/Gv40O6PwYyxozd
         asWjhb99+LAvFN7Or9SqfpjqMGTz/DvOFkZwPppVmge2m6ql8nis7nXpIbduhQp+r48N
         uTtjtZA3OQKFdXQkiVdbrqHX1Iipkvx8DSXQLcE8nb9iwSaapjEDxcsdjzG6ipFnyj0Q
         nowZdCdySYb3YM6WfxDsQ4Tr54cBs6EXmVGQg+vAZgOusYbZavKxBGMHCNjj+GD5Ks6J
         l54A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794584513; x=1795189313; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppGiE7FrehG0Z5d1t3V7/PggA593KE8lD8QmDAS3lRA=;
        b=kQoeqYBjinyAldZ57c2gGndBLJhTqt8IlI6oslgrk+0w+jca0QYiEgO0kV7VfNgx2M
         DdccYqjAFRMK7X8/Qv+negGoL8fv3fzej2wa2axUy8sbtnDadbOuSIotSr98J5VwQGl1
         nJbtg40wsqDF44pdvg8XY+kLknu43nxx7Gch0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584513; x=1795189313;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ppGiE7FrehG0Z5d1t3V7/PggA593KE8lD8QmDAS3lRA=;
        b=PUFnwqVHy3IWz3NWp30rlsAXJpiWpe0Tx9Bst+huUfyMjtvaMprVW6/IDRwW8BKvys
         d3s0irL12Fw0mb/ZiTt0h7obl+h87uZeieliZSjWAWlKvTp6VtOjMjFAZYkkvbe8vNS6
         f11JAqFYMNKxmkL4sC6fqqp9KoQwgsb2Tgn33lt6utC+nPy3nakdjbuoI4KWraqBO6YN
         IqPJqBhuTfsTBCmePT1aKFXoDUAFzHaetivEnQorCqOQLf/zDK4D1X3w4HKAqqS6su9z
         uceSvRW24ieL6wS1G0LLwNKCofrEENX/dmlEGqHuNM0Uh6ZLUo7gQ7XWO9nNs7CZ3pIQ
         8ELg==
X-Forwarded-Encrypted: i=1; AL+hErGkLmjQ07LhvUb+7VbtHTgfkPKE4mCtlR65MyetgT++MjMLRu/3N9Q02DPkL4V/diIK9WQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tg+D46I5i3Dl39TDWzlX64M7ByvNOjOcjoBSufzw5ZsM4qE5o
	owAhi/zt86m8cwJeCPPx1TxZSLXDZ1HfBdxB4fIK6AowzvwklJ1qO5CMK3uXGxg0/xpSddH59ZG
	D4eIgJJxn/C7GFAuIuVWgvMFdSm75aPWZZNCbXdg1Gg==
X-Gm-Gg: AYBFou1M2b9u1kVa7B2Nm9Axu4jN9JO07HNxhoGhchQKwsFIiLu/M7yKOmasAUv6TaH
	IBWr3H73ETZ9xk+sNvHBLkJ0H7XFkoalvGa5OiMzfC8+05vWtrigw0RmMiJ6uegEoOxWqrwhXk3
	WO9eEofMIEWhhxRSwOqX4sdFtuiGdJXdvGzWNjbs0ygm52E4eiiR3lL0v7QSOBNcUsE7ZL1vojE
	I1pUGXP9Gb5oGr90bjVZlZtvN/dU6CCLSk/qLH77477+6DmBbb/r66GrAv2o8LKpAyCNYvNfCQR
	mMQr85DSobMjHu5qX8LHZ19Y01Uh7tsaKH+QviO/fX6r9OhEQHJLGnbfQ2t+wCV8VXDvZLN8gIg
	Ptq+bU3nRzIj7Zsw/s931P1dq9S2PkEbKC7Eamvxms1ePjuYOFi/ARiJznII=
X-Received: by 2002:a05:690e:d5b:b0:67b:f249:5a3d with SMTP id
 956f58d0204a3-67d8963a4dcmr1125273d50.34.1794584513549; Fri, 13 Nov 2026
 07:41:53 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
 <pull.2309.v2.git.1794576606249.gitgitgadget@gmail.com> <29490124-5020-42a1-978f-0f5283ba9e11@gmail.com>
In-Reply-To: <29490124-5020-42a1-978f-0f5283ba9e11@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 13 Nov 2026 16:41:41 +0100
X-Gm-Features: AclHuK9ptrLZw8bCuS5hidAZxx7ytSwXiyl2WLYx1qFhT17qw5v8v0eWz04CmeI
Message-ID: <CAL71e4MZTKK3wmf4TM6DcZdc0-Bt91XaPTHy54rbYUmhNpWcbQ@mail.gmail.com>
Subject: Re: [PATCH v2] commit: remove padding from struct commit
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 15:57, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/13/2026 8:30 AM, Kristofer Karlsson via GitGitGadget wrote:
> > From: Kristofer Karlsson <krka@spotify.com>
>
> >  struct commit {
> > +     /*
> > +      * Must be the first member, so that a "struct object *" can be
> > +      * cast to a "struct commit *".
> > +      */
> >       struct object object;
>
> I think your comment is backwards: We cast a commit into an object
> and it works. We can't cast an arbitrary object to a commit.
>
> But maybe that direction _does_ happen if we check the object type
> and see that it's actually a commit underneath.

Hm, I suppose both directions do happen:

  1. From object to commit requires knowing the type first to be
     safe, and relies on "object" being the first member.
  2. From commit to object could use &commit->object instead, which
     is what most of the code does, and is why I only mentioned the
     other direction.

But looking more closely, there are also 24 plain casts to "struct
object *", next to about 100 uses of &x->object (and about 110
casts the other way).  The casts fall into two groups.

Some cast the result of a lookup function, e.g. in tag.c:

    item->tagged = (struct object *)lookup_commit(r, &oid);

Here the cast is arguably the right tool, since lookup_commit() can
return NULL and the cast passes that through, while taking
&lookup_commit(r, &oid)->object would be undefined behaviour.

The rest cast a commit we already have, e.g. in bundle.c:

    object = (struct object *)commit;

where &commit->object, as used in e.g. revision.c:

    if (get_name_decoration(&commit->object))

would do the same without relying on the layout.  I am not sure it
is worth unifying these, but it might be worth settling on one style
for new development.

> Perhaps instead of "taken from the commit object" you could say
> "as specified by the commit object" because we may actually load
> the date from the commit-graph file instead of parsing a commit
> object.

Good point.  "commit object" is also a bit ambiguous in a comment
for "struct commit", so I could instead say "The committer date
of this commit, without any adjustment.", which covers both cases.

Thanks!
Kristofer
