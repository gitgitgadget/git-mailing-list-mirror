Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6230BF5C
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 03:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780976919; cv=pass; b=hG0ykjU/j5JHf4r63FdbYJ2xBwvwhZR78iZmbRjLPIPx+vvnadWzpXD+K+k0fxIsDXJHxRwlOMEvnOSrb94It5IWvrX4kzpCBVWfDC03yf/+nAc6hsq5sPyKfw3SQ/dd63pmm2La3U//EYf4Cxs9nk6X9mAh25QAyZwGxZiuFGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780976919; c=relaxed/simple;
	bh=MRY7CJwZ67p4xkofIEd5zOYlfwOl6BA7I+Zww7Amm7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAUbCsiVg/lXOfKUC3buxgeH+DZoBRLV4zF0wsfYjLTHae3tkNu7v+5OTrE9rKb3vV/CEEXTMbRpR99zjU1UExIjfVe41xZEWVpXC1BqB2sGghNhX4BkgfeyuqLBkuv9Kra0b/pYWAS/bLfV2vosztB89Vg8Klny1obpvriuyEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdS4XKn2; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdS4XKn2"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-396770cdcfdso52342201fa.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 20:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780976916; cv=none;
        d=google.com; s=arc-20240605;
        b=d1KjpIQLjNxT80pBz51E6+rYSNwWfESl4Ztzdpw/mg/cIj9lURdtlFqybhPYSWnxk1
         LMsJJqiknbixC05XAyNndRBYSnotStTnzJX5CYFSVhUqeefVBKhY8Yv+c6lwizi2tFg1
         NGNTNbucuwwf4FVpHEnfGY0sdR4EqVfTQRYOWMPqfdKIJCTSNBO4lzAghlez/fC703Da
         KILXDuaFQfouIQZtxZ/L+jBhI4H+QiRwtSuiqkMOI/VpFBL+LOvMI/Ur5PrAHhP9iVaM
         PQ5qA2OEp7PNWeK1zUCt5vyqzj7bwrMxeljBoUqRxSWJh0+16YPdw7BMxTkw58cvZVJN
         yTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GX4Jry4dSLG/YIo1WU2AQoXgt92VwgIFSzRJoAVLvPE=;
        fh=N/Hn4Wb1qGNgntkEgdKemjVdh0BBMPDjsCOEmemegKI=;
        b=L/w0kkusl9dhIPrpwhikjQKxmKVu5onU35i266zrjgKbyUtBEwca0x1G0r5M3sJWDl
         lPEbKGr+69ltOL6b9MzbemjtcSFUeCB6CEseR5NhBUv6Dqdbd1/VBf8GokGbtiTwh1FH
         ByJd0mu+aDXSUHwlBchRsjXivbdiYNUBnUpd/vTntnplnJM7dmBnpnUrIBzGdZMo94l4
         6bUWkWI0sRNXayqeVsJwpqXgEl+2cZDDO8l3HhstOp9G9VCIf+vG5bT2MlOfLV0OMQoC
         A3TSpGkt4XwGN7W+/7EuCApfVm7r9T5BtEERVvsizuzIGyOKvj65Uy6FbMHk+BAscJj3
         Qurg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780976916; x=1781581716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX4Jry4dSLG/YIo1WU2AQoXgt92VwgIFSzRJoAVLvPE=;
        b=QdS4XKn2Yvq8GNIGEXBskMv9MWdPoF9uqSrnoW2owlt8wPHavSQGpZTCnFIzGf8pJE
         QsWf9e5IQTP5uevqMKvsAho9t1IEiMQ/ND4gNOpdjmceFd4IaGlKQE4Vz/TJQuJqPjIO
         2L7NuVAofB3XhLGIawUv8wqdRV2j9voVggW5eRs038jG2j+4K39DwOPYupeGcbl/L+9y
         4l8aRAg/zhHIlvOhzoIhOqyo2pI9m0km2gI4J64R/6UsNBBhVCoORrbONjsLVtuO75Cp
         xmDQI5PpY6pLNEsm5MeFhcNcF0xefcIkDgJAdm9vkI/m8dNx4Q8OeE8Mtwh7QRr6aI0X
         Dp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780976916; x=1781581716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GX4Jry4dSLG/YIo1WU2AQoXgt92VwgIFSzRJoAVLvPE=;
        b=j2IZfqO2UK0/YKZH4X5cXYi5bo/G0Zmfn6WT5RYdw2plO4fZ93Bf7cE27PrhBssmME
         a+8i3cY+8yE0dVEs+BwgiK2m0Xp1fwMnpATRE0VYEOQEcqI7KJzIdeZi6OgY+HZv0FJ9
         p+fU54AqOG5UdKvikPNN1Gc0VCoWEanIE9ZKj3szZWXad1uoMrsFSH4NtS2DGQDvV/Ll
         vPlhve0MBLJCmujHB9x+f3PvcVEKyaW4GzKre6JQO0aCKbLwR+uvCXkRdbM5vehQ3ckE
         MF3lTjsBXjfuOC+bPQG54pVDPP6tne3QWGc4s7WKUpbVI7G5HPSgQbnUsjTsfjxtjJGu
         TMaw==
X-Gm-Message-State: AOJu0YwU/tzgswjLSotyRCvdAk2dGb2TIJEtWv2vzRpcNnV46fCBkJIo
	OcWKr8PM4W++sxqOWXiyQOWpt1Sr8+FSpIIkhoS/FzbjjfelL6DB3M+YsHWpol+A93/bSuaZGfJ
	gsMIS8p/URqpG68baRx2W+c/1uuz18Yc=
X-Gm-Gg: Acq92OGKZX9ENWEVmGqgsgfJQjTS7yjk0x/NW2wAxYZe2KYL4flmXGi/+zCF7YdbQqL
	1UpO9QS2fZ+23frf2ifU5C7xVkHTU2jAYHWh772xMpfb0qp2w4Q6cU/YPxFxcm1hteD7BdhdwL0
	IN77aEOyu4PMdF8MnXxxCRwr+euO6sZXwESc3WTTkM+OD3xbVx4RaLbBKd92QvN1TcX4G11K5TA
	e/Lor6N/RwuW6/OHEKCg+1GrWZIRPpTrFRVkRVIM+d6C4Br3apfxn4fFmQGufHuWiJw/KInuYDR
	3f4JQOlvCsUM9JNUEpGCGzPvG3mVIN1KaQwcjsWzOqTjGeo9GpMOMhvNQJbfukQxRY9owCMcnm9
	2c+QVf0mRR9wWeIcvYXDqUMqevoO7L5A=
X-Received: by 2002:a2e:be2c:0:b0:393:d562:d51b with SMTP id
 38308e7fff4ca-396d0793a6fmr54770381fa.9.1780976916297; Mon, 08 Jun 2026
 20:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
 <xmqqv7bstmw8.fsf@gitster.g> <xmqqecigtm5z.fsf@gitster.g>
In-Reply-To: <xmqqecigtm5z.fsf@gitster.g>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 8 Jun 2026 23:48:00 -0400
X-Gm-Features: AVVi8CcehyGTNRjCmTWs3hkItXXapZ2jlzK6IqQ1Kj5WVqzjiDr6mFMGCQ9ut9g
Message-ID: <CAJ-ks9nCK=a9s61yR7U9wf+e785Wir6RZSKTDWXyP9nH9aEXhQ@mail.gmail.com>
Subject: Re: [PATCH v2] ls-files: filter pathspec before lstat
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Please make sure that your v2 is a response to v1; otherwise loses
> > sight of the previous iteration.
> >
> >> Changes in v2:
> >> - Restrict early matching to one pathspec, avoiding the regression Jef=
f
> >>   demonstrated with many pathspecs.
> >> - Add all-matching and many-pathspec performance results.
> >> - Drop the Assisted-by trailer.
> >> - Link to v1: https://patch.msgid.link/20260607-ls-files-pathspec-lsta=
t-v1-1-8cf40b730146@gmail.com
> >
> > And it is *not* a replacement to force human to follow such a link.
> >
> > Instead, please make sure each piece of your e-mail identifies where
> > it fits in the discussion thread by pointing the message of the
> > previous round with its In-Reply-To: header.
>
> I won't complain about them individually, but it seems that all the
> other v2 in different topics from you share the same problem.
>
> Documentation/SubmittingPatches expect that the messages on the same
> topic are threaded with In-Reply-To: headers; e-mail based workflow
> tools like "b4" offer a useful feature that lets the user to feed
> the message ID of an earlier round and fetch the messages in the
> latest round.  As the message IDs of an earlier round that have
> become commits for v1 are known in the refs/notes/amlog notes
> (published at the usual places), replacing a topic with its newer
> iteration becomes:
>
>  (0) check out the previous round.
>
>  (1) learn the message ID of the previous round we have checked out
>      using notes/amlog (e.g., "git show -s --notes=3Damlog HEAD"),
>
>  (2) detach the HEAD at the base of the previous round (roughly "git
>      checkout master...HEAD", but not always),
>
>  (3) ask "b4 am" to fetch the latest round of the thread the message
>      we found in step (1) belongs to, and apply these new patches,
>
>  (4) run "git range-diff @{-1}...HEAD".
>
> which is very much automatable.
>
> Unless an author breaks the thread, that is.

Yes, heard loud and clear. As I mentioned on the other thread, I
followed kernel conventions here by using b4. That's my fault. Sorry
about that. I'll do the proper thing in future mailings.
