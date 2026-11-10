Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290890;
	b=18lTm/dhvqer08jnxCt4xgKMM6hDr0dwk1ZG0nGJfYa6CkVrUPkRRZbGy3pRZmLIdGfA
	 ZgUSiIxUrvFqoNo88FT5KxZoWlKEgvadcktnvRMprnDy9VeFPP8ryiEbuJttla3QwsboR
	 UTVF9/s1bJwrj9IFVYFJFeku9TbqPG3t8pqYIMHNZRJRFsgxGXlkAT5hsqoNjzGLPs5El
	 MlA8IuuFSrfTdqCycBdr4iIcsOa25DXkhNIxhIN5ljXe8ZE45pLCCWUNd+hT0zP47BXGn
	 Os6UjwshEGsZ+FXAzmpLNBAlgpaG2g1RpjFBqzOaf9eVjlT62GX5FOuED/rvo1GIj0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type;
	bh=qkxh1qEEmXRD2hOpUbVs49FMq92JoeKbNx+G0O/vqyQ=;
	b=luN+WIHmSrUOUpvMD48+ZCNphQajBZ43XLK5nh53G2SDpX/XY5QgEb5zzNpJIJ54NnfI
	 lM00PK6AUHoyGgFWqcDcPrmobFo0RWfvaufRLbhD4nN9J+hKQ8M3Ym+FaxczX4pUiWzem
	 AJe4qrW1DP9YAUJBI4WfNv4vclrPPg8Y/DAcU5XPTjFDVFbkEeBnCfUd2qPYfYNgmL1y3
	 BKdfcnbzLOD2mRxi3feiSDv4gH93a6XYJnUg/nt9i0Pg3DGsJdoJGcd5WJjDUPt2EkUd9
	 bOY34nI9R3ZBaUiKt88b5fRHIpUCRnGmSEYSfRX0//6GkaDzv98qTwdf6XTUa8fMJaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=taRsn7IS;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8066606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 06:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8066606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=taRsn7IS
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ebdf1c2d1so17838396d6.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 22:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794290889; x=1794895689; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qkxh1qEEmXRD2hOpUbVs49FMq92JoeKbNx+G0O/vqyQ=;
        b=taRsn7ISk+zgUdC3rA44L9u6klQELaCJCDxs6Cbnj+PTCT1ahkoOadvB8oI5U9Ie3a
         E4vONT5Ez78bnIX/ArN1JlfAOX2IqFNNWzCHgWQnSD2SJ2sZXXZbmlSzuRuUv6Ov1dp9
         yLrxdmzSz4QCOpoV4b55ws49WJO2FLf5HLk9NcOTl+2duId3wFifUnYKjrwL9rgZ8+fE
         Q8L+FJ23NcCKD9YByNMQTuQLpqXypG88fSop1FMsEDryymn+dx9EWhSm7KRhuPBkj865
         iu23rIotgv3MPQ4u72SCMJSq7AneagUx+LYuY8AgQKNweeb5Jt6H1PG5AlADjR5i9lDg
         mzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794290889; x=1794895689;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qkxh1qEEmXRD2hOpUbVs49FMq92JoeKbNx+G0O/vqyQ=;
        b=djFeeCAHReMbI4vJ9oAWcS5xN92dWqP7vYqkhFGo8GnyMs349ENXXIF8ZoG8WyCrbg
         ADJq5m71E2obdvt+mUu3SUEWRX0kDTpyFqAcM9q5WXTtRyBzt+Wh44R6a4Mq5aHDdVCF
         3V8kkZ7degFH4sYBHtlvtxJJ82B3ACMQn14fcHy1dEgOArzfjksPKHLTkKzwabMa67+B
         yAo4qEo4tbLu8irj1W3u7j+lt1ILKCVsDLkoeHEaMlncIU0x+Q1mtSzzcn6hhCoiK4Xe
         29cUzSxJx9uvCxlmawZINNgkP0FbsF+r1WD/jN+9URgR8dI6wB1hVnWkiJliRcQNCAGH
         jhBQ==
X-Forwarded-Encrypted: i=1; AL+hErGVxN/q05fsm139tSuS7cjWMyU52PfXd5nGc4EhUZ0CyfZdUpg8n0Mvd8l8Hx4QjJS6Iow=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sYKXXgHcRlOGcnQKKWrZrSpCfWVdV6asfq/6bN+PJjz2VATDe
	GkLurQBrFlHmZXJCHQAGkVlv/fabORuI+zrvNnmBr6tsoJrrjOnNegsddRsBqg==
X-Gm-Gg: AYBFou2eQWR/GQnNI6dyl1cF4/udO1zcxHVz0cE5uxQfBBZVbZbXN9EIVr0/aExQ9Jl
	p2e4ezZ5GKAgo0VzGuGQgE2qT1yqr8J5TxTujnR1KQvSUJENzadxpGoXG5py9kPODY/Gn0t3Q2+
	bsxQle27c+87lH5gj/kNrBOBA43FPuoCkAeqtEEBOqPwjKn36sfwP2pv9mkYo8Rxqr1K6zDfXAx
	igP3GxbuL9AWFMbTeWUhYrSzi5kBuRy99t+mpbmdOx9sx6yWUx/Uqpj8/La5BwwKsboif8BKioE
	QyOGSYx85xY1vUX2mtst5++cM7HHmiK1Gk0UztNzrCZjLN0ryapgGhSL5FEPS2wt9oogKOssv5I
	Lgfug3Z+8RxwwPiZAnRQXGytSC1noEnwxqmLCKfXOq23GGjcpg3w3ThlQfdR0D7JOSWy/StzW3D
	wk+4jGQurpz91kRi1qZOsdFqHUd6+pB9nYoGL0PNi1dgXI4IoUFciKG+Ok9uWxg43JFVb1NDo9d
	grWe24Tg3C9od7lQkKS/A+NRB5wBj+NZ4PfeTZHKj7eRry98B3kzDR2P0Fap8tVDI7/WmlxbH4W
	rcCpVXx46Uw=
X-Received: by 2002:a05:7300:3b03:b0:373:5561:8d06 with SMTP id 5a478bee46e88-3751fd32788mr2738874eec.37.1794290455070;
        Mon, 09 Nov 2026 22:00:55 -0800 (PST)
Received: from fedora ([2601:646:8081:1c1b::577a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751d9f135asm3898136eec.2.2026.11.09.22.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:00:54 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Johannes Sixt <j6t@kdbg.org>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  Kristofer Karlsson via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
In-Reply-To: <CAL71e4NFyAShDZPW9JRB7Bpg3aLY5mY4wdn5m_ZYoLQjHZw_jA@mail.gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
	<50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org>
	<CAL71e4NFyAShDZPW9JRB7Bpg3aLY5mY4wdn5m_ZYoLQjHZw_jA@mail.gmail.com>
Date: Mon, 09 Nov 2026 22:00:53 -0800
Message-ID: <8733t9z0mi.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> Nice trick, and it would work for t4205, which does not care about
> the byte value.  I tried it for the 2147483649 bytes there on Linux:
>
>   printf           time   peak memory
>   dash             6.5s   2.1GB
>   bash             6.0s   3MB
>   coreutils        3.7s   2.1GB
>
> It is definitely fast enough (on the variants I tested).
> The annoying thing (but not a real blocker) is the extra memory
> usage required and I am not sure I fully trust that all
> implementations will behave the same for absurdly large padding.
>
> (Particularly for paddings larger than 2^31, as you noted too.)
>
> It feels a bit like a hack, and tweaking the existing test-tool
> feels like a more sane option that is easier to reason about.
>
> A gotcha here is that the printf hack only works for producing
> "0", so for the cases we truly need NUL characters it does not
> help us, and I think that is also a point in favor of
> simply generalizing test-tool genzeros instead.

I've mentioned this idea on coreutils or gnulib's mailing lists before,
but I forget where and when. I've wanted to create a printf variant that
doesn't allocate much memory and will just use putc_unlocked for each
padding character, which would avoid the memory issue you bring up.

Most platforms will be limited to INT_MAX there, since that is what
POSIX specifies is supplied with '*' [1]:

    A field width, or precision, or both, may be indicated by an
    <asterisk> ('*'). In this case an argument of type int supplies the
    field width or precision.

E.g., in an invocation like this where the field width is supplied with
another argument:

    $ printf '%0*d\n' 5 1
    00001

I think my original reason for wanting a different printf variant was
escaping that limit.

For generating bytes where the values don't matter, in GNU coreutils we
frequently use 'yes' for that. As a result, the implementation is very
overengineered. E.g., it will use zero-copy since coreutils-9.11. Before
that, it would reuse ARGV if it was contiguous and the arguments used to
determine the printed string were long enough such that we weren't calling
read/write on a tiny string, or it would generate a large buffer before
using read and write. Here is the performance from before and after
zero-copy was introduced on a beefy Power10 machine, stolen from the
commit message [2]:

   IBM,9043-MRX $ taskset 1 yes | taskset 2 pv > /dev/null
   ... [11.6GiB/s]
   IBM,9043-MRX $ taskset 1 src/yes | taskset 2 pv > /dev/null
   ... [175GiB/s]

This was introduced around the time of the copy-fail vulnerability and
various zero-copy vulnerabilities, where there was serious consideration
given to nerfing splice and vmsplice. Luckily for us, that never
happened.

FreeBSD, and therefore, I assume, macOS use something similar to our
previous read/write method, which is fast enough. I think OpenBSD and
NetBSD use puts on ARGV or the "y" string, so it's relatively slow.

GNU 'tr' doesn't handle multi-byte characters, so you can adjust that
output if needed and remain relatively quick:

    $ timeout 10 yes 0 | LC_ALL=C tr -d '\n' | pv -r > /dev/null
    [ 616MiB/s]

I'm not sure if macOS 'tr' handles multibyte characters. But it might be
worth checking if they do, and if they keep a fast case for single-byte
locales. Doing that without duplicating code is quite tricky, which is
part of the reason why we haven't done it in GNU 'tr' yet (but recent
releases have improved multi-byte character support for other utilities,
so hopefully it is handled soon).

Probably more information than you need, but hopefully it helps you
generate slop sometimes needed for testing. :)

Collin

[1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/printf.html
[2] https://github.com/coreutils/coreutils/commit/2b1c059e6a06eebbb721d010b1221ec54200cc33
