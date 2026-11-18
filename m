Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795038842;
	b=ffLvWpVg/wfT9rfFfdRyt5gMdhWGF6vJ1n+rCdwGh7RZ5aohSTbMFUO4Z98aFjZgTM3N
	 iZWbk1R+ibM7IuM4JiS6VuEjtQtnTCarBJ+INzX9N4MilynTmGqcfj/TWNFO52w5ZUsUZ
	 jnAxR/NoyHg2LhLKKAWRzpiWW/4jlYSajN1Hruelg8gCSzkp8vwiFvPUxZTPdrVhWJ5nL
	 6V/PhELcAaWRfAccD5AiOzBxlffouS/vLK4BlpU6xX0FvT131qVFOb5L0/yr8wEUMBEpi
	 5HKGoUDEV0/Xfle7ilbnXnkF0jU+Pit8XdrBNbZTaTWy2euas0ZiED44gGV8LskOtXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lJZJ8rr6FC/AV0K3bpEexvcKtfB5kRtQmOatowU8Qw0=;
	b=0nGFAjiYkhWrPmn1NAIMarTNTH7KezhWEEE3tryhbijBqGZIMytCdJJkO6YiuFrVpAb3
	 AwiXYm2DTb9O25sUSJiCg4vamkbi+QeY62h5VuwMWNngquSH05qK5nkKZQEaz7WnZXN0r
	 i+HJHTLuQMUfPpmQnSYnuMDafkK7kVks3veji2WCn48c4dERlqHVVRr97/+XL6g5B/Bty
	 UgTt3xMJNy8uVeMVtAPhDpXPLT9PwRqr2P2inWpyCyinJWeoDyDRn/x9oBxcgZpiNzehu
	 xjkvedv6k7kc6Lcl5zJv2wcGV7YvvJxpis553n44EHNjzJuIE1rstSrix+t80TYTg7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OFcwJejc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2D606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA2D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OFcwJejc
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso1104a12.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 13:54:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795038840; cv=none;
        d=google.com; s=arc-20260327;
        b=lm6+To+x0gf/rNsOHeDygzgiO2CGFgJpqVIXneQL26xuZDBDxFJP2UAxSltTm343O1
         jbhStPMOmLJJxI2tSejoM/hgyyBypzv/bYLdVgYlOoPtB+3Oarnu0nCHZJk+u7Obhv1I
         zSw+rDeKokW0RdJPtdewOtVxYKB/Ixo7ilNO/GRQGHqUwzxBbEhcTaru4ZAahHlI6IFH
         WWpbqfRR7jNJX4T46NxPnUnS5X3tvmFz49oRhFMsjS0Ski4FsgYE0LCNxHAQMAiIhiTd
         b8AItfdTKdTieFl22lKWyF5vA8ooYOMdlQuBUlIE0SENWsVSJCQLzJSkNiQ/cA05mjNL
         BMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=lJZJ8rr6FC/AV0K3bpEexvcKtfB5kRtQmOatowU8Qw0=;
        fh=B5F6YYfT659SMP+X3sKz7fgGyyB7ypOpMHWX1HohuZ8=;
        b=kV1Igv7/gxRLNbHlXdMjOluJxrkuWfsX/ljgw4jBKWya4m7iO4VxNDoyYOvh7Z0OA/
         0CVDXxLYKyu43Z0VLu1eIdV8OEWuw0f6Gh0FW4jOVvyGLT14dKtb3EqvYI8JuhQuR8Vi
         qFvO0Bpb3Wg9wcgUC6iilW/BQjRf8c04L5wq6tIjCKcMj1avR+pyIPi9699twGIaLEHT
         1566ZiPapyhTpew8yQ0GLJpMNcqhtleVQFfPwck1lHt9t9hObEBeby2e8HqHaJeHZeoX
         vBPaaL1cKAxFf+r2efsRBWwGHtjj2QSALkD1GdELIfLezPvZjWwtrw2aTGXxcgEJppCT
         uZ6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795038840; x=1795643640; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lJZJ8rr6FC/AV0K3bpEexvcKtfB5kRtQmOatowU8Qw0=;
        b=OFcwJejcHros4S/R5heyCBTf9o8o1zC3JgnP7OmeZftv7SJAig0NPYB/VP2b77l+20
         oeJV7zQB+9ZluaS8THQIHOIYvlzVQFs5ETGiUOshH+ZPtLPMIs2M0WuRLf/Y1apva2wb
         EMjKZMFqm3Ax+vq/0M/YuloLOlBrGnsaiLtPBuAgldJ5tjWKEWpvR9dRIY1QKlsYFWpM
         G2Q1Etu/I/0dyCxTRcvoBasTMBLKbgne7BXMjxu5sLNZ52b/aKLb2KlNaAdV4wtukhgg
         coObaZV7MpJmgB9L83cQ3jKHyROD87qzEmWzvEMdr78ujj2Jx3KFupjvup0eeY0vt2mm
         Zafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038840; x=1795643640;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lJZJ8rr6FC/AV0K3bpEexvcKtfB5kRtQmOatowU8Qw0=;
        b=u6IK4IMm8qqO4xgqles3rPyrJE6XVdnJklb1j87VC/OrRPs5+XhjkcSgDUPHeizoi9
         B+tw5QuA+2ysEM9KII7Sd3XFHdU/d14mDUDZTZiYA6adZBOzt35rX8gVR6YtxmVi1CW+
         yRgjFdKH2RjALYaC/XtLFGApPScGehj/l86jBza/QTboHAD7f5TCtlIftrw4NN01pfX0
         /XiboqmUr8a2krPAWNG1ADM8IQ0lesWzloAq/O1Gocis6k9kL7CY9XbMZRLwp7+SuH1P
         yRZs9aFC6lafsxc7RUU+OYTsTIQAWb5qGWvhTC8EZUecHXWESKmCjjxaX2zqF9x/PpjA
         ofrw==
X-Forwarded-Encrypted: i=1; AL+hErGKqnzkwIp69j3K8ge3wCznePVMtV/ndMYpYZKu8KCLRJlcTxVopXo/A/b+y3FpAOjDCjE=@vger.kernel.org
X-Gm-Message-State: APuU4Z84b56pWSgGOAd0aylM5j5nY6Zd023Nk/y/Qv2qMfzeYUjQ7fmd
	qcKWixkj257YZvoMwUcloLGamo8ezZP8Wu2k0153ftsTccSGKVOGpZMSPTvmGNHn1o1G5LGc133
	/0h7fxoCNFzFj+OKZdeB2ZHmCtQXN/mk7fAZ1Ln9+
X-Gm-Gg: AYBFou3GN/fU4Axv5kML15ipYijgz6HCjNJEgD48zKNeLW337gl73RapTEAk5XIEdRb
	uvKzSiLF/l3wcLdO4ZX00F3AOfQXofD2HC6RonfdyUkr7WeqbWgGx0R0rFmTPRSThpmL/JBhVA4
	ag0kvZ4pdbjTDUMBaAD8TbeH65zuqGi5XhI8CwsnihJqQbv4h3nM1X8RkcubOpA9w1a6iAFYAIq
	f9L5Fj6sXC73qW2vQq6hQIOmg/Dg8i3hPIzYNt8YnigsMP+JobXKyRGyAQcpuVQ3jg92ERiOszV
	BHkhv5Q9wQqEuXe+ECT+KeV2MymbUBZtckN91Djyi/rDTYdahLfWdi6aXIJU3/X82dfhkdmS7XH
	Bb0ELf7pK7jZcDemHKDKW4noR761JMpBLiQR6ku6WU18Mmo99wcvHL5nTUxmHH4F071o2EBdZL2
	spFqCbWVC4TA==
X-Received: by 2002:aa7:d411:0:b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6ba10a57b5emr9811a12.10.1795038839923; Wed, 18 Nov 2026
 13:53:59 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Nov 2026 13:53:59 -0800
In-Reply-To: <av2TgYegy1w-Wi8t@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com> <786964ff00368648e5bd0fd4c5889f7c105d0a51.1794022836.git.gitgitgadget@gmail.com>
 <av2TgYegy1w-Wi8t@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Wed, 18 Nov 2026 13:53:59 -0800
X-Gm-Features: AclHuK-jxeKyEFKWjMuOvBC7Cvg3VWwQ9gOWii0qj3-UHRQtimWATVPM56lsMmQ
Message-ID: <CAF+mdieq6h0UX_xfgO1yxtd-gZE2AuJT-mpE+WCKtAFO4VJzig@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] remote-curl: retry transient HTTP errors in post_rpc()
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> But the POST requests aren't necessarily idempotent, are they? We for
> example also use `post_rpc()` in `push_git()` to POST data when reaching
> out to git-receive-pack(1). I don't think we can assume that it's safe
> to retry requests there.
>
> So I think we'll have to adapt this so that we only do this for some
> request types.

This is a very good point. Retrying a git-receive-pack POST after a
502/504 is not safe if the remote already processed the push.

In v4 I will restrict retries in post_rpc() to read-only services
("git-upload-pack" and "git-upload-archive") so git-receive-pack is not
retried, and add a test covering push.

Thanks!
