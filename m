Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964B5616B8
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190711; cv=pass; b=hb7h74ju9P9I3B5fLIB9QnwYRPH6OH0+gZeSlF2+OSJIgeg/TAtytcUtO1HTkh7Jr14E42qBn3SaFAfEYT7bX10S7sT0UhwV4mwJ+H4qOCUOF7DN8w+7Ls0SduHtVHn2HdidRHL8ks1rCbzBBB4GP4fTVSAasLSXneeMfbh4IFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190711; c=relaxed/simple;
	bh=Kyqltv8bNEzL0VNsyFC6l6BsJF9SDI25PmtkEdeg0q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcTlljztv8O/Vfuh8UI6WKQvrO3hSkmEIlcegrKpVlYjx40U159dw4je1gdZWxLBsLTbFrkm2wYEUX8lCbEHPAV7QZBdFR93rmwUHdbTNIjcuDE/oJDROP2MW6X+m6erzhyeVid1dCO2bjy5tXzWSBwcHZneg6P/ojgAxQxp0kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2BpoyPp; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2BpoyPp"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9ab667so1031770fac.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790190707; cv=none;
        d=google.com; s=arc-20260327;
        b=QunjZqC3s3/PwxWYXmcKW8hTi4pOAsdudjJmCcki2R2q+KAh8YS68QxxcLGvMyWD/n
         MFzzqDgHy2J0UudHf5Cnh+fJiW0RwJdwIcPAPIvsEDE1mxAHBBbRbgwq9hlMBjsWTVOh
         xesC/aaWPkXm8FUspizJDXmQMlshStaMXJ4AY742DUaWF6ZKLy3A22vTZZkaa4kM4qgn
         uI+TbKoP73dSJ8xtzkRDueFty1N/aNJk3HCPG/+Vc6pOhJfmWs6SZVZoYMZmiZ3q8EvF
         vN+lpjJdkayU/xeIXXLboFrmcozOiPi2PnTTCd3gBVsZlaEiiDWdkc8dbj0qo2trjxe6
         ySEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=77rwKPNeojgkqLEKhSjs2cR1PUdsFa49nF8R8MkJz/s=;
        fh=1cmuXsi4NeQk4O6mjfp/VUohL5buQ6b3ce1i4eeodUw=;
        b=IFRHumNlmbUQKmqjjIrXELvT9iwRgi3bDVqmuKKgSYFCtRszcebjZ6+xlOiuB5ffvU
         Z2Y8Qt6eGEfbbKD1kLjB7qX9O3by3I5APStEN9s1qfvQL9IXssxptkuzelv1lTazJqih
         uk9FUWzf7wlaKwr+xE2AHNn765cp42Avw8dBjhZx0/FJIGp1yRE3ZNLbEsHem1YIah8x
         Zt6hLsnDsV0mIF84LQukqeBXyPCEDGj8OXKoki4KO7VypiMkWON0dkuKhN1K53nteh+f
         RBdjO6nqW4Dt//7aG/28DASfS3H5W4RaqC9h82888hTyb/yrTb9Q6s5d2BWzzGYnwlV4
         oMAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190707; x=1790795507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=77rwKPNeojgkqLEKhSjs2cR1PUdsFa49nF8R8MkJz/s=;
        b=k2BpoyPpGeUAe9cl6DQ/5rKzTBYTRQWeL2aoJ7g4Ismrgy8gnWGlFW0rAX9MXL/Bbz
         9khNCwOVzpJHY+y5a2ufc1EyGk8rn0baEeHsAy4qIeqBw6U2Q7nbYIYmWERcrgqx22b4
         lH+Gg/tc3m28w5B1C/tYiCdpgTeDXftJ9ZTYXELiIBqHB0besIhlMu64LjLlS1m9Jc6T
         l+Ih+Pfp4PvhAJ1/ksyDONUZPe5vFCbJA5g2VbnnY88TXm0QoJjwm9EeXc8xFgcqaGRZ
         ZBQgTFRlcwxcx1mWoLfGI/68ccOHzQJnO16pHo7Uo8K//NjyPAfpN2VREMKoAVfwzJQJ
         VtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190707; x=1790795507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77rwKPNeojgkqLEKhSjs2cR1PUdsFa49nF8R8MkJz/s=;
        b=g4/Dmip4hyPiXhywCOXe8tr+2IF9txdx9OtTvv2HhyFCJw5xPD6cEE0vR1jE1MMQ3s
         TersOoYm9AfcaGYJTXCwzy+IUDL3BjYcMcX3ixLWyipdaxRzpj5opwqFYvJF9q8FoQ4/
         Wtbzvl0jnWuvHNL0D8V5SALu9v4V/oYp/RkLT6HTk7ybdDz7VW+P/uiDPCgA2bZFFe9S
         o2da0gqcTUdwxnw2CkdPyDE2LEnI565886u8n+2SDv7oB9qV7686rqX+d0AO4JaR0/kZ
         KAuDfKDZNBmtpsxnqCr91LhCyWNY3Jb1Qrwy2L7LrEMVGaQrRJhC++E58speRY/PoocD
         nWXg==
X-Forwarded-Encrypted: i=1; AKwUvBz26raspoJUDnJSaX0isqUjIck5T5zseY44lusjs2NBpOSpfk0ZV/JABRIvo2XrmnEbOlg=@vger.kernel.org
X-Gm-Message-State: AFuF++nNApVsRGP1n6pTmKs6zMi/W4I2CXvS8KfXvJxezEg4SvsmAvgc
	LhY+QHx9r8YYnt5JjjnhK27uYvlJ+U2D73SCZv9svxUvY7b35CnWTs9GbtaMGgHUPGHFuavOJHm
	OZbpL6LVdsrFWLcTDdeMaBP8L8Tr75VU=
X-Gm-Gg: AYBFou05Q1WblmyZW9C3LVaHSznmnekpjMomMhG29WHAtg2gf9aACoOgr/8ZvI2hjJz
	SsZLyyc8LmkiZ3JO8+YmHLt2TmFxqpdmlIR9rPWh8yiiRxxM891xxJe+o/KXs/jX6LCHd8jfrQR
	/zJKc1lVw9Jck4Bx2fdY99sSOI/Uj0pFSBgYvepoeRaz/Oo1P4+2QEcm/tOceHMGGMdiN0TXdWu
	LyS1hmebsXO8bUpa55akpg3x4gdtMJfGWWy6JxZcTYyAOLaJahi59MikdW/X+Qro6yLc6i935A8
	29Z8zU50xWXHOeCgl8rOMBeixPrSSj+Q+dLWZQ6H9TKAZR5Rh4QNu7KrWn4bMLCAYDVXzqVoqUP
	1FubRMRme7ZCp5DYnyw0FXiMm6QaazghJyeDdtAjqFMz807nFvLNRJPg4rkVBsPo+PNgVJZtTO7
	FDkjR8xBo=
X-Received: by 2002:a05:6808:1692:b0:4c6:3c74:88c1 with SMTP id
 5614622812f47-4d72df6d1e3mr120593b6e.32.1790190707465; Wed, 23 Sep 2026
 12:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
 <CABPp-BFadjqtOB_9cYkrs9UBgTp0hQxu4oiV_yqzYOuiu6g45w@mail.gmail.com>
 <arQZDXxf0139omx5@pks.im> <xmqqzex7akcv.fsf@gitster.g>
In-Reply-To: <xmqqzex7akcv.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 23 Sep 2026 12:11:35 -0700
X-Gm-Features: AclHuK-S14dStYoDcjcBcUm0MjteFkXl3gEZsVzmBIZJPT_VxJyubw5D0cS803E
Message-ID: <CABPp-BEQSx4m3BcT28CpVGCtsH75+x3gmv4OJz_ecLVLx+kBWg@mail.gmail.com>
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend committed
 conflicts again
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:33=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > I think reverting is probably the safest change for now, and we can the=
n
> > discuss how to properly handle this. I'm not a fan myself of refusing
> > the commit outright as that would break my own workflow. And I'd assume
> > that I'm probably not the only person using that workflow, also because
> > it does let you inspect the result before you move on.
>
> Yup, splitting a commit into multiple pieces and other manipulation
> is easier to do if we are allowed to "git commit" in the middle of a
> "rebase -i" session, and if "git commit" is to be allowed, "git
> commit --amend" needs to be allowed immediately following that "git
> commit", if only to reword a misspelt log message.

Makes sense.

> > It makes me wonder whether we can instead fix git-commit(1) itself to
> > maybe not reset authorship information. But that's probably a much
> > harder change to do, and probably it would make the mess that we have
> > with the ".git/rebase-merge" state directory even bigger.
>
> I do not think I understand what you mean by "fix git-commit".  Make
> it pay attention to some file in .git/ directory and override the
> authorship information over what it usually uses, and make sure it
> removes that file after it consumed it, or something like that?

Yes, `git commit` already does something analogous with
CHERRY_PICK_HEAD: it uses the referenced commit as the source of
author information via read_commit_message("CHERRY_PICK_HEAD"), reads
the proposed log message from MERGE_MSG, and consumes CHERRY_PICK_HEAD
after a successful commit in sequencer_post_commit_cleanup().

Teaching git commit to consume REBASE_HEAD in the same way seems promising.

"git am" is harder; it doesn't have a specific pseudoref so we'd have
to dig it out of the author-script and final-commit state files.
