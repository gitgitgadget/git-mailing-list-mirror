Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376FE1F03D9
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 04:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768709796; cv=pass; b=H8vJwiYFlkQNRTbiDBSKKhNFuPRx+p7G9gdtqNYR90PkQGG5PcJQVw6YaKcHGKAtj5CVWEKvMJwWI9Bfv1SJixXsp/3yBTWYqd9xyHwe3yqBeQdEC8r4rLIOcQw/Mjw8Bogi6VpKw7him2e1GTD+lucAmO+uCAu4T43h/FnZJsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768709796; c=relaxed/simple;
	bh=Ql5jKzUFHw3qgT06RS8Hl9szQtTnkd1GOcLoUasjwX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hfql/0wb9B6kdUUCnvyVMCrVsgolhwh10MG9s0G/XxobcI59dVVsQwt5pLQBg622JKl/wzwRHOcHgAUc2GB2wCK3czw5HYLOwtDsFKDQVaLyZsoC/E1NVXKy9WDfx1K0fuLzZ1eXeXdy2JZ8z4sDuylK5Rv1WSKg02FcSnVy+2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk3uRqw3; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk3uRqw3"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b801ff00294so69605166b.0
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 20:16:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768709793; cv=none;
        d=google.com; s=arc-20240605;
        b=e+s5TenZCpQt1OHof2vfdbar+D2DzfpU0Eei1S/R3JFK5GjdxGAm3G3rbCtEVUUWnR
         jyWt2d5+WQVEmK8AbA4t3O6Q/tKz8B3DYcj2bc65wseVoGUng5O57xb4FSjIp049sqXw
         b2ISoaCSMuJtgYDDxKKiG2Hq+xo9t4Y4vWjw9m+iSGCujmL2c/d/fkdLtxls3hzbi8Jv
         mKmyOoQkCYEa+lBAs4Y3AXdhhH8NajrMppeq0HiFjkGxiHhPW63ApUqXbGpULO9vmBiM
         Sc2xLNO8lug3FEmDl82GHuNQFiu5+9/8ZN+0vDHeuvn+G6Euz5ja43u++w/yfcKYNxaB
         I3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uewH8p5yu46ezCBcDsl+TkYwULt/BuAXi+zuQnphQQQ=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=iKBLaqGJugZbAY+BNueLCgCXOQ2kIskp0lF76APed0i1JeHasIfOn4ibXDBRFM/t/y
         rBqMSGtvJ7ER5M5erEgurdmcIfil5gRuevSuibmn96UTTBCCSy6wt8Et5Yd3T7mpyh3z
         rvwETH9x3J0BY1uxAA5GZpsA2LXR6GZ7n8m2+Q8uX0taNkqur9G2Z/B63zzIax4K++t3
         UjP+I05dRSzdHT0CPadk7iSpGiQ2o4UYJwyHZ2qcchJ4kgzn2LFlVCC5Izp/Bzo5l9Vl
         4kFt7qimFZ+HFEt9e+UA8UmGAYIIq8l6vgOqYdQi0hsw+3rmZ6ckl+BZnyLQDFuCBJZX
         Fxxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768709793; x=1769314593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uewH8p5yu46ezCBcDsl+TkYwULt/BuAXi+zuQnphQQQ=;
        b=Qk3uRqw3gljyjfyuTTJfZwMLFNr6KULXBkxfa3G2Rv4ZoXD/4F8fZF6/AyunNXOeoH
         OV/jeLcV6dFQMAgV4v7OwRfAY5wtpHoYysUp7uzby92t6FcGc3jCMZoHGti1frA3xrxY
         RJn+KzDuBecFQncxqLwNP/jjG8ebWlMkTfI/9F4IQt9hyKH4eTt4I+3RWfJGPF77mpbl
         UlMknRmA79XmaklXGfGvJIadKbZfB3dvbTNgTXKRW52ViCA7GuFql6ztVsksdFYPlZvy
         w1CIw0YV2dZRcrTwXeZ5zXvofcZAHeL48B3NA2jODIsRADYNADYh6MIgDYmeMxpyNpHu
         HkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768709793; x=1769314593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uewH8p5yu46ezCBcDsl+TkYwULt/BuAXi+zuQnphQQQ=;
        b=JWTX1dkRSBLey808qeBKY3BHksNvWDc0l/G0wRsUpadZ08BC36DxkweX0bN+Kquamb
         LJYLMgG/ci2mPICoBT17PvCrB3ys6ac93MIyc7uZ1q2E4Ny9OyJAoZViRveYdjUMhdrE
         vs0kYEt3GPVP0/Iyn7mWxxhGbj/LecdXXtT96A4OWBmy8lFi6Lk1VoVcttwVTHmflA/8
         0r0L3mvmYEk6EhVNYui7whKhtqF5C+Jfke6H++xtS9ExyH5ORHKno1/eDBFRWei++x6A
         vrpsE9TBj5p/qUe+6C2qJUAKw7gJ+sECbVgDEVDB+g8BlfrnulchT2R8UEG7sw+y+B5Z
         4Y9g==
X-Gm-Message-State: AOJu0Yzl3/Nr8HMOcUrurWedSQDS4C0Mt6gIkT7UVbwFzjv4nwV6gYOQ
	IUZfj9pqWXKm90yPL9zQOGaujHHX9hpF42vkv/00wX+X9cKaTpPRMBuJBcoVzmSRay1+LJQBfku
	ZfAJ22Bhgku1V1xkpTcCBgwaot/l/LYhgiY/2ypBZ/Q==
X-Gm-Gg: AY/fxX7sgbcRr/PIJPfrUZmXVL4CNO6Pe7Jc972Mbe2QuBP9qhD+roGVf1MpXsXvXMZ
	TuetAZHQC18R96VnEMPw5IjLEy/EV6iaPnfEHBx2mK19YVjvq0l0g0ll2V+sJtC3sPtDfRdKyzL
	IfbIiaJsRGiTKXsMKWvp8lv3K/Ptg4C7WviA74vMDSBVZ2KYVuJsTws02Ihq7mmCR/qB4Zpoajg
	bFzPWpFFHB6pwMOXUPUKgK2+hwSPvFj0R174456zlaPhPTDlkxE9bz5ey5KE7Z48rJleA==
X-Received: by 2002:a17:907:6d20:b0:b87:3c4a:e689 with SMTP id
 a640c23a62f3a-b8793280000mr355192866b.6.1768709793243; Sat, 17 Jan 2026
 20:16:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117175847.334666-1-a3205153416@gmail.com> <xmqqy0lw5cmq.fsf@gitster.g>
In-Reply-To: <xmqqy0lw5cmq.fsf@gitster.g>
From: Yushin Tian <a3205153416@gmail.com>
Date: Sun, 18 Jan 2026 12:16:20 +0800
X-Gm-Features: AZwV_QhKeoFhqwWGvvHwib9EmjzkTUi2yCvf1QzJCw5EDU9ZJKgFtanfy_VEdlo
Message-ID: <CA+rU_o4TYi-9dTgReP6=+15SZ--gyZg7OK2rn=Rqji5sQ5P-bg@mail.gmail.com>
Subject: Re: [PATCH v1] t2203: avoid masking exit codes in git status
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

>Looking at other parts of this patch makes me wonder if we can get
>away by filtering lines that match "^?" out, instead of explicitly
>naming 'actual' and 'tmp'.  It seems that the entire t2203 file does
>not care about untraacked files at all (in other words, there is no
>"expect" file that expects a line with '^?' in it), so rewriting the
>above (and everything that this patch touches) to use something like
>
>       git status --porcelain -uno >actual
>
>makes the intent clear (i.e., we do not care about untracked files)
>and simpler (i.e., we do not need "grep -v" to filter), wouldn't it?

You are right. Using `-uno` is much simpler and semantically closer to
what the tests are checking (changes in the index, not untracked files).
It also naturally avoids the exit code masking issue since the pipe is removed.

I have checked t2203 and confirmed that no test cases expect untracked
files in their output.

I will send a v2 patch shortly with this change, and I'll also add the [gsoc]
prefix which I missed in the first iteration.

Thanks for you suggestion!

>
> Tian Yuchen <a3205153416@gmail.com> writes:
>
> >  test_expect_success 'git status' '
> > -     git status --porcelain | grep -v actual >actual &&
> > +     git status --porcelain >tmp &&
> > +     grep -v -e actual -e tmp tmp >actual &&
>
> Looking at other parts of this patch makes me wonder if we can get
> away by filtering lines that match "^?" out, instead of explicitly
> naming 'actual' and 'tmp'.  It seems that the entire t2203 file does
> not care about untraacked files at all (in other words, there is no
> "expect" file that expects a line with '^?' in it), so rewriting the
> above (and everything that this patch touches) to use something like
>
>         git status --porcelain -uno >actual
>
> makes the intent clear (i.e., we do not care about untracked files)
> and simpler (i.e., we do not need "grep -v" to filter), wouldn't it?
>
> >       cat >expect <<-\EOF &&
> >       DA 1.t
> >       A  elif
> > @@ -26,7 +27,8 @@ test_expect_success 'git status' '
> >  '
> >
> >  test_expect_success 'git status with porcelain v2' '
> > -     git status --porcelain=v2 | grep -v "^?" >actual &&
> > +     git status --porcelain=v2 >tmp &&
> > +     grep -v "^?" tmp >actual &&
> >       nam1=$(echo 1 | git hash-object --stdin) &&
> >       nam2=$(git hash-object elif) &&
> >       cat >expect <<-EOF &&
> > @@ -171,17 +173,20 @@ test_expect_success 'rename detection finds the right names' '
> >               mv first third &&
> >               git add -N third &&
> >
> > -             git status | grep -v "^?" >actual.1 &&
> > +             git status >tmp &&
> > +             grep -v "^?" tmp >actual.1 &&
> >               test_grep "renamed: *first -> third" actual.1 &&
> >
> > -             git status --porcelain | grep -v "^?" >actual.2 &&
> > +             git status --porcelain >tmp &&
> > +             grep -v "^?" tmp >actual.2 &&
> >               cat >expected.2 <<-\EOF &&
> >                R first -> third
> >               EOF
> >               test_cmp expected.2 actual.2 &&
> >
> >               hash=$(git hash-object third) &&
> > -             git status --porcelain=v2 | grep -v "^?" >actual.3 &&
> > +             git status --porcelain=v2 >tmp &&
> > +             grep -v "^?" tmp >actual.3 &&
> >               cat >expected.3 <<-EOF &&
> >               2 .R N... 100644 100644 100644 $hash $hash R100 third   first
> >               EOF
> > @@ -211,11 +216,13 @@ test_expect_success 'double rename detection in status' '
> >               mv second third &&
> >               git add -N third &&
> >
> > -             git status | grep -v "^?" >actual.1 &&
> > +             git status >tmp &&
> > +             grep -v "^?" tmp >actual.1 &&
> >               test_grep "renamed: *first -> second" actual.1 &&
> >               test_grep "renamed: *second -> third" actual.1 &&
> >
> > -             git status --porcelain | grep -v "^?" >actual.2 &&
> > +             git status --porcelain >tmp &&
> > +             grep -v "^?" tmp >actual.2 &&
> >               cat >expected.2 <<-\EOF &&
> >               R  first -> second
> >                R second -> third
> > @@ -223,7 +230,8 @@ test_expect_success 'double rename detection in status' '
> >               test_cmp expected.2 actual.2 &&
> >
> >               hash=$(git hash-object third) &&
> > -             git status --porcelain=v2 | grep -v "^?" >actual.3 &&
> > +             git status --porcelain=v2 >tmp &&
> > +             grep -v "^?" tmp >actual.3 &&
> >               cat >expected.3 <<-EOF &&
> >               2 R. N... 100644 100644 100644 $hash $hash R100 second  first
> >               2 .R N... 100644 100644 100644 $hash $hash R100 third   second
> >
> > base-commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
