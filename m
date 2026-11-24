Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795534021;
	b=vms7+4oNnaS5lzwcyovF6dci6BJZ6AqWeAUi42qw/YsyELyL2pfj6mcvlQ/fgFYXiGH0
	 P/SCDcXUfaEdj76ryRfP1ncUy2FotIWl2X+g90ST60Vvp5NCRCuaEti2Egu6qHh97kTqC
	 mxE1afXiQDtGrQz8FN0dPNKB06Ae3zEVDOEzYpjwAiiZ12Qw/YxCaFApyuKVa9CB3zDOf
	 H1ItB/M8GlpOX4A2MVyGqnm5GCiUtO20rvrMMYPCjbtBM7EyYQBURWkm7ydFdEEL+F+mB
	 9vJ57LwoBLHGnGiFipzsSF+wiWmtW51eb9iOI2fzMRMhE38lnf36dV8xiu9/8whn3RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=z2OeJsVXYQKzp8QvuPqOiV9raofQl6dJaSiI+5oGjl8=;
	b=GrSkODWmIMQgblh3Ch/543PbgHYcxerVjwPeprJXH3xLCMrEE6iscFZMnwV+NNZEbP3s
	 5MnkmVKXtfoLzgj4pEJ5Sj08YAgl/KNsNUgOJajZmDuahKii+3A9rphebGEc1tT/nXyg7
	 esPzqDEj5YqR27vDltM9U9WRb/RMnep8xIFV28Lbj9oi9i0Rx95W5JCoHS2SL1SdB3G/t
	 LOl6L4MCHjvT74TDhogV2pGXg1sDi/zjL9ZggYz7N0J9vyY2fJDrrh55Wqd5UYwx5TXVD
	 C3VYqmx44g2+g9noCerglWb3U3yFWvPAbShXf6/q0Bs8eqbT/ilPBnJK3JdK9IzuXUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0oQ0cjW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FA606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 978FA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0oQ0cjW
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b24f4b15c4so1933080c88.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 07:27:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795534021; cv=none;
        d=google.com; s=arc-20260327;
        b=PtbJ+kPzdePQ6uqOmhwfjufpjhr1JD5XCboqOiJSQZ7B5EWas5+eWrSz01k6BehjkC
         ef+5/yqzrr9SFBsTVIjUiE3FK0wtEAPTLBiB5iuOvzKO4dgcxJD3LhOiVr3umd3Y5SHF
         keyA8/xPPb4VXkKNwocl7DIAeVw6izUQtP95/lCSsBHrt4QVPl3IDzatKCPBQLpq+DyB
         r6Se1vXlqvyzpYzcvA1yg6vss3xFP7a5/m1m1qmCfiz8rC+6qQbBkK5xfoM9C9QI7VCb
         5te2GKY7AmXdraEEtgG/hOugm1sMth76dryHhMyOG4E/oStIcQXLhh7BvnzbmLrgfCfp
         tkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z2OeJsVXYQKzp8QvuPqOiV9raofQl6dJaSiI+5oGjl8=;
        fh=l0UGPw8BQtAny6O0d24j8gItcBLKIQeaw/Dkb3YRsis=;
        b=KNWf/UHVXKS0vfGDUVfzdH66H61OqCn5FP5u1xJ7a4Egv5EYNYYpGqxpx4CLDLhACk
         WKvlhi3gVjfgShwc0nf0/P2MajDa0KOxCv1Ur8BQNs3/LZ8u604mLMg6L+5tQVq0P0/O
         G44vKQLsJteUiPRl9nlM4NRxb7jeCyv5RkV0aONntaQ/V4W4NOqY07iDi6Y2WpxCB2D2
         v4JdRsFSyPgpSfWtvp4ZzqXkUtevCIbAYhuPn7NOM/z0Or6x4ICqMA/3aDMgiiBONaoy
         JEQdVBAI/C001/+t51rcspLvJMTG77a0nPbBWcEiAyTyTwGNvt2/pwntp7n5+dCOIzZt
         pIvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534021; x=1796138821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z2OeJsVXYQKzp8QvuPqOiV9raofQl6dJaSiI+5oGjl8=;
        b=c0oQ0cjWCeJQxzOdZSqdIvLZMEJzS806TdR2v8Fr49afcxmYoA0rGu1EA+87IXjVjY
         STTWw7ZEl827Edh6FW8E9bFWK/ZojEOfBwUrTnSWE4JirI4gxWK/I9eiRTHEM8g9Q7LO
         uq5gh3RQQIxrPeKvypKG9eSAxuR8vmnsOBOBxN2pAmP0l1f6eCImJEP0znVi8CejqjpE
         0i2Qltz7Qq8oMCzQV1SuhON66nhpuGtkRuWOOQJDLz+mTdO5lAxr37EXzxVag52wawoW
         69BuOxnQVCcJyFVwFNsrglBgm+plOwIAnfqNlbTwswENkSGsgt6UceSLQStU8vNhum+y
         1MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534021; x=1796138821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z2OeJsVXYQKzp8QvuPqOiV9raofQl6dJaSiI+5oGjl8=;
        b=E3aZIz0ee+1tLyWjYQJCimP3y4Y6oecLKdipYzf9ACyaNw0Bw4jpJi3fqE/USymNEc
         VUrQU4H4vpdK+p0axuf022fVJvQOJ798gX4XqK+qMUpMQAac3I9XvCDVMMGiNmyggUMv
         4tmmaabsWVKQxXlVeMIFcbzFVEFG44gUhbXSZrvCJCY0Uje5ocJDZjpU4B3rgJZkyRNs
         ZWvtJyVNQTDfasKTWyfj9pV3z05hZJtHExYaHuBJkQdJy1gvau3XC2HPNrHH7YOxh8NB
         YmnJXpbr0lLyR3Lwt5QavzG9t9DJRHiECI8VQizuM0sNyACz7fxYjUoUoHoS2e80kCnJ
         d+aw==
X-Gm-Message-State: APuU4Z/z82CkF5EHzyb5QO/NQS+9LOGilJoYSJkYxbSs/NpE0HOG6nzm
	JH4zEvHNuN8vF989NPyOYJtC+EVwdGG+3VJnbCibGBfiriuJHS/YsHm6ca3WQ/LO7RBOuKHLhqY
	pWT4aTHszQ2P74vJIowkC4z2cSW4Gyvk=
X-Gm-Gg: AZFdTZf2Vr2v8UrSdk57hrHsMPmNLpqZrMvWdZ72KoJsyQaRGdSzU6nl8HUVdRaUqAm
	lRx8m6vVDU4Vb8/oHDOXyv9DeKbQPF3OrtJG8w1rjFpZ+vuU13UNAYsYxJ9d4wvcY9zbvpRIbRw
	NYxpz/XEL7EjcY6LH5+MWzNSQYL4gOQfcqw2fQGPSth1SNRTzTG7CoUXiT1psvSSYP/Bt8QQ2Hk
	OR9ShW8jAusQ89eNwzZXlZ9BOUY+PpXYsa1QEJYlyqJNA+RFK09OnuHaky5oegIPEHAa84NpquI
	csehsHdXT25eOSb7NHDDE7YTLWde3G9DESJERz14eOb1yeoFxEtsU8BImjd/be80qDCMgdSeKzv
	WhRi2a3DoV/DXO/PhOUzHU/rAobU/cKySDC8lqizbzbrLPTJHBcLZDRc0BKX6ISnUYAs0wurlwx
	88n8yooV0yTvEi62NBfVNZyu/nLbTVaEz65/30q4dGob7j0ohoq+hqTuiCxte/K+24fK0sAvQHi
	X8Gl3G/mYIFJFt99j8HkTg8
X-Received: by 2002:a05:701a:ccc9:10b0:1b3:b3d5:566f with SMTP id
 a92af1059eb24-1b5568e006emr14939153c88.11.1795534020641; Tue, 24 Nov 2026
 07:27:00 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqq1p8zw49g.fsf@gitster.g> <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261105203344.48513-6-okhuomonajayi54@gmail.com>
In-Reply-To: <20261105203344.48513-6-okhuomonajayi54@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Nov 2026 16:26:46 +0100
X-Gm-Features: Aa3M54pyqgokB6XhFYiDzAVfASRIuTC9J-w0MTFKxs-2Sr7CiB3UjOSsjVPf7VU
Message-ID: <CAP8UFD3SosDP2_T3aWz-72TQy4yujaEtRH9tM01AxwEkXzmDtQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH 5/6] notes: pass the repository to the
 combine_notes callbacks
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, ps@pks.im, 
	gitster@pobox.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 9:34=E2=80=AFPM Okhuomon Ajayi <okhuomonajayi54@gmai=
l.com> wrote:
>
> combine_notes_concatenate() and combine_notes_cat_sort_uniq() read
> and write note blobs in the_repository, even when the notes tree
> belongs to another repository. The callbacks are only called from
> note_tree_insert(), which has the tree.
>
> Pass the tree's repository to all combine_notes callbacks. Also make
> copy_note() use the tree's hash algorithm for its null object ID.

It seems to me that the copy_note() change is not related to the
combine_notes callbacks, so if you moved that change to the second or
third patch in your series, the title of this commit would better suit
its content.
