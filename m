Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553125B0BD
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318237; cv=pass; b=YjHMtozQ67wuy3O6sDGPnzmFYAZ3EoM1dJWhQf9hQs1sy8hU7ZSvh2oGAnrayfKLGtIccaOqww2rK86K5LdnyhEMnWKt1KseI38uuk1laVwIO89B/zVjW4R4vgZUK67akwhJugz7wTrJfRL8xCYq11TRdp/RnzLQDOc6W0mKoNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318237; c=relaxed/simple;
	bh=yOE8Xt+vOjyKZjdpQQh+vLGQhTJuK1PpKXsrK5ZfVlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6c3axmtX/DJEz7Td6R0rfQtBwTzdXM55AvG4TeaDB+hkoFwn5RpJr173BOqiWp5VXSCDuggYvxvoDaqMTYUOiafkFsZv+Kvp04CyVJ7hOnFFkjjL45wXwpRGbZVnSC0/vDbJG6s3B+RrTVQGeI/dh9Uys571v1Ga5FDRxVdjZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9ODDXhP; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9ODDXhP"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e4a4e92234so28969375ad.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 13:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791318235; cv=none;
        d=google.com; s=arc-20260327;
        b=n2+8Hvm3XUkghob3WuGLDS0K6uHtrC/0BXM5Jdhf7wGbaV6jKyU9R9k8qierHMm70/
         i0d0VFqIxNNKpVC2Bb7kR0If9gxD3E/xOGCI3mHgCa/Hr5m3lD21Sr7IFnTh8m2ok86j
         K7hsgWl7H+RumUW5HU6AK7OZ5+twr1fcJjEbFjFuhelw6ckNiic+AKTQEn0KD9uSmxS6
         dfXOdpThqQnYX6EgVwkyBBNzaM2wb6H+NSOUstyTpmClI/jzBIZ/ZksPmoxd2uA+FCOz
         LeP03xml4/yQyCguUsb493o1IoXMHmhu1jcsQP+7Yn5Nz85IAFvzBzZx8DYfx+5oi+Gy
         g9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WBO8BJ8HAyFTZoVi07fHyEB6OVrGM/eF1rw0/F+aB1E=;
        fh=eTbup3dHWFgd5UZJ4cdzvJklmut1XZ6A08VkPoZlo1k=;
        b=LfqnqjKWSolsKFmZXv31QQe9SYLTvIJ7rSe89hxVvb5Z/UGSC+NNh+GfOWbgSdj+eM
         qSTQW44nWLveb5EwTLf9BRseP3nj3F+DyzzkWciF783vArY1Sw1sVVoX52yrbuRIUd0l
         veQ6M93AK99vc6XpEDLF9rTDRr1qqcDkEP1rojWD8fsc/XGYGVaHhHBCdFp18YqWpZpd
         Zh7wUNj/X6VIZP5AQAXebpNOsTdI7pvcZPgPoFuXFQWGXWlkD9wmzOypDaiwMcYXVzuX
         zXaJ8V8FBWkLPD3K5m5/h0WCOFA+22tuYWts1Oa0LvGbl9qACxTAFoar304+UzNSxwgp
         t+Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791318235; x=1791923035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WBO8BJ8HAyFTZoVi07fHyEB6OVrGM/eF1rw0/F+aB1E=;
        b=m9ODDXhPJT9TvISyVXGH5yvA100n+s7A/3TdNS8kTHzuoAaqpEhRwmtY7Ge4WU9X9U
         fZJVEwwZlTVfYwetRsZjxIpGkmrEwNjR7o1r/cKomnYdNk9dT1njM/nXLQT4vBzAHZKg
         NtgawxX9+WpKHlQDKhcj42+t62jMQ1mMiUjFLqgfMJoOLHAdjRsNd50nDGmv7XGmT2Sc
         GSzN1vm9pIwlxiAiaDtl99ERzt8ulDeeMr4ALkSxZONftFRJnKtooY8pt2TNjyECJRHl
         CDAvi8SJiSBpOIipgdr7QbKDv3UIlPSOmYED/4YTVdaNzk9DFvGQ2lA58e0N7B8LEgD9
         T2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791318235; x=1791923035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBO8BJ8HAyFTZoVi07fHyEB6OVrGM/eF1rw0/F+aB1E=;
        b=L4+LAg8dYG+LIC35Ml0fpDs5id7E03avCBC89MxfHy43BE0wdJq59VWaz44GDcVpDX
         8loQMvyn0hMyhVa0EarAawk0K3k8wqf173hcCvUNO29ecgW+CcupYkWFPbq1lIMTX/i9
         nKZg8hDnBEbIgkFx0G24VEKJkXK5J8/9ALnuwOQLStR6+mfJUhvvj0+eWQHrbF6JELPa
         efrdOZBuXcs7e5OWPTt5NDwOcaKfwvw9o+eV8fNHrnNY0ZBT+Jxi3J33xCL0TJMIxL/G
         yotoTEWACapzdzi/cnnlA08SGqlL9NWfsDewwLSFRFA1GkK+MzJYUjFrRCG0QfFCV02+
         HINQ==
X-Gm-Message-State: AFq9FYLr0GQ0qVaOgqlFWffSHacyTnRgRo3FxwxP9JqBujsMx4ZZ3FOK
	KOramA3tKzMtFghKRcFzwLtQCv8mas2jOFNpgB4N+Qdl3v2KJ7JQ13hHGWdXE//LF4OMose0diU
	r4RJdAFMCEEK/Tc8nItcRTlBwPS9e4Mc=
X-Gm-Gg: AYBFou14gl+7i7SkZb6qiNtFmSl3AtOtrTaFEhVBoJvY8IzBQACyqipNW/34Azm6fsE
	YT6Tr+uWJ8tDLlzpRKIFbu1HLi39ovrdV+HEVYlV2H/2W7Qri3QePn/EwCLttcpB6vbeE0AGCTU
	6oRRK02YF1+RnwPvX1LRxae//7WePEukcJELaRRBGYkBK/JMobH+A0H4SAY0uaEp8E8pM3+Bvy/
	4cppgdGLVzEk+qo0716LvJoWj/uP8oEEk/kMmMQDyVZEF0vscnj09uIaoK2JG9cJTFRT0xKDa3/
	tRDtPRf8klR19+EmW5/B8AJUPDA4eKPe1uOIF6wpyc/NkTj8OUd+X81QzcoEsm2gIM+/KVweBJV
	OdjJn/i1+0ISLGn+V7NeTi3iSHCy2TejXsJFQQyoNFgPXDdIVTEAmy62CSXEht9lJ8cQjI0fD2g
	59rvLDK3lBh86NO2mUuVnkJrXSk/Gp
X-Received: by 2002:a17:903:384c:b0:2e2:e5b2:6455 with SMTP id
 d9443c01a7336-2e6004bdaa7mr3949115ad.53.1791318235587; Tue, 06 Oct 2026
 13:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com> <pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
In-Reply-To: <pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 6 Oct 2026 16:23:42 -0400
X-Gm-Features: AclHuK-RkfUQOHnHI7JewjxuBKM0EuPpnqWxXvU4GDxgQRCutu4jqeJUJoUNZRM
Message-ID: <CALnO6CCwCLEBzJiRaJp3h9b=6uF5x341NhXd+B7UfatsQmr2TA@mail.gmail.com>
Subject: Re: [PATCH v2] doc: use `man git` to teach users how to navigate the docs
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 4:06=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>     Changes in v2:
>
>      * mention the git help push form too
>      * mention you can get HTML docs with git help --web push at the end =
to
>        advertise git help's great features, and remove
>        https://git.github.io/htmldocs/git.html since
>        https://git-scm.com/docs has a nicer view and 3 different options =
is
>        a lot.
>      * some minor wording changes
>      * fix commit message style (doc: not [doc])

Thanks, personally I'm happy with this version.
