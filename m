Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792948840;
	b=msFjzAHnh+m3MGnTFJ/9J8ciXnECSRrmaaimfzzAv3zXtDLvnRjkgvi+I4TmGvnFkp2N
	 cZDZRq6Mtqp4XZomdSg377aeIm95nHzeTxjlQx1/+etuzc6L0YBFPhxemAu2iDvg2HK4H
	 WQYnkc4pm2JQEiUHNwiKUbSrOM+P4HfRqWgCQCRx0war6D9Vs85Oh5aA1hqfuwHvlFSZ3
	 5mE1IcO0dm59gXWXTPRoRaKmgiI2RJK/3ByeqDiK5LTuzF36FiuSKy6GyqSndSrPgmBBg
	 ESp0kKl1NUdENnj+wLynSBGUQ6x8veT2wguqOo+3Zc7Xjx0TQ6t0iiYSgFExc412Y8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792948840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NI0jTyOTIGz3Rsm4WGXiiDS3figc6Myeltpdsu1Oyew=;
	b=VMqTru4th4HTyExmENTaVkZmr1SUVpQ0zFw6PMjBuHT3Ws0jLZqCzmcMWxsqXAEqfkjT
	 2p+7/XuEOKe6eKJ/CTx0P3C4b4KXtEOep/nsyPi3spPju37PeZLxNEfMiXijl1mVqk56N
	 lymEdhEDOqqbcpUcN9FuMtPTNGjiq53HRFRJyyLV7DysS5K3uTt5SnsO8zdjrGxdnIeYz
	 BlaAgnVc3EvwZKQCY2GEpdBqIYxLR7yWqL1xFqC92g/n+OigoM7VKOrQ+wXjM2R8DgXTz
	 rE90SKdseYxKaX0wanALOmUaMWnUR4cobgDTQAqQ9hWh2VwZ7IPG5jeWdwDstYp49Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jAlceHGk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B073606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 17:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B073606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jAlceHGk
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso3215129a12.2
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 10:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792948839; cv=none;
        d=google.com; s=arc-20260327;
        b=lQIrQRerTfVHeu+R/FWZMyXhAGboRmVYAy04+225cip4GFHA05dZzx3WlvhMuGh5aD
         aQYNr+ji1i93fJ31eUpNGhYgAAJSYrlMD11xTv+IxvxEEsFIMADV2EemaWim8xLen6bS
         Yuq2wdFSgGclqBq8VsWG2uTa9xumZCayBs3r36yRzrAqfr/Dy2xVbwHJ7ugNfpD9R4cu
         Ln2leY4hNsQehno/BmvbX9izi85j8MSYoOpR5WJvwz5wUKxdWMemE9pLl1GAhIFqZqiH
         GhcxkuyRU/29q3jR9+UEmrd/VAaNY9W45CgABPz/k4bonXvWay5M0mhxvUYGUS+yDJ08
         J0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NI0jTyOTIGz3Rsm4WGXiiDS3figc6Myeltpdsu1Oyew=;
        fh=rZJK4+QOj5eW+vTILEJ+giOUqfZ+nLM13NRRg7/8y7I=;
        b=LCtCdqBrBlJ9Zmo6H/YtW/UmbPidq5Y61Mmwr514Ti0X/f3cOxczIiirMcTWCPp3kK
         q0Ajf54IPjo3YppXcIuHdAMbuRYftSWDFJutVTrUdYRFKohDwxqmeyHJAPncak5l/760
         aVfkM4R2QXaM4XiJakLI/2O/1mbdNuA2AS2D0UGPr4kIJlNyGUaL8g7grgHHXH6a/+rq
         w7cx+lrpFqkDRcEl42NwQc6igHkITzw7hm5sb1MIwROiMR2cqWtBwLB826B5CHowNlDE
         bg9FujgeeYtV3KtmYym/smbPF8JMIutaF8Mz5Y2VdzHbd40DEGq3HG7wjkPK/pdNdRZE
         tqlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792948839; x=1793553639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NI0jTyOTIGz3Rsm4WGXiiDS3figc6Myeltpdsu1Oyew=;
        b=jAlceHGki5zN5KlFqzVcykIdXrQuMXoffS5j2LdrE6GJ7g/zbveG9xyfym/PyIffjf
         Ed9n7UXsJ6l/W06zZdJeB1Y4uMdZEwTUvZU3C+YxLWD5qFiYPUcBAgPcVTLJYL+XU3YN
         J80rApG51zJM7fBZiPz1toPtPzwb5mmiRFQJ8BXEaCOtDbSv/lBnZfFAjGbmlsARCmwN
         PE/UDMgESNyNobGcrWUBnC6ffgQzRJDR0/yrkHkTNgHCO6f8jHOPUaFM61b13JcQarPk
         S5r39wl7fJTDDMEase3O0uJElfvWmQInmWbEZ0pSoCuAXIKR1UUHb4pFxuxLdx9L1Mpu
         21eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792948839; x=1793553639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NI0jTyOTIGz3Rsm4WGXiiDS3figc6Myeltpdsu1Oyew=;
        b=cByQM2jc5ytAjVpgRY5xPSVetw0TyG85Gyv9YEKLXgegmoEzhL0VUTJPIk3AoNpOi5
         Z1rRqO2yTLtVMz9zgGmVm1QXk6689Xo6r+urXLKylYrnBpitSybiTLofO/jgc3LkZ3Ej
         oymAXesHUyd+wNX4dLMMVIG4M9ltB4KFCFgLWjTOOrpbNeHZMrkExRRHo81g3Oh7giAY
         /XVJT7a9LPdTL0tQr1MvQkua3grrj2a+bYAvKcN/UIO9F007hXVZueZMhbF2SSUUdt6+
         8hllLQmhnsiqY/tgfZIGsQyk1NH7OqOJ27BSrc+Qj6Nu5ou3BuaO9D4M35QGbgQPARMK
         8ahQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQ2sMnK+F8G2HbdcjLEE0AVLDW2XD7UD2QbdTrvC4bp6upt632lh80H1vogli7025nTw4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI60saLh3Pis80Z0FKdpJF120z4tSv7sz9MBkwx3glKJBGE4WKc
	rooBB4uSxkUXtPeyKtbU0KMrcHljhnunMv+O4ILGFVHCwCPyS2992SImjp47ZWlIy/ONgmtcZsv
	bTCyFtMutlKkf4c35RTzKBmsVtPb9t9A=
X-Gm-Gg: AYBFou38ZFbn42XDvoPxaAG+IUkIpXzMc61if4spZVXF3VGlbWo92LBgXCZwUm754nZ
	4HNYaWwz5CpjFmBvVaS/iCPkq6a7jtFivcLDPnB7G3tN1TgaIFu50K8JSUtfedywuNZQYWqHzNv
	DQEZUH8OZrhLGnPtdMlBYSruc00kEj9RcVAvAqvGDVFZYHckXldizUnMg31LisQnGGUsXI83Moj
	jL5ThBBAWhtdVZ6SnIZ+QNC2zV0kN97YZADShhBfIPjb4td7jYoNDnhgrMZhEh2R36rU8eNhiy0
	jw8TuzzbpB2WgzEYsxIWjIbXZfkvodLIPOpwYcgu77HddUrgEdz13MAqJ2l8Qzvj7UVMt7UQKgc
	UyNQcVDJx44nbG0LjWeKJKl7tpoJyGu/OjIy9pXJu70pghZXU4XtM38A1Hb8qsgTB+AS9cw==
X-Received: by 2002:a05:6402:e07:b0:6b4:2911:b6ff with SMTP id
 4fb4d7f45d1cf-6b442fc8c05mr6426732a12.8.1792948838498; Sun, 25 Oct 2026
 10:20:38 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <aa20604144efdcc5ada00d65d538fdb42c2e31d3.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CAgS3=ne1RkT-DioLmY6SqhnOZ8NH5kxxCZA_1QFx-dBg@mail.gmail.com>
In-Reply-To: <CALnO6CAgS3=ne1RkT-DioLmY6SqhnOZ8NH5kxxCZA_1QFx-dBg@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 25 Oct 2026 18:20:01 +0100
X-Gm-Features: AclHuK-XeB3hO6hBff6tGxL3-6BscRtBa5_SeqOlnQUtO7sBgXrX3Jx9OdUY3qk
Message-ID: <CAHwyqnVELh2ZyCy5W8+jHHWN=UvcgMJP0k0i1PJKU5bU_AhUrw@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] fetch: extract collect_upstream_from_remote() helper
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > When a fetch has no refspec to work from, we fall back to guessing
> > what to fetch: the remote's configured fetch refspec if there is one,
> > and separately, whether the current branch's upstream lives on this
> > remote.
>
> It took me a couple tries to parse this because the 2 halves ("[one],
> and separately, [two]") are 2 different kinds of objects! I think what
> you are trying to tell me is
>
>     =E2=80=A6we fall back to guessing what to fetch: the remote's =E2=80=
=A6
> separately, the current branch's upstream if it lives on the fetched
> remote.
>
> That way [two] is also a "thing to fetch" in the same class of objects
> as [one]? Or have I misunderstood?

I'll take a look!

> > The latter is independent of the former on purpose: a narrow
> > refspec (for example from "git remote add -t") can leave the current
> > branch's own upstream uncovered, and we still need to be able to fetch
> > it.
>
> I don't really understand the meaning here. I can guess that you mean
> something like "A remote with a narrow refspec, like what you get from
> 'git remote add -t', can omit a branch's upstream from the remote's
> fetch refspec, and we still want to fetch that upstream." But it's
> taken me a while to put that together (after puzzling out the above)
> after first not knowing what "uncovered" meant.
>
> I think the whole thing would be clearer with an example:
>
> """
> Imagine a remote with a narrow refspec:
>
>     git remote add -t main colleague <remote>
>
> and a branch whose upstream points at that remote, but isn't part of
> the remote's refspec:
>
>     git fetch colleague work:refs/remotes/colleague/work
>     git switch -c work colleague/work
>
> When we "git fetch colleague" without a refspec, we decide what to
> fetch by combining the remote's refspec (main -> remote-tracking
> branch, in this case) and the current branch's upstream, if it was
> based on that remote (work -> remote-tracking branch, in this case).
> """
>
> Note: we aren't "guessing" what to fetch!

Thanks! Maybe this should be the example instead?

        git clone --single-branch <url>
        git switch -c work
        git push -u origin work

> I'm not sure if we have guidance about where in the parameter list
> "out" parameters should go, but I would expect them to be last? Idk.
>
> Should the "inputs" be const to better communicate that we aren't
> going to modify them? I'm not really sure of the const semantics of C
> anyway, and I know there have been topics in the recent past around
> const-modifier lints and so on.

Yes.

> > +{
> > +       struct branch *branch =3D repo_branch_get(repo, refname);
> > +
> > +       if (!branch_has_merge_config(branch) ||
> > +           strcmp(branch->remote_name, remote->name))
> > +               return;
> > +
> > +       for (int i =3D 0; i < branch->merge_nr; i++)
> > +               string_list_insert(tracked, branch->merge[i]->src);
> > +}
>
> We do trade some performance now, right? We first collect a
> string_list, then push them into a strvec, which has some overhead
> relative to skipping the intermediate step. Plus, string_lists sort,
> which the original didn't do. And the caller uses the DUP version of
> string_list (and IIUC strvec_push strdup's as well), so we end up
> copying twice?
>
> If we used a strvec instead, we could use strvec_pushv, perhaps, being
> a bit more efficient? (It would be nice if we had an ownership-taking
> strvec_appendv or something?)
>
> But stepping back, if the caller just provides a strvec instead of a
> string_list, we can push to it directly, since that's what happens
> anyway! We don't do any filtering or anything in the new caller.

Yes, I'll handle this.


Harald
