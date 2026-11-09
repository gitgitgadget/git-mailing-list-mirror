Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794208260;
	b=sOnZsKnLNaqMPDpVKv2RS3Mf0I8nSe09u+7RX9OWvmiKHZCkU79rjeVZFSPFuU+LnxsF
	 4BOh9XQwP+9WT6VuuZuKT442i9nQGtrwv7OJdCim5OoC4nY6VCV9fhBocJnMgKg13zy6U
	 ebAiTaTTATj3p6l/KV9V042h7xjkAZC32XSy2FAFlpDpQtEDkBKViyIWWCgOXDieD/818
	 teVaj0UJ37yDW/2siG3vuJVFhDGOMSf5wTxi6JSdWu+ibtNfOE1BAP6J6JGN9wjMa2OA1
	 uuV4HP7Fm7iTElbOAmzrflc744zBhi5r9bVQw89hoD8XzL0jTwv16AzwGiYWd2GKBAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=MYgAc6sMbqqm7pvxW/JQAbPm9nj8+wzh4u80b38BR4s=;
	b=yvuihQi0E3lLHxBXY0FybeRPTxYjQHbcnUOduymDLKFOr3WCiC9HIdrwfGDniGFB9y8s
	 0jhy3kdG+LtVYzcAh9vj+ZP2NkwcOaEt/Fyg/lCKZm1FG8JP7tzWFIZfvzL446dazcquJ
	 6F7iF0ynu6vLhQ4PvjXiYPFW6kUECcg9xV1pa2BsoFcSSguN9K1ey/eSTPqXZWrnmojhM
	 vwLpxunuqDD6qDvkomXzukQ1ExEIND2eqDyybOnZ50fZuFIC2L2rVdEu5Ofyd1awyKoUW
	 f26UiXZiQgir8+DL3MeYzH34Wnze9epZc5Agj51mKtJr5Ze7HvYW882x4JKJGrtI8lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=FkTelz05;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3E606A33E
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 07:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D3E606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=FkTelz05
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso74743666b.2
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 23:10:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794208258; cv=none;
        d=google.com; s=arc-20260327;
        b=s91poLOZ2WW3CAWD5zjMehabw4lmPOwJNQuH1CY7RtlseGLUxQqfGw2ib40vmtVcoI
         LQhD9BXshQD3pbHULVZiKQj6NndH+OGkrl1uPneUKbtL2XXXh1dABeN+QPaQJX+41glj
         A1nJjMvPs7rkf4Mty93JOf0miWzk6p0y3zqvZqJuYv9opoAZumN0/2PLe68JbssgIRw2
         sCbOeZeaJVGG9HhYlYKddnAEoRchThSf21jHYAK6WHPdj6EZS71lu7B+oJNI3w0F2q4L
         LJlxOV+gRCyC7VhG6qnCD9p5iVZR+F3SbY/iwuog7wDOXIUE95AGD8QS0I5Pddt4pP66
         arMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MYgAc6sMbqqm7pvxW/JQAbPm9nj8+wzh4u80b38BR4s=;
        fh=4jkUSrW7kLLismh1gvgu+5z+tFgQdA9TNAFty1FoBtU=;
        b=UCJZ3LfxgDzXZCtYRuv41hQdEgK0ahkH42t4SfVtTOTkNiKebof/KPxBCpKRDG/buq
         Wwg2H1T13usdAs97P7KXfhai9rR4AEl7F3YHaEeh9oizsUw9DUIglME58jG/UIuX/Sek
         7VXqJpNvbYx5xgP80uuH0hL8h3pIHEpiPmnYKwGKvH7kzYn0Tj27cU69/PxVdfiy6jY3
         //NJurYYlHC49PbrRfwgs6pZmZ5SyYbu+fq4sDBs33A4seX9dF4qG2m/gmxoGKJ7nra9
         YmzVJq2Os74ojKfRr5nfXhYIPT2/JdQHkylvT9t+uJ1iC8NJ4fJENVMD8lBGMef4J6fd
         t52A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794208258; x=1794813058; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MYgAc6sMbqqm7pvxW/JQAbPm9nj8+wzh4u80b38BR4s=;
        b=FkTelz05F/R2vv4kZffYAnoJVwRQJgqf13gDZenqm/C97pGTLEBtt+imK5C6QYEadV
         Hr4iloRV5bSBNQOUwLAIp03HlCEWOpc+q2QybpF3DpquzZlFI+Pez/XfnAc6X4vd3Ig0
         vh8zd+8dzSUBF9kRrvNY24Df+2xIPjGQPfrEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208258; x=1794813058;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MYgAc6sMbqqm7pvxW/JQAbPm9nj8+wzh4u80b38BR4s=;
        b=B89ratwIpr5/j/1BiA57Zyu0Evw5Sx7anmtrA+c2PVtuBVRcJ7b1GgfUfGkbIaHwXk
         wgPT5iK6bfcOmYD5UOzfPP/odWznA8gq8AlfMZQKNeu7UDFWbzD55hzAg5FZbbWhx22G
         Tcl8YAWlGeKwXnIU6dObTJTQf1tz5xLsk/h7tAFBqhZOfChYFeIFHQW4VfAGls3gCw4w
         +PDQFAlYgnm14CeZqdXGq8nixeGmf8yzYsdpBvmPdhnkevjWnq54KHvVfofnFrkugvTP
         +ikFfgjr9xxoQBDT1Thc8DUIfSY9e+CV4B+LEZFPJQj4zgx4g+d0rdbC3fJeggBDRzq7
         Tq9w==
X-Forwarded-Encrypted: i=1; AL+hErHSTx+sUObbiRp06LQ62r5OwUnBeenSAPnVhObGISK7RXxBAVnQpf06RsFF8wuiveMJmQQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CdWfQqjsqMbkxNbLA1yKIun1OUL/LlMcKQ3r1NqY6xsWrR9tk
	/MxyDGhvQGwpPJRas003dMFjN2KFfs64reP2iNuNKfJrTbUK9b5BXOVP9GsPlvn7hwSof0RyL1n
	kMUDDYBXJ5qkQ+8zMVGSflRJ5iKodNMDRs/4Q7rFDBg==
X-Gm-Gg: AYBFou2HPsX7O5tuqnhweRpRE+gpWrfy5xjbpZFQHrhFpqtCZtYh5B/m5oBWgLo4u3q
	aoq7IuA0qdeAhvQWTYkk5WvDpwpBRpHaXDsFumRLfcrkIJF2pY6Fz88k8+oJIDJmYk21Ed1TDub
	M65gp3K/Wu1JpcrSOsbp6jOb9blGdI0Warv8STYHkhni80ctVq+PkOlazMU7j6VFir6BOmXM9V2
	4vfzPcVUiSf187VUdBtiD2Pxx2niWgXRqwfGMdl7kh/OfkTUerA4LuqLyC6GV5+ajCA9CwqVzif
	qBEkp+f3avIckSifUkAxCX6aAC1bXLQaxeboXgoi6yJz3oSu/Gqenx74xUrO4ngMvidplpmDftT
	3HwBy5mMJ12nTDItc8tRPpsqFDxVV1GA3jzijfMpd9+1I5mWZlWvIwAWT6nI=
X-Received: by 2002:a17:907:96a8:b0:c42:102f:15f0 with SMTP id
 a640c23a62f3a-c4d6d15aa75mr198848966b.3.1794208258486; Sun, 08 Nov 2026
 23:10:58 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <pull.2301.v2.git.1794165304.gitgitgadget@gmail.com> <54139a3a97127732e11fc5abbc9a3687542669f6.1794165304.git.gitgitgadget@gmail.com>
 <xmqqeccu3hqq.fsf@gitster.g>
In-Reply-To: <xmqqeccu3hqq.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 9 Nov 2026 08:10:45 +0100
X-Gm-Features: AclHuK_9fmV1aL8ogZu-vsADRDpm5nonbpGlzqsxWy5oW0pskUCrxwpWHIs_ncA
Message-ID: <CAL71e4PkS0dRvqSkL81hSPO3M3K2n5ZTumFNvCx9MsBsFKbnmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 02:39, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/t/helper/test-genbytes.c b/t/helper/test-genbytes.c
> > new file mode 100644
> > index 0000000000..b760326b24
> > --- /dev/null
> > +++ b/t/helper/test-genbytes.c
> > @@ -0,0 +1,61 @@
> > +#define DISABLE_SIGN_COMPARE_WARNINGS
> > +
> > +#include "test-tool.h"
> > +#include "git-compat-util.h"
> > +#include "hex-ll.h"
> > +
> > +/*
> > + * Write "count" copies of "byte" to stdout, or an endless stream of them if
> > + * "count" is negative.
> > + */
> > +static int generate_bytes(char byte, intmax_t count)
> > +{
> > +     char buf[256 * 1024];
>
> Allocating 256kB on stack may not be a great practice, but this may
> sufficiently work on most reasonable systems, as this is an internal
> of a "run once and exit" test helper function.
>
> Still, the stack memory for the primary thread of a process is
> limited to 8MB or so on modern Linux systems, and I hear macOS also
> uses 8MB.  I am not familiar with Windows, but some documentation
> found on the Web seems to say that their linker gives 1MB to their
> product by default, and among 1MB, 256kB is not an insignificant
> fraction.
>
> Again, this is an internal of a "run once and exit" test helper, so
> declaring this as "static char buf[]" should not pose an issue; it is
> not like you would need to have multiple simultaneous invocations of
> this function, each of which needs to fill this buffer with
> different values.

Yes, I think we have a few options to choose between:

  1. keep the previous static.  Technically this means that we
     should also document it as not being thread-safe.
     Currently it does not matter, since it's never called from
     anywhere else, but there is a slight code smell to it
     since the buffer no longer hosts a constant value.

  2. remove static and keep the size.  Since the stack is not
     complex or deep here it should be safe.  It would break
     on platforms with a very small stack, but since it's only
     use by CI and developers any breakage would be immediately
     obvious and easy to fix.

  3. remove static and shrink the buffer size.  From my (limited)
     local experiment, it seems the buffer is larger than needed.
     We could shrink it without losing performance.

I don't have a strong opinion here; I went with (2) because it
seemed like the smallest change but I'd be happy to change it.

If we go with static, I'd prefer to have a small comment
above the function definition:

  /* not thread-safe (due to the mutable static 'buf') */

Thanks,
Kristofer
