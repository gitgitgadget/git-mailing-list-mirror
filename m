Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72623C2774
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971374; cv=pass; b=F3vdn4oxxKMfUAcXzo+oA8vXJjQgSzWkU+qdCCirPLU98QQkv98UvwLzlJnpYJgOUNWu6RS+OP6dctA+QcFCtcJTfIFD1HtVum/XmGainJREYkzU2MzQpTNK48R+04gyN6kJuG5CoNX61zIs1rLP+kHaq14YN+JdU8wHCeUS6dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971374; c=relaxed/simple;
	bh=oykgin6LGQM1NKN/OJRzz/zunyxqjaceVoOd+iTxccw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRNtblYj0jryO9xbTF7txJ4iW5zsc4SBf4EbCWxGVqNwO2NwQ59BtFRNHsOxwn6Oq0tZOuMEmBHkmJTlT85PRxkrN2k+iXZpLMd1MKu99rL+W1aA41AO3uqWT/Vx+sgkp/e4gzhB1oRuwsGAE3Szj/LFgQZSB+fmItdUZY69ayQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl7OufbL; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl7OufbL"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c315a445752so598894966b.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 02:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791971371; cv=none;
        d=google.com; s=arc-20260327;
        b=efP2ZofFFjMAft9Gn0G2Dmid/ascD35R6UzNrPYtTilu1dF49M09GGlqglrjaWBUO6
         zEnyDGLeV2NZVEtd1/OoArhc9pMtbnHVmYD+vg9hOGjhj4EN0DZXx7TFo67/HGP30YcA
         G6MfqEYbmvY9R+C59OaGVzyGrV0DH8nsFSAlYGPFpyu90URRu9c0EbDURAcmEBlLO5KT
         lDDxFWGQ2PXXs3i0GnTc5vTHrpUaUuJxamAO+9CCA26sYdm0TryXkYhkQz3Ms9rUBQ1h
         G01iutJt60rSGbziG4oxAKGQVFx/SbVp/rSyt/Xy0kwhwP+0IgAmiuq/BqEWc7t6FcQK
         ++PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VvvOm5G5uKKD5UN4UDqO2qi6CfliioNvS696bFsU/n8=;
        fh=e2cPc0WAaF6GjhAJR2HEinNqem51qJjd6nRuNMdi0ok=;
        b=cZwNjW9LkfmPWgsm1ZhW1607bjlXlerya1m7iDr7dB2MRSNbKguZqhQ3tB1Tg4LLOK
         mRU8n57oRdXo8YhV+eILF+vsX+mK2W9zK35EqFNLV01AJTiQ7Z+ICgG5hkh7pSkC/NGr
         OnOHD4cQYpd5+KLcfPTrMWM9SGr35P1V4jyr9lA7TjklIUiWH+dz5uBQ4JYtDN+JVqju
         nLpaaPaPpxDwl1Z6rE4ko4revETaYRhO5O48cSjbgEfWy3m2dohTiR5A2qvk4leF1qSd
         4QZvsurcFF+iOpX1C47a9D/V5D7DUPsNAgp5n5G8WgXvdRlsEQbVUbKROmnBM7lvf2Yx
         6cCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791971371; x=1792576171; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VvvOm5G5uKKD5UN4UDqO2qi6CfliioNvS696bFsU/n8=;
        b=Hl7OufbLJ3xzosJBut9Mx7uflVHRnb9jayb4HSekbL4HTgzqZCAGJ6YZqWT06xn6Ip
         CWK/4dVeu6iAt2nc/Tbee7faktKJTytngx302AyNgbtqCHMFlcL8PAWQfOjSXnuY9rcn
         xyJYgn0rUVAnbvBa7pCGQYrSurQT88DgQGz1yZ8Ig53WAe4aR1oLW9TV43VIqvOZsW2D
         u2ufhckNHf+vNBOCdrjnd1qh45ubjMo88hXzbRegpHtCQHu2fomJzZHSc70dcXeYRtwl
         +huCevoXhyP6pqkTveR3v1oR7/BRLK5hU5Avxo3tfgL9eovb3FI16BQtzf1bxrXsKJuD
         4fTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971371; x=1792576171;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VvvOm5G5uKKD5UN4UDqO2qi6CfliioNvS696bFsU/n8=;
        b=YvDNQdkTuQ+1EF/LocQm2WjuUQcxs2jWFOcIEMHM1tCSXhWHP4oB6NvBi9yO1nTs+y
         yUrds8XPG95GplBQ5ZM7EQbSsI8b3RYO/X3assaZRJah2wsKYDDxM6+9gskvgPXg/lxS
         6DYcAUY2c8ckDDfl5xQXTETI6dc8euq77pOq0Z0EiDDH/O9GSB3f0kcdzfpJlkv9I+ER
         7LB3cZJqr2GcqPmFPQYkPtu2JRYLlIRVnSsud/VXULwiIY6GcDg6p0bTnGjgeRbmhb4J
         5AamfpZmuqTfyqVwfzoJ5Uxe8U2s5cu4GlmHlY7tpavg3PhQXLYYnksP/xadBHUdqVuQ
         jMRw==
X-Gm-Message-State: AFq9FYKuI7imEjNaGh9UR1DeJN9jioU5h4M7Cuyy/6pD+8mKPbYMS/cZ
	goEDZnvd/CnAgOu6um+MGjJnfgRB6AguYWXkphiJtUSwGP7/Q24vv2oSD1fF044Y4xo8OWAY4i2
	BGus9atyQnqG4/Ipkm8Gp40IVv5/kFvxM80+p4RM=
X-Gm-Gg: AYBFou0LdgAr4i+6TeENlqqfifggInMEfstUUILL6LiOl+24j+m47ZMDso6WzD2hdlG
	57PA+d+lnfW47UEMb6iNpBfwwckBvJbBOF0MMuiRZ7rHjq1jjzWhYu+aOWmWXzi7xY6RSuY8Rg2
	qIoYIHiPhpfEEVV4+Dv6CDKhRJhAZ1agBuqNMAYRLH7ThPMMd5yGdls8+cQw/LZDWyTZZ7igE9I
	EFduRn9j3GSqJW8RcGFsbCzJHHZ59iJAm1NRf5fxbwtTPmjUt4LrU3pVVkv4JgI0qYajyAYyQ3W
	Bbh9jr81jqtomx0Q3mqQoSG+MbAiQZqY2kDtQmSTVxooyt0RM/RpYyBCcdBNBOAdqXrDPIjCJbJ
	17YaI/2HAoQ4=
X-Received: by 2002:a17:907:ea8a:b0:c26:2eee:ffc7 with SMTP id
 a640c23a62f3a-c31a9f784f2mr1376119466b.35.1791971370836; Wed, 14 Oct 2026
 02:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
In-Reply-To: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 14 Oct 2026 10:49:19 +0100
X-Gm-Features: AclHuK-HYk_FVY6sVEwigXgxWdJ9RWLkR99XtzPGG7VB3okTTBdB6zwsbUnhjLo
Message-ID: <CAPSxiM9-F-1XKvWeEnBk=_FyKyev5pfnid4fiN-OjLYLnCTWVw@mail.gmail.com>
Subject: Re: [PATCH] t0081: modernize the code testing whether a file exists
To: Shashank S via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Shashank S <shashu8660@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> From: Shashank <shashu8660@gmail.com>
>
> Replace the old-style shell `test -f` command with Git's modern
> `test_path_is_file`.
>
> This instance was found using:
> `git grep "test -[efd]" t/'
This is not necessary, remove it.
>
> Signed-off-by: Shashank <shashu8660@gmail.com>
> ---
>     [outreachy] t0081: Replace the old style 'test -f' to new
>     'test_path_is_file'
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2254%2Fshashu8660%2Fupdate-t0081-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2254/shashu8660/update-t0081-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2254
>
>  t/t0081-find-pack.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0081-find-pack.sh b/t/t0081-find-pack.sh
> index ff9d56fbf1..7d5082c487 100755
> --- a/t/t0081-find-pack.sh
> +++ b/t/t0081-find-pack.sh
> @@ -32,7 +32,7 @@ test_expect_success 'repack everything into a single packfile' '
>                 ".git/objects/pack/pack-"*".pack") true ;;
>                 *) false ;;
>         esac &&
> -       test -f "$head_commit_pack" &&
> +       test_path_is_file "$head_commit_pack" &&
looks good to me.
>
>         # Everything is in the same pack
>         test "$head_commit_pack" = "$head_tree_pack" &&
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
> --
> gitgitgadget
Thanks.
