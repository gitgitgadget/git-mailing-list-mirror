Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A323B0AF1
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000425; cv=pass; b=m/eTDQwwI594oHlliiMjttnAPuIFkhvbD+uG/a967RGohvRBRtYHCWnNHTQYXlciOXX0Lb3DAIsefnaXCXZLMBRSOIRAxEYgaOGB8HemgZX4/uttY30duc4S8sSdg4GX9jUAq3D4v5rcmD80sz+QBrDJZHMzqVh7qtfwPRjsbcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000425; c=relaxed/simple;
	bh=Fvst+b7JmKZwnY4ASAemxBCbrPKfMCTdp5CeUCytrMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJm5ZbqxkHmtwl46Q0YJeQJ9IoClR9bz7WwaBoEPzle7AzSovszvbar9gCD06Tw5X8PzeoKeqWAuwzTuSPvZ3FvZhzsTNJ3wAsqAsMaHhFhtPuwmogE5oM8mFIcOPWQM6Lhaa4zC8ULAZ2liVO7KFcsg0riQSOWMuk2VEgbWDfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyZCCGOz; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyZCCGOz"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43ccf0ba2e5so2193947fac.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781000423; cv=none;
        d=google.com; s=arc-20240605;
        b=dN3mOq+Nri3SbLTG8i4j3tTNJ0hqQtUKTa5y+s/BEJO7zGir3T5qBbhdU5zRXMNm66
         43KiNWopA9WUoFvUiBPrVj7WX0gucsVhKKxDetKo0HA+cHRIQIzUIEXWPrl8A9Z2K6KM
         zG+n+rkC1z/BRw4rwXK2yQQKbEantOKo7IaIlfv21cbjOV+Swxg/lVhwBuMbbRBHac6B
         80g7PXJdVwACDzRcJ/rkHQYp17MLNsB2G5zcLdcvErm1Xdnjm7PmABeNmd1YywHB3QHb
         OtZJljcQPfTrJ+o/mtAXLOGKBhUQHqdZ0qHUqFhmWovdhfc+mmAFFHA0SSphLLOuA/wr
         DDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+G4b49xADV+UhxzQ85vZKvmkydeBXPAipEb0tDsSwko=;
        fh=rHIRI8tvNIazrMhntkidDQGrAFHYVLuXLalOS3XgdyY=;
        b=FZ8tJwpsbrtqWm2ATQDuZMylMXZOEe1IkJOTrvJVrkGMCQ7xDPQU9owyQMApcXcdlG
         JRSjhKWUdNTyGrIaNBSruLJQheL45UGgOSeOJgvIE/kIQGpd6YL4tRpd9A+pZhLryR9J
         bhPBfBqHrsVKccUFV/QVozRi7Ni9GBGxsBkAlVEGpJaxQZW130U0AdF8G1gwqViWClGn
         zfgih9CIQ+XN9hywI7bjPYwqkAoFd6FNtd15h588WcfX9nPj/eRnk4Vgld8Hs8DpdzDA
         uUl8XxKj9uerBNVnvkpDok3o54p4EYVOgJ1oHnoZNdsBPOxnvXWlrT4dgX6FDoRsXPOw
         AuWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781000423; x=1781605223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G4b49xADV+UhxzQ85vZKvmkydeBXPAipEb0tDsSwko=;
        b=CyZCCGOzIAyJ96mUboR9hgDynJE7q8bntyLylv4WCaObNeAuHMAY47epe4ytg4kq11
         K8IKqx+B4bJXnPmvj8FETT7/c+WwGNbiGoqdbSLNWa7TJGJhR15Iae5hB901AzRTHOqQ
         vvNQtMD0FymqnpkrC5B56igI7N4fnTswYYc08epvauwxyKdd02MQQDWsX0FZs1xToSEr
         /UytkI2NRduyEnbmw+L6mK0euAcGkFmkC+93ttXKR1/KJortGE1oqc3vXGTUp4iBwkGs
         EhHXgva3ol/HHVUPD4gNt+QsRdn4QgPBL95m4S5ZV5qXaIHmSaYxjTwHJy1HsQvix4sI
         DPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000423; x=1781605223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+G4b49xADV+UhxzQ85vZKvmkydeBXPAipEb0tDsSwko=;
        b=P6Pn0BKAxzZmUFnu2ns5lgou35AfEDvEc8xG7EMn+IyQ3Nb96bLCwpo1LUI1r6LSiM
         EtuC4WdxXaPvHbkEqBdXw4lMP5Ltp/wV06NosEqMkdvtOq3vRxMuQnKmZux5bIe2AObE
         cCRdRkxmYXFWnI+u64v4YeBOqbkRhWgtLYOlKy+wlV5i5e3YPb9Vu7GI8la4wf1Olan6
         mkjznbj0zALbeDhaGJ8pgOE5Jw763/6KvsoIV7PMpRTdxeSSr9Wx5LuOlrqm99BdOBlT
         MA2tzrBJdedVYQe5Ab5TZremIDQ9375pPwbYI84hDbfN0otpm6hhNX3zsRgDYsStJPCK
         wiUg==
X-Gm-Message-State: AOJu0Yy9P9/eNcYnSd2jnn0HmkFGwmHpeBiyzN0UNvqe8K6meAag4g90
	3pZD5JXX763Yw5ahAJ4ShR3WGORcQWAcaPNYsQov6gOot5HW3Tq8r0hWOSPBuPmKYrmQvwrkPsn
	jwfYCHCEb0vGUocBvNEPyK6nzo0SFSRc=
X-Gm-Gg: Acq92OFgE5hyY67RtdVP/ZsDoiNNWbAVcCyvNDtI17OK47e82TMS63n0VPaOFbbL0US
	QOg5+lnCr+GB1jmWwVcXoxrFS2YKaQMYdQcGkLPAfVa1Fz4VmrXk2z+rYt0G4LlBEIzj8TtLiDo
	efhK1+AwsjXkbqczpcEbGdKBExrWxHYRjS7oqqqCB/H0wjM4s4zdULYFdsa0ssoZCA/9N7EOa/Q
	xwHC+bT6eDXTEWWh+CZ0qUpMURieZw2kssSNylZOFF2WNNIqyvuVXlSDummRZR/FuPwbDcolZfs
	JHTSg33SnF9kabh8682QuevhpueUXdoXC0Nz7ShCaHTzcL1RC0ILRCUexU978hVz1h+vV81iO5P
	4dEVyrfbqjamCZQ==
X-Received: by 2002:a05:6871:358d:b0:42c:1f88:ac with SMTP id
 586e51a60fabf-4413dcbd75emr9408115fac.29.1781000422888; Tue, 09 Jun 2026
 03:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606143412.15443-1-cat@malon.dev>
In-Reply-To: <20260606143412.15443-1-cat@malon.dev>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 9 Jun 2026 12:20:10 +0200
X-Gm-Features: AVVi8CexwseUkp7dhjSNONj7l9xMH72KbtxHv3188NHl40sheYFdGgzgMU_8mGk
Message-ID: <CAP8UFD2vhb3fMp0sfJKewYm8H7HQQ5+dZnQFijDL4Z5Mcf3SCQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] environment.c: move 'protect_hfs' and
 'protect_ntfs' into 'repo_config_values'
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, christian@gitlab.com, phillip.wood123@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"environment.c:" in the subject could be replaced by just
"environment:". It's a bit shorter and it better describes the area of
the code where the main changes are made, as changes are not just made
in "environment.c" but also in "environment.h".

On Sat, Jun 6, 2026 at 4:34=E2=80=AFPM Tian Yuchen <cat@malon.dev> wrote:
>
> Move the global 'protect_hfs' and 'protect_ntfs' configurations
> into the repository-specific 'repo_config_values' struct.
> This will help with the elimination of 'the_repository'
>
> For now, associated functions access this configuration by
> explicitly falling back to 'the_repository', which needs to
> be addressed in the future.
>
> Note: In 't/helper/test-path-utils.c', there is a function
> 'protect_ntfs_hfs_benchmark()' where these two global
> variables are used as loop iterators. New local variables
> have been created to replace them.


> diff --git a/compat/mingw.c b/compat/mingw.c
> index aa7525f419..c77696ba8a 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -3392,7 +3392,7 @@ int is_valid_win32_path(const char *path, int allow=
_literal_nul)
>         const char *p =3D path;
>         int preceding_space_or_period =3D 0, i =3D 0, periods =3D 0;
>
> -       if (!protect_ntfs)
> +       if (!(the_repository->gitdir ? repo_config_values(the_repository)=
->protect_ntfs : 1))
>                 return 1;

I think the code would benefit from functions like:

int repo_protect_ntfs(struct repository *repo)
{
    return repo->gitdir ?
        repo_config_values(repo)->protect_ntfs :
        PROTECT_NTFS_DEFAULT;
}

int repo_protect_hfs(struct repository *repo)
{
    return repo->gitdir ?
        repo_config_values(repo)->protect_hfs :
        PROTECT_HFS_DEFAULT;
}

They could be called by passing `the_repository` for now, but perhaps
later in future commits `istate->repo` or something like that could be
passed instead. Also a code comment could explain that the `gitdir`
check prevents calling `repo_config_values()` before config is loaded.

Thanks.
