Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF43890E8
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509845; cv=pass; b=FXIkI4Z/ii+Uh/oJSpofpQFOLYlqPjKus36n2yYZfV+clOCrSY5jJdQJpz2CG/snc5Q7UQFjgAzxQc5y8t8Rd1TEGchsstZ3iwCS3Ezu6yH9XPjVdWIjZftjK8S8m4/NxoUduVo9XicUzHkATJO5yupe+5AddzVnu5OYBoDvkcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509845; c=relaxed/simple;
	bh=QbhqPtJDZt+FJVvai1xr2LRplBldwf+inkzLdZe/el8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXfu8LoU6DQTf0rrbWYJiadm+3PfrNOOycYh0J3fHy6/HrJ0ykjjmY/rIlf2CdSggfSDoYnHYAyYEwrIc/h4m29p06v+SXXGrRZXskg4D/sxQ2bgWphXT45xqWpNFHGR7yXv6J6l52UfgK15CvIaIEtgw/UFK0cH90sWcJYH3wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIsRR/AN; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIsRR/AN"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68b482888c3so1518753a12.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 11:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780509842; cv=none;
        d=google.com; s=arc-20240605;
        b=F/eQPU46IZvjfecWopT7A5thwjhVrO7UMbmYWEOmU6GW0EEx9RfJ7WNxWrMpsIjQNc
         dsU1rPyHoDjKOfRTMyBfTj64K+KdRmxr4B1OpFEqf9ngTd5f+bqiyuBwvanI2CfpJSQc
         zhucLboXHG0nohuQcnqd588o8Q8oq56gc0LeE6TSIMOEQPmQMZBxZUZVXLNgUjNOFdRC
         c3NGiOQyWM1p1o5IMUzphsFVdVPnNc7uhB1S+Urbd9CECxfu1Nz8dsQQe97jIO0h8MDo
         jT1KrA/hmQdNAcaEZDIejfd+TGyiDC7CBEeSVVpz2hhxi+P3AgC+DMbI/TN6nFZHybpf
         F08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l40QNRO9LrEZ/rNlv+fb2C1m7qzN36wxlTYAslBzW9Q=;
        fh=mZixHP2Ewss2SFJr0NJjUylVjNy0qV/BrWHw1aJTsFw=;
        b=e7Z95UoAHiKpYMLIpOcV6loLjZ9wOAS+tnksklcEtInykLfz7RIu25yVAcFWM3U654
         +gHzwsD5tTb1YeRtJ5Up4ypYhD6U8/Z3R1SEbXLjVeHHLWJa8Mlhc1V4nIZe47D9ajIs
         i+W0fZ0w9YEdP/CX75yZeSlRI1y7efgumtueF0+4yaveabl/JmmC58xSn4eGEUO4l/Jp
         Eht7URA6EwT5oT/NscAFxwcwDcz0NijCVM2ADbMMi12j4gUNvjtZ2HD4DkSQyU4XNZ4+
         /E9xNqb/gGEbsD2AqBfxQzBlkfIcPPqWcVAcKdf7KxUH55sqN8I+yCfufpNb2Vd+EHXF
         ThaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780509842; x=1781114642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l40QNRO9LrEZ/rNlv+fb2C1m7qzN36wxlTYAslBzW9Q=;
        b=VIsRR/ANhsmBtago9MAma/mpBcCBkbUPpXo/cybrHOTTd9YfJQ4o8bX0xN+560T4DS
         fRMusqssJgo2REYv4sKru0opnbtsptVhBElPxU1il+v2WcMEyoRxH2O1wxO8C5m5YTe1
         AXhZBINLKEJ0qOYm85RhfUHRvkN/m0vlON2wD2nxF8yB7aJFRdcs7hGmjFDgQkm7aBDp
         Uffo8V1mRYFAA0ZBJBldOf2l4fzE9LJB1XG9dlmZDdQksiAucSEs5qsaTQK+6Ji71o6I
         KAUDb64w887PWwvDE676fPL1ZC4/xibkgarTNmVlosvA3lsqMwHyP9je0utOpG9MaRi5
         mT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780509842; x=1781114642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l40QNRO9LrEZ/rNlv+fb2C1m7qzN36wxlTYAslBzW9Q=;
        b=Ind1nQXGDqIiMcX5GNJBZBJNO6Ik/iAy0ACWAEwZVoiFPB/9wfvnNSpobcNXfwhRto
         GiJyLUlkio4IlOh5vjmatv2CoaVhY51txYRqBp6MZYpvZMFhNafpeQ55DEQcNVs7gc1/
         FlPHLeQYGx6OaK9mPwulwxaFy13f7MPtHgsc80KYr5WuCK8I1to213zPT8grCG4gU2ft
         TdTBI80XTVk5xVEQJxX+573jeLcDZ5YtfqeRrs76x+Ja6ounxPs3AxyfRzIoo6Dy/bUe
         VzCvMfv+jWVboTjw90XlrBhKsXFrWHxRPzIE3B7GpWi17Hi+cDwn1hOitTXhfTEqU+GF
         7d9Q==
X-Gm-Message-State: AOJu0YwDEkz+6Eskzaz332/0+26aPOvUnadOXK9pEbrtzKn/PCX4irqX
	d+tdPu5Hf4BXyg5FcEMmnHW/Zo9G3Yk5XmHXrRhngKkw2wyeV+ZnvEk+r9ayJGlm2n2axRF2tPG
	zdZ2qBhS12JXUpqNMOrFt7P4PoXF8res=
X-Gm-Gg: Acq92OGBjRBXTNpUz7RZ68wVuUtgpIp/lx740yWoQ6+7+99L+AFYo9aw4DSRH7P9Jt2
	MXU2V+vkppi3K+tNf9+8oOpKwa8X29X4cWRI13Ojy2BtAtspOp40eNsqxnDw1zszdIrlnLwsLfv
	TKXWQ2ABDexCzn+y0oDANkM2/Ag9USDUVZzBbn1JRwtkSlPp5dAaUHHMJcdUYiYimUABsIVOGPA
	UTKfcrvFXS8b3MESAg/HFfwc39o8HoWmIxwsWa+10FIBjNztJeE1rugGxxxFwE9Yg3ScMO5s87U
	eCq2RMAlbno8QVGxQALyL7GZcWph
X-Received: by 2002:a17:907:271a:b0:bec:7185:d3d8 with SMTP id
 a640c23a62f3a-bf1d1a8c7e4mr20342566b.6.1780509841479; Wed, 03 Jun 2026
 11:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2318.git.git.1780477489662.gitgitgadget@gmail.com> <010c001d-e241-475d-99ba-f60f71d3365f@kdbg.org>
In-Reply-To: <010c001d-e241-475d-99ba-f60f71d3365f@kdbg.org>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 3 Jun 2026 20:03:23 +0200
X-Gm-Features: AVHnY4J3dHPO67uA9bXHU6u3TCr70VuWMXS8oaSddE1hsCBqkJ9GRLe5q7vGrCU
Message-ID: <CAHwyqnWsA_s7bXoFZWgUmMW7b9x9H4KmSvgvc1FVt6nyH3HnLA@mail.gmail.com>
Subject: Re: [PATCH] git-gui: silence install recipes under "make -s"
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Can we please mention shared.mak in a way that doesn't assume that this
> patch was made in the Git repository?

Good point!

> > +ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),s)
> >  ifndef V
> >       QUIET          = @
> >       QUIET_GEN      = $(QUIET)echo '   ' GEN '$@' &&
> > @@ -89,6 +90,7 @@ ifndef V
> >       REMOVE_F0 = dst=
> >       REMOVE_F1 = && echo '   ' REMOVE `basename "$$dst"` && $(RM_RF) "$$dst"
> >  endif
> > +endif
>
> > -ifeq ($(findstring $(firstword -$(MAKEFLAGS)),s),s)
>
> I would have expected that the old and the new condition expressions
> only differ in the ifeq vs. ifneq, but they are different in more than
> that. Assuming that the new expression is correct, was the old one
> incorrect?

Yeah, the old format doesn't seem to work when I use that with ifneq.
So I took this other format that is also used twice in shared.mak
(lines 40 and 46).


Harald
