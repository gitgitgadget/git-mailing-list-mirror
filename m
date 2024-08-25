Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71A2AE97
	for <git@vger.kernel.org>; Sun, 25 Aug 2024 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724582735; cv=none; b=SLCm6eeiPmNjJKtwbK4G5ADwx53Lcgm1g+P5/ugoEbiVME9d5gimekcAxJQvibroiqNyCDrfNjRgWvdIrAU2sK0LfKGieNu5bdetqh7dw043lzVcdQudcpTGpIX+bpOvxvIpUEQPUx2wAg0b90Y6gtG1I8Y/2BgTGtyhrMScLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724582735; c=relaxed/simple;
	bh=qHGrpcx90jKXBEvgcoaaAPQvR+wd7A5DkyGeol56KRQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=RIqG9h7pe3wfH7epZ5wZ+fsJQ1YLMlt2iqeWdCdqqbe/a6sv1jCqw6lpRwHadmvCSb/TOstXdr17iA/Rky9EauK6rLj3la55v3c8T9rOmhj7eYyK5scJBLt6epcenoTBDKDWpV7IkJbtqkYDjUMwQyKBCgnDhhpWeyjl+r2ILik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHaySWjB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHaySWjB"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71446fefddfso1527070b3a.0
        for <git@vger.kernel.org>; Sun, 25 Aug 2024 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724582733; x=1725187533; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEg9wDUaTdk3c9FtGycHIXHMEPRqrx/UVB4mVuoCbu0=;
        b=fHaySWjBbpXMo7q8Tq49JQF/18LI9XXgsUyw2fgAiauWR106YeNFD0wFmnxNsfISyg
         7enWGE+KHQlAp3G7Uuc8HGjthVGwkHrIZhkEtGrK/2r4Fhj5owwvby9fTDFVpXU4KQvP
         /2x5+zUsi7pdir2jyGtbbpTxHXdwMMaXSzG36X/peHhNaSeI2OgGS0Jq2gAo7vAIU/0c
         Qkq9T79XcOYy2E6Fv8KN4MuXcRRY+xJeGX9j1HBpmwCmT5ESiJsZ6FM92Y9/D8zBMZic
         hxpmYyF6pNO5CHHIqK/cx4ScB/zV336d2CkIP9B9wax919SExWj8z1+iDkRlg/AJYmSP
         Au/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724582733; x=1725187533;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OEg9wDUaTdk3c9FtGycHIXHMEPRqrx/UVB4mVuoCbu0=;
        b=IsoYrVcQ+TzTHSnjp8bCUCNrCkvpdl/mm3h4/LlpssnwI0cz2vl4YJLOik5da29P06
         yFTRWE4iOBO4xErEcOkzXeBMT8KpifExI11645zPejigVUS2PRe88bZg+Yo6pwA+5rtv
         VhA/oCt44vW53tSpjr3OguS4x/e6qyzuseoUKU79s/kS/Ab6saKFfylO1vBkOwcZPS1w
         JeTuHvB1/xmFnfABIMA5N1DKYDYt9vNZYXqI70V/f10DEKrnjtQ/Jh26wKsFC60zBCfS
         yEiV+OfVpANP4k/frbkk/smkGCb/D/yZpbBz+vEO5jm2t0h/DXZcaQbdxlWQcpEocXUd
         j3jg==
X-Gm-Message-State: AOJu0YyFs2STSg8q51YDQPMCqgJMucChbccyTt44XYr/T99uOhgg54mj
	+upJy/7HjwEsAH/OkigNlqnqAXwy2XQ+X6oMde1eMasNYmpaJkS1
X-Google-Smtp-Source: AGHT+IH5O8cykQjnXOathNa0tTy7LFqLQgAg96mKYInYRXYoAdQCUH5qetTpVZV5Zbm6qy2s3m1FLQ==
X-Received: by 2002:a05:6a21:e8a:b0:1c6:ed16:30e4 with SMTP id adf61e73a8af0-1cc89d29e87mr7990329637.7.1724582732486;
        Sun, 25 Aug 2024 03:45:32 -0700 (PDT)
Received: from localhost ([106.222.205.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567f74sm52183075ad.60.2024.08.25.03.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 03:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Aug 2024 16:15:27 +0530
Message-Id: <D3OXJZTMW1BP.1EYWBW4CTQVES@gmail.com>
Subject: Re: [GSoC][PATCH v3] t: port helper/test-oid-array.c to
 unit-tests/t-oid-array.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Christian Couder" <christian.couder@gmail.com>
Cc: <git@vger.kernel.org>, "Christian Couder" <chriscool@tuxfamily.org>,
 "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>, "Phillip Wood"
 <phillip.wood123@gmail.com>
References: <20240803132206.72166-1-shyamthakkar001@gmail.com>
 <20240824170223.36080-1-shyamthakkar001@gmail.com>
 <CAP8UFD3mq+k8QXDrFAp5bfoCN+sNgm3vJvuhryxVYDaj-SZU0g@mail.gmail.com>
In-Reply-To: <CAP8UFD3mq+k8QXDrFAp5bfoCN+sNgm3vJvuhryxVYDaj-SZU0g@mail.gmail.com>

Christian Couder <christian.couder@gmail.com> wrote:
> On Sat, Aug 24, 2024 at 7:02 PM Ghanshyam Thakkar
> <shyamthakkar001@gmail.com> wrote:
> >
> > helper/test-oid-array.c along with t0064-oid-array.sh test the
> > oid-array.h API, which provides storage and processing
> > efficiency over large lists of object identifiers.
> >
> > Migrate them to the unit testing framework for better runtime
> > performance and efficiency. Also 'the_hash_algo' is used internally in
> > oid_array_lookup(), but we do not initialize a repository directory,
> > therefore initialize the_hash_algo manually.
>
> Even if 'the_hash_algo' is used internally in oid_array_lookup()
> through oid_pos(), this patch initializes the hash algo for the repo
> using repo_set_hash_algo(), which contains the following single
> instruction:
>
> repo->hash_algo =3D &hash_algos[hash_algo];
>
> So "therefore initialize the_hash_algo manually" is not quite true, as
> it doesn't look like 'the_hash_algo' is even used.

the_hash_algo is just:
    define the_hash_algo the_repository->hash_algo

and we do initialize the_repository->hash_algo manually.

>
> Also I think it's not clear how initializing a repository directory is
> related to the hash algo.

That is mentioned because the old code in helper/test-oid-array.c used
to call setup_git_directory_gently() to setup a git directory, which
would also initialize the_repository->hash_algo.

>
> So maybe something like the following would be better:
>
> "As we don't initialize a repository in these tests, the hash algo
> that functions like oid_array_lookup() use is not initialized,
> therefore call repo_set_hash_algo() to initialize it."

Will change.

>
> > And
> > init_hash_algo():lib-oid.c can aid in this process, so make it public.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> > Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> > ---
> > Changes in v3:
> >  - changed commmit message and comments for more accurate description
> >  - removed test_min() and return early when actual.nr and expect.nr
> >    don't match
> >  - rename result to expect for more accurate description
> >  - removed a redundant check in t_enumeration()
> >  - add check_int() around one of calls of get_oid_arbitrary_hex()
>
> This looks good.
>
> >  - rebased to latest master
>
> It's nice to say it was rebased, but it's better to tell the reason
> why it was rebased.

No particular reason other than the fact that v2 was posted 20 days ago.
And it is not merged into 'seen' or 'next', so it shouldn't be a
problem.

Thanks.
