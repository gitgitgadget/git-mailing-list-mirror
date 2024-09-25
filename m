Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467061D5ACD
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288340; cv=none; b=VVfD+1y5LH36miRFxrq5s7Go+Ak67+yq2o/2+vNeqIsw1lYeZ7kofy5li2Qwk1e2mIHau1UFf41VWsMc5TJ923z6I09WTTIShIQPK1jN7gtQtJb/y8z5KNSy5RY09mfa+SZXCBw5lww6pHxHWiWsvLK1KItcaiZczbM4wMpc0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288340; c=relaxed/simple;
	bh=WzW+cOmkm+w9Xwyg1+wQqAFIbaKpTm+YSW9AguBohTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMtm/CoWrUgD8nztNIIJUVhRVM73xcKRQcbq3YvIK5slJE7pazRKSqIaT3ou/d0ve8U0CW3jHaHIyZeoq1N3c92DbTwxZv66PcxfpowI2yyRJ9O9a8ZSJ9jFwYBUz0JsGLpqNrAO6CzLx6I7lGdKsb8AkgfWeP1q0iuZPk1Vf1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H99s9cpF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H99s9cpF"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6dbb24ee34dso1722467b3.2
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727288337; x=1727893137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y25CmidvQaP/5QOT/8N1+Tv52OTpY6HWtIsrJsz0QOE=;
        b=H99s9cpFlL3UNTp14en/WH46LpyW+7dQKBP/TFzdWJ7lL39CeJYKNKyERjOM5/H4HJ
         ev9/fLa/WsijCbzU6t23YmUbO/7mwc8OQzkdmcktoxZ6uNnHfibUHCgnsX+Brm6JeadP
         OaVn0eWBIKlq2tRuGjIdmHy1T5WyVczXyIpEeHMMAO1r2i3iAAQc61TZqJIPlKC+ZvHC
         GjuFF5Eheid5zx8AGaO/rKAqPmAtCNe6VPo78YHcj/U3KTeVPA0Quy6nwZg0xLjKqCkH
         QNh6G838Wt9YhlHElr4eQmP3ECGlSjnU83yG7uABnu+Qd7b530xGU0nt1Dt7EpXc2+ny
         HRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727288337; x=1727893137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y25CmidvQaP/5QOT/8N1+Tv52OTpY6HWtIsrJsz0QOE=;
        b=IujdVTv7ZUab/0NjqOLqDmtKCtSqk/0r3rI+tVtUsTpvc1PUWSFDE/oidLH9UZqkCr
         O7INzd5HxowFsN/TSJ2QUl3FevJ88/sKrm8n/6Ki4AsOcHnN9HNPsiABlbSMHBw2Ra8h
         x0st3TuSKC+7MYeR68L3mm3w+S1XzSSBn8IvRcpZ8y4DfZePiBBdvsXjwB7U5AMA5N4R
         W+DRQl7MM4itatVXBJea5ObqFrsskqmLpozVcBd78wCRJfiGPyiIyq3g6Dz1e533eCEK
         V+l1G8RhSanEeexfvE+Ri/2chNRpjo88U3+W+t+bcHIS3urrGD+TgJu/PJQfMaVSVzrT
         rJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9e4dxGrLLf0sX3g7UsGzJU5HUqeV/xjSNKuB2f5n2atA3p61evEECxux63AsdX3Z4A40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7eikRGhhdujfD6WDvsDL8Le4BdpfO7/AZ8lfJeZhsacb6AeM/
	h5tHhoc0SKAjSjswyrWVO8CMa4EsZ2U+ipwS+9fMuFNi6EKGH12SCM7uEhxovMmyiks+Nes9n4k
	tMbuF6TlmXq9VL5sHo1PjkcdSHQc=
X-Google-Smtp-Source: AGHT+IFr52CqGcb8pYVG/2782WHkobkgXXofuhs+7HEF8u3eFRmD5toTU2Rc3PfdzTSf34NbfAyoaUX9MbSFQmOpQ6c=
X-Received: by 2002:a05:690c:6786:b0:6b0:70fc:f6e4 with SMTP id
 00721157ae682-6e21d711c8dmr39607137b3.15.1727288337174; Wed, 25 Sep 2024
 11:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com> <20240720034337.57125-7-eric.peijian@gmail.com>
 <87ldzy9vxd.fsf@iotcl.com>
In-Reply-To: <87ldzy9vxd.fsf@iotcl.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Wed, 25 Sep 2024 14:18:46 -0400
Message-ID: <CAN2LT1AabjD8sX9LqFgcEn2cFK+J9fAhEhbZTbQeUHEmW_+cQQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] cat-file: add remote-object-info to batch-command
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: calvinwan@google.com, jonathantanmy@google.com, chriscool@tuxfamily.org, 
	karthik.188@gmail.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 9:12=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> [snip]
>
> > diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-=
remote-object-info.sh
> > new file mode 100755
> > index 0000000000..64eb55bd9e
> > --- /dev/null
> > +++ b/t/t1017-cat-file-remote-object-info.sh
> > @@ -0,0 +1,748 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'git cat-file --batch-command with remote-object-in=
fo command'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +
> > +. ./test-lib.sh
> > +
> > +echo_without_newline () {
> > +    printf '%s' "$*"
> > +}
> > +
> > +echo_without_newline_nul () {
> > +    echo_without_newline "$@" | tr '\n' '\0'
> > +}
> > +
> > +strlen () {
> > +    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
> > +}
> > +
> > +hello_content=3D"Hello World"
> > +hello_size=3D$(strlen "$hello_content")
> > +hello_oid=3D$(echo_without_newline "$hello_content" | git hash-object =
--stdin)
> > +
> > +# This is how we get 13:
> > +# 13 =3D <file mode> + <a_space> + <file name> + <a_null>, where
> > +# file mode is 100644, which is 6 characters;
> > +# file name is hello, which is 5 characters
> > +# a space is 1 character and a null is 1 character
> > +tree_size=3D$(($(test_oid rawsz) + 13))
> > +
> > +commit_message=3D"Initial commit"
> > +
> > +# This is how we get 137:
> > +# 137 =3D <tree header> + <a_space> + <a newline> +
> > +# <Author line> + <a newline> +
> > +# <Committer line> + <a newline> +
> > +# <a newline> +
> > +# <commit message length>
> > +# An easier way to calculate is: 1. use `git cat-file commit <commit h=
ash> | wc -c`,
> > +# to get 177, 2. then deduct 40 hex characters to get 137
> > +commit_size=3D$(($(test_oid hexsz) + 137))
> > +
> > +tag_header_without_oid=3D"type blob
> > +tag hellotag
> > +tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
> > +tag_header_without_timestamp=3D"object $hello_oid
> > +$tag_header_without_oid"
> > +tag_description=3D"This is a tag"
> > +tag_content=3D"$tag_header_without_timestamp 0 +0000
> > +
> > +$tag_description"
> > +
> > +tag_oid=3D$(echo_without_newline "$tag_content" | git hash-object -t t=
ag --stdin -w)
> > +tag_size=3D$(strlen "$tag_content")
> > +
> > +set_transport_variables () {
> > +     hello_sha1=3D$(echo_without_newline "$hello_content" | git hash-o=
bject --stdin)
> > +     tree_sha1=3D$(git -C "$1" write-tree)
> > +     commit_sha1=3D$(echo_without_newline "$commit_message" | git -C "=
$1" commit-tree $tree_sha1)
> > +     tag_sha1=3D$(echo_without_newline "$tag_content" | git -C "$1" ha=
sh-object -t tag --stdin -w)
>
> I see here and various other places in this file names with "_sha1". I
> think it makes more sense to name them "_oid" because these works also
> fine with GIT_TEST_DEFAULT_HASH=3Dsha256.
>
> Other than that I don't have any comments about this patch series.
>
> --
> Toon

Thank you.  In V3, all the variables end with  "_sha1" are changed to
end with "_oid"
