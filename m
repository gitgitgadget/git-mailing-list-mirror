Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792959799;
	b=PB4mwqCbasY2LBhq3mNGog8Rwkm6vuMZDlwsp+iGbKOwwgS8n/s0w633M5kDZx7Q20zW
	 WY2xpfRJgE4BRzStpWNb2Q32iGkqqGV0d+3XMsfkiM2O8HC2MSD0/pYFEnQ76wHXx/OFA
	 G8xJQ9nxzkl+YnG58LF2amGBCo+U0qqFWVl4dK/epiV1J+kQEb+XdLcVKJIifdzu95STm
	 KAO3Ek9bgEN7gX/7jEF2TdzNhBoKnbJ0GrHXr+qWa8GBGCR9ZCZvkUwLY0LsTQFfYC00N
	 DO273opN6fz+2ttCis15mqM/EgGYTTT9L7LuNyCclov/qH7FEDmJt/u4IjdM5ASmdeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=jwrYO67Q36cCwHX5iKAoMB0hSkKP1+jUx7vPIzA0ATM=;
	b=jwmt3rEn+sOEUHYijtlZRytJ18ktlKIW6Zps/GQdXkT1I4EuYkTl/rpfdDheHJDytMKm
	 /GX6C10j9JmnxZSPx/TM14eQGeih7OOMiNvKnwQ6sRCXSIfgiqF4VnkY2XgmdcEifbD9F
	 NwRtSczbIGWPvPNExoF0HSYymem3tg26dlDPyYyeE4/DciDeJL58jaxs2dwJC5sweBlxK
	 j2VBFDXgmlGQWAM6IAXOyy7MYUK5ds975Bm+LfeSnvbLjpsQGzR8JJpMznlQ0bA+fV4N6
	 b3l3ylkURRdeyejQ3R933sNwFnjP3kx92GwQPmf6AoPKrmeCrnMUq8m3dDmYw9oqjJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J+krLVZf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AD606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 20:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C3AD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J+krLVZf
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso3205700a12.3
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 13:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792959797; cv=none;
        d=google.com; s=arc-20260327;
        b=mA1T1CJaFtajHD5vpBeMQXcOJvM7QmsHy8kRWWKK9N/ZIe+EtV1sGK8gjptrpsZhu7
         GbDwWV4sk5sYtsmw/GqdlaajVH3HV300wJjI0hQPTHyDPEqAz5wDvdBX1zGqjNUpSpLF
         maeuSrX5TO+8YlwV8Pz5b/SR1pouk74OpI8yLlwNS2pelXYTqjOV6Hv5gXUC5JBuaKcU
         WWU/BJng4ulP6xAQx/sgiKIubDarotFVfeWw1WTqwtqeOFhVjQIlAjzyzvR+dh12ywLl
         93eJtjbEu94v4k0WH6HnPqgQph57IulryNhT4ryILJzmwzt/BjzqJwx2bbLqfDKDXHze
         Bxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jwrYO67Q36cCwHX5iKAoMB0hSkKP1+jUx7vPIzA0ATM=;
        fh=MffT7doFJd1LXenQe3wNUXd75Qxub47l50EkC3S8spA=;
        b=HzdzI73TnYYwpEfBkkj3t2zAZBM+oD2zPdTtt2tn/ngjsrP8AEK2trHPfm16TBHOm1
         4k+X9YO9bF7pnRWaJml+N46mktvoJA+LkTKKiQgApLi1O7u0QEsepAeHnB+NcD6I4nyC
         JIBBOdxPmsk1CwqE6qmy2SGBX74fCnLRI1o9oL9EumVUSs3adQfXxDnI3bTEHg7FY93y
         DvVX10/gw6UC/SumeBkp6zJYbeY8BM/ad69NntY7bikmcs2FXp5hGjbn4NzXiBbHdzCD
         8CxF33cKwcGPuJzASocIA6MAHJnG9FMVnjDSqXTFksZIcyd7/jgpYtuZLFKTm556mm82
         ElzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792959797; x=1793564597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jwrYO67Q36cCwHX5iKAoMB0hSkKP1+jUx7vPIzA0ATM=;
        b=J+krLVZf4rH0B7m2arzDnOwl8o4my30r4Fraggzr32QLooFOuxruFLn7ycB56xZSAE
         F9y5MQBgYXy9Wknv8IBwB31upI22JbuXw/2ZEu7mlOKZiTwBCYri/MJn5jqCOL+SRXvJ
         KoTxdr8TCnxTdEzLirB0Sm6UxAB5rwis15btmeF2RZp4nba7HJX8p95CIta6PWam353l
         jpBkTpPCXAQXVtjgDcOn6y9GMUc+Z0ndHQnc9sAMVCSceGIi1IRk70MXRX41VoHENouN
         Gz+PYbJbJbH4EtzzR7Pnn8wdfxzEaSk3Kw1MY8Ec1SKWdgqI4rMB8DeRd6n8/PDlLZ38
         Mdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959797; x=1793564597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jwrYO67Q36cCwHX5iKAoMB0hSkKP1+jUx7vPIzA0ATM=;
        b=y7iVgl3YNffcmtQx3XqpKklF4ChyTgbp1D7xGA67TSV/6/5IPVDA26ps1oQ0NxAYEq
         EKhTEX27rAZKpGb9fojbTiv2tdGg3y4YV+O1l3LLTdmKtu/OdKeOiejFOQD9bmevSl9u
         qxDUc7L73ObRRB+PiCxP3YfDRyWw+omFcav83P6pxtFjErhXaCOny6BY1TWU/1/aLosw
         WVVmGOTNs7TVIpkmRm2rzmI0YYM1Mx8zrI8ryjH9I7bDmoKP30bqqC5Qwh29FZOjtpM2
         j3x699JgkikK+ETy1JqpBgM4+cmeOvC8ZgnT0AHte0YBansCLw4kqddkJ/VLX5KaW+AC
         vmPA==
X-Gm-Message-State: AFq9FYKLIUOakdIc+oDhGZTdq3oazpBKz2Y7ySdWVa3q1S5t5i4rSGRa
	CkZu0sTK6R9l46SbHHegqiloy455h+r3uULqV0dX0xLIPA9kbR62kOGB1pB4qFjEZd+9nUYmsR8
	TfGtKJ7YM6ElxAFd8OGYHjdcIg5pkSRI=
X-Gm-Gg: AYBFou03S0Nj+xUJFcTU0ISOFjOQ9trGzDEeTi6m6aSJ9pQL3TWQoVAWzCBYTbHE6mS
	RDcx5gSxVWxRCBIZZG3vTiwgdrWRiTjMBN6nvcJiF87TZ5E0tdJ0v0oChTXGn4HE5paO3wTlcs+
	B1DtI9YIesvwiOKJcZiqbFmNmmFY47I+GGMTm9ElfeCiuaxhf58vuGHWQTbAMO49Gb+JJZOUXcS
	HV035Z0BMVLsHsNV6bSiTgJjexjnWraAfxNnL8wK7bIJZ5SghBuaV2NGdwDTFH+Wv5nSt3XfmNO
	Sc2KjMoQOB+9KuGv/5g2eggATG7ANA2EnrC4sMz1goSpMfI3S1X98TD8/G3vllTT6shgjofuTdT
	eU5jwerz28Ywp+HDYvHDAtGL2ea+dxlJwg7HEzDDGAA4GbcI83w1C9b9lI+W4FcN2xpeRUg==
X-Received: by 2002:a05:6402:280d:b0:6b4:62fb:82d5 with SMTP id
 4fb4d7f45d1cf-6b462fba081mr2272717a12.0.1792959797422; Sun, 25 Oct 2026
 13:23:17 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com> <aa5a98b80d2682cc0fa321c091c76e483fb6810f.1792348037.git.gitgitgadget@gmail.com>
 <8ffe4cb4-fd89-4086-945b-735316e6d501@app.fastmail.com>
In-Reply-To: <8ffe4cb4-fd89-4086-945b-735316e6d501@app.fastmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 25 Oct 2026 22:22:38 +0200
X-Gm-Features: AclHuK8J5sKgD8ACufo3HbbRLpvVt0jiGNTv2l1s26SWirh4vD9AlTXi8q0qMds
Message-ID: <CAHwyqnVs3+ebj25fkTmeRjDTJsJQh9ECNYMy1xU_yJLDdDeAaQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] reflog: add --historical-branch to name the branch
 of each entry
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, GGG <gitgitgadget@gmail.com>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 9:18=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sun, Oct 18, 2026, at 20:27, Harald Nordgren via GitGitGadget wrote:
> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >[snip]
> > diff --git a/reflog-walk.c b/reflog-walk.c
> >[snip]
> >  static struct complete_reflogs *read_complete_reflog(const char *ref)
> >  {
> >       struct complete_reflogs *reflogs =3D
> > @@ -178,13 +257,16 @@ void init_reflog_walk(struct reflog_walk_info **i=
nfo)
> >       (*info)->complete_reflogs.strdup_strings =3D 1;
> >  }
> >
> > -void reflog_walk_mark(struct reflog_walk_info *info, bool operations)
> > +void reflog_walk_mark(struct reflog_walk_info *info, bool operations,
> > +                   bool historical_branch)
> >  {
> >       struct string_list_item *item;
> >
> >       for_each_string_list_item(item, &info->complete_reflogs) {
> >               if (operations)
> >                       mark_operations(item->util);
>
> This was from the previous commit. A function that uses a `bool` param,
> iterates/walks over a list, and then *if* `operations` is `true` (1)
> calls a function, that looks weird to me. You=E2=80=99re either going to =
do it
> to every item or just walk the list without doing anything.
>
> > +             if (historical_branch)
> > +                     mark_branches(item->util);
>
> But now you have two `bool` and you do two checks.
>
> This is less weird to my eyes but these conditions inside a for-each
> construct/macro still looks like a bad approach. Can=E2=80=99t you check =
each
> condition and then call for-each with an unconditional `mark_branches`
> for each item?
>
>     if (cond)
>         for-each item in items
>             fun(item)
>
> >       }
> >  }
> >
> > @@ -287,6 +369,16 @@ int add_reflog_for_walk(struct reflog_walk_info *i=
nfo,
> >       return 0;
> >  }
> >[snip]

Thanks! But maybe not worth reviewing this code now considering that
we don't know if we will even do any of this now?


Harald
