Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793658010;
	b=OGyOoFdUZnjc6RSgf4vZFbasI7jHcL/fU6YxZ47924sMfxax+eltZjXjEc9c0WX5VJhP
	 iBg7QVdZopjIOo3kqog2bD/01StpuDB40eLQbiA870GGGRfpdw4ws8kOcpd+30MlScLv/
	 WhpgfRwfG45w17d9FOk7sbU4UnbBSicXsvXoVc3iGWXLmLsJwPUgKs715+kKjVzYMSQzK
	 Q96rEkpdyqCkedG4/VruA1XeCL7sl/hVpdG78330W/mPJHzDSeYooy4cOAxmDl/D78KLH
	 cxJEAMuo9a5Kyd3o2X+J4Tuy9ARQHMsIIyBI0W4X+YI+rq4qfkQxgzTmEAWrT2t06bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=k8MUG5oj8u8JQdfZ7rrhGRwlvxegorRYCeiucYhJn9M=;
	b=fLsAATmJZo+Rtw7g3rGgqCsLAnz5eOVPbWXFdCDxcI8vebOpCpGJloh+WTfGrasWePM5
	 ITpZZiM9xXoFgKlkyLA/lBscAk+0oXpEIFIO5gaohSI/hO/foEHuSVGHE7WlTLWpSqwBf
	 4OvdqJUcbOGc0gb/7NnBtidcS0/AUBV2Mk3ZdkVFCz08igjVDqCEOGhgSbsD3FIU2OUbp
	 BICTzU+7VtCmPdwx6LW5kusjbT86kyKQ/Ov8znDxlVioxMLYH2DPAHmEt4hCHDvZEPCPD
	 BQG43+vmD8N2xnTmwGRaReikwCrpfDvcVJofN23m+wHEPr/KuMh+izvdaoNcWhcxjoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OrO2HTKG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929BC606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 22:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 929BC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OrO2HTKG
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43bf9548df4so3383039fac.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 14:20:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793658008; cv=none;
        d=google.com; s=arc-20260327;
        b=sy3kjj364UtetJbYDW9ezg++If/E/ZAGX88dmvKjGnPppm+rEES8JXwyXSXTj43JeO
         tHERVypbDFLtC2aaeIIM22ydH5zWVNb01F/ijvRmysuCTT4eN1TSe4Xc7XmolBcSOzKc
         aSWVJLDRnDDIU+kLF2JWEl698myecrWtxkMBAgfK9i8mtovYwHMxAi5F2893Abt6WuXl
         YfP549gkfwavsd5LLUdq4HMZHgwmauHb/etOQ+LVRI0Zd8HokDLNUvaMYP8yFDazaJNv
         aT3DvkdH4BmsPnuMqax9Oem5MvMTRezYxF5iWIoaFrUMdYXm5gY10s9qqwPscMuaFPg2
         sKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k8MUG5oj8u8JQdfZ7rrhGRwlvxegorRYCeiucYhJn9M=;
        fh=5PFJeBr7a+nhkSJKkBd2FkDf8aw85ThIkZJzXtcSCYg=;
        b=q661KWzSuL+Hps974NzmB/VkSiHhhv8+v5j8w7d0F/oH72nAo85dvijpzxyU2kcKvN
         xOyFovtizyr98sv8+Jp2zrzMNuW0hcS/LmCBGHKJLwVY4Hx2SYuyoicU4I+nJaXsjkwR
         rpYeIW7r5v021zf1MyX3qg/TmlZkUFpdkX1FLNYOHSqsjNzDOPqX/sjFe8SUassxuKOO
         XFdjmLcPm7CXRIM+yHAYf0qTNVeuc1yNx9jO0ZY+xmGT7qczQukxWqX+iG6RRF6hytf5
         rwQtKTDe3jKi5FQnnzjEXu/rT+x4Bbb52jWHuK5w6ZOOG5LzInfbatfyP5pixHzkiivS
         rD4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793658008; x=1794262808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k8MUG5oj8u8JQdfZ7rrhGRwlvxegorRYCeiucYhJn9M=;
        b=OrO2HTKGM9w1LKqCtLw1sVu3a7tl/7ZRF3ie4cbrs/chPEKqyrf0C8+R2IWj/Sb1a3
         dP7MjNdNVE/X1MK3oO2Bnn9Fhx/7mCoamAlknSJJR+lgHlAop71Ywlj5SHfxabL3iO5j
         v9tjz03UDx8spRUIPog0m2GP8LkMlaMwmwY90HGxEvr6pOEcK/zlXzFrVoZEr/BZvzoB
         mimof7yjL007qHCS6QCazsaS/q19U08Xf5dL0mn7ovBTldYj8dk2YQhA73BF5OUK2GAY
         EJhjUbnD5jwR0fnQqqPjuT8iDQ3AnMmreJ6YBQmpOzS4FrpFm1ASPI2Hb46HsQh2yEcS
         JbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793658008; x=1794262808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k8MUG5oj8u8JQdfZ7rrhGRwlvxegorRYCeiucYhJn9M=;
        b=Y6DmD+YAZZvFfYb4j3LQAvT/SoXp1eSM9QEIT8DbGDf3kFM3vliP3npxX2LNgHS0w2
         XAnm4Gt7lrfgp74p+Ya9vssA7rck881OTqliaxnLr8eulc7AO2yPiY8wh2dUl/8q4rfP
         n4iT20U4Gv2vJt9ALQ38yt78mBoPT6HBmLY3QjcM+W3rdsMZt+Bkh888OkPCwI3wOLwM
         ZErkQtsiSPTQaOf0U7pZ3DsIYyAECohP6A/fhCSFrOK3CqB0K7Z2fd89bgD/oIOlE/jQ
         0p66hjMEd2BRybza4qcV69+ctEOnWvxuSg6dtnLaA/o7VmlLTnJFGmz2oQkjVb/vZEFb
         mpWw==
X-Gm-Message-State: AFq9FYKokMpypQOtJ4p/5oyypeWaD3XtRW4NegsqqXHl5Ty6xeO8K3Ag
	YDf4mq0ne8ocjuGBDNhw+BYbIjh7PArwmN88Sw7tXimX1qdhb/AS6W9C4YgHBxt2rKowS5vVf5b
	TrJWSKLJK7k2WyatxbMEB7iNYtr+IR808Lqa8
X-Gm-Gg: AYBFou2p7IKgOLND9ZQNs+jOxNqya1rzWczRcjLG51NR6JZPLQzdLKkh/DpBQ4KGw19
	DPFTtTXAxuzidMeToRqcs8igy09TVyf22rEPyepQ6svLBMti+VxxvdiaG0bSjKOk86Koy8EgsaX
	NwxSJAcQE/YEDGQLGcxnF7wnBMCWwt8PU/vLtXM49mBscFebOxwvtRlEIzgHkiwwEmXJzhALaZT
	vXygb8QLhewgSmKgg8QncvCUcocqWCR7UVzc6BNcKQ+iuEYVDz52mUQxbHJSAIBp/Z+EQmwgAVu
	kTOpQ6LN2bOTix+yJ64Kf9vwJz7uisaUOjcR2E1+XjPCNILIy5gi5WZ3K4nW7HBeU08GuruHy0n
	aMCUXC4G2iGZv95jNY0FdFFrZxAk0qFFmXcyfNfC+K+q5MQF7pndHCA/RqQ==
X-Received: by 2002:a05:6870:3341:b0:49d:e65c:34e4 with SMTP id
 586e51a60fabf-4a9076c4fcbmr7522399fac.24.1793658008393; Mon, 02 Nov 2026
 14:20:08 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022212903.177261-1-andy.koppe@gmail.com> <20261101230326.3675597-1-andy.koppe@gmail.com>
 <840bc117-75e9-4d63-882e-3831156871a3@app.fastmail.com> <CAHWeT-ZdZ0o=_rPWFPcXqCyc-WV=fzmKVRVx2LetfQzgYkKO0w@mail.gmail.com>
 <f194e2af-cffc-4867-9069-7070c86785da@app.fastmail.com>
In-Reply-To: <f194e2af-cffc-4867-9069-7070c86785da@app.fastmail.com>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Mon, 2 Nov 2026 22:19:53 +0000
X-Gm-Features: AclHuK9xtAYoh_MKRKam_aUUGDXiybwiWk6MVe-DqSK8UHKRfe-PIJxOHMaMqXM
Message-ID: <CAHWeT-YSK3xFA=Hztr3Uj5UW=L9JcC_0iOa5pUG-WGCpwng9vw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] root refs vs pseudorefs
To: Julia Evans <julia@jvns.ca>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Nov 2026 at 21:01, Julia Evans wrote:
> On Mon, Nov 2, 2026, at 2:47 PM, Andy Koppe wrote:
> > Root refs:
> > - Can be stored in reftables instead of files in .git.
> > - Contain either a single hash or a single symbolic ref such as 'ref:
> > refs/heads/main'.
> > - Can be modified with 'git update-ref' (generally a bad idea for
> > built-in root refs) and listed with 'git for-each-ref' and similar
> > commands.
> >
> > Pseudorefs:
> > - Are always stored as files in .git.
> > - May contain multiple hashes, and in the case of FETCH_HEAD, carry
> > additional information about where each hash came from.
> > - Are only modified by the commands they serve (i.e. fetch, merge and
> > pull) and can't be listed.
> >
> > The big thing they have in common, apart from the *_HEAD names, is
> > that you can pass both types to commands such as 'git log', 'git diff'
> > or 'git checkout' to refer to a commit or tree, just like any ref
> > under refs/.
>
> That=E2=80=99s very helpful. I think it would make sense to include
> =E2=80=9Cmay contain multiple hashes=E2=80=9D at least, that on its own
> makes it very clear what the difference is.
>
> My impression is that FETCH_HEAD specifically is a
> relatively popular pseudoref and folks would be interested to
> know that it can contain multiple hashes.
>
> If a pseudoref contains multiple hashes and you pass it to
> a command, will the command use the first hash?
>
> Also are FETCH_HEAD and MERGE_HEAD the only
> pseudorefs?

I think the pseudoref glossary entry covers these questions. As it
appears in 'man' after v2:

pseudoref
    A name that can be used like a ref to refer to an object, but that
    is not stored in the same way as refs. For example, pseudorefs can
    be passed to git-log(1) or git-diff(1), but they cannot be written
    by git-update-ref(1) or listed by git-for-each-ref(1).

    The following pseudorefs are known to Git:

    =E2=80=A2   FETCH_HEAD is written by git-fetch(1) or git-pull(1). It ma=
y
        refer to multiple object IDs. Each object ID is annotated with
        metadata indicating where it was fetched from and its fetch
        status.

    =E2=80=A2   MERGE_HEAD is written by git-merge(1) when resolving merge
        conflicts. It contains all commit IDs which are being merged.

    When a pseudoref contains more than one object ID, using it to
    refer to an object yields the first one.
