Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51251D6DA9
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788610065; cv=pass; b=mmYushmMx8l8Q01/Ml3Z+ZE06Kkyj0KSqPN6IWtC48VSXxBRwX+Jc+9qhSyrkzDvfxCJhCaI8zwmw9sQmS8YtGrZhFGzXapBPT58bCBrl0X/vHSK1lnUwox+c1CNfvCKaQ4cUgFb6UHYR9GL8wZA/GPJ2riS4FEh3V60ad7O7Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788610065; c=relaxed/simple;
	bh=hkywG2KphYDmivzPcgVi5FRlGta1KwIgRMycd00rtXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwCUA/Fh1qjDgHz4fS3Q2DtnZTUr8yXVpayWvnAWM4bDqsc5sOq/6IToCYFpekY3zEvaCGkyaLRex162Mlexys1QVwZsxWnqy8TQFU8FHaihawuiy5qYQo+xcdg8ORCIhJvikSq5aFb2R7CDBEZ7oqzMY7zB9VSTzIByPJSsO+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sl7Z6d8N; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl7Z6d8N"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ce98cb8165so20983055ad.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 05:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788610063; cv=none;
        d=google.com; s=arc-20260327;
        b=OofLCflO1gKsacle+asINqFUzftFN/Y1GZCAGJiJD2vbze57GZeiwiHijzOPI9Xr6a
         Sgt9IBxj6ZokA4Ewc7kjoAJEBGOCGmrnh1zGRI9Tpfy+bHdwBvux4U21CCqOROImdnd8
         S2p7SbL3SuhS/OMLfS8nI+GfXgAaCcvCchWiJVrgcqYPOjFvtNByLjVGFPT8nQgDylfZ
         JnMHImAUJi8TKYcqCpzG6onf3rGLtkvN+yMwh0Z8zkuIQit8aq9jpwP2IXpcVVI7Adv9
         w5p/ZGV6StVccW4IgzU1SxIZVFnVcfF3eXnB4MHM+8EFHF0LPC8xd8AzIql4jWwqgSNm
         d+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m8sjWGhIObwuMMsMWhhG72BT6czrgPMryze/SP9hYqk=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=I4m1aVYUagp9VbNju2IAMQcNawrexregY/WRec1AHg8LeKe/b+ZxUJOVnMiSDltNp4
         MrBckBrskTE6nuAURQ7D9gxraxkdWWzMrFFKxgGSazKpuQKl618s77VMDoiTo3aMtbYd
         NMJseFwbE5GGayOED8toTMbEiq7phEHcE7es4mppPbLYl0xKW+6CRGijabXNTlOgnt/K
         JupzyDTDgYNB3iPzRHHUHcaQ0BX763rWjuIs1Rc8tl73NhzoLogTC/PgkD2aoLGxkIgC
         Zk8glA1AaiP/82GJQtODYuCtVaeQ0jJ6ytGYycGa9M5UoyuDAKy4CskJv7mBdrAdyFhu
         ajFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788610063; x=1789214863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m8sjWGhIObwuMMsMWhhG72BT6czrgPMryze/SP9hYqk=;
        b=Sl7Z6d8NgY0N0NU3N82YJtkBq4fscVbhprK/y4CpaNyfZQGBTUO5rO0WePEST7l83t
         v97NvAPmLt5+y+eBHZm9EPxvNAkNQdTG5EfG90bCYIKTIVwwWNdLg9vk16PtFfBZnVIU
         OLW3YRQi3QsgYTXsePJKmXbSf7VKcWSoto96DvkT88gIQZ8mB2tfL0xA7GPPJGIdbwWM
         yBgzcT0GCcQs/3vljk0SbcpdGTmSa2u7BTlBm7FcjhqQgwaqCORuSiqMTMp6dmDm8Qv1
         M92Xob0jr28A05TeRVq84pgM0gdy/N18idQ9MIu4qI68wCpLxVdAcFmuXmd9ntX/oN0V
         CYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788610063; x=1789214863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m8sjWGhIObwuMMsMWhhG72BT6czrgPMryze/SP9hYqk=;
        b=EFZPXvVB4ejX+CfuZqBON3c3MoSQqMeZAxvwc0J+sN/0JAvkmX6/JgyLwG1UaJw3Do
         x6P+96C9uA9JWgw5n1+aZT93/v9R/Qc/z0qV1vG5iyW6omJx0sDMGaoWhV4w7QOwF6uw
         I59XGMoTI2AB1vH++lELJaod72blQwqUlUNjRKIHyiWGlH8jkAlTJw/Lsnp+UqcvZFZp
         6zwmXbNxPPuAK836tIFmxZ2m1yE4LAPEoHoGxfMaXynCH1fSXTW3gEew+sGevmXyPn5M
         /cbXvbJ/iGCExKZIK5WSYylzsJVWVogTNOQyDHXebHp48TELlFGcGsO8czg/tgmrIzeI
         IdGQ==
X-Gm-Message-State: AFuF++kU8GMT3aLg1mN0377fLEX8ucfgkSr4dMP3bhBmCa8u6KELgLPy
	VD/ykLnSouMtuiYGSYaqvlTZxX5BUHyGVP8L+pS4Gwwsxk6ahrwMnxLv20/g3asC0/7ezwWSRSr
	bnR6VQboEUruHKj0RqhVrfMOVAVzkdGu9UWm5
X-Gm-Gg: AYBFou3ce849j2Hmq0fhPP6EHjMFap0K0UsmUYD3DgwVze0sfeLjxeD5xjFW/tVKN9o
	vKk6xaOJqIkD33IebVrV/VtoCboQX3nfiwdlEiKEb5blLxudOFmQtInOvDYE/kPbwCP3P6EgNoi
	Ke1oFw13wAw2lmfB4azhIICaJDS1Jua7x9ClwV1BhFtQxtuiUyDpSpRb1QfHWc9C3dcE/X/YJY4
	mJ38HY1sV3OA4II2zR8/6RdcPwdqPl02GsVcxtbmwgTeg3gfSA/yGjgYsowIUS21Do/jN4UsoAj
	ZBCdyb0zRWO3lNHElLiiQ+dtzHqhujtUTRybBf7NyvLG7MkPLNmn2ZY1VbbMCjnt5wrq06YWJhQ
	6nl3n318r5+fzEgDRFLy7QxZ90xCZo82GRB4EncqF7brulZlegUjeij637gKJNdb8Afhy4sd+
X-Received: by 2002:a17:903:380e:b0:2d9:80b:1674 with SMTP id
 d9443c01a7336-2dafaf6070amr177653605ad.8.1788610063072; Sat, 05 Sep 2026
 05:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq7bl03723.fsf@gitster.g>
In-Reply-To: <xmqq7bl03723.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 5 Sep 2026 08:07:31 -0400
X-Gm-Features: AcwNN1VbS6cosDR9ksoYUCNlSmjh3exsEoVjvZ4lyjQpXO4EEmVpxZdY5FIGUgg
Message-ID: <CALnO6CBALuJ2DTm3_NSH1=Q4DLEFWO1EKHQeHPCg+Luh9cY_qA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2026, #02)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> * dk/use-nsec-runtime (2026-08-31) 3 commits
>  - core: convert build-time USE_NSEC into runtime core.useNanosec
>  - environment: align repo_config_values_init with struct declaration
>  - meson: expose knob for xmlto relative links in manuals
>
>  The build-time knob 'USE_NSEC' for nanosecond stat precision has been
>  converted to a runtime configuration 'core.useNanosec', allowing
>  distributions to bundle one binary that adapts to filesystem
>  capabilities dynamically.
>
>  Waiting for response.
>  cf. <xmqqbjaefhwo.fsf@gitster.g>
>  source: <cover.1788206466.git.ben.knoble@gmail.com>

Reply is at <https://lore.kernel.org/git/D0BA1B32-1CAD-4328-A612-75A6484130=
17@gmail.com/>
:)

Of course, you'll get there when you get there. Other commenters welcome.

--=20
D. Ben Knoble
