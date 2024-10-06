Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2361A716
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728257288; cv=none; b=k6wvvhEjy4dK7sPRkw2TOemC9hICWAWzLI/X8DCvMa1OIVWyXWrkEIhnlpQu9r3bk2u0kPweoPn/9hc2rZgWiWcyVaQs6n6h14O4K9yDDXsJ0pF0j33bP+zxJ+rsPALhHGE0ZoYymwYPkalbix9NYoaEK+t525GGL0cO0iNHdnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728257288; c=relaxed/simple;
	bh=Wgp3oT6ibiorfZkMQgnWx0j8FDDM8fNpZKySpBRn/B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0q9SVZpl4FRP6Hk6WM6556Dkx9MHlmok3pb6iU58PJpkkLdSsGWCFY0/5CefaQfmUPNnobU+BlFBM2IQdndHvU+CrahAV911HZnlQCxo1eJRCBuXGRGl9qLS0TZaZmlsUkiwyBt1TSmi1s3QxJEOmtHYREz7ITAPylLPrS3Isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb316db199so5814556d6.2
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 16:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728257285; x=1728862085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgp3oT6ibiorfZkMQgnWx0j8FDDM8fNpZKySpBRn/B4=;
        b=qO77d5he0uSSgo0YZrxkLZiftq9nEKz+3eWIa6jJGo5xR6cHZeNOlQ5Qn/w/HeVDvr
         yS7Oia6xXG0mdZpb5V0V6fa1/xsbQn4b229mGh1EdMMwEh9k4AfAOTDrklpJvEjSLwlb
         mgnUj9ShAoMpzRVqGxGZE/hsk1UZCM3rzHEHSX3V3Xadn8FAcq6+gcnhiw/jgDWJjVk+
         t2jM1lYEr71Sjmt/WnrCCw4LVfZkbgxjdH8Q0CMvfCWV6gtAuiPYIbPk40KXzjc+17Eu
         +zHozftuNqCPoR+J2hHSo/cMvanDXsEZ4LLRJOa7FlXGcjcM8DTvbGRl2z1SMWbFPXbS
         4k4A==
X-Gm-Message-State: AOJu0YzC4S4Vva0JTml6FPcNFjqXqyDcYhWT4wooBkeCk/fB8dHS/ER0
	THdHzOTedwVdcIA+i7fDeM/H9SE3OhnWJIurn/7iwhgnWcl14BTA9DR170q8mQj0kKWbmYGXFJB
	cJhM7szPGFi8LE3ywIk/hAjn6eOY=
X-Google-Smtp-Source: AGHT+IF8Lrvq0BNzti922oOLYTR1cPv6x4KQEO0JwI/ZlzGLDP3mAFBmqhd07XwjwHI9R+KUlu7RPir4tu253Nynbxg=
X-Received: by 2002:a05:6214:501e:b0:6c5:1022:6a86 with SMTP id
 6a1803df08f44-6cb9a4661e5mr74503806d6.8.1728257285257; Sun, 06 Oct 2024
 16:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-4-cdwhite3@pm.me>
 <CAPig+cQApvzpuCBfViPD_hJjqe_poFO8uB1GapeVpCd2EWvEug@mail.gmail.com>
 <YYay6Jp5c84h3Tx-LViX4teN5KSBX5PL3_WcOFRzUooFrpJpcBD2SRWf1EQjvrMZsI6zkKyPd7JbWt3Ed3OIxCdkg17fY2qvmT4-B6a0RAE=@pm.me>
 <CAPig+cTKjebbpuy-SCLWd0QMKfHhRyJ81oESNjsUoPDLLNpNWQ@mail.gmail.com> <Gs20QHTpaeb8S4LJC8MapFaP1PN9dJQFgv2XxFKSMDqJV6NvYQ_2aD79u-Yls5ddXmLECCbljzYUdzpPr10QbGKUu_BdP2ui7xo7m-UY8HM=@pm.me>
In-Reply-To: <Gs20QHTpaeb8S4LJC8MapFaP1PN9dJQFgv2XxFKSMDqJV6NvYQ_2aD79u-Yls5ddXmLECCbljzYUdzpPr10QbGKUu_BdP2ui7xo7m-UY8HM=@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 19:27:54 -0400
Message-ID: <CAPig+cTvi18WmEM=wGNfoB6nHDh3zSpoSXWxQLBYwWvrOF3N+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] worktree: sync worktree paths after gitdir move
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 7:13=E2=80=AFPM Caleb White <cdwhite3@pm.me> wrote:
> On Sunday, October 6th, 2024 at 17:48, Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > I haven't yet pored over the code in-depth, so I don't know if it is
> > even possible, but it's typically very much preferred by reviewers if
> > you can present a series as smaller, simpler, easier-to-digest patches
> > than large monolithic ones. So, it would be ideal if you could figure
> > out some good split points (especially since patch [2/4] is already
> > uncomfortably large for a reviewer). But sometimes it's just not
> > possible to find good splits, so a large patch may be the only choice.
>
> There's really not any other good split points because it's
> an all or nothing kind of thing. All of these changes need to be in place
> at the same time or there's some edge cases that are going to fail.
>
> I suppose I could try to split the *reading* of the absolute/relative pat=
hs
> separate from the *writing* of the relative paths. However, I'm not
> sure if this would be worth the trouble as most places that read from
> the files also write to the files.

If that's the case, then it probably wouldn't help to split it up in
that fashion. Artificial splits like the one you describe are very
likely to be more confusing for reviewers than helpful.
