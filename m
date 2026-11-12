Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794523947;
	b=AwH58xNrSNqpSgFXE22YnhO55lB/A7vQdvV1A/5/xulJ3QeT8nwyIfSV36r+iEsa/q1H
	 6aNX89mzFB13GXw0LWDXJYGMhJzYqvW/kkrzqJRu6ZB1tGT5hdiUEQonALp+tCY2MzsPx
	 5DxYpjH/S1q4/tJf20eq/0Ooe7o3AAQkxOfoWMawptwEi0MKNMcKcZfDZpZtKZnYzCi0b
	 VWPi2kTsq6RRLbE7SQoI8J96xaz5VtOLW2FXFovyPQc/iMnfZhc2+J37jn06rHX7UMt+M
	 8pyNYDnyz2pO5keTfKeGGhVSenH3ef5QYYI6CnSZDlDIsHGUcPqsQppuAPqECRE7LsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=B18DGuEE17Dc/Chb7bsNFSsapcK+S+r7aAAb/RruRig=;
	b=yYSeSTS1OYTDa8GOYHE0iBQtsu/AR1nnHvOQtdWFJPIGxOZsuwE+f9nxwvrtFbdi2iJL
	 qZJYNiu/khFL8qOlEgx5NGQbafpjkd8vFUcXpm0orbrcqDpsyKlsWU3ct2MCdQfKFHd8t
	 a14B23FSTdhFXrqmG4LqFeqD8Qz4nK1BD1NRikB0rf1UAtGY2AuhcNnIpiN+EfLBxV+Pc
	 UBT9Qanw7xu7ND+tHTQos8nR3RfwHrVLVWbLoXKbPrqiepIRu36XjU7IDn7QjBXd7EI6H
	 UqGFFvoERrWZI3kMHwbbzL3km4o+vDoxXQ/rlx66RDwvp0BVaAJtztJAPRCmP74CVnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dK/28id1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BEF606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63BEF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dK/28id1
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-70b875f6f13so429238eaf.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:52:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794523946; cv=none;
        d=google.com; s=arc-20260327;
        b=SvxieqG8pNe9HNCic4i4Rqqs2+S/yhNXogjNhRG3bi4saNWjZ0yvorgrFxTDJpPAbs
         L2JiBQkIMpXS3HtjAaGN4YKIkKonaEs+/9vWiFAgT2YjXhl/exk0Fojr5OHtSCNiDg9E
         0UQnhE7YuTUo8kbIBiT01+hIDxc/JfShMt1pnQYmZQg0X/S2M6V9hX3PYgm5BD2kbGQp
         fAgl/huo+FtgDya5SZUaOlFLn9BBqjWQKeSBPewWdGEtvDVVgPt3jOvJIqkxXmXOvS2w
         x8EPUTqVPt0EV5JLgocVFLtOJbqQhmGLelC/iznrYDILLsB2/2+7pEnMIsugOblX8F2s
         0Ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=B18DGuEE17Dc/Chb7bsNFSsapcK+S+r7aAAb/RruRig=;
        fh=l7/dyyS5ePl0mMVTKrc8c1o5nJYFvATkAy0S73UC9qc=;
        b=pkDvzzN7SM0AKyGESu8jR/uW5RtyOamnDBEdi6nstLgUkTB0uslAX5vr+uK6dAADCO
         4q8LRZSJ8MRaYt/xhFN9CIOXLsAofD03HAPW0XZboFnubamn2+ji66TVUfZKFkBCRA1g
         lYIAuegyDTc+/txluGedJSoqDu2gQFgVwgN6SDp9iXETrIL8PQCB+1V/Ddgl9I07M8tE
         3intK+oiy5szYwwU9Cb2friqdWS3IrboqJglr2iYd6ntVxS0genK5zyMtN6ieVUDrZQJ
         jbQL+qiH8q3eaQaENETAVdZRlXP/OmO8HmrQj6LPHcrBYDXdSpkhAxRMgMoX2cVkwpSp
         HEVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794523946; x=1795128746; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B18DGuEE17Dc/Chb7bsNFSsapcK+S+r7aAAb/RruRig=;
        b=dK/28id1HqDP92NH6UX60q1aLCUS57qu9CuTLCELeU+HirzNJdu2HVqtSr++KJIDGN
         cP12S001KpYo/SnnPIIM7WN26NBr8g05eM4dL5TYl1FM/UheQnRpug4pQSNoD5P8PMbh
         +n9j57CS+wcV5tcvTR1wvUSzrtiBLt95xWj+4h75jp1Sr7hUJQlPxz8Yx90JT54pu88B
         bXAKJfObnl78UaAOGc/NW+5LNosxyuNdD4he5sJAE56jUwMxXxnN3QHYi3OmE4zZq9LC
         d/jaKDoHjVrJGfHE5jbYUzjCxX958mQSgBffuO00juZzqzqaACk74Sgt5VI9JrLZDrBW
         Zesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523946; x=1795128746;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B18DGuEE17Dc/Chb7bsNFSsapcK+S+r7aAAb/RruRig=;
        b=SItpt3/+OwgywskLHtlIsVoDcvDXkzGPNvoqJN/KSDjNBJj9MPPDEaIT3SrqwOhsVi
         K41x0hzHH+zkHeOsd6oxY6Tsw8jwwdLPsVkEXwCokctfRJMOLXlf0hxLkNKIe593oQT9
         L+9DZXJQ4plIdd44Bz83q6wEmVJoaXA/zSg8Fp+Outqa8LFFotVkUoEYL7obWMLjYm+D
         AAJpcWjCLMd/Zr5N1a5jdmV1+cWoisAD2Q5l9GZXWO6QxXJGV26fZ08/AsQBSxkTQBoT
         JbFgpT4x48AbHIaqoTssAjBp8XF6szF4KN0Ypq/9/bQcYGIxWAUY+RXVNAS7Iiv/Iwi5
         AdvA==
X-Gm-Message-State: APuU4Z/idrQo9oxhVDgEor8oylPbddU3hReJkTCpd4qr4xnLqlmxp8kN
	+xxNHoubFEI7xgDYPgZozyS21LgLP+/q9eQ4IDkQYpayYjkG4b+B5xQVx/LGEsVJUjo3aFmMutl
	1/uFHHRHyE1GS9umfuE+aBGFmAmHx1QJk/DSjVgc=
X-Gm-Gg: AYBFou1KHd2qnlpYktCL+3afeem8aU4mTnx5Kqz9u/srnx1YSkI3rhiPVKS5uX3N17P
	JgGTILUHEZOdtCUo4/rVKXZ+Vm3/4BWCZ0HZAUzLAQYE3ZLc++9XNlKdL3zKrwduzEzyUzi0EmK
	I2VQRfli1+Zzm4NDvtdwN97LLNR/pHVwJacq9dmqtPW1DVZIkD/fkgfavrHy5I0h5P9jlBpJDt5
	LNTUAbjkzZeWw9nZDHDuoFGtSfw90WwjpeG4vYK8oO3T6UjuMTJ46nT/4Ceep0EEPvPR079eHLy
	kCeATSmQghWef1wzFFRk3ySs8T3+BwIIbFL2eDCEMLggkiXa3VHlk3WGQkugsaZ8ajkRk1mu7cc
	0Swk23bARbvWrRwLQXwaoIC5Sk0q9UWObAU1yQReKuNNxJ0JXoLanr8weZw==
X-Received: by 2002:a05:6820:3382:20b0:700:52ae:7e48 with SMTP id
 006d021491bc7-71ab507b913mr307152eaf.47.1794523946332; Thu, 12 Nov 2026
 14:52:26 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022212903.177261-1-andy.koppe@gmail.com> <cover.1794000450.git.andy.koppe@gmail.com>
 <ac3ed53867d868c36a91f4c5c6be1fe2d874651d.1794000450.git.andy.koppe@gmail.com>
 <xmqqzevld0dc.fsf@gitster.g>
In-Reply-To: <xmqqzevld0dc.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Thu, 12 Nov 2026 22:52:14 +0000
X-Gm-Features: AclHuK_O0ZnwFd7_52mDctA1oB8yGjAni0w9hQbKmiayn3IDMPUIvWvKKDa8Efg
Message-ID: <CAHWeT-Y9AeKZdKAybLO5RFM-q=X2LaKKX-meWhNqzK5tT6dW2A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] doc: stop calling root refs pseudorefs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> wrote:
>
> Andy Koppe <andy.koppe@gmail.com> writes:
>
> > Several manual pages still use "pseudoref" in its old sense of any ref
> > outside of "refs/", which the glossary now calls a root ref. Pseudorefs
> > have since been restricted to FETCH_HEAD and MERGE_HEAD, which are not
> > considered root refs.
> >
> > Replace "pseudoref" with "root ref" in those pages, giving HEAD and
> > ORIG_HEAD as examples. In git-worktree(1), say that both root refs and
> > pseudorefs are per-worktree, and drop the description of them as being
> > directly under $GIT_DIR, because that does not apply to the reftable
> > backend.
>
> Thanks.  Clarification of this kind is very very much appreciated.

You're welcome, and thanks for the comprehensive review!

> >  --refs::
> > -     Do not show peeled tags or pseudorefs like `HEAD` in the output.
> > +     Do not show peeled tags or refs outside `refs/`.
>
> Hmph, is there a reason for saying "refs outside `refs/`" (as
> opposed to "root refs") here?

Corrected to "Do not show `HEAD` or peeled tags in the output."

> Do we even say what are normally shown in this manual page?  Perhaps
> we would want to update the description to say something like
>
>     DESCRIPTION
>     -----------
>     Displays references available in a remote repository along with
>     the associated commit IDs.  By default, all normal refs under
>     `refs/` and `HEAD` are shown.  For each tag object, the tag
>     itself and the object it tags (colloquially called `peeled`) are
>     shown.

I went with this to introduce what peeling means:

  Displays references available in a remote repository along with
  the associated object IDs. By default, `HEAD` and all refs under
  `refs/` are shown. Annotated tags are also shown peeled, i.e.
  recursively resolved to the objects they point at.

> > -* List all references (including symbolics and pseudorefs), peeling
> > +* List all references (including `HEAD` and symbolic refs), peeling
> >    tags:
>
> Here, mentioning symbolic refs as if they are anything special is
> misleading, no?  Symbolic or non-symbolic, refs are refs.
>
> On the other hand, "all references" should logically include
> (normal) refs under `refs/` hierarchy plus "root refs", so "List all
> references" is technically incorrect.  Perhaps give it a bit more
> correction, e.g.,
>
>     List all refs under `refs/` and `HEAD`, peeling tags.

I switched it round to avoid suggesting that there's something under HEAD:

  List `HEAD` and all refs under `refs/`, peeling tags.

> > +[[root-refs]]
> > +root refs::
> > +    Git may create references other than `HEAD` at the root of the hierarchy,
> > +    for example `ORIG_HEAD` or `REBASE_HEAD`.
>
> Is this a good place to talk about their naming conventions?  At
> least we want to have a reference to where we talk about it, I
> think, just like you did one for pseudorefs below.

The gitglossary reference below the pseudorefs entry is outside the
whole list, so is meant to apply to both root refs and pseudorefs.
I've tweaked the wording:

  See linkgit:gitglossary[7] for the root ref naming rules and further
  details on pseudorefs.

> > +[[pseudorefs]]
> > +pseudorefs::
> > +    linkgit:git-fetch[1], linkgit:git-merge[1] and linkgit:git-pull[1]
> > +    create the so-called pseudorefs `FETCH_HEAD` and `MERGE_HEAD`.
> > +    They are not references as such, because they are not stored by the
> > +    ref backend, but they can nevertheless be used to refer to objects in
> > +    commands such as linkgit:git-log[1] and linkgit:git-diff[1].
> > +
> > +See linkgit:gitglossary[7] for further details on root refs and
> > +pseudorefs.
>
> Great.  I do not see a need for so-called here.  As technical term,
> pseudorefs, references, and root refs, all are officially sanctioned
> words, and there is nothing so-called about them.

True. Dropped.

> >  `--merge`::
> >       Show commits touching conflicted paths in the range `HEAD...<other>`,
> > -     where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
> > -     `CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
> > +     where `<other>` is the first of `MERGE_HEAD`, `CHERRY_PICK_HEAD`,
> > +     `REVERT_HEAD` or `REBASE_HEAD` that exists. Only works
>
> Phrasing "existing pseudoref" in the original was wrong, but the
> updated text feels a bit incomplete.  "... where <other> is the
> first ref among X, Y, ... Z that exist" or something like that?

I just added "one" to avoid calling MERGE_HEAD a ref:

  where `<other>` is the first one of `MERGE_HEAD`, `CHERRY_PICK_HEAD`,
  `REVERT_HEAD` or `REBASE_HEAD` that exists.
