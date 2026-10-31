Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793473711;
	b=Wr+CcESVeC2qgr/+5p+m4Wc8U9zPDPmZ5dRW5GsULGV5npX+XQiihypsJO6trc3nZOcT
	 8edv2HYGJtg3PQjn55KruV2lUyzFtC0dwgTxr6ngaHQ/tlPwBZUjxGZwpgO/c/O3YFMOq
	 0KczU7RwFHNCv5m124iDSa1I+SG3MF1NsTVak/qiMzf7BlECMNJUNS71p82ra3ctwDdKO
	 ZFs+/rMWoGeN4psNl+6H9Inl8aU+I9vI0Hn415PfV1EaCVhzzHkcpXSAASyxSY+zPbkLR
	 WpKNFdNBsi9mLg31MR8uvtfR5dXZFfgcYO1K49FJItPIpoHUIYiUqeZi8MJlDqITmLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793473711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sDmlTxezdPFtYSKNsPxm7Vl1oLEBZBWr2TyrrMgrEEk=;
	b=hFjLhub7rCCRbR6YLPlh6AoyqCK9IazR1BKsyEF1lPGEkeuIqnNRw2LQBPOhRE7167Wc
	 hzSrXDcZpDbYWWOFE/vNntLbWq3XeVtBO2bfMI2FJ/FjAkF9UncFKiu9yGb3VQtvPxmT0
	 sugsFqSHwLVfAAvYEXUJydRSC2nJ2EKwXhzk66xVblXYVLySNn+FAwwlAw89dnM9MLLxX
	 6C1lHpJpmfn8Ysb97bK1DUhl5hrar0DZ12GAM3BSgfa18LgrmNccOJbGAqXnwsHXbviKS
	 YrcXqzbljfBjbQ6hEQup0mtRL+znwYs11GbKx5SouSzyYZJih38AFAMh9RqWoN/yLEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dq0Ix8jm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F14606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 19:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07F14606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dq0Ix8jm
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91bb5795792so21263436d6.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 12:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793473710; cv=none;
        d=google.com; s=arc-20260327;
        b=YpgxQDFYn9EEwgr/OczR7SdfCYcmqNhTIubGMRpPMdd89/lOWZrjHvwl9LqMPdlo4v
         hryL32lmOjSXvUbgVFDyTQGAVDeG/Fu/0j9GjNicZ2nv1TVlGRcP8v7nau7O+Bslb0qJ
         ebRYz8I2WYp4caN3ioMNhMo4vunIu2/LgdyIiWO+wLgsDoAwpNL29p4Eh5WHF/24NCx8
         8BWecMVIFaaLpD4ZNfg5OwIBCo9dnIU//qsg3+Zh2V+NsS4acev6GGRKRQb9G5Ziy2/5
         I1sEoVNFiW4nszPBVgllgle2LpbLqJ42b0UFATGibOLAKKeAvYWaBW1aqL1/EVG/BRhN
         XtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sDmlTxezdPFtYSKNsPxm7Vl1oLEBZBWr2TyrrMgrEEk=;
        fh=0ntEjTNBVORqxkOvMCyrsNWjOyMy54RXFfOMQ0AFUFo=;
        b=QkXgZTXQfzQobeXTryXXZhb/OF//NHnm7pvtu0iUKwuQDODsYTCqstRodxArEdF930
         ah65L/+W+iBkQud4ZujzyWpR1UVvJqSw8K/MR+B2mnYeMI28PG/NVJGkwer7SYohRSex
         PQgW2ooR9D9rTQSYNiWitP5LqZ9AYkqiYPYOysTClyEeJiQ8jlElImeSYw4UHFa8r1PU
         ro/6bnGpJ4B4EgO0ICQfrZ3TI2ao/CkDlWi0ovyA/sf9wkAqKqQUZNAOPHgE7avgL3Kx
         zp0dr5TowJXwG9kchwGZ4eD3vGaksC5dkjSI19K+dr14ve4nPpapSOFpeRlh4v/HLXZy
         P2xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793473710; x=1794078510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sDmlTxezdPFtYSKNsPxm7Vl1oLEBZBWr2TyrrMgrEEk=;
        b=dq0Ix8jmqxu5SJT5OSNrPiurqTl93AcTTg9e3O2lhEqU0nIwE+IpM/TcSlEtXtluTD
         fxplOA6RgVfcWuiI7AR5nJ3BkoLD/XWO/LF634nhnqJpJKE4KX0E0pmfj5sS1ZXnDNXI
         wOE+qu0wFFe6+BKkMbbdhCYfMArEjHtZE/QehXAaEva8f7QtEblLZbWFjUPJD9TJhCN9
         ra9iQYAHbCbJUUGr1JVp4zpIHh2OLwwjxajwgkdqKmBvBw+C9x2C0J0N/6B1b7PchfJG
         kHtGwAq9ESsqjv/9wD3la2fCP9oxkaHOK+ZMgTTEE4BUPDjS29FVXfOM8JmNB6QEdIxg
         uY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793473710; x=1794078510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sDmlTxezdPFtYSKNsPxm7Vl1oLEBZBWr2TyrrMgrEEk=;
        b=VC56U6oZ16/0VO6Ptlr0//88zPgWIkKGwEBSf97vu/okAinOuJeGFN7mr0vphGm1YP
         BWx87dPYQNbKDPayY1rNd1A2O0S/W4VoK9hk4BKidhmGEx/Du0XDSnl1a6aKY/FxrELD
         MkNv6tjQ+uE3rN+8DPq/3XLL/Nd526QtfR5Kr9w0WdtzvS4H5iNFIXOF0wkDZE3jVQGl
         rFSOitZlvxIuFMarfIjCNAtsU822QFswt2JGfh1a3be6gz4fFqz4TVEahfckrVPovnkw
         CTFz4aeWy+sqomeMWmvkx6FTQabnVydoJ50dJYOZly9IwBKfNIYi4DgaEkP/KvGrl2MX
         zpSg==
X-Forwarded-Encrypted: i=1; AKwUvBxJGTHAArY0uvpjbGehQIXBK15h6X14VS3rjB5ERbaeITAyLvG/O19DkeI/hb1d9WzusTo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbbvtJQAbDhbTj6bNbeFicPsjVpJ0GPP2TO6qjamB083rImSZf
	ZMqX15Xt7VMYXV94Z+YXz1HeYjpQObnmc54SzCOexVu8NHf4nQe7wRE18jiHYkitzV7Wz18OUfv
	dluOlIAKNjeikSeaA5XaWrvTf1YhevZw=
X-Gm-Gg: AYBFou1fuuZHzPKJze2VaUOeoHiKMlKRlhlCxE2XVjuIvoeHA1fDFA00negmdlpfBZb
	VSJEQlEhVxDNmQY9wOwcXsHEHtgGE1ENqZtV9zU3qZyrfIqMHekxQsI+HkUQfQ8MPyff2bCXwjq
	f3pp9CU7l79lDQ3TMGlBcaGBHmjlDgrdeAXJ4eWuHWTEhtdBeFSfS0AqL5NJ0mn4NkRwImvR1Qp
	OVprsEa1S4GmC0hMZPm3PqlH0pSD17tPAXYLyB1bGJDHCH0QyyFQhYvs6UyX/mx6J0MefSoOWRf
	u75N5g7VWG5Ecz7O+U0XPG+wCnpAbzw3mI5Nk4oBTclV2pvt77A4RnQrktw03fZXgR9GHyFPckv
	ar57xJnJIW2BEsyXww34gjdNcHB3BBOWbX5Iu8llWXtopyOU1/SC2ZDDYDVR4slNe8LRovzDKko
	IbnhYd5lNsJwdpTiTPaKk/mnIs1Fzrpay3QS8O+FeiC24tTvvWORxJKD3/7bH6G/HPK7SEltdxL
	Jps
X-Received: by 2002:a05:6214:5507:b0:91c:809d:6fc0 with SMTP id
 6a1803df08f44-91ca4b6a87dmr95821536d6.43.1793473709778; Sat, 31 Oct 2026
 12:08:29 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com> <CAFpMFfALb1KbEw-dc4wYCxS4PXfDBwzQOD6YPRe52_bpRnGt9w@mail.gmail.com>
In-Reply-To: <CAFpMFfALb1KbEw-dc4wYCxS4PXfDBwzQOD6YPRe52_bpRnGt9w@mail.gmail.com>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Sun, 1 Nov 2026 00:38:18 +0530
X-Gm-Features: AclHuK8qnAk6Ire-LsUTE7cM-CRSu2ov8vhBRztZHYXYSk0WcXt94SHzYbb5Jds
Message-ID: <CABh_KWh0N0y7rN61wx5=zQWs3QmD8Ho6ONig75ocj8zFWKh4bw@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy PATCH] t4041: use submodule repository for
 commit abbreviations
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 10:16=E2=80=AFPM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> Hi Srujith,
>
> I applied this on top of master and ran t4041. The new test fails
> without the submodule.c change and passes with it, so it does catch
> the problem.
>
> A few small things:
>
> On Sat, Oct 31, 2026 at 9:26 AM Srujith A Poojary via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Use the submodule repository when abbreviating commit IDs in
> > submodule diff headers, so uniqueness is checked against the
> > correct object database.
>
> It would help to first describe what happens today: the commit IDs
> in the "Submodule ..." header are abbreviated against the
> superproject's objects, even though the commits live in the
> submodule, so the abbreviation may not be unique there.
>
> > [Outreachy PATCH] t4041: use submodule repository for commit
> > abbreviations
>
> The change itself is in submodule.c, so the title might read better
> with that area, e.g. "submodule: use the submodule repository to
> abbreviate commits".
>
> > - strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
> > + if (sub)
> > + strbuf_repo_add_unique_abbrev(&sb, sub, one, DEFAULT_ABBREV);
> > + else
> > + strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
>
> The same if/else appears twice. Maybe choose the repository once,
> at the top of the function, and call strbuf_repo_add_unique_abbrev()
> with it in both places. I also wonder whether the fallback could be
> o->repo instead of the_repository, since the diff options already
> carry a repository.
>
> Thanks,
> Okhuomon

Hi Okhuomon,

Thanks for reviewing the patch and testing the new test case.

I've made the suggested changes and submitted v2. I now use `sub` when
available and fall back to `o->repo` when it isn't. I also simplified
the code and updated the commit message.

Here is the updated patch:
https://lore.kernel.org/git/pull.2288.v2.git.1793473062113.gitgitgadget@gma=
il.com

Thanks again!

Regards,
Srujith
