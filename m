Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792946875;
	b=BhqiXIwSJPG8dfplbwHmLQvdS0/0By+E3eHAKZ1RHqDQqLdmzNH6gHSA+CmkYx0Y82mG
	 /GmSrGV6jnhSDi4uqo7sxSW2ScoGCXMqKAGi/sbfH2zPQrAaZUU5Sqh8ubas5aBE+Wv2y
	 xzPu/Hm3pDkmjMhnq39SQ/gi1ZPm13H+1F7i1vjdjlaL9GjtUkhFDtsPYpQJUH9+gp8AO
	 wQU7CIG2BqbHbHQPuMXGe7VxA9zvT2ALW8dhfkftczUB2J6tJxK+3K79H8NSfVu6mnfRd
	 IG5WQ5wDhjt1bR641V6usQIVZMNyD9nNE1OJKc9DEZB4hJAPoW2Z3A5r6nQx+4YIA9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JJn0rQZz7zGIKLoabAhYJM8foCkhkqszsUOMFu0G6rI=;
	b=f+Ikk86iwHdMOSoyykyT+FjgxdxKLsIM//0PSdVOJbJRwE5IbUcmHDFNrqMlFISQ0xQj
	 KINXDJpJYQUnE+wBzvMSPCJjC+Jm8XlsJh3fdKgSkD0ezDsqtmGtv+kW3ykC25VYUSMO/
	 Rzk4hjtoqOWDf860x9slff/bojqcUGYn2DbuwX7EB7YyXU/9HFCcry7+tqR0QwsVvlgzU
	 Sw0EweiXyEbWdq8zjEc1T1X2Q2lNt7xAb+0DIhFuOJS26v081nV1u5Ct2nJL5bssgUKyH
	 ZTS0tcF2qL0f86k7D8tCIxfzP7dvii5yT1mTJ2Uf9ED0Izxm3xQuXd2pIpPou4sSrQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q7ecwheW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A18606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 16:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A18606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q7ecwheW
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so4417892a12.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 09:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792946873; cv=none;
        d=google.com; s=arc-20260327;
        b=VzCxflC9nIAE6Zq2zOq7wahWHTsqYiIpCBTfWA4MUw0yEY9B04h714XL9NeQIPSi4q
         J3y4ZVxqyoegDBXRQ9fJWL7gNLW6yo6QHag3EGmkFOakPirUCBjarsBRi/J6rec0t0Tt
         C78kLFNjUlM7aKmkvZaps+JPfHm2IoibJzlTuBuOoZrNffl1gysRGS/2dZ1rZjz6Bo3A
         JSYX7bUdXO/A1lIMFohbpGcO9eTTa/F/7DRNkJ3amTZaC/vFCSj0coaEWCry66wPBr4l
         pmD5b6J79uTPBJFQPd+Dbi8vRJYaX2tUTZpRyFicnGTKovZdXNYaEqg+0D1hCA8e5Gjs
         M3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JJn0rQZz7zGIKLoabAhYJM8foCkhkqszsUOMFu0G6rI=;
        fh=nns60kLr2kuVEq0pewRu+Hwrc8vYxZDTNGgNZVsp1+Y=;
        b=K3c7nfKxaGdmCWeBtztXtPX1OkzDTT1NfTKsc6Xg5/TM8yyCsJkwAF1/BYGdIpFXEt
         ZZFgJujZ3eSTX+mycNCsCpy7gMIhfh4zl4BtdkbcdPQzV16CFdnr9A9ncWnqFAzyjEHY
         htScMpQuZx9FlXHWL5bVIfoLwi5Tks7wIDxoAKE0Cslji3Emupx4MVALLTrrMtf94jE7
         DPtFM/F0lmVE664vrVL50NcFoeMkMdtkueTsyLUSY4WqMoVfxEafQl71qMQ2pzjm6XbP
         vZj//tlfoG5CjqmiMHK7ZTcXVAqrfrFq3iPTCToNpku+rq0AIIQFYkZXwIjvl7JR0UgG
         9VxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792946873; x=1793551673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JJn0rQZz7zGIKLoabAhYJM8foCkhkqszsUOMFu0G6rI=;
        b=Q7ecwheWO+O3OUih0K/ojEUOzCkmAvigI5u9I/g2SNTuE382Uu1PYVUFi0gfQqX7zW
         omhA/EOjaRzZw3YSXkQ5fzpC6xBSh8+0UlVSkgBcKpvmhneqIPPINE2KIhz+LBCaUEjH
         Ry2BJaEd3bQB3JhM95+WamxNGCHc/efPFfS76pINQAqRV9EEJufEIqbD1AAl2ifbwdWo
         fcgcALHkt6TxHKVXhhfz+ezNS/HkCx5loMVIwLQlSrQqCRxLgS6c7NfKN+BUt9SLFwCg
         jtFbUooQeXsi5PGDWQqVVfx4VY5oJUjAMybjP6aYPNJy6QnG4BjFJN2BNBmA+rhUxPbJ
         krlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792946873; x=1793551673;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJn0rQZz7zGIKLoabAhYJM8foCkhkqszsUOMFu0G6rI=;
        b=fvIvI+/AlLihr0MAe2Axm5t85LlQY5aM9Yjncu7x1LvHAuONEO0x1J8yu0aWjv6hjB
         rfcOq+1mfMH0fhcsBAVMbXUMRd8qvc7Oyp2LjMZN67egi2xiY1OlsonKBKCKa0Mr0w5o
         Zb1s8MilATvcZgV+jiypgFV48aYHuvRcXlzgM9zdUxGt6XWLdemEvj7p2GUkx1ZMZQoV
         0t6e6CmvhHCBh8ysqHTRaZIEXI2r35hwJ6rw4+fVNCVWB69T8EFiw6TsoJlioJGy9chn
         dywIZorxEmTF6vR49J0nHyEnRqVtBAcNgAlnFKksrHM5k0sUiw7bBcbQtwrGuYJes8OQ
         7iNg==
X-Forwarded-Encrypted: i=1; AKwUvBx8F2huC0z5FW4xePLAntqGO1RQ8/18jqzfIZoYXU172SM806LPZxCasFyyfaw/PnhLAkQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCGN9DIdrRg9VvnxK446avToWpDBkRd+pB8qk93qC8xqXKSKQS
	lSp8hLaYhodPzQoCNgXp5RfdgOGTGFKz1jUWsbGRQkospWZmYp4lIMNmR/uzjbVzyffGeraMKon
	pVl4WWg3LrAvR6kELe0P/IpFiW7zB6SE=
X-Gm-Gg: AYBFou0tu6k+7IMpo6ue9UD30aUrmahCNQ/lgOvFnU9nIxNI0RHacCU5Ov3PSswFc9a
	Bd7AA0Vwen+UMOfKqzCRdwZKADTnBnElLdZWFDOpAN0lyFSIIcNpcYOkVWmAFXBWZgdHMiO1nkL
	iLW7BMsXwLAXPeSxaeb2rmCvyIYhqpYxnwulHMuFbDQyfVB0HzTtQMzGWsdMsw15Nh8aWmkvkXX
	FJ0MR9evWXjeLRMNdvqxhwkfc5SK2Hki6AycV4KN2cbrnOrb8WPOE2NPpSjK++v9TitUaU8EQ6P
	znOS5fMoQ8vVmllnWoDsdJzv/Zmd5+SgVtGqkolQgpLdQhO5cqPU79Q5tNBSlyg7p1vLB7rACE4
	mU3WtXL+woRNwlAOuKSZapQyeb+gY10hmR4SLDEIVMOi7ZzYg8YXCFt5yDC/KCvRrG4f02G0LK4
	VNzi1vW1drITlB8Tc=
X-Received: by 2002:a05:6402:240e:b0:6b4:16fb:b99e with SMTP id
 4fb4d7f45d1cf-6b44301025amr6501903a12.33.1792946872997; Sun, 25 Oct 2026
 09:47:52 -0700 (PDT)
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
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
 <CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com> <CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
In-Reply-To: <CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 25 Oct 2026 18:47:16 +0200
X-Gm-Features: AclHuK_UjZIhh_UPLmFf7xFWN1Uug8NdssWRI9h7Gv5cRSb2vqOsG1YEMOlub-I
Message-ID: <CAHwyqnWuj_1x9B4H+Kto2rZn6YeaM+X-vUb-uUb2jr134gcHjA@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 4:14=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Sat, Oct 24, 2026 at 1:19=E2=80=AFPM Harald Nordgren
> <haraldnordgren@gmail.com> wrote:
> >
> > > remote.h says this procedure does "For the given remote, reads the
> > > refspec's src and sets the other fields." Ok, and glancing at
> > > refspec_find_match the idea is that "refspec" input is a query (with =
a
> > > src or dst) and we find the matching entry and fill out the input's
> > > fields.
> > >
> > > So=E2=80=A6 I assume the usual idea would be that refmap is a "supers=
et" of
> > > the fetch refspec, since I might want to map refs that I don't
> > > normally fetch. (Or it might be disjoint, if none of the mappings
> > > apply to my usual fetches.) But that means that remote_find_tracking(=
)
> > > won't be able to find entries for the mapped refs that aren't part of
> > > my "normal" fetches? Are there downstream consequences of that? I'm
> > > not sure, I haven't looked at how else remote_find_tracking is used.
> > >
> > > Could that affect, for example, --delete-merged?
> >
> > Good point, I will change it like this:
> >
> > ```
> >  1:  ba7f1354cd ! 16:  4603c84d68 fetch: add remote.<name>.refmap
> >     @@ remote.c: void ref_push_report_free(struct ref_push_report *repo=
rt)
> >       int remote_find_tracking(struct remote *remote, struct
> > refspec_item *refspec)
> >       {
> >      -  return refspec_find_match(&remote->fetch, refspec);
> >     -+  if (remote->fetch.nr)
> >     -+          return refspec_find_match(&remote->fetch, refspec);
> >     -+  return refspec_find_match(&remote->refmap, refspec);
> >     ++  if (!remote->fetch.nr || refspec_find_match(&remote->fetch, ref=
spec))
> >     ++          return refspec_find_match(&remote->refmap, refspec);
> >     ++  return 0;
> >       }
> >
> >       static struct ref *alloc_ref_with_prefix(const char *prefix,
> > size_t prefixlen,
> > ```
>
> That does look like it would fall back on the refmap, but to be honest
> I'm not sure what is "correct" here :) I was hoping for more
> discussion of the questions I raised to see some thought about what we
> should or shouldn't do. I suppose falling back might be important for
> the later step with --limited-fetch, though?

Without the fallback, @{upstream}, --delete-merged and "git branch
--track" fail for refs fetched through the refmap.

I'll add tests to lock down that such refs are tracked through the
refmap, and that refs excluded by a negative refspec in
remote.<name>.fetch are not.

--limited-fetch does not need the fallback.


Harald
