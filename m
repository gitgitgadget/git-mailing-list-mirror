Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792526727;
	b=VeNvwkkxaw/EV+YiBOts0nUU/nRdcqRIJKczeMsDFYwIDC4UrEctKKdjyAeUEZbb9Wqx
	 RpM33iUeywbV8vGlIPNJ+Cje67oDFiSnvzxrIKw3rAWavS+9Kfa0U18WdggPgh31sdiMe
	 4fuwgkzXzlRApfyft0MJ4Y/yHVcjRn44VViXrKTYo9FuWsIwz9tVO2LqwTgaSkG6wi7pl
	 MkzswPNaGDa7Ybb41PdCSXQv47jGbweGljGlXL+hOAL9oBjgAhO2QiZizMbO4B8tKFCeA
	 2L7/EjoUKJ39tqTcapoiSEAEWFhK+wm8ssZTofAFor6rZIuN/VxpxXALxDlQOm25bwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=QniJClzb0nwujnaCeBfWaNkYn0lOjNO/ol2TeZOE5q4=;
	b=3up+3n8HyGbvIUgdLR6NmPilW1ZHFEs2QH3sljx3Dq2rw+vlKv/c2cem1qJrjenJiCcf
	 /vecMcjZ3SggmVIkx3oQ0Csj8tr3zHjN8vcQziVJOEHy0IUfDDYEgWmoaCFG9q6eo90LU
	 WdT2uZkYACc6DbKXzCjUOUqElw7MS+JN9YrOY6XIoVYae3aC+CFep/r870dVQXmIaw/O5
	 h9MytG7aVbxXwWAP/ajNcSsyHYf9u04rccwCxXPdYMbFV5KaPA7Rt/fJCLSm79DMmpLa1
	 4nd2NOOIQWyk6JGfOauvzauyEBd0zRXSuU99lAMWkmm6cuBnaCIdvzsXUAIP9lMpYyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=imD621NK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19D606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 20:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E19D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=imD621NK
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-49ddddefadbso27316fac.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792526726; cv=none;
        d=google.com; s=arc-20260327;
        b=AoAGC4/KKACAqmSRl0l0AJNclkigC2Akduet+8vTC7DAH+HXvckOIKiYxkxspc3E0X
         Vag7GNEgsHT4IZkDza7dupYEJeopbZedJORzA9+i40cEML70AQaLkZq7EV6U3patFXLT
         doyzLT+FFD1Y7JFWDUUMrtYVUF4djzOPio0eWyvEiJT1qMC9wuD6jIlqaagWSHjUqYos
         bwMkSm+mKz1F1VG3jA2y6U8NQ+ya6brkTIlbOpDDQoKsCbuasQsT6CLgyEpXWnymkZDl
         U56efgSyt/ftZD+VBT6+pSK+rlSzZ+ws7sPv5mmASxHSWoedh/SDRmWv3QX1Ne6S96Vb
         Rffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QniJClzb0nwujnaCeBfWaNkYn0lOjNO/ol2TeZOE5q4=;
        fh=Tczw0obM6Dp6WXaqRz6LMjv/5C+9GaR+vl22Gr1KDWM=;
        b=PaBR4/FdfD10gscrh6VWmbSeiBUImoZRILzgQMGTTZN155ccCxUvJbG8oS2gyXWlR+
         nxIzoXBtjDlM0Od3C89wQDiSD6Aiw8gNFke+Mp9osmQOlzut3FyB66m2tV3vK37BSQ5d
         d0Q4DH+Lvcqq/aQohgEj6UvDkN6DBjMlUDiutWJAc7FOyIibjYUW6qP1vZdycIYj2nXT
         rO0wtjIfoz/9D8qLOKpo6bmMPbZFZxY11nhCk1NoQAGCyG7saeY7jC3WGLufyPcZe0rX
         3K/AZ0lsU3reRElU9pzs/D3Afi7d4DPF2V4H6Rt0Kv8cYJIJs1XQk9uW9ZFvGv0sCkSY
         mySQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792526726; x=1793131526; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QniJClzb0nwujnaCeBfWaNkYn0lOjNO/ol2TeZOE5q4=;
        b=imD621NK1KNKw8ppTdPDkZh6Mm4QlZyykhnlLNANSaInx9BmoNanSKhLD7ljSHX+Fn
         KRSoGLjc0m4uCu6hZoIqabB2xNENuteNotovIGBG0zPpyPYavQQ6zpCwNDUQNE/+FNKN
         Q/V0J76obDiwFyjJKGBooGPfjb5fnD4+jYbGPlXKjytSDTtTAXETh018Js99iuV7sk04
         nspCPMi/eztXMg5O3Im//lgscWyNxKcQfclE6yzND4+zs9ygO3T/zANwe+znqsorcSwj
         BovAZVoTwPLM/X8OtGVFC/ieD4RmeCLIY4PytzZofZgoHo1RDr6YAR5+fb76ozxBpznI
         96cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526726; x=1793131526;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QniJClzb0nwujnaCeBfWaNkYn0lOjNO/ol2TeZOE5q4=;
        b=QaQpU3qx68pAUK7vqYWZmwQaKNlSEFg1bhW3Ab6DlixUNSv5/f9cvFozGJ5m/paRiN
         uZ4rDv/wTVvNAqQmD1NY//JbKlOwJvT4vnHq8/crAg0ksez1rzQkE1FI2wfVEMhQlOtp
         Hvf/7khCaCpT3onDY79ZNHjuZ5lVmVRAPBHuf7T2xSDlT3PhyMEF5Xzc9v1p7TF21UIT
         TY5WSejqdw8teZ3TzFMBJsITCgCtOnY40uuvc8nkt/psyvEoLzef7amdR2yTlJzovpyp
         RUtdxWNW2glrwt9mxcPTdDN/ZHVrKNc5rBO62RrYTf7lmPfRCUHTHF0CNOr9/WVTaH0e
         G0ng==
X-Gm-Message-State: AFq9FYKx4LsK6rgwwYt+9EgYKRGOhKyjmdeyJOgQC2b7TfWHW6v6Qp4S
	Sz60TK8xCj2Y1/SLgLVAl0q79BxT6X/xVETRSvfdNXakIgyND5tJTuecO2VqI1DccV4/zJ2G+2l
	wUe7l5rmHcEfYcOMcLbXCy15yPfBz8mY=
X-Gm-Gg: AYBFou19IzgUP0leFdZId/89Xgh6I1Fu7gdy93Sh5XMRi3yOyBjrTqZ5lD0AGxA1XYG
	hGbS5NwWpbvsb4HYlVQDzKDB8qZOGtce0b1xtJzkrkj13QLrVfsly5REuQgsoebklvICWc0Re3D
	8rBXFp/VCS8pXHuaraUuG+8thlkkHSXlwRARVHDygU6mDsYGhiZmmOgwZ3xUQOie5A5FlZL+IgV
	sXExRI9pxyPTIcBMYJMhteXa7iR0MakQd+tV9QsYlBy2CRyUb95aIJexq8sH588kjk+zjpMj4TN
	No9KJE7RrpMmh4VA3LvGloJYYtM5EPWYLf9OdLlHG0vn9ESiJUEKVQ==
X-Received: by 2002:a05:6871:7b0d:b0:483:cb42:3979 with SMTP id
 586e51a60fabf-4a7578b4035mr10557884fac.17.1792526726314; Tue, 20 Oct 2026
 13:05:26 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018205305.2634339-1-andy.koppe@gmail.com>
 <xmqq33u165dp.fsf@gitster.g> <CAHWeT-Z5OhJLYx21V417DoL3xOQJj6viUzCm+04iDe0zu=jVWw@mail.gmail.com>
 <xmqq7bjcxqkr.fsf@gitster.g>
In-Reply-To: <xmqq7bjcxqkr.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Tue, 20 Oct 2026 21:05:14 +0100
X-Gm-Features: AclHuK_V3HiI_T37xW6nTVjuF7jg8Y2h5oQfqn30WvtRQcvOLC-DYBrCMLYsZ1Y
Message-ID: <CAHWeT-aD9pNEdWHVf+M9dXzav1P7dTD+h4mQ8c4gkrpvdYxTxA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: pin cargo --target-dir to ./target
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Shardul Natu <snatu@google.com>, 
	Mike Hommey <mh@glandium.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> wrote:
>
> Andy Koppe <andy.koppe@gmail.com> writes:
>
> > The problem I see with that approach is that CARGO_ARGS looks like it
> > is intended for build preferences similar to CFLAGS or LDFLAGS that
> > could be overridden on the make command line, whereas the target dir
> > is a hard requirement of the subsequent link step.
> >
> > I suppose `override CARGO_ARGS += --target-dir target` would avoid
> > that concern, but also set a trap because any subsequent modifications
> > of the variable without `override` would be quietly ignored.
>
> But we are already tweaking it with += in the Makefile, aren't we?
>
>     # Rust flags
>     CARGO_ARGS =
>     ifndef V
>     CARGO_ARGS += --quiet
>     endif
>     ifndef DEBUG
>     CARGO_ARGS += --release
>     endif

Yes, but those are preferences that can be overridden on the make
command line without doing harm (within reason), similar to the
default 'CFLAGS = -g -O2 -Wall', whereas the --target-dir should
always be passed to ensure the cargo output is going where it's
expected.
