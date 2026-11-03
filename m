Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793671838;
	b=TRi7sjpuNM8eDyB43UKVBRoMv5os6Iiqzo9lways9zXsMFrYWsyjlhDgaPev5WAjniF4
	 zHk0ZTGOiy6lqyITnk82+kWozQVCeR4r4M0t5RzINiQYc3tDv8lJNCmfn1GyxLYjRLUse
	 pPX/7f97tWwQkoBjkB3lciRtvAzUNvZAaErSXmdkqBEyY6t/bs/ABqTdidnkvFx404mgs
	 eR6PzZh1n8ARhHh4olVTko9OLhKwiND3poqIGJAdkXePqqftHwSJO7amFcrbJ0p8+pmt9
	 eS1jKK2VHzml2Noma7sb/LTetjZAPhtDYDV0PBGwJldlFECpATf6eV2qGnnBp6chaSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Vv01i/cJj2IpW1xbeRK7gTl6rM5GGtAcXmohRC9lSNY=;
	b=5eZIT+ngKlkYf+UVuP6aB1+DTt3wN56GU8RHDdx7W4A+9+v88KOL1mHk6ZcHImNJq//7
	 j4F8b0lYwLwrjrgwF+qE570a7UvgIqLskyxNpf8I6NPnJ1rIpiECj8rfCQcaYMf/k+tcL
	 EoOYEF1FUNDBKD3A1q+tVPG5I+mdvRO/hxlTI32mSUv4Xfb2FR5aQ+QRiLTvfJAJlimIJ
	 Q4Ryk0fYkJehS1DcFh1/4BZG9bUHhCIzuNmsLNOZtpfVWGxhbxBwJUst7gmEx9d6tpksR
	 NWIadveDemYr5lfUAEHz4qGVFjouYhIEh/hoTerZsHhRATuMOluOl0JC3x577H6rkzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oubiWW2o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FF606A326
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 02:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F39FF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oubiWW2o
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-51f2e9e6987so139366b6e.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 18:10:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793671837; cv=none;
        d=google.com; s=arc-20260327;
        b=SopmBgWgUx8AFLdBYHvBF3uCTCHhPKPZEIL4eyTKhx9rylMqL64dYV8k5Hxl80/6y6
         40MC4776RgdSFKKNgtWZcvD93ILwTqa5N+Y4c5U9u49zQkn1AaFQWtf2Z+L/YR4sa25A
         1pykBHgYJmzQK/C6r8Zlwq4XKwELFiwq2yn23MMKJQZ44cNCesk9q+awuNFnqmX8mUxh
         yo3+dDL583PqglpsmVaJWbrnTpeD90lFYarN+Aeo5AmAhXrg3jxTX43KqAGmYKPntzHg
         t/cJz4v+Wg0DMwnhr6gDeJxaTr8MLktRnEpLPZRcrZFCRNmurdQMDBMrD3JZBBZTerJI
         NFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vv01i/cJj2IpW1xbeRK7gTl6rM5GGtAcXmohRC9lSNY=;
        fh=mv5zqN92u4yGkXYcJT4eDsfhsA+TdzFjZ8yY/QsyRCY=;
        b=YNb4IGjOJSs+28x/GH7rwnldYqqKhPTt6V0E/GVXwc4XX7CUuvEHS1uAZMNMgJmuGn
         yIaE1jH4p8Z6+hjdcbBrNYlACaMyMJT3jzsDm/tw1A2J4IlYnY20Bee1qBu2TlViN1zq
         EVSXzj4PLWJxuKxeB1WT+uIdUIEYtRpGT0/2CQw6by07hRqiY3h3GQKszBD4eTu6yh8g
         v3Bi0LXsqVXrnUNh17nkXbSHVeREGxhp63TdUz5mZOZE6c3jFkyoOrP0cy2b0NJbyIMW
         P4jeou0aYHzAtHHXVzFmRY1ywBK+OH3uBpysUYMUCzLFBAQN5+58ltYthN3SMan4dYon
         yHRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793671837; x=1794276637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vv01i/cJj2IpW1xbeRK7gTl6rM5GGtAcXmohRC9lSNY=;
        b=oubiWW2oQaLbvGj9yk4ngtUwAx9e/0Sr5ixDY0jdk5g9CKIp/gyZdAe1q0wd92RsHo
         d1K4qTt5LM8gkiu8nfHg8jSxDh+KmtP0peMJa3Sk2UTdJ3O087wznpGM2J3GbRCzqGnu
         umA3xQ9RHeBcXEvWDbIbbuusRbnLdvfTWBPcAVqY2nMmEqSLBV0o5ErkV8+TmWbgB/nO
         ZKbpN5Eh9Dd+voPVzXnOVBCvUOjPkEr4tXYXn2fZA7TTmEGTi6okwg58nev2MIy5MViE
         cpzjA5/9nUl/1UjLgANzgeCLrC/zQiK0Fw3thIyomTrcRTtqSxobrokTuh2lR5XoXXhg
         i7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793671837; x=1794276637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vv01i/cJj2IpW1xbeRK7gTl6rM5GGtAcXmohRC9lSNY=;
        b=K8Rq9M0ph3dP8wvdeTvarsPFF6thWAp60tCiRCUh3BEMt2Z0mntU7WzT+17eckRcx/
         ZgxhlZcy7+Oa/VtDeDqxVLBiB8H6TRNvPobHgaRobvr82jUsNMpQGJ0+qJd2QbiICS16
         5hIOm/LDqsFTUcTO6uokksQHmG2l1E4oteqA0wcBZ1AvpdbgcyMFj6tRrekcXUmfJQOj
         JgBUmObiELktygzMuLRjZb36Pw9ORcFzldat3xBO2BtP/Xyha9x9+mi6TUSXDwur0wxu
         piXdPzO270yBkiNfjEY0fD+z1z9Z9eNWI1rSKil1IILfoTCgnO/mOi5XhOVZE7v3Wf5v
         3h0g==
X-Gm-Message-State: AFq9FYJo0UpTwQ+x/L1l6Bum/I3ATessb4/ChZFUXNBuOP1uBrbCFJRK
	PIDFpb020kXKfDwGXkMh8+aciQ9x2Ie6Hpt/ancFaCjlU1pOy960wh6Qw8JVSZJ2BobDLeP/tCZ
	wcb65BitY9icYfaFCjSL5x+EnBBOlA+2Y7A==
X-Gm-Gg: AYBFou02vSvMq6OulxeV51sD6kHayEq/x0q3pB3UcaLfn6zzJw/GZ8mZvN0pXhjCDyr
	AfmaFdKAz5soe5PY7KzxIUZIV1ptTyxlUMlD2m4/DtOgNJDeAUBp4na4Z5v9iBoQcox7IGt6Boe
	RPAa9Vx6G48mVodWCaPhN/2voCCgEofn52EPOYK7CW7P/Dnll09OeRct36Nd3cNv5yRfDgKRs37
	72ozAmPVxnCh8DixHW9Z1qs/vTe2woZi+QWS8Sa0aUyOX0QDn+E0lmePuGfaHaDdV7xwBnwbnVx
	MHpTkfg5M6oxc90LyzGHRhf8bNsfa+FXOBNns2pCHaHUuNPahhMDcYhIoTtp+le5BVjGJnp1lBd
	KGwN1E6DJ9ABEqH5Mwfbz5HB3OiF4sKNP0NHklqh5HlSwcrisYJ8u5mf1AHtnHOsopM6RkteQVo
	2Yiw9JQPHaf79iYmdaaQ7egMhKP1vg6jnz3fMq4L/oHs3d7nWavk5NZqWB
X-Received: by 2002:a05:6808:6f8d:b0:4d6:9133:cfe4 with SMTP id
 5614622812f47-563efbd41d3mr7372099b6e.41.1793671837038; Mon, 02 Nov 2026
 18:10:37 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-4-jayatheerthkulkarni2005@gmail.com> <aukCnmlJzZmOTihM@denethor>
In-Reply-To: <aukCnmlJzZmOTihM@denethor>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 3 Nov 2026 07:40:25 +0530
X-Gm-Features: AclHuK8ApYrjzbuC3_IW3rr62KhUWdJUWG83h5nFi1JspOgrcFUuO9mVIHEQxHs
Message-ID: <CA+rGoLdUU_uHq8rzuu9qkrv+iAp5Hb=JpcLLU6a7NUQ5VJPV4w@mail.gmail.com>
Subject: Re: [GSoC Patch v7 3/8] repo: add path.superproject-root with
 absolute and relative suffixes
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 3:13=E2=80=AFAM Justin Tobler <jltobler@gmail.com> w=
rote:
>
> On 26/09/27 05:14PM, K Jayatheerth wrote:
> > +static int get_path_superproject_absolute(struct repository *repo, str=
uct strbuf *buf)
> > +{
> > +     struct strbuf superproject =3D STRBUF_INIT;
> > +
> > +     if (!get_superproject_working_tree(repo, &superproject)) {
> > +             strbuf_release(&superproject);
> > +             return 0;
>
> nit: The early return isn't really need here. This instead could be:
>

Neat, I will use it!

>   if (get_superproject_working_tree(repo, &superproject))
>     format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
>
> > +     }
> > +
> > +     format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
> > +     strbuf_release(&superproject);
> > +     return 0;
> > +}
> > +
> > +static int get_path_superproject_relative(struct repository *repo, str=
uct strbuf *buf)
> > +{
> > +     struct strbuf superproject =3D STRBUF_INIT;
> > +
> > +     if (!get_superproject_working_tree(repo, &superproject)) {
> > +             strbuf_release(&superproject);
> > +             return 0;
>
> Same thing here.
>

Sure thing.

> > +     }
> > +
> > +     format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELA=
TIVE);
> > +     strbuf_release(&superproject);
> > +     return 0;
> > +}
>
> The rest of this patch looks good to me.
>

Thanks!

- K Jayatheerth
