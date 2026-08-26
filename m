Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB73BBA03
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736087; cv=pass; b=GiNJ8fj5SkFIWhLsxwFr1br3Ip/7dTjMnJpvjFteO5mtQFwdkRGP5N3kX/9PFsV9mAAZAwmKaLPyXb0U1PgdMiXBqz+lKv41z56ckW6nJiFzBgRK5IbjTkDX4CjT6GXUcu7laMqnlPEExOibszCKN71LXew7alNHYsSQWclQYCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736087; c=relaxed/simple;
	bh=Whf6X9ZHKPJJTjJIHG/MtIxt1rIkeGiFsVP4jdqFV0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGEbGnpWrye9Vg7tqhEwhs5j38yYPZFu4dnc4OcilPj4RZg/UPnH/OMKW4JP0YP7ScPYB50OsaBWGwhPUasToDqgiF2Z+TrsUH+F75Fomw/P+4YDUXRkfRnWAy2vdbEiAB4FkhSyqRnp4zaXH2ehUkKf53GRBDj8hPhjelQvl7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoLCwqK3; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoLCwqK3"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a3fda88184so1156708a12.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 02:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787736084; cv=none;
        d=google.com; s=arc-20260327;
        b=oS4jbHhzErpEb5JscjMWyZgGE9KCF7sQMjcN+A1XatcuMB/zQVvXwM/znFW9nxZZ3F
         8br0x0NuLSVb3RyUzJD93Xg4g1Zg/uUrJubvcRxbEIncwT3DZdixsuA9sLDNzsudBd8R
         +QsUaZBvRC4LntJ2G96a5FheqTDlJ/Dg/wwXzNktJKtj12cBC/tQ3smYtjkbih+i1Mov
         Dwin4Ol7iSuCYBWN5AdT1f1ypfpQMTlLoxIS5bImDE4PKQMT/eE+RVleTZACWlsPhJo5
         9rmyhJuU5IplCYKEpPIBAx0T1e5yIdfJRDDxAdh4LTbclXN2w9v+smHYgJO29lbXDR32
         d1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KR1n+fu3SoAVH+5hZ6AygfFbFgK5dCgsGgNOeC7PDJQ=;
        fh=2Kwt1e/vg+a/1DjH+iC2MwWuLWd7Dl1N3Jtn4LQwsiQ=;
        b=YZaNLKPYl16KzngrR2ru/Ioy5lBt9FkEb6tN/6G3Yy4Ms1L1TO0+tYp5u/Wf5H+q3D
         m0Mdi2Gz8EGt27kfz8kNfkxFWuqlXkZmHrjswldSmnEMhTIYldDFp9rwNHTPmvGc82Eb
         eB3d+r0llraphIFlz7l8bE/2U7WD9qnZzSI18+Ttm3ApdA2qmlzb/x2fPgwK/TL7RdGJ
         oVWLt9i49MpaFHgRB6ReYUrkKZ2qIzoH+2Vq4lPYYjc9I2Xep6RfCf7zO6z85B3N5qxl
         kwgWmQS7mZ6mQiuhLDkD1YZrAFUIrv82OGIw69PgVJTC+VT7PhOzHnqSWIZzfUXHjqp1
         mqFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787736084; x=1788340884; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KR1n+fu3SoAVH+5hZ6AygfFbFgK5dCgsGgNOeC7PDJQ=;
        b=WoLCwqK3UGG4iaQR3J2gzllOscezQ9ZY8srn8zVvyUzP2qjc/K2Vlh3HLjcdaNtkRk
         5e6B3/WtGIwgrmoSabDeLBBYgiKxln674Jf2PLxY5XeGJ5laqyUWwenfJU1BWBGNUoHg
         v+NC7kLP6YZES+fo0np+69S8THdmSXwKxmk4PVG+OKgXceii1Hmp+NJoadN+Ftj5jtP7
         pZh+hPf9jci5v9yKNtHIUzmULVfhFMUxxg5AnKq/aZeB5UfJcPqEvwMnU9A7qFtXvVga
         MSqgU0SIWJQ23b6Q+MtRd4QGJXsg76CnWrQeocR5HGIFiuuZFJ/sdedjUyqKDCawtr/l
         s0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787736084; x=1788340884;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KR1n+fu3SoAVH+5hZ6AygfFbFgK5dCgsGgNOeC7PDJQ=;
        b=NDVtQNvHiq+NvOvkvrigLutPI8gc+ab2tpuE8wWwExQCTV/CxWJ5nz4EBJoMxB7BM4
         COycU5ovOI2Xh3HBDgoUqMX4V3wHsY3z/R4cWbZMNNWG661CclYHVQs7NnRQ4zvHD0y5
         Q6XhbG5HwaSAS2yOs3d3D8S1cAf7rJbdAPTXQAV1AUJcHGpUqoPKDF3XAItr3BA8FQ3V
         XTTFusffGRPOWVE2DG6U/qY+wyNDlbLukLzhoesW/ngfYLRsr8oD+PWKQT30sAJQlg0L
         g+GlE9SgJV6fm8rhYD+Sh/a5c8ZNBF8heJVFWLxUyvPH85VgvNrg956jlOnXcxxeKA4+
         66Qg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8sHSYfIqeLgJaehYBeQHqJOKrnIAw5Uxnbvz41Hn9CRpKtYdkvMYpfSNdkKTuK4Zj5Ig=@vger.kernel.org
X-Gm-Message-State: AFuF++l6r9PY3zBNaX7weclPQRYJNIbV1faYwoofyPkfQ5WNdcLhF0Aq
	wNOkMWP+DsG1P/UvjNywydZh6lI3/+2NgFS8dZF98/jB5YwBSwe0uxCzv7MLBbLOYfZcjb8Or8M
	FBPrc3g0jr5mrjalskqNkQzKqjqlmpd8=
X-Gm-Gg: AR+sD10M3RaGbhucEx6oyovNkv1j2fv1HQXUbHTm/s8kSJ3bCyGGZ7v2yMgq45WaK7W
	lqNeu6tcrv2Fo0sekZVyUYOxT6NAM5qNmtue2Zw5LLyZQhAuwT18mpQ4FeRU6T2c7glJwOpQxUT
	cZhu7E9witBxtt641VQfE08jkmOANp5thg+FGC1jKv9/byMGCa/j1Xa83N3o0hP7T7m589PJxuv
	sR0s7WVg03w/yogXqV+yYRICGj2FLTuBLfqnbslRme1F3eadsDPxXFF3+bmMyp734P3S1OVbAg4
	mgWOFQXK7Z+y+34Ovda651NIh+tlDsMJshlh5Z+D5WRB
X-Received: by 2002:a17:907:e915:b0:c20:f6d9:d8c7 with SMTP id
 a640c23a62f3a-c250c3805f6mr606289266b.24.1787736083577; Wed, 26 Aug 2026
 02:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2365.git.git.1787693117.gitgitgadget@gmail.com>
 <d3d7a06e3d6f0c7adf9739ca496ed4012e261ac1.1787693117.git.gitgitgadget@gmail.com>
 <xmqq33w1lv4j.fsf@gitster.g> <CAHwyqnXjO6Cv50BVjJjW939A06-bQtcA2uf0Cwk+xuoc2Gh_LA@mail.gmail.com>
 <20260826084641.tb2NX%taahol@utu.fi>
In-Reply-To: <20260826084641.tb2NX%taahol@utu.fi>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 26 Aug 2026 11:20:46 +0200
X-Gm-Features: AcwNN1UTZ-2p6gtLGOdpVC-YZNSWST7rAyijqenHfz-YZx2cfWMOg7VtyarlWfI
Message-ID: <CAHwyqnXbzWCfVR0k=UskRDNNdPQnBEZRA+4r+kYbjT9J5K9OeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] branch: protect local upstreams from -d
To: Tuomas Ahola <taahol@utu.fi>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> } Do we also need the same safety around "git branch -d feature1" by
> } the way?  The "-d" option with safety checks the same "is feature1
> } already merged (to its upstream)?" condition, so it can protect the
> } feature2 branch the same way, by saying either "oops, you cannot
> } delete feature1 because you still have other branches like feature2
> } that depend on it", or "ok, featur2 used to depend on feature1, but
> } because we are deleting feature1 based on it being in origin/master,
> } we will make feature2 depend on origin/master from now on".
> }
>
> Harald, perhaps that's the passage you thought of?

Yes, exactly. Thanks for finding it!


Harald
