Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794579154;
	b=4SoXazBx5MmtMgseExpZsqyr/1uQ8vTW6QJ0KOvDa/QSic4ufq82jKrhVhDGQVJg1bot
	 FrFPzEcgqxPElYslc30Q6684zNFphsFEYganxX6DAYmwdi1yxRWBO9LGlFDVE0OixJwsb
	 gmJWapF6TWR78jOExvAxH2tp1WX486WUBqznppJ4Cpvrpul5xBMjNowVB2hjsESBDRR3s
	 o/YC3Ytg2iNCyXt5uR4AsuYEGaiuynkcbIwvWS9UOsO2Wbk3wMFZS164bcAi30EBijSnd
	 gnd9M98cHenKiV69sw9I2eCpxYgj0jY5IWjOIdYD/F9T9vZP9tkXJs2VnTbZNegCrlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=pfOBCVnSHFwF0TxtIKWx4A6RrfbtpC0FIPcv7BcBODo=;
	b=Xq0oRPZ/HMBKyPzNb/QqLMWf6xtGMJRqIPuLh4c2pWoDUG83BgBgmX3ZvqStfEdDAtLH
	 Sf5dItp8YgqjlJf1D2uTdSQKzRxrFSCDYIH/9r4MwKnTT1QSFkl1q2l8KvF1tH4sRcqM7
	 rrU0OHDwn5RVgh7zzXupy++6ij08ERyuydUGYkr0FH2ifoR8xMlwea0Zqk2xmvHRzbyt8
	 g5URgyav8M84dwUKProOeh9J60YJDsgs+tpv9/H4+95Z5WDvPfvv6WygpnaE+ABvKfTwp
	 XsU83qS/Hfzp5nyeNLQNPL4c3/8N8CY9I4QEavr2SUhOWNXB2J0+ODJ+UXvYU8LVQZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=QSUjLyNd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697A606A32D
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3697A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=QSUjLyNd
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b70880c0a4so1527106a12.2
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:12:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794579152; cv=none;
        d=google.com; s=arc-20260327;
        b=RWb9wz96OBZcHnFxOEdzJAQn+UNXOAbtvwW+EbzBz13BEFCUK4QfWg29HED99X6/2K
         eApeM8+k/cGd7XAMxF1xelHneB3u7xappjeKnHwKFqzC06A//wrl4rz7BeMi3pjIeyA4
         0/NBufI9vKa6+8tsGaHlLNz8OPeekuEVE3aMi3QItnFXnK/p0qq2wnX3E1cbMn4pgBI9
         Zle0CMA6fHCIppdqr5tIRkT0J9kaBhEb5In+xARWnGmglU1vDtFshR/YOe/No+w5/Kff
         OVtKba0UuSsP0qcRAkpSOq1Llp2aUQNk7epijgTGJseLAr3kwC0fB6Lj7W1a43oJp9a7
         VFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pfOBCVnSHFwF0TxtIKWx4A6RrfbtpC0FIPcv7BcBODo=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=LyBrFKVU32W7KIYok8E1SPOkecQvucjWm6MsvwNWPJl2r+mpxbUxun9eCUtXfeXCUx
         XAOd1H3NDc69KielpKAROro8Om+8C3CeslDMq1ALXJ+QrzCoy0MpXgSriXPiN+c2LgMe
         0xPJKI49ZoJoVnnXAqs2ZGBxGftRRWeD8m+STg3nYshiLKpsggSDYdnVgY3qEGDc813C
         8S3P9FFTZSXPxvsXNN+kdzqdM6UYVtKyypa9ZdQKX0ZPPprd6xpDNQlNVpWnPuKwmamX
         WfmXN4xMN5SZLaXqdO1CO8lJ1zOXLSEYszB2XyPjj9ENXLnNhRkaqOWIfVel9EWywb6H
         GXmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794579152; x=1795183952; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfOBCVnSHFwF0TxtIKWx4A6RrfbtpC0FIPcv7BcBODo=;
        b=QSUjLyNd/6Q32qU3hfy4mWt6W62oXBcGqMTzPI1PqBVuqir6DOaK1vscyRoqSLI5A2
         z7gPNvJi5A/aFg+hjV2hQivTw+FUwU2pV9imAzNNG8/Md9X1E+YWE25n79HE2vJDmeSF
         nw5A6yOGTQelolcXx3QhZFg3wl60/qV/qjkz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794579152; x=1795183952;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pfOBCVnSHFwF0TxtIKWx4A6RrfbtpC0FIPcv7BcBODo=;
        b=h5Q0M8yCga8uTEFTl5mwYIN4ZU09f20U+BxnrnLIVuUn4kU2m6A5R+V22Ll2LJpjKa
         N3Aaos4cwNYDhu34C34USKP6z03p8OquguW1MoeZ7T8TMvugXhpcoAIB0/jppBuCWd4I
         X/h5UwkajBlbpkb/HhRqYPO0iuwrV7cr9E8DznouBNmqP6zOVVLTSu52vSe5/4iYawgs
         QAZwni6c7UGPpeO7gaiTdfaBlpcUuaaUVjgu4KjlENjHt8GZnF6DSaSGtFrdG6jjNVQB
         WOAbiVdU59Apa4I3aZT/6pf+Nf6lAP3oZrPeRi/8/sHeDCzmmFVdSYQ1KFbsVscUmDZp
         f3nw==
X-Gm-Message-State: APuU4Z+E6Ada2rIxFemzfsA/9+6uPkrf6oE4nxA8YKp3fFH7QhFnxZTK
	A+noMmJnrHCavEM74+A+gwvFLMg0KxyMkHk7+qZTDhECsoo/9IqtpMPf0YYsqWqmH2HYSzX2Rjk
	SlcrBuPjWgUfRzwe1VBPwCgEncRyU9AU+fEtvMQ2LgmmoP8q6gNGnFbuUgw==
X-Gm-Gg: AYBFou0slz69E6eaHmBXGa4BO67xh2rDsF81hs96ftJi8NN+rVAf0cArWTPw+hpaRj2
	AMXiPsoy/5T1b0BM5JEUUnNChN/23LF6+tIhasIMS2gU0Fw3DgQUCBfWuI6PFsIBSrqdn+Y0zHS
	iHeEWUX1SyI906tTPnZCkJKFfwqf6oFb6lyz+OYaKPfJuYjrHVBrK5Va36Dy7lRcVYkVFMJaSf7
	IADQD5N0EPpYyWMmPT/NPYwVRuc9l2YIT88SsV29ZqYB/l6g79qnerRkkrpddE2MNcxEKznb/Hn
	e+ZEsFUHlqo+G7PvTiHBpCefsCFZIs5LIQy2Z7EpogDazn1uneeAJth2JZCxIlGldUuvzBebsMV
	ywcJmfvBbz27vIRl32SMFZ+4t1+VOWjgDG1oHQQ==
X-Received: by 2002:a17:907:1c84:b0:c4d:28be:9ce7 with SMTP id
 a640c23a62f3a-c5096118f53mr230384866b.4.1794579152375; Fri, 13 Nov 2026
 06:12:32 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im> <20261113-pks-repo-count-objects-speedup-v1-1-7ba4f29e74fb@pks.im>
In-Reply-To: <20261113-pks-repo-count-objects-speedup-v1-1-7ba4f29e74fb@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 13 Nov 2026 15:12:19 +0100
X-Gm-Features: AclHuK_Yra___umnv5JBNmRt8qzhw_xVDNMLJRbSbFQ15O9XLHLPFNL4eS6eJDY
Message-ID: <CAL71e4NfnYLAXQT-wpb6ciJZwTrT51EZVsEs8VertN=xBmUD_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] builtin/repo: only parse objects as needed
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 13:50, Patrick Steinhardt <ps@pks.im> wrote:
>
> +                       /*
> +                        * Commits have already been parsed by the revision
> +                        * walk, so there is no need to read their contents
> +                        * again.
> +                        */
> +                       commit = lookup_commit(data->odb->repo, &oids->oid[i]);
> +                       if (!commit || repo_parse_commit(data->odb->repo, commit))
> +                               continue;

Tiny nit: I understood the comment as saying that the code
depends on the commits being parsed already, but
repo_parse_commit() handles the case where they are not.
Since path-walk hands us commits from get_revision(), I
assume that is only a failsafe?  So this is just about the
phrasing.  How about:

/*
* Commits should already have been parsed by the
* revision walk, so we do not need to read their
* contents again.
*/

Otherwise this looks good to me.  Only reading contents for
trees avoids inflating every blob just to throw it away, which
is a nice easy win.

Thanks,
Kristofer
