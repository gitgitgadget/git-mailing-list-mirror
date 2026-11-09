Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794229540;
	b=eXHEl/8k523KtRbsfMyzf2RiCL9gjBXMPu1Bq5wPtu1OW2dTvYW9rtiG6jVnpbSKzttc
	 rx6eoyNpEeLsEUlsXYn79WAnwE+1X54luDzvrKxZuuQCuvkFUXv6dQ9qfc/WF7xJlUSF7
	 OkiBwY3/Prz0FgH6Gi8C3UdU9w4KPLbm0DPl1FI9RZa4cmpWPbFsnZ3lu6dpU2nYPUBwo
	 ovi9+SuO0fFOmbCs9UJuKqORbXNeYG2hvO9sGDi1ElMNWWuHenHJkKnHm2whsIYy3yKCv
	 bjQXFG3p7OiFbLDygCUBUmH82FYvQZ9LZOvgmiha1EHvPNltWCI7LQmKGL1Jk4mxMvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jWyPq9GvpoqfIEm5KsRP28Tro/1aMFTLEDz6vfd9eJw=;
	b=ktdacndg8Zni3nEgceT6zgkumAv4d6ppv6Ytdt1O9TAW4bwoB2yyfAClgFZIvX2xbYec
	 awUq0Sgph+hi5gHJSpCmWbt+Zl0br601f3PTBAdm4RMzVgFtrvzyDxe2gvvCBWFVbIP10
	 rlqPYDZMqzgTUllcT+stPStQm9fASm/zLom57AZOhBRUa8n1Jh2yWiuxQntxamjimrI1Z
	 fCmOMWpg8LdOll3gp+RTVsvOCoUlc6eJfDPJ2bCbQOeS4oSQ+NRyZ87Uj+hxI6EKrq+hM
	 MkDH1Fx7mlhrWzm2PiEEel5lsJZz0UUSgm6xfO9WS6jCAWJX48HDqgGybZETcuuATjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b="Ju7/6E+G";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095BD606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 095BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=Ju7/6E+G
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4ceaee6770so111227966b.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 05:05:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794229538; cv=none;
        d=google.com; s=arc-20260327;
        b=aid7M4rfB4mVOEsuaZG4FUj4XKleTIKggFCraLwX6P1KqLZHZ9PTOl6aSQcgaGaJ6Q
         4xiunbDYFQYNX2jmo+gq9u2RtwzVQFqgcLoKo8y3GO1vmN3e4uKmu4qfPNNCr0hHR62q
         yrxzyPmbBgc47+KRV4v1ka+HRi0tzzcjjINVKUMf9+DiYVo9B4A89c8vQEemNeYQeIMf
         kpz2fUC4QuO66w2f2Vt6x7m0dMf4nHNrVZKG3bhz67WkTcHNDsmA9sYcmoJGDxP5qY5z
         J9kdTyp1BBwLZSI1NdqX2hNzb1cOHi/Fct/Gq2d85asGRofVe8Qs33lz2HfWlSfXIdWd
         Xdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jWyPq9GvpoqfIEm5KsRP28Tro/1aMFTLEDz6vfd9eJw=;
        fh=yHAX/HAC4i7T0fx1pY1wHx7LgzAlPnLDcG70sJcIZTQ=;
        b=jVmg9ZrE3YF490haYmVEKduV3D42wI3s6/4Itr+U/pcUCn7A6wu1xMftl7ZIo5TtTK
         9kuZomii5FH2Rd61LcshCJpx973ymJ/j3SQ0rC04KGHT9j1t551tczPd2v3rkY3KrHve
         5pTl8bY6tTFwnjcjc7TcAEDnAdz4O9YH0N13uQ4riyAgcBFGdLbhHChvyVxxLiBEC2RR
         6XVpI0TMsEicp5ympiHKexE8N4788NKBWC9SlCW44zbCYJeFuniw3Y+qiOSgVB9iGQyV
         HExbmNdFIyxiLFQqh8PYHVpo9N/APU6llH+ripV51qjO3Q4ojvebiy/wi6CZtixld1sx
         VCHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794229538; x=1794834338; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jWyPq9GvpoqfIEm5KsRP28Tro/1aMFTLEDz6vfd9eJw=;
        b=Ju7/6E+GZ5XvpgGSXF0ubp1Nvf36Xe2+H83+VZm0b+/vdmFiX6vJqEYg/Y+th6eb9i
         S8q3DMi3GoEF9QGKDAI2M/6woXTNGAHH9COOZRBGRGuk+vEZuCZmyI5mXwCQo/3vnw3c
         Bm81aVLyT8KKW+RhFcaq8eIMhSy9lsZWOrw0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794229538; x=1794834338;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jWyPq9GvpoqfIEm5KsRP28Tro/1aMFTLEDz6vfd9eJw=;
        b=E0jbTWGZRGeaA8L/8dbkudo8dj2jw2nYS/xCX418nKSJ2B6jc+GUBTTRAg1dthGoln
         SEZfRvCvFFoEH9tDHjwtHbXiUDPTILI3jtUgqya7+ZM1vIJ/DoxcHh5wVMouvg1LFv5p
         iRQrAC8v2tuPZRViOp3x64IKgcThndxBtaIrvKpIBaEhSsMv4PqR9TqXFCyK4jhe7SRx
         BDhhZ0z4uILTYBHlW5KSvQ0RIav8LIIZ/M8hPc/TKZ1PFZ6JyejKntxWmeA1j9EzJej+
         zG57Kxvdxv0D104X4uSo/WFo71rO8bM2c1vgVUKJcV72bVGvRCkTTw+mXmnhnZuTaege
         NVRw==
X-Forwarded-Encrypted: i=1; AL+hErGh78WdSKwBxZ7r3HG8Q0azdGHlhuL7zle24pRVvkJX8EplOdwyDw2+tCxENzD67T+Y3L4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KJ18yKAgAiYY/A1CeLBLtG2jCIQ2w9Yj/RWcXEjqtUSo9zBdT
	PoMZRdckO5/svl6XN5b9DOQHnZWN4VtqByKTZVNghMi5QnQU1V2tpCCtRAvcSINqNo4aK/TgaSP
	m76JDQEwlxiS1bJehTJsqW0UkFFX773YU9DwG2YS+BSTesrPlRmIaDeDRHA==
X-Gm-Gg: AYBFou0e+Jlp+rA3rllNUuylibLfAET24m9Ip3WBfgWIVDdUQ9PuGGNGTkTr5CMKNK2
	Ycu2LnyQbToZmHIxWSQro6UnMzIaPoW+UGiUQKRGhc5bRU2vXAxruUcQnPIEuTFAvhcIT9957tX
	HS3MG935vV/i2Xma9qfPEkRDFpdFmJ2LqHq+zPJAti/Y6k36Yp8Zxda0LNCc+o//COlvaKxY56O
	clNYTuJkFcxZsjzTDBUI0+8xqtH3428X77BOGrvQDThGJK8/8On45ZuLCMijURHFl8BD98k+Jlp
	cWghQWOJWRnts3pA2LY8QUlGHz7BWcn8JZB965Y+t+g3u6bOfh7tkSpDy5n1x9I2v8Zt1HsZtj7
	CdgzNp+/4dcFGXiW3D8pYHe5IGVXJRMnv+2rcoXM=
X-Received: by 2002:a17:907:d408:b0:c4c:e344:ece7 with SMTP id
 a640c23a62f3a-c4d6daf7fd1mr329236866b.10.1794229538310; Mon, 09 Nov 2026
 05:05:38 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
 <50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org> <CAL71e4NFyAShDZPW9JRB7Bpg3aLY5mY4wdn5m_ZYoLQjHZw_jA@mail.gmail.com>
 <6992b7e9-8721-4e1f-9c00-9fd0e0704e80@kdbg.org> <CAL71e4NKsTZNoLFOuSPfiJPf7oS57S01MpM5V+UOr+bgMGjOkQ@mail.gmail.com>
 <c8688e1a-17b6-4d0b-ba9a-fc1e0fa8938b@kdbg.org> <ddea802a-d4f4-4de9-9108-e68201841bc4@kdbg.org>
In-Reply-To: <ddea802a-d4f4-4de9-9108-e68201841bc4@kdbg.org>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 9 Nov 2026 14:05:25 +0100
X-Gm-Features: AclHuK91OEnapvoNb3Kcka6dOb_BuRHP7zzURULlYP4zve-Mm_6fWwsudi9DxDI
Message-ID: <CAL71e4PSOJgKFfBLrTXJSAewnZTJpNEiAMC-_FbW_9cmpEvLmg@mail.gmail.com>
Subject: Re: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 10:33, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 08.11.26 um 17:34 schrieb Johannes Sixt:
> > Am 08.11.26 um 13:24 schrieb Kristofer Karlsson:
> >> -       test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
> >> +       printf 000000000%02147483640d 0 >expect &&
> >>
> >> I tried this out and it works on Linux but fails on macOS[1].  What
> >> happens is that printf only outputs the nine literal zeros
> >> ("000000000") there, and silently ignores the very large padding.
> >
> > Fair enough.
> >
> >> [1] https://github.com/gitgitgadget/git/actions/runs/42475956442/job/128717309586
>
> Well, this patch passed for me[2], but I have no idea whether the
> particular tests were skipped due to the EXPENSIVE prerequisite or not.
>
> [2] https://github.com/j6t/git/actions/runs/42583623620/job/129048078411
>
>
>
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 01b97c8888..5dedb9054e 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -1182,7 +1182,8 @@ unfold () {
>  '
>
>  test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
> -       test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
> +       # 3 * 715827883 == 2147483649
> +       printf %0715827883d 0 0 0 >expect &&
>         huge_commit=$(git commit-tree -F expect HEAD^{tree})

I tested this and it passes on all the macOS jobs.  t4205 goes
from 800-900s to 170-280s there, so your idea works well.

Two caveats: the printf builtin in bash 3.2 (/bin/sh on macOS)
silently prints nothing for a field wider than INT_MAX - 15,
and it builds each field in memory, so this peaks at about 2.1GB
RSS.  Both go away by writing in 1MiB chunks, at the same speed:

    gen_ascii_zeros () {
        _n=$1
        while test "$_n" -gt 0
        do
            _chunk=$(( _n > 1048576 ? 1048576 : _n ))
            printf "%0${_chunk}d" 0 || return 1
            _n=$(( _n - _chunk ))
        done
    }

as a local helper in t4205.  That fixes the slow test without a
new test-tool, at the cost of yet another way of generating test
data alongside genzeros and "genzeros | tr".

I have it ready locally as a single patch, as an alternative to
this series, but perhaps it's best to wait for more people to
chime in first.

Thanks,
Kristofer
