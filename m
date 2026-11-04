Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793787098;
	b=2lA5CgcKsyM+++6GyOeasZKQUBhuxu10Z9hAJL50erpEeaMdIM5j6cwjTYwrjE6P8B3e
	 XUTAntF+21DXK1HqERSucQC+oiIkI30hjUaUdy237U3xCaPzB2yG+iyiEI/TPPQQW0/T8
	 wch3VOmFDI4e25Bfbb10OOEX8WUSXvzBjFWYoxr002DrFniztNkEBWufp5u07cKFtI/BA
	 2ZvHyT7HFipOw62eeF0f0nq2dmas+sl35uKISUHS4zZirPzoot4A8SGhGvGnGRotwJtz2
	 KZorIKw4hVkHKhD1Jx5JXg4w59TbofalmddiOeE9vuzVt+UCyGyaBtGqkPc7zcuAZ6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=2TcXW1lhelh4I5Fkl9kyK1ue0HzxYJg8V7dbbBYToiQ=;
	b=tLQgAy5yEBQIppbKi1Lb2BNFsxqcVBRxk+x04Tj9/banLz3tfhbBoHrO+OYmvynfrUao
	 KS4zS7zIBQmciuNjT0Hkjm7e+t5Kxx+NWufHzBYvMPZMb2L4pNZPPK05IhiG3PDCkN5LU
	 2MZZTgF8SJ4yeGoQeEUOSY8/B4Lm1nvkWXo30Qeg3jgkEKu9OxB/m02gdfq0H7KozUEim
	 yWl6DHQIk0mBdp3+LkdVGef1luuVVLUl1c9Pa9i2XGUT1DF+G/S3aaOM9VA0UWb/7dhGf
	 JrGO/kvdidGuqBP5VUsuuEiR01lXq6S8oEIk9ODjEo26gfNlS0SUrV8jZo4tJP7Pk3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b="CpQpW/w/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D9606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 872D9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=CpQpW/w/
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4322d310e7so78408666b.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 02:11:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793787096; cv=none;
        d=google.com; s=arc-20260327;
        b=kZdVk++2nMc2RxCoPu8hbn4ck5+V9Opcex4ko88weQg1XY4Oy9mTyCbhj+4V64wCBt
         OMBYxmztXcC3Y7Q04BMrCwmkudZqoMIL2DlnxqIB+ppSV8vms96x/OnIJ9b/l0LJBEZo
         SHEGiUnJEcJqFuXFKf+kKpRIx0GQVYV9nURjtyiZsWQy2W5aexfYsr+sU+l8uu8Xtf+6
         09tHo2KtQxZ9rsnKjvAj+y5s7IlYC2FWmmP2RrK1uk3WABtFWnWQrx7OeQuzcnTtF5ax
         yd6JD1o+3bacsCx/4gyII2olsgAdCA8ucgdVw5nKFEF7O8otYh3g2h3RZBQsA8WdpSun
         GHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2TcXW1lhelh4I5Fkl9kyK1ue0HzxYJg8V7dbbBYToiQ=;
        fh=NTG/ErkP67SHubsfent+TdcPuFLXJPx/1xSvqS4pvCs=;
        b=D+ND2sYJmPj1MiSypbEKXoDEd1R/HaFmDw0KnyLRDVj/btcgSl4lahgWUKQjxYI+f2
         8rTMVhHvJ770rJOdFbrTotFNo0SC2qRipOAdKPSHrsQv0AfOY+TqA57NOCF0t5Vbg0oX
         sC+BeCiLKdKj7OWGE4noVmBTeslx5nsBCqgt0lEXFiFaJP8hl0F0DzA7rFwYoHppogWW
         +Y7tls7W6ct1mkAFpqAHdfubBvwY6uFseEySfSFIZQGKFbnhyGkF45eda4vr70JChVhB
         ht/PqKeM5rfYN9AELD0GkYDK+/g9Bsb2RtBUH6eOcb/gj+37CEmT+h5RR3vddpt6dEp8
         KHtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793787096; x=1794391896; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TcXW1lhelh4I5Fkl9kyK1ue0HzxYJg8V7dbbBYToiQ=;
        b=CpQpW/w/PagEveF+dRfYw1frTvAeOmqr4Yc6HtIfpI0QbL2cL7mqUEu+ya3/3S4K0C
         6XvcgvAfsDHc9cRoOrADITE7I0Ia21dnFtRGVUQBL1XiW+y544F0YT5Z/YTH4zZYplPi
         mUwN/O1nLb8bDO9OMCoL+L/Lnjs8vhs3VhsZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787096; x=1794391896;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2TcXW1lhelh4I5Fkl9kyK1ue0HzxYJg8V7dbbBYToiQ=;
        b=zeOQHQYM/ZGXQWOgD8UghGI393IG0zvTsFr8Zczml1Kzr7UFI0Z4USiCW4/tLaoQFS
         RpGgX5eX49YYdQLHKoFxZtEATAAGFJCgbXu9EG9IeBPt21VJOheUVUF/e+bjR9JzWNQ/
         IvcgclLFmCQG/4xol0kSpn//I/fhi8dxKE1josY4eNo08m3tUCd3exueLN8ZFpKeb8Ig
         GdObYvf9qHOdEDXDYiORp637uEee8BMpHvWY7YvIBct6RS1KZHAGUIfqZ97RsjUU6NBR
         MtjbYJLsM75K0ThSSSGayr02vC43Zsa3/Kz5S8vuXomMqlWYzzsSyvTIICHjq+mMqMwn
         kgZA==
X-Gm-Message-State: APuU4Z9Z6y7CHR0C5tviqTiNwv5EwQZdNRHfelHFxmT/36zVx16c46bm
	yJd30BEsJ+ZpxHrH7JAAv16jnE0qDLGPwsxds2mxbS0ql1m7QGluBT9RnzvpX1Kr6NZOvlfc2/t
	UL589/XHCJ0iEK0xL0k+bO+uRbwUc29OMd/0jJLbPzQ==
X-Gm-Gg: AYBFou0UqK3/u9GyjhMMPZWlreh8MhjbZkKz4GSnaesdabdVgB7GISIFFc896glrcNN
	f23G477nbBSwFZxRCUJd3vKLy1Aw5TCqU2+rSjvuUs8AjkL9bN1wcHaMBxSIfjUE3Rja3qkyioU
	2k7BAAbgcHMYjr5W3uce+lI3wO2/pkZ1+JcZSA8kUDvuc4cILyqbCCFvPhx6cnKujE/3p2X1Jtb
	OBQ9UzararKERMylmQ5FurUWb6bqhX2YrqhVHL00v7Zqnmus7aMZGA2nwiCt8eAqBqH0lesaR+c
	nnv1FIr/GQO1o5cNCP5Oonp7u9AIdpSdnR/nbkz0HwPk5fFUO8o3PmMTBg5lMqKnkP4I29L7Ut6
	Es/LZapUrokprJQCGdih02htb+uy7Gqwv4zE/6w==
X-Received: by 2002:a17:907:2da2:b0:c2b:4142:2db1 with SMTP id
 a640c23a62f3a-c4ca7acc1b2mr1407689566b.40.1793787095935; Wed, 04 Nov 2026
 02:11:35 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <yrjh1p92qc7w.fsf@pohly-mobl1.fritz.box>
In-Reply-To: <yrjh1p92qc7w.fsf@pohly-mobl1.fritz.box>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 4 Nov 2026 11:11:21 +0100
X-Gm-Features: AclHuK8Le3Z941VBdwL3AQhFv5yFZWSw82alVLx2PK_5Lac_CxF5EMnf4YYl_nM
Message-ID: <CAL71e4MqMdGk5ryhNxvVNN6Z02+45B933ZfUuvj4hM92N5a6hA@mail.gmail.com>
Subject: Re: [BUG] Lazy fetch in partial clone fails with "not our ref" since
 5946a564 (odb/source: make read_object_info() pluggable)
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 14:31, Patrick Ohly <patrick.ohly@intel.com> wrote:
>
> Hello,
>
> "git merge" in a blobless partial clone fails with "not our ref" while
> lazily fetching a missing object. This started to occur today in the
> Kubernetes CI, completely breaking the merging of PRs. We should have
> been using git 2.54.0, the affected version, for a few days at least
> without issues, so it can't be ruled out that this is at least partly
> caused by a change on the GitHub side. We are about to revert to git
> 2.52.0 to unblock the Kubernetes project.
>
> [...]
>
> I bisected v2.52.0 (good) to v2.54.0 (bad). The first bad commit is:
>
> 5946a564cddc0bf471f27ae4c3fe205441e3ef65
> odb/source: make `read_object_info()` function pluggable
>
> The parent, 3bc3177ad7 ( 2.53.0.185.g3bc3177ad7 ), is good.

Thanks for the detailed report.  I think I have found the cause: I
can reproduce the failure with your steps and make it go away with a
small change to the loose object cache.

The problem is in the semantics of the loose object cache, which
answers quick existence checks.  It is a two-layer cache: a bitmap
keyed by the first byte of the object ID, recording which
"objects/XX/" subdirectories have been listed, and an oidtree with
the objects found there.  The intended invariant is that once a
subdirectory has been listed, the oidtree holds every loose object
in it, so that "not in the oidtree" means "does not exist".

Writing a loose object does not update the cache, which breaks the
invariant if the subdirectory had already been listed.  In
practice, that means a quick lookup of any object in the same
subdirectory earlier in the same process.

In your example, the object the server refuses, 27b64cc8, is not in
either parent nor in the merge base.  It is the content-merged blob
that the merge itself just wrote as a loose object.  merge-ort's
prefetch had already listed "27/", so the checkout of the merge
result thinks the blob is missing and asks the server for an object
that only exists locally.  The server rejects the whole batch, and
we then die on the first object in it that really is missing,
3c804b88, which is why the two OIDs in the error differ.

The bug is older than 5946a564cd (odb/source: make
`read_object_info()` function pluggable), but that commit, which
matches the bisect result, is what exposed it.  Before it, any
non-quick lookup that missed called odb_reprepare(), and that also
threw away the whole loose cache.  A merge does such lookups between
writing the merged blob and checking out the result, so in practice
the stale cache was discarded before anything could use it.  Since
that commit, the retry only reprepares the packfile store, and the
stale cache survives until the checkout.

I think the fix is to maintain the invariant: after a successful
loose object write, if the subdirectory has already been listed,
insert the new OID into the oidtree.  (Clearing the subdirectory's
bit would also work, at the cost of listing it again.)

I have a local fix with a unit test for the loose source.  An
end-to-end test is awkward, since it needs a merged blob whose first
byte matches one of the prefetched objects.

I could polish this into a proper patch, but since Patrick
Steinhardt has been reworking this part of the code, I think his
thoughts on the approach would be useful first.

Thanks,
Kristofer
