Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794407814;
	b=Bg+3AaaytBdAvvUug9VvaAmVWV2py9j0EqqYFxaou6FLMP7406zLhijssBD6Zai6w14T
	 HFAGSXfewVm00o3RDDK2lreNAvlrs2OemiqhNRurIodTAyEiKNOPlZfopEcVxKAHGJS1I
	 tHkDrl0WLsy72KT5iy1Qfk6Rg0azUHowd3UKBBlm9iQ9UuM2V8JntI8iAF7gZMdI2tSt5
	 Tc8uEFb1V7T48AMEI05N31L5wVDnEVVP6KtTiHjKzP2vgRQuc0wkrM9jzfUPKQmDqxLO1
	 /lQ1mafhPcWKoc+fQcltK60YPSsiJkhpXpchPjT7vAi5oCUM4jB/gSaY0mnO09dSkiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=bZQwAZGVqF25hMq/B1SVgKFxAxmW13eLYF6YJCsPDvY=;
	b=3yN2s7lnwOUgnbOPcCNWhMDfPlWmpVnax1lKBJKfLyJsVmjCqKSJCSyfruJ0r/uC/5h3
	 Nw9uLrcAO3oXWtRf1hKpUyzVdpisNv7iz9eM/dqLmYZbXr5y06zwW7U6+BdKIWuddAnIo
	 9GFBmVtCkIHxwxF9N5esnwqcB7S5UGVdW8KAg0ofFMtWsGTv0BIseqrBAAGGf6jEecqsG
	 4mFCugpQg5RKGpKpN/hq3e4kvEKKZhKQFeMVjxBm/0gXZfJ6Uy6i2SCKW9YkCuDpkZvo4
	 OpbEwtbctwmavez/BFngXLuMllj9efJK54Ea+lN2t1NaB+5wGzpp/kfSa59ngJ/spOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G33zzuPj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1423606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1423606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G33zzuPj
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1897112e0c.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 06:36:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794407813; cv=none;
        d=google.com; s=arc-20260327;
        b=MXi/bGLxkqRjma9lnrqyVbEncK/XR6WiE8lOjpVJfEqfeopgGOzc5t0EaQ/rVGgnkd
         NjjAN0TApJJ6sIGB1G+Q4ftAPkXfvq0w7KUho1WI3GFBeGQLu4vhcQiXGjvyuFP1Yk69
         JCspohwvUjtsSQNSMFMBYr349tJyCMLR38Ge001m8UQ6Kr/lp/n0b9lyM5Ylo14gwEyl
         WE1uHwaVCj4+T2H1dtPCiE8GUaZDzaPYfU+fXsbF2nrYG12y9OC7mVBaoKSDf4aIhTvg
         //SISHsM+5TkqCzdMUNp4ARVU+Q9j7sZVLmFyb9nY9D1KlMrBE+gJfK+8qGt2XcfjsSf
         ogjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=bZQwAZGVqF25hMq/B1SVgKFxAxmW13eLYF6YJCsPDvY=;
        fh=OHT6WBlQa/Mmw/5eunrNMKjFfFaeoaUqFym2xfriy+E=;
        b=WEc1sWZwwmGkehYX3pDpZ59OTvLMVi5iYCWcbGjzxpih4tKbbBOxxwQQIuHAmSq0rD
         bZHajMFxO7+0akZ4WsRpoA0681MRobpKB9xg1MTREHDfSQYjD1JZ9yUgrAQnZHbkim1c
         0lRy8210zpOlnAQ6WF/TVqi3ezXntHyn/qay4fmLEfqZqxief3mhpkOzUpxkagPpbnSJ
         ONNOESVkzLonY4USGfeU7i9VcUAuymyCxvEphQzfrjIbzPU1IDibYaYEzyASQYlvYYPy
         9i1KLhyW72QK0JJ0quRgxHVNnB0XkrnUcHkfMnYx9OryUkEd6sHfiWXk2fu+hAbx4gPF
         hQHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794407813; x=1795012613; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZQwAZGVqF25hMq/B1SVgKFxAxmW13eLYF6YJCsPDvY=;
        b=G33zzuPjShYDTIxXuwbVi1QcoS896W0u4mq3/wtqIwjSQVtD0ES3aSU7fJhe/aTfsN
         aHuFDeh217khNkt8MVopyEfbXx3G/N4Es3UCv+XcZ600khD1awEXx/yG4iCFgT9WwbLh
         aSCpXBh845jYngT8B+gcn5q/v9xlu64bUHzfJa0N7U0jqj9fIkNGO+ZIoCbUpVfW5jzq
         Kq6ERpts/hxqJC5HD9vhz5Z93bf33zf2ZlkRkDradmzD79Lj2peqHFSTfAYMqPS58L8r
         IqMA0oWvyWQ7S68l4P5qK+tGxTnF2D1kQKIlcH1t7P4jp1Z+eVtiqabTI+rr1spbJ4MI
         GOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794407813; x=1795012613;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZQwAZGVqF25hMq/B1SVgKFxAxmW13eLYF6YJCsPDvY=;
        b=GdRb6AJ4qU5Wgk86yEdUAu1P/FE9mFHImNjifdiBDAytVMnsRgq2cEOH0QJF84loUN
         LE9Rf3/ucVVKhJ5nCtEG4Z3Y1OQVALLrwN8aCGw+e020fpd1Pr2YAbal51esen0bxHvT
         n0maalG/GB1Z31/lZuds3o32j2JmncimtOdnYzdzMSqm2A+1fMBUIOqa4PipR2nazX2Q
         HHFaduXPFOX8aIUdrKmVwuxwhzgHo1k8OkjFJJWAdF1IW1gmScC9Gyyk4ed5ur9QEmAw
         Qg+Wwbe0+GsnX+1ACN398geQsX1Q3f/TkJZDoWMJc8DIGlO79Pf3c4LdZMReiQEw+zXp
         OKlQ==
X-Forwarded-Encrypted: i=1; AL+hErGBHEcdvPcMBJASDcJ6szlrcgLarv9CKctYfFPNWluOicUsZUl6LeNaasiRxowB45PAMKo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+yWzAQK2xSPgKxda0wskVedsXaiqIlMXEdzYnqM8JahToG18j
	0fNsviOR05PiLyB8FZJDTGzidwvkApvMVxbjKSYrVtvmx0jyu+93AkHELOqlm5pz34/Ae90kYyL
	GDBNaa5o0z11ayUtw5nRaPigESPjp8DfpxA==
X-Gm-Gg: AYBFou0H+cTUt5ac4kQnTpK3ydUiD/d2QtCT7PPg5+fe7myUk/DpqBoj5uWYjgP5FlR
	8mfW8x06+vxG0n1Jal+i6rBRrQEGo1Oo/7q/EoiL4Uidq0+TOhXauT/LBiXulHscvUNghNIbJNm
	c1Iad39yTPg11UQ3C3mTHv369IBU4VYV6gK9NYw3+uvhEJwA8AEsNE53Vi4BFLoJeHPz8g9rjS4
	WTUTSjEw3ItPmtCPe04A/tqw1B8nZNh03DhuNWEcipJAY9kkRQBeJ8EAId/9JYPYF23Tl9YFWJx
	GP8XiRHlSlOAe4eosi9Wft/KQH/xefi8Ncahd1TgpC1MVgzOi68q4nA9sGr3s9D7K0YGLrTOMfx
	CUMHVGFq4jfD2fyuauwKRJNyyenqz9spL4JUzr6Ra1IjxOwS9WBL2/woDqAquq1BjbsFMLfrQFl
	k47yrmFVVsaC4NN+fQLCZ3Z8yX7Q==
X-Received: by 2002:a05:6122:3c44:b0:5c9:c60e:3a4a with SMTP id
 71dfb90a1353d-5ee1c4ae46amr863699e0c.22.1794407812770; Wed, 11 Nov 2026
 06:36:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Nov 2026 06:36:51 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261110002251.2007617-2-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com> <20261110002251.2007617-2-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 11 Nov 2026 06:36:51 -0800
X-Gm-Features: AclHuK-cQ71KH--tKVo8iDq0OOJkeVY74uaWclCWtOXvhY6aggk4hJEFKL8r944
Message-ID: <CAOLa=ZRpoB5+woCf=D6PAWkQZ+jDkoDgkpffh=AYwCa8BefQyw@mail.gmail.com>
Subject: Re: [PATCH 1/4] object-file: rename default transaction prefix
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000434db9066001204a"

--000000000000434db9066001204a
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> By default, the temporary directory created for a "files" ODB
> transaction has its name prefixed with "bulk-fsync". This name dates
> back to c0f4752ed2 (core.fsyncmethod: batched disk flushes for
> loose-objects, 2022-04-04), where the temporary object directory only
> served to batch fsyncs of loose objects.
>
> ODB transactions have since grown into a more general interface for
> writing objects though, and the temporary object directory is not
> inherently tied to how objects are synced. In a subsequent commit, the
> temporary object directory is created for every transaction regardless
> of the configured fsync method, which would make the name misleading.
>
> Rename the default prefix to "transaction" accordingly.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  object-file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/object-file.c b/object-file.c
> index 132aaab6f8..201d9d6490 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1566,7 +1566,7 @@ int odb_transaction_files_begin(struct odb_source *source,
>  	transaction->flags = flags;
>  	strvec_init(&transaction->pack_names);
>
> -	transaction->prefix = "bulk-fsync";
> +	transaction->prefix = "transaction";

Okay so the prefix is fed to `tmp_objdir_create()`, which will then name
it 'tmp_objdir-transaction-XXXXXX'. So this makes sense as we use ODB
transactions in a general sense.

>  	if (flags & ODB_TRANSACTION_RECEIVE) {
>  		/*
>  		 * ODB transactions for git-receive-pack(1) eagerly create a
> --
> 2.56.0.173.gf57c9a7388

--000000000000434db9066001204a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a2ad7451cedb4290_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yMGZZSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMElNQy85M3Z6L3pTNVpDQTFvc0RJQ2xBbmNhWnd3dApyYm85a3o0UUZ2
Q011OWQzcmh6bWlydjloZHBhWnFGVzhDcE9nS00zTWpVSkhsM1FrOTFkSmdsSnRnTUFBSVJECmZO
RXJkK2MvTTBjdUM5WDJHUUFKdW5Fd2NHak4yWmJ1aVUrbzVXU3VkTm05c2tIOVpRUE53Qkk3R0xn
TXp0S1MKM0dxNjVZbFlRd3lDVTBVZG52alA2ekVPSHl3bHFIN2tSak5KWkg0dVhTcWUybENFZU5B
UDZiQXZhY24wcnlQdQowL0ovTnEvcjJyTzNVczN6MWRZbm11V2Mvcm1DMWNHemhTV2paWnRoYTdH
Wk92RVFjdm80N3llc3pkWkJSSFVQClNzNXhibW5ISHNzbGhDWVdNL3djSjRSWlpNV28xVWZ0TjFL
aWp5bHk4QzJWSGhlb05UcEY1bm43RU9VTGtvTVEKQThZeTFmQXErVlF2ZkkzR1VBcTczS1V5VHI3
WEpNU0p3cFZTM2NkVmc5Uy9XL2hNellFdVo2WjFiWE9HNFJWYwowdGJPOGNwN24rSjdzYmVQTW8y
cTdLMEJBVmFSU05WRkdpV3VjVGtoUWJ2MWJ3K0dJcFVqek5TejBkWUhJbWYrCjl4eHl4ZTh3eDl4
RmtoakVYTG8vOHB6Ym1jU090S2ZhbHRabnhxND0KPXl0N0IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000434db9066001204a--
