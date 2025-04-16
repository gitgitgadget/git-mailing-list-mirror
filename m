Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3691A840D
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818609; cv=none; b=tFYPtiahhzxxUY3uqQifm68vRCbIPM1QO5EV4oydcV5Qq4S6ykO5RdRdBQusPlcZRGEEe7+Yd6PLIWYsbwiODR3KaLZ5sG07pKv+5vGASvJG6EFMaKdBEnTvbdjapPMtNoooJCwj0DLnJDLIYuT+h6072g3iYMmPgL0ALTrzcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818609; c=relaxed/simple;
	bh=L6jVpwlbNpU2RYXhJtX94ASSmsVxxHDs6wEitjg5Shs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AFlxwilTnhvZb7U742j13O/ZiQ4aOfOB5e+wP8Mr1jhIo4x7ILWGLVDthepLt23Yk9nwllcl1MaX33hdE8g2aWNnuisrt96IPj3+5Y6TkXGyj4i4viUYHMxoNYi3zbxsbGgYzuLLkl6mALgv0+VD0pAptezD+syxg++sGrWw/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW9CLpkf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW9CLpkf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227a8cdd241so82674335ad.3
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744818607; x=1745423407; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6jVpwlbNpU2RYXhJtX94ASSmsVxxHDs6wEitjg5Shs=;
        b=fW9CLpkf6Or41WZLgbRlgS/a1ryEiVNZMBeKQLw3dAzmvv2xv2tbcA04t2xYd6+phO
         b8pj0nr/xwo+CKSiNjM0IkzRJCeyUtwBWJx1ccsQnbNYSaaVtW6wFTWjkpXs4uphkTYn
         vECL5/IZUqBSEhlRl5fBWUx5evW9MimujiTHi+TXtRl4eC6DSbpa9fFZKqt7QAQ+Ebv3
         vyLIdCwdy4U8WKZziDrnBxP0UxYWKfPzHXbNOw6ldR/GNRKGoDg3ZqmiNynJe4pgDnNC
         eEANgSrJDZcyV0fkMtptIa0Lf091+dN18KVO+VYY5HWN5JerIwwqUzNa8E/65JmOvudv
         u8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744818607; x=1745423407;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6jVpwlbNpU2RYXhJtX94ASSmsVxxHDs6wEitjg5Shs=;
        b=c1wl7/o/2SOMY9s+FX9t3Ys/9rQYuP69sfWP9Vwo2Rgg7AXfAdjkwgXHPuMgA3GwEa
         MsUz8WNsFNCg1k5ZXkqfFRZNF+7qCan65XtG/8UXRMmLGOKgGxIVubkDFPLsGVnsIDJh
         0sGPhGwuObcKXf54xZ22AwD7ORdGdgZd6PlRaFmQENMDZ47ERdy7WM3UOPxUXnp7kCBK
         xctHNYJvibt4yFfN4R9bbf0CfsOwi3kSUNmVsdQL8lVxsX+9Akaa0GvPSsBqFVSQ+wJ7
         6bBNRSxUj5TjBjuOn8M+zfEjQ3m9MsjOowyzrhHh0TZtmwFrwSSrYxwFReE8KClr/po9
         debw==
X-Forwarded-Encrypted: i=1; AJvYcCVcSCVtET8VxBQ5Ww2DIWytiakx41jRMP6H/atBztTknkzRXqOq9svBFbt8nDDYgLeiSHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6r7LOSZKeYloWA8fI7Ep050mgju80Bl45K0Z5lNdqLuZjlUt
	On0EdLGNTBMvoVZp0caLHH9VjGGBaDOnGSUSwo3FnYB66DTA8+FC
X-Gm-Gg: ASbGnctGe/aSsGBMn7oha4guAbH0r7Mkl329nr9RKH/fNokCRxUGvNnUW2pOR3a31iV
	9Wt5sNojs2XE/W4v/mBdqlg+gxXKUKhjC2FvSOXSH6EO+pAwwXjdVZ+Ebp7tv+KNFKTRxLvsOGd
	jeAFoW6ik/BAUsHPAQcRTXp1oNJ5DtBAtXfaJIS+d/bDpoFSdPkfkjOOy2vY+bjFfsja39M1ctc
	R/vTEQbFcLxYaRAdN+5jjtZw1Sn5K6LFIVSltgXoc8yYwSwmV91NZhOj/oR33ni28vOFtqUmBZ+
	8gvUNSP0HUu5UfteesQNseGsAXC5/UR2QO8QV2Y+suXoGbNhUZyU6LbS2uygj1RUZTJtGwJtEZT
	rejs=
X-Google-Smtp-Source: AGHT+IEFxQZTlzSNn1iObcufmyOzKo6tdUOiVzzNneHZ4bxFan7vCScvmIqlvwlsJMCv9GN9ZM4tCQ==
X-Received: by 2002:a17:90a:e18e:b0:2ee:ee77:2263 with SMTP id 98e67ed59e1d1-30863d1ebc7mr3811113a91.7.1744818606737;
        Wed, 16 Apr 2025 08:50:06 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:899b:9db3:7efc:4ac2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3085458154esm2370657a91.1.2025.04.16.08.50.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:50:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CA+rGoLesZ3nSjruJ8_XRWVsFpMu8mo_4cCOdB-GFHU_qXkXDCQ@mail.gmail.com>
Date: Wed, 16 Apr 2025 12:49:51 -0300
Cc: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 git@vger.kernel.org,
 peff@peff.net,
 piotrsiupa@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <717161C8-497D-42C7-8C10-AC112238EEFD@gmail.com>
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
 <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
 <Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net>
 <CA+rGoLfAidyuomeNym5WX8Bo7-jPcfHx35wDeZ7W2aorAN-B7g@mail.gmail.com>
 <xmqqa58gjlnk.fsf@gitster.g>
 <CA+rGoLesZ3nSjruJ8_XRWVsFpMu8mo_4cCOdB-GFHU_qXkXDCQ@mail.gmail.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> Yes ls-files is also a great example, I will add them in the test.


I was going to suggest you to use `git ls-files -o 'f**'` in your test,
 which would eliminate the need of `git add` and `git reset`. However, I
just found that the bug doesn't happen here:

```
git init
touch foo 'f*' 'f**' f bar
git ls-files -o 'f*'
```

Here (I'm using the current `next`, currently at `fd585f7`),
`git ls-files -o 'f*'` list the files correctly:

```
f
f*
f**
foo
```

I also tried with `git grep`:

```
git init
touch foo 'f*' 'f**' f bar
for f in *; do echo 123 > "$f"; done
git add -A
git grep 123 -- 'f*'

and somehow it worked:

```
f:1:123
f*:1:123
f**:1:123
foo:1:123
```

So, if I'm not doing anything wrong, it looks that it is not solely
related to pathspecs, but related to pathspecs when used with some other
commands. hmmm...

> I think for the pathspec and glob specific commands almost all the commands
> share the same code, so it should work the same for all.


I also though the same, but somehow it behaves differently at least with
`ls-files` and `grep`. Perhaps it will need further investigation on how
some commands behave correctly and some don't. I would start by
inspecting other commands that uses pathspecs (some that I remember:
checkout, log, show, stash, status, ls-files, grep) and see if they work
correctly or not, then compare the two groups and see what differs
between them under the hook.
