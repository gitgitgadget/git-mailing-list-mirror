Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66F6395D94
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048242; cv=none; b=POwufMACEQjNz3X1Pr7DaySMn/fNQhNxSJDdNmGkxs1KMFXEDYzkw634/83J+FdGrbhEmAqlZ8DJjnhWW9lvsYyneOIBn5lf1Wz9IXiTkHxIY0Vb28iFDXAfXAvRsjkO+3Hnr+VszZqlYkBA+xMpfHRuJ6HY87SstZoOALmIDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048242; c=relaxed/simple;
	bh=kmWKYjOFSVw7Jr6pziY3IDnsqLf/PIaT9hlptPKHJww=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FRss7uQDtzfSay1eNNJ1C79P12tep/Qs20HNpCgpB1aalbgyfnY5Eem2bEm6+YzJPNYUJhc7ZDiSi/dgPNYdpSGHRccgM0Qg2oBdCFaqMqGsJNDjIZuAyLpn+GCJKGiA0LIXOCWVF8Q54P3byeQV69eL8wEzSUwSWTjqWAxLS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFq68aQe; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFq68aQe"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56a84f2bf7bso111193e0c.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 11:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772048240; x=1772653040; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmWKYjOFSVw7Jr6pziY3IDnsqLf/PIaT9hlptPKHJww=;
        b=BFq68aQebLNzIWq68PiFza62ehOtrFwDSv+ouEvitOGq++F/+9WUfTNYgcIJc+9N0C
         jKdXCi8xOLBIkJ33krBh/RU1nW9iAL2z2zX9J9PWdYXWiR3K4Bfa0V1NFPzB7ICOJENX
         obgszGesnmwddXAcP4T9LtxjBG9nxvkVknOSFdJthV4TAkn4jvldwJXxSZKBgU67wEz9
         QmTIaH3Pl7BHTLeYWp+49WE4GvrJDq9yharV3JB6VfSyThlRKX1CUvZ8LvlZh2S5uyy9
         QETt69sno0YrECM9g4/s+Dp+a75/to5UlbRC0ZsVoE8TK1KeazJQoESHM9Y8buc9FdH6
         ox4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048240; x=1772653040;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmWKYjOFSVw7Jr6pziY3IDnsqLf/PIaT9hlptPKHJww=;
        b=eK6RdYfxWeQeC4Gt8a46GCaFJAktaWL6duUXbjXNXAMaaPFGhAn+9QI9EONfKFthL3
         AGChq7ldZ9wkHZ6OV0csoi5GFFwtuGb4O9QLasD6vK0g9gkuleIWUsm95Xx/aoVL2nGm
         7/6BFu/VqNEcynvrgM9VFvg2rARv7ZIdaeIB7b62k91P4jBdKScZu1/ZNZIhTkRzVwQn
         M5gqvxEtsy7Fs3PKZ8DhOFuAsMvCzlwqjQtv2gV3rwUNEeiQoACAkUgiNdxz5ImYHhUb
         hb/q4VxqIOZ4MTRpKlfENJ57bsOdgpnOnZnv+xHByhhSEUv4oQm+A9ZEeOr4eZ/WGRq4
         b5qQ==
X-Gm-Message-State: AOJu0YxYfKu9XKXgX0BRaJaPo3NV0lU6nx7Gc8dphKM+lvjIDe8awbGr
	NpODzWdPfqFc0VQkPwb6QL2MdUlWnRGVa/zgtMvxZgS+7U6Zq/1k6hKt
X-Gm-Gg: ATEYQzyWvucorsG7aGOr9N7U1yGzHeDbECJ/YCcIOKgQjJPvNG9IEzsJ56PTOw6Nz/W
	e6NxZpbED+5/YqKI7WXop8dHPrEm/9y74gkiNxDpZOJ4kh7AHM5Z2YFJrlEgDXDy8GzrjweZjyh
	iDmzvr2VFbN4Jhsi2oh3g0tLa8wU+Lj/dTy3Ejj6UqpMH31gzC0F/KIv77TQQ2Lw8mUWxZdiozG
	dYdrP5bVvO5EHaNEzo2VIzRn+tyzAYk9dWiGJ5a+vN1HzXsNpBEUppS7CETNSzDVwZd0/TEK8kt
	9x+Agsp3IqZ57KhcFxxUdo5snxHA3hUcyaXnntGk5nhTbOFkdewgdmlXEhZa4JZSen3NCZf0JeO
	OSy7EgBPpMZ3h8Xwu7Gwi8PMBsRYYXLbWN33T96DDrPrloS17Mds9OkeZdZ8JgND2K9WlA3MZRc
	Bde+rP6AEJt5QPEfIth4dsi38ZHVAuEW5N0SScVqhrzhLpFAmzutDsPA==
X-Received: by 2002:a05:6122:1ac9:b0:563:618f:b7e1 with SMTP id 71dfb90a1353d-568e475251emr8188373e0c.4.1772048240542;
        Wed, 25 Feb 2026 11:37:20 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a6d5ccd1fsm9575121e0c.8.2026.02.25.11.37.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 11:37:20 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [GSOC RFC PATCH] builtin/repo: add path.in-worktree field
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260225190306.39358-1-valusoutrik@gmail.com>
Date: Wed, 25 Feb 2026 16:37:05 -0300
Cc: git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <05C28DD8-251A-4990-BBB2-26C144CAD982@gmail.com>
References: <20260225190306.39358-1-valusoutrik@gmail.com>
To: SoutrikDas <valusoutrik@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)



> Hi everyone,

Hi!

> In this patch I am trying to provide the equivalent functionality of
> 'git rev-parse --is-inside-work-tree'

I'm not sure if it should be in git-repo-info. I mean, this information
is more related to the current directory than the repository itself.

> I found that I could either use the 'is_inside_work_tree' inside =
setup.h
> which does not take anything , or use the 'is_inside_dir' from dir.h
> and use the worktree directory in the repo variable that the function
> is getting.=20
> I went with the latter because the former was using 'the_repository'
> inside.

Makes sense, but this way you're re-writing `is_inside_work_tree`
inside `get_path_in_worktree` but without using the is_inside_work_tree
variable. I don't know what's the cost of doing this.

Something that I would question here if isn't it possible to make
is_inside_work_tree accept a repository as parameter and then use it
here.

> Although I am not sure if 'path.in-worktree' is the best name for it.

I think 'path.is-in-worktree' would be better.

> Also, I did run t1900-repo.sh and it was failing one test case,
> which also ran with an ok when I added the new field to =
REPO_INFO_KEYS.
>=20
> [1] : https://git.github.io/SoC-2026-Ideas/

Everything above is not meant to be a commit message. This way, it
should be placed after the scissors mark (---) or in a cover letter.

> +static int get_path_in_worktree(struct repository *repo, struct =
strbuf *buf)
> +{
> + strbuf_addstr(buf, is_inside_dir(repo->worktree) ? "true" : =
"false");
> + return 0;
> +}
> +
> /* repo_info_fields keys must be in lexicographical order */
> static const struct field repo_info_fields[] =3D {
> { "layout.bare", get_layout_bare },
> { "layout.shallow", get_layout_shallow },
> { "object.format", get_object_format },
> + { "path.in-worktree", get_path_in_worktree },
> { "references.format", get_references_format },
> };

Ok, the process of adding a new field to repo-info is correct.

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index 51d55f11a5..d793d1b8e2 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -10,6 +10,7 @@ REPO_INFO_KEYS=3D'
> layout.bare
> layout.shallow
> object.format
> + path.in-worktree
> references.format
> '

Test missing here.

Thanks for your interest in contributing to git-repo-info!

