Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452E2765F8
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855315; cv=pass; b=twT4+Wkell8/HPZpk90SI3izxboWEO1tky+Xof8XgyBb8EPekqjxzS1HaYZ2XDVnhnztRWhUgAAz3jmlTUQHdp5SVkE3hpZv56/zdGQ+Idrfcua1t0xzlJJl54H3ccHxi1Ex/h6jSGBayFUQUNJZEahnrh0q9HstsVewCmzI7Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855315; c=relaxed/simple;
	bh=1LYHU8zmoSQTBAqP6EnNibbtob3u5ZDV4v+K7k9pIXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaiVKtPULXhvPO7liHd/t5YppDt4uPw9dHn45ESrygVprqOr9rMKA0Z9wr+HDjTCsHReyIeLnb8v4Zwp7quljQNqD+uxE+TYt1eVkwFPAF36BaeFEAkv8vdWdAya1HL85YU71cLzrktTiuCCmx/Sez4igxlavZyE4lnwLxewfDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba6d1e047cso148458eec.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:01:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771855314; cv=none;
        d=google.com; s=arc-20240605;
        b=Mu3I9+9dydrnndcIG+0IfCr+dc03z0Iqe9c/F9TlBvUNF7KxOPRjUzd8Jhcd6k22d5
         UI+9v5MB1kJNzw+tYOxtxoFvucwc02n3AZu0ihSu4+VvcK4UdI5JR2wgcqUYKf/Ygy/l
         fRUDZQw9KoaL69SWZr1m1fys2G9OXnZog8994YuaMxelLeQ6GJvZpxE5thhwJBR9yi5R
         39eip7t+rBci9aQjY+AQ5RxjgTzMhD+ZomuecgWZgbVIYuEypWOSgio5TQX5ytZWAbqG
         8V0HfcAgzOic55DbTPYEH5Lc8df3okcVMxMrtrgXa7Q/HEI+be6KM7FDzTxoNKd66EW/
         LLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=VZPO0XMDs0ojy58ZXCrpG6MW0TKNbfS/LMkI1+Xc98Q=;
        fh=9sEzfdr/LoEbwvL5msN3KdZWDik/jaAFs88bddl/50s=;
        b=aShDgJ7jcx7NOvgLZmmj8DJKinzYqXd4GVVSTdL46NWyrtI8158B336MwWLcFl9XRx
         XMIZjZrVSrhvUBhiheVcYjhDRW/y+YkvBXQzjuHeWaSaOZJHlevEvLOL0lRplEfQPRAJ
         9UDEXuHBoITxfz0mo3GpMCBjnW6/oNFOyNrMmlfS7nvkdrAzoQ8TEvByETSx09ho6Q1G
         cUZoOfl/S0/iPgpr6X8LBJdUnblrxwNCSg6QTpdTyL1e3NwQH3PnlzIPKcJtgDp5xKYg
         E0vEmn4tcBuCfQdX8vmO0nxqHTTU+WquJziGngHP1ZrGQ+67ucidoHGjbvykmx5Q6Yin
         RlzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855314; x=1772460114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VZPO0XMDs0ojy58ZXCrpG6MW0TKNbfS/LMkI1+Xc98Q=;
        b=UnzB1t6KDlAcwwxojxQzt4NY92lF5YNVMSO9mmXWzVxWMWk4GZNHtZFXelgz0ENG7G
         MLwyiIQs+oyzVpSDkl/G9xx7kL7i1YEU+gw5GWwd8NfCvLUGmXes5494qInDtOGgQjKn
         4DRetOfSHQdxWBE4mF6DrbqOW/J+WgxK2Z12O/BPHHkOaC4xVbELbzxcWyNXUcVujQWz
         j/MmJEB4QyWze3DtUETr7fXonP9g2BhPSFrTz6wgM/RkDq94NSdq8g+RcA59s6vnUBVQ
         qozzEWlD+FGG9JaFIkj3Zp0OgENqMilsMCtn/9O4M6XhmV2ZM1scEzisd+uftTIGoFT+
         vg0A==
X-Gm-Message-State: AOJu0YyixnAvlnOcIWx1zJi3raxk3pie/ksq5uRJ7BR0crbTFd2Q1uBh
	J+UsWB/oIc+F2JT5dRmUIErv/cQGY+FzDrFa/qkVT0TlyjoOsL/NMcb3hw8fZAAyCQcdqt0Jczl
	woN+hqvN5lMA1oioPg9aS6jMQExlI8Us=
X-Gm-Gg: ATEYQzyTqfyyBAkKsnXXZl8GfDLtpVdjyv1qOJ8TM39KZ8LW5VfjiNYtchJtPH0rOy9
	tPKGnPofovo0YyWHXHUiF3oJrvYP3RSArmAAzazlmE6aqBpZgojXe8+KmcY9+xG3gNNsZbHVX4n
	cXC+yX/FNGhmToKMDNThkVxFTS3JO8qyYwHaBt277USZKQpGbypeZFIfx3yowZZjBpdlQcVHn1q
	75dzgMbNo64aXBsBA0WtMT/SSTDHGidmAyM8c2PG6QBLJx5gEQ0hEpmGvcLRHCgBEaJtd0aTK2h
	2iEtMTVIm1oukT/v8EzBsUoNFUT8SKFzHojlBFrTKA==
X-Received: by 2002:a05:7300:cd43:b0:2b9:1375:b551 with SMTP id
 5a478bee46e88-2bd7b906c25mr1418943eec.0.1771855313277; Mon, 23 Feb 2026
 06:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im> <20260223-pks-fsck-fix-v1-1-c29036832b6e@pks.im>
In-Reply-To: <20260223-pks-fsck-fix-v1-1-c29036832b6e@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Feb 2026 09:01:40 -0500
X-Gm-Features: AaiRm514RdtL1ILOiQD2Nb-cKrhFxZQm9-jpcxRFq8T4oFxZunk2L3CM6Evcptc
Message-ID: <CAPig+cSSLd0MqEsvaeQFPN2-usZHvSCS=1Nor_w2xbOR+W9eWA@mail.gmail.com>
Subject: Re: [PATCH 1/4] t/helper: improve "genrandom" test helper
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 4:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The `test-tool genrandom` test helper can be used to generate random
> data, either as an infinite stream or with a specified number of bytes.
> The way we handle parsing the number of bytes is lacking though:
>
>   - We don't have good error handling, so if the caller for example uses
>     `test-tool genrandom 200xyz` then we'll end up generating 200 bytes
>     of random data successfully.
>
>   - Many callers want to generate e.g. 1 kilobyte or megabyte of data,
>     but they have to either use unwieldy numbers like 1048576, or they
>     have to precompute them.
>
> Fix both of these issues by using `git_parse_ulong()` to parse the
> argumemnt. This function has better error handling, and it knows to
> handle unit suffixes.

s/argumemnt/argument/

> Adapt a couple of our tests to use suffixes instead of manual
> computations.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
