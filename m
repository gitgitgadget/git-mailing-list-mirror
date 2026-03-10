Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6740DFB1
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150034; cv=pass; b=ljRVAWDKpTlDeM5d9HPwpkbBnvNulLreIG9UHwu1ZahgqtfB/XYe8zAyttkHN7mRphJGmVDWRr6ZpuumTAbx6ul/EbKJ1KBrvjEvSKstNQYZcTSQfmE9fGdh/DRf8pVv6Bt3bbCKnUfAQd6H0YrsjGlon7V8F3s+tSeHoWXE6XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150034; c=relaxed/simple;
	bh=12zeIJdXvBqIOpfALzLkM6D9qPhuxsU9FrR2oB5BeBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohnaqA2ZBecbOPap+5zkwpNoe5JuCfxTeIT924hwGhSUKBRh/E7YQl7eaRcZHqpawl7vwrFtYILWz2nu49AxleJEZXLZ2xqckNXvMVWD5b+lZj7LkVxmcZBEAoEjZrhs/dH5JY1g+7HxPPU8OhdJWkXqj9RNi0KpZzdWG4y9e5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lccZyBb5; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lccZyBb5"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-94b07fddecbso8219955241.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 06:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773150032; cv=none;
        d=google.com; s=arc-20240605;
        b=eKfcjgxMR7NDjarCTMOvI5G/ClO1A7ajPT08Ru4Zs5w8+W1gCo4B3ENv0ByVWBbMDA
         0+Ux1bUt3LcAIeEG/YTsTwpnJolxaeStTg+MSHjDSn5G56OnQks4hwFn6WWYPu8oWKjv
         EwBGcvVrV3hV9KsKnEIkWRLB/T5DDvvmrbgEgF0aTinboRLf2H91VbIe1CvFGJEW4TLg
         EJOCLO77QPT4xD5DvARR1C9l12aL9Y7Eh6XoF5yJh+DWTz0Ae71cUDQDrW6hPz01Aeq9
         TAPZw4mx7ZTFDFsHntt+TFM7qRIxQa7plWCHKOL3jObJgVEmKjSX6Efi7i0F0qirm6Bs
         XjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4FzeDKhSD65GttQ0zxGCfvov3nYHhIA2usl7ECwO628=;
        fh=tfHPMg+P23O0nh6ZG6RGE89kcG7crMcoLWHG6UT/1nU=;
        b=EsE6WhOlCtcFaelot3Z0DHbSj86KrkkZaaoIvpDEZpKYlpGXzs3VlfWzrNdRCRSvQu
         E5Fs7Whm6NXehse/mBL2auHgWT5fuROW5nFzA8aTtFZcPYZ6qPkuzPqWSdx+qkp5eX/I
         pPnt1TtnvK0mnu3HU9qieP++xl/II+JeJJhpr96TVR3UDR1WSKjHIs77QL4/Y/VHfNHb
         bu9HLeTebC2d+2sUAT4cQc0+cEtIPGP2YzG0OL6vN/sbUHZfvhsV5mvrfhVV6Uz5hPpV
         NCRIRNJ3Jicwt6aTrQF1Yf4NkKWAF8NJ4mUo56mmh5DhItLKrbuDZ5ly4pb9wHYACGFY
         pBpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773150032; x=1773754832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4FzeDKhSD65GttQ0zxGCfvov3nYHhIA2usl7ECwO628=;
        b=lccZyBb5Sm5+kx5qSbh9Zqr25kZ4q2m8Yt/u4qHoBW/7b5yH0BVy8YykVX/H1FRuFb
         cm/hycLMuS5tBl3411NG0GxMCupGLqBegcno317nvbvUyqdNlvhTfePtaGkXf4nNiqtz
         CmaxGRVAHXtGEsBNKMDfFmeUA7pR5JlkbVrX8ksPa4mE4pI3XD/wWtFF8wGXjLqS7BQY
         qyGA4wjULXNVRxPBpy6aCB9UdHctkoWZcTj2//Dw7tgRrA66zkOaSnV4OIdyLjEIcG5r
         ABeuy1qiXnT+jI/ay2c/Vo4Dqi5Vra8eYRk56xnqEBBytF5ZbWIlrJ6+h6NeqvMKjtYL
         o5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773150032; x=1773754832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FzeDKhSD65GttQ0zxGCfvov3nYHhIA2usl7ECwO628=;
        b=kruAAxtQDcdyw9jhDIkN6olVZF0od5Mg8LQYMkvOiL+uRAtLDI/Bu0HXtNlPD6Ch8+
         QSOy0wj5at4LM6ptuU/hZj6OvhED6T646kcSmAa1K7R4d9/X8zaIeJ9CBF56ufaJXUlv
         EWWOGdUan8hCO9Snk7WFnXNGhbDXDoUskeVB07vjV/fL3BrSlCr1vgjJd1uaqD914p4+
         Bj0ZU9SMxh+9SH9vtsupAOv1H/ijBnrt3LCRlAM1rn5VN7tGRqJ40EU9DA5B3odfQ7P8
         TYNSZgUD7poIjEH2oig/5rAbnRtDnC0ZT0rkYXlcgiiq87S61Z6WEIHUVkqbGYi03Nsl
         oUgA==
X-Forwarded-Encrypted: i=1; AJvYcCWtGZ7pAhao7I6zI9XrLVmR8MKd29Xm27xdb7Psai6RQc0f1p/zId5Pe20lENvbvfEATj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9FtUg4Iz0RUlBFLv36M2bEx2o8XFYzm975sxvfwmJ5OV6vgw
	OS8esQW1ykat992/NMdLlkMuvnmQhkhHqxgGq883IxOLiq6U0mf8EuGJST6nP6TfGGQ1qTPDgW5
	sM12+dovC9wuFjeAAlp0OcjpBVK7XTno=
X-Gm-Gg: ATEYQzxW3VlRcMDY7CEHFTPfjgnSCuLybUJ6ExlVD45xunVuohfqyjkuuZEK03+wNWX
	evz2AKqzeK7qlQ9ORmwIQb0NCqsHrqYKv0hOQ+osaxvnWhtG8EQu3Szsml4dLxDQDEEi2bBHPS1
	HSqFNArjlBctn3DDdpkFLGoJbXb/g7VAzeviQJRltt42+VVyKAP5phDK53B6rVbAwioPx5UBL+I
	kvto7Zbmb6u4EV3RMCt+w4xe1IvSHQuL46wOYj7bb1AeO0yxLguy8cNXlkXig4/sF1fZLAD/w/Y
	u9sKsuslsY3IvFB1iu410qsY37SFeNTXZUhXLrNw/IBrlovkjB8oum9tOPlQ2xmfT5AQEbhuW/1
	Us+O2JMzFsbTdbdRp9/RESe1wwHvvUQ==
X-Received: by 2002:a05:6102:b10:b0:5fd:ef38:920e with SMTP id
 ada2fe7eead31-5ffe61f3cf6mr6515372137.29.1773150031887; Tue, 10 Mar 2026
 06:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <5f100fe0-d601-4ee3-adb9-a2458203d10d@gmail.com> <xmqqzf4fx0vo.fsf@gitster.g>
In-Reply-To: <xmqqzf4fx0vo.fsf@gitster.g>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 19:10:20 +0530
X-Gm-Features: AaiRm50Ol8t5OR7av_SooFYpdE5xJ8n_u3MUcyPGWeBNGpItAanQrlvLycft0nk
Message-ID: <CAOAgETNoQuju_RWbe=jo8JF7J2+V_pVoyr6FeKw8LwYKi_HipA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Advice on checkout dirty files
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As per the recommendation of Phillip Wood <phillip.wood123@gmail.com>
I have changed my files and added git checkout -m after understanding
its significance :)

On Tue, 10 Mar 2026 at 19:06, Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > If the intent is for the user to carry over the changes to the new
> > branch then recommending "git checkout -m" might be more convenient
> > rather than having to stash, checkout and unstash as three separate steps.
>
> I personally would not recommend pushing "-m" to new people without
> explaining its ramifications, though.
>
> If "git stash pop" fails while a commit different from the original
> is checked out, the working tree will get conflicts for you to
> resolve, and that is the same as "git checkout -m".  But the
> conflict may turn out to be too complex that you might not be able
> to cleanly resolve.
>
> With a "git stash pop" that gets interrupted by a conflict, the
> stash entry is not removed from the stash, so there is a clean
> recourse to "git reset --hard" away the conflict and attempting to
> unstash (either to the same commit or to a different base).
>
> With "git checkout -m", on the other hand, there is no such
> recourse.  The conflicted working tree with the unmerged index is
> all you get, and you get only a single chance to resolve it
> correctly.
>
> So...
>
