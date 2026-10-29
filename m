Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793250077;
	b=hpbocMvaq3MJvMUDavZ4DpafBaqtJFea8iFU5mBxtpiYg4S3XcexUoTVVYlM0DuT9X86
	 ivc3IjLujspN4NN2dWQWFwJKSRwQLpiQvlfSBskYDwY1MMJ6zOxAK/fYWLevDDo8AaVYh
	 EQQSoEkGq76O39m2CW/BOvykcnKyp+R+NviVVHJZm500ppCZMRRWGBJPV+4Ss2l/AeXI8
	 bR14YRnD86ulvS5AaNbaLCmG/xr3U2nUE/bix+0ECBnVUeT79C8nzYcIiAhfGOEReFRKG
	 7iIDu5mG6Hx2iFpY0sUJr9bmsB05fEcuLEq7/g2+pRB6WQEzHO9UJvyifMjO/F5UdVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250077;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JlrHHP1ecKmQGQVHsULDQVnR7JwDw1zxBRl+0bPXFxM=;
	b=YIu4oK6ToNJdzl3ysHgUuJUH0vm66FhYhzBVu5J8bLsjGuSaDVbeC3FEjpcZ202eUZ9u
	 k3NTLilPG38Iel4NhNU0VXSpbcshfN28opQqr4ceoWYj/CUJvMyu8Ni0NmGAcSThdU9IF
	 ZAxgOrlp63zPlOejmMslB1qU1k/+nch4r0z5/8vBVV6RAsx10x2MLL7a5vPXUPfI8KnHf
	 KtkTAksr8hB6Qp46CyYEjUPNj0fc3nC8kqt6UN6Q83a7DgH1xadKZWmxee/hH0Twqdoi3
	 adidmT4XmnG9bbW9bpM/KmIj+SUhvxB8HcwfmL+kGFke+kdGndeFg7S6ZEH1TWoeyGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=fail header.from=sunshineco.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850AD606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 850AD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b126b23502so1844187b3.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 22:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793250075; cv=none;
        d=google.com; s=arc-20260327;
        b=FoF3YxdTgVxzu5QwDgRGKZLS0y9C2qrk1dZaaq0Kct+V/ZhIAg0nICR41yF2swuJ43
         ESR05jq1hjL/9BhfFZ9aSXeh+uE27d3wGAPyuQUN7aqkvS0czu2gvO6q7Y/kPDwMNw6e
         qKztGj1WQGoZurP0PqzqkWu4zmI3PQ1SVci1XDpYcTDn3eIEZwjTVOcqf/0JJUxL1r+f
         x9ZogZqtq0jEApve/sOHJQuJ5rU5+K/9KV6tHHVPYX9PJBfr5AzVYWJwkezPOrVkQFs3
         FxlKnEMwYjTbf8KCAOVrpIpmNTeArake9gfgTY6AKCKxp+9/MDqIUbciQmxiWf8guHeD
         o7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=JlrHHP1ecKmQGQVHsULDQVnR7JwDw1zxBRl+0bPXFxM=;
        fh=g71Eko/v5KK1lF/+7ozCORE5J/eOto2X3hRcqBkdLGw=;
        b=sibxarwvjntNLdJ99RJvAU8nAPw0WNI9WV+hpl6rBVe4XO/kU9Et5msVt4cafUMZf2
         a45t4xBRN0F9UftqN3/xIW2JbgKymIfeHRzPnyKH5RC8sYup1s9D1+sIe+iX/GeHdndb
         B8bXCe+KfunCiKZNFIG6Is6oD6bajycAPHrQ3BQRXK4YdnNfhlbVtt6u8yJguzUwuUKR
         pZMiUPNJwhs9mSAuUusks2xSl5gfjr+xZQTtas+pxA4moVeFZJF2JS2oEGV8Srt65GCQ
         dNylVM7xS12PmFzultFhsz7MxqnVj1ULk+3Of0eCqrkaGiZ5MviaCUXxT90v5NlkxF1n
         P9Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793250075; x=1793854875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JlrHHP1ecKmQGQVHsULDQVnR7JwDw1zxBRl+0bPXFxM=;
        b=Y8StkAvR14nnKZ+yLdqKciQYv9BiIS4r3fsfSd+y+U2XlqbvEp4mXQj9Q6REa/uf7U
         098+ChD+dBWsNrwE4si4ilX6yU4PxEaJF+X9tfQqMCnxS8Ocss2UP9oNtoGwYLtkRb2q
         irhCYgli5u94r284/arXl/cAbUIImIS2r3xdoHynEmulBiJSLRlw/X8CNQ7VGNMjgR90
         81354aUu2GvAhAWVw198jtQMSmbvBaNcld2PHjj9XV9lw5sJd20Q7uJKp+IBdoHUZNFc
         CxQJ74V6AX9bDHu33GJwrw8aIQ3R+Cma0ZUqx/yCdAn9IkQrFS+cjiTeGkslTpG6Zv1A
         mo7g==
X-Forwarded-Encrypted: i=1; AKwUvBxjTaFxuC7uiqqQEltCT6eXVTsgYTSPCMOa9Aj5MSFfn9QnSSKRAsHRV3QJSJMTdkn40AI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJRzQOYWcnnTVu9Dz692MKpju1wu8kA+rXO4FSpMlpYgHOQeH0
	vy497cWs1+qhviVKZeQDzFuOnSbAayfUrAkIUhKh2lRc3Iw0k0Sk0/DCX0EIvn5wIxJnD1RKVNJ
	+I80j0BnlNJlZQspFzvTUv4FX8uzwvbc=
X-Gm-Gg: AYBFou3EzaN4dpoRst5d8VJquc1V8mhZCXiXtDj6LRLzVsORP/m6tXYKvRjgFitrbyk
	kU6H9pmf2RgkTx9wIwPN//C0QfNlqQp3vIHDTZQYUnyhq7RrRYN2b3gz6UmqkCmiPx4db5Agcpf
	gBDi//ZmS8J4QiZHWgL1gd3EP9zRVfXUadZiuU80KbRArb3jcyEulsyFy9Bpqjm8b5y3o+zeoyI
	l3mTTH1bsWtyjxjzggaofK24/zWQsJr6zE4kHPdIxbwgg02gwW9wg+53RPdyRMDZlDps7J2NXsO
	UKV953SzvEdxm8Otx9k1t56SmgBlJiPcRPzaxrLpp51dnotYfpr1mRbX2Hr9PFsMU2fZriqaHuF
	UWWqHSu37PDkD0rR4Niz8aqJr8nX3H9ujeUL8CmjQPJYN4j8UQmZ8Dwdl0xcrQveGNioHRg==
X-Received: by 2002:a05:690e:130b:b0:679:a56c:e2e9 with SMTP id
 956f58d0204a3-67a7b8079famr5125414d50.0.1793250075314; Wed, 28 Oct 2026
 22:01:15 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ad504925-cdda-4de6-8791-97a51a9d90a3@app.fastmail.com> <20261029044633.12429-1-me@jaspermayone.com>
In-Reply-To: <20261029044633.12429-1-me@jaspermayone.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Oct 2026 01:01:03 -0400
X-Gm-Features: AclHuK-Naz81Mu3O4-zPlxzdbKJZAFxgKHelwBkOwuh-kNzFtqTX6NhEhuYqMzY
Message-ID: <CAPig+cS=u5pDyMxkT-cw+Wt3qfxuFuvmFm0Qm19_mg4JK+Mxdg@mail.gmail.com>
Subject: Re: [PATCH v2] worktree list: add --branch to select worktrees by branch
To: Jasper Mayone <me@jaspermayone.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org, gitster@pobox.com, 
	phillip.wood123@gmail.com, haraldnordgren@gmail.com, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:46=E2=80=AFAM Jasper Mayone <me@jaspermayone.com=
> wrote:
> Phillip, thank you for the review. Your point that "git worktree
> list" output does not say which entry is the main worktree still
> stands, and I can send that as a separate patch if it is wanted.

`git worktree list` guarantees that the main worktree (or bare
repository) is the very first item; this behavior is documented. I
think Philip's point was that once filtering is engaged, you lose that
guarantee: in a filtered list, if the main worktree has been filtered
away, then the first item will not be the main worktree.
