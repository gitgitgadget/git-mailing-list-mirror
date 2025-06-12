Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1944690
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749699101; cv=none; b=H58XlLcYarzy/kCDGZ8QcpB1hWfDHoatzX1KFlv45e/QALrM+r1yI8ijKL8jNQP/X+rBBcEkxqabN/zSOgwvD9uJdHO5b1u01PStMdnDmdNqaREZQjapFVCuS8ZDUkEu/ZC2/z62rlIsfadvl32MgW85O/J+0XpoawYj2cLjnac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749699101; c=relaxed/simple;
	bh=frNGxnnhDl/g3JSHnRdgNx18LnYntuXIcoxIrLquYFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUolUq7biBCb1hfKT1hjKNZilhxvBweLB2kkpa1Q/wKWV3ZRferfkoz1i/ZBDZUp0DUHjnwAClIGt+ptwxHmUn6Gcz45a+2E/lGHEThywxDaEf0I83vyECUV8Y5SeCEOcQ9xh38jEvIuGiKWhlE6wU1nbcCUqBVymiklPKETW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1A9Nf69; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1A9Nf69"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23602481460so5200115ad.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 20:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749699098; x=1750303898; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wbf0n5a5XrEjK8L1FE6afikyZ+LT+xUWQP5tfWT7ldM=;
        b=g1A9Nf69Cou4rb3JVEZMk52gk+sKLgGcrFOyqTDu3bOzHVTtONmA9LCMNkxhacTGg0
         cysBU/zeHJJZwrTG7NLvxjbUsrA6YZ7RKmS96uYm1l3kgJGsz2BufB2Q1XG0JlC97XND
         3Uot7o3lVvOM5BR9HhR7/d2BFjpw5L1f+PGRJ60CspBRtBv+fLsmMfO6zSv6Iu6LX6oq
         OPBTwHNlD2z+QlXogdTWBtOf0i5Y2CMorh6LhSVnz4U4o3D/BeRw4/YxbAGGogDldar5
         QmvY2AnMGGRAzsIQi82z3VcLbwCB4pe5I1mSmUX+FbCU9WrLCEIdy80H6+NWHLlM99lR
         TAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749699098; x=1750303898;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wbf0n5a5XrEjK8L1FE6afikyZ+LT+xUWQP5tfWT7ldM=;
        b=GOUHt8Roo5zX2aBnvRJVRM/k/VdB4fsiiBdeBsQKpzp0zBzUpCQlmkNXcSSC09vfKp
         64tL3wsJoGxaTh2r8THNeKBgpUsozGBwHCP6YDnchoiKa1N5p/xbuZz5zF/Vd88sij1m
         nP6GGzaWeRyzSIFvDgcBwJ5l4wllt+viH9IGef5T3BxXFcOdZUD88DiZACF6oPNQqyVN
         Z+efEZ1iH4W0eUwGzNcx0VKOFspCEdksCt6RVbS9hwHQjRXS3RsTW40g2uNl72wsm9AD
         il8b1CaV4IxHDYJpoeOTQ2bMgSI/M+rOe7ALPjKck7iTAUb/8+rP18FZiDTeP9TPmWx8
         bSIw==
X-Gm-Message-State: AOJu0YwWKTke2KYQoanLirdaxzSfqw1+D5OT6peEY6JYk2cIcDaaGlFw
	/0Dr8V66OH2pjXgOk37nlHBLNWpuRA8jLB/HnzgrgS3D1nDuFMygcmVIEAvhqA==
X-Gm-Gg: ASbGncsY0HI3ihhVL2wBgxUVnOaexv+W00CgoPsu2AL69TXGC6myo50xJu6oMa8fbZq
	LR0c3nZ8YYaA/FWs+kpzp4ORXBUCqcVtLaU3EJw1BnUDZnwGvD8mvHJYlhMLzkORFyE6oA+Xeoy
	/Hhu90C4xNtEKdAdFTEuD87OaozGl1rD1mBeo77jaq6sNnaL+Ip6oSq/xZZ2RxziNZZ1oSB+E8c
	8UPVxRwCd/ywWdhBRqr6EiBIXU/AjsHCOookQLhvASUZQJTNaiZDjlhA614E3JVm3eLqWDmCVxG
	gdhoXUWPAdRt4poEPQP67grCdE+AhzmVz+WBz1mZ0W8=
X-Google-Smtp-Source: AGHT+IHTV5akqvc2mS10ez5k+q9fl4zy3nGSiUpn/fG8203nyomY+z1dWqkGdFv9q7ISQt2yNdGpuQ==
X-Received: by 2002:a17:902:d552:b0:224:1af1:87f4 with SMTP id d9443c01a7336-23641abe7c2mr96153035ad.22.1749699097722;
        Wed, 11 Jun 2025 20:31:37 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::53de])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6f9abcsm3427755ad.169.2025.06.11.20.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 20:31:37 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config.mak.uname: update settings for FreeBSD
In-Reply-To: <aEpF3ZjNwkR8FssX@humpty.home.comstyle.com>
References: <aEpF3ZjNwkR8FssX@humpty.home.comstyle.com>
Date: Wed, 11 Jun 2025 20:31:36 -0700
Message-ID: <87ikl1eiuf.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Brad,

Brad Smith <brad@comstyle.com> writes:

> FreeBSD 6.0 has memmem().
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  config.mak.uname | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index b1c5c4d5e8..da592eeaa0 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -302,16 +302,10 @@ ifeq ($(uname_S),FreeBSD)
>          ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
>  		OLD_ICONV = YesPlease
>          endif
> -	NO_MEMMEM = YesPlease

I don't have a FreeBSD machine that old to test it. But Gnulib's
documentation says it was added in FreeBSD 5.2.1 [1].

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

>  	BASIC_CFLAGS += -I/usr/local/include
>  	BASIC_LDFLAGS += -L/usr/local/lib
>  	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
>  	USE_ST_TIMESPEC = YesPlease
> -        ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
> -		PTHREAD_LIBS = -pthread
> -		NO_UINTMAX_T = YesPlease
> -		NO_STRTOUMAX = YesPlease
> -        endif
>  	PYTHON_PATH = /usr/local/bin/python
>  	PERL_PATH = /usr/local/bin/perl
>  	HAVE_PATHS_H = YesPlease

Curious about this change though. Are you basing it off a FreeBSD system
you have? Or do we not care about that old version anymore? For
reference, FreeBSD 4.2 was released in 2000.

Collin

[1] https://www.gnu.org/software/gnulib/manual/html_node/memmem.html
[2] https://www.freebsd.org/releases/4.2R/announce/
