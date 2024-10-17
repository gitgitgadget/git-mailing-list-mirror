Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB071D86E4
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191012; cv=none; b=KbMf+kmUAeEhokQ1jWX/9cYGwl2fhrWghAIM8gAaiqpZ0/c6R2gU0sIT94dZv0UU06DVMpUDGiKn54GFwWmnCi4yJm3TevHtSk1cjHu4almrHnfW2ShPfosbEqwttOaVKmXdwJIxPTBSJoIiIAHSLP4dYUtFkyQzRKnDePMlu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191012; c=relaxed/simple;
	bh=IQY2x1LI26+/83ky/t5i8Dbyz3lBuoBTy4QmpxyJwmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCDMhi1fbjrHMgFuugbNynsyJqZV9ckb63NK9NgjZNd4vuCnwQXKWttibeazjDfq8MPGP3JSJ5SYLtgb+k/sf/ftIrCh6fNDV6FB1wR7sGxppR6gzpXQECbguXhCY7e8YVmKRlnJH5aTTuULLYbNKnjVYnEE9r5JipyOoVaQqf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=khlRZ3xo; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="khlRZ3xo"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e314136467so12379137b3.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729191006; x=1729795806; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b0FWEVsjU201ZNzQZ+2JXKfZ2zySkx7YqMFClzbZ5JY=;
        b=khlRZ3xohNw8pzLVx8HUWYqST3RTcSrjtyp644rMdI1RgwY69w+zYenE7iyavZBuTC
         VFYHJ+Q9qrWIcE9dykgN2KBNkWAgIq9SaV8YQkmzUSFJkYrvBDMhzOFPAttla5EbMtFi
         eHNBRr37YC5NmRghAEMad6xU2OTgKE3KiAo51cTzEqT5YzgOkEOsJE0CVUU4BmWRkbMn
         zDwyHbbZ0PaO1Bn3E3KFXPTPH/n/RxF3Jz0jDIDwWPzCaotHpPkya4jvNsR/0/SJNpNj
         FqAIL6845XmQm2lGTWKhKi2eYdjSDamU3s8FC35G59pCNiunlH6TX7NIqlaTJgDHw9D2
         YRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191006; x=1729795806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0FWEVsjU201ZNzQZ+2JXKfZ2zySkx7YqMFClzbZ5JY=;
        b=SYLRWdSlSlAcs+6OP7xY6/cRASWz22CytoQQFM1U2xygZZkUQWs+GZuuvgZG41fIuM
         6peeXb/QP2EzbTpnHSO3Ju5fd06+HEXi12LH1UCCbm07B6mQX8ie5v0gnAVTcDhvEIr8
         pXKzSJ1HvnctBMvLDBA4gsvrMx4QKGLkgu26zHVaLudQJAOhwwld57n8eyHwlakT1zNR
         HjFgLYJsEbRxfFDjq4/gU9D8dIQwoEesGo7rLq7jtaMINzQ+o6iKEe7PrZC982rdB0ea
         cRe7hng6MeBeLoqYxzdqCwPeJebs796TbGtQTYFYLH/Ebjf5uARqZ4uJcdLUusaswMsu
         o49A==
X-Forwarded-Encrypted: i=1; AJvYcCW3t809KqAoA2a0oQKyV0B7hrP2vh47pU+jK34r6AX5GW7NVgPlpsfJgRB5hXPOpgudpac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkYN2JaJaaV7P0OG3xrTKEH/M1eiO8E05xNTWJ8wbX7izyJ22
	aicjPg5HmWKsTxhqFVJLWnN1IOw8HDm230dJdMHiyRX8a/1wkVgUdmI3Bb6/Vls=
X-Google-Smtp-Source: AGHT+IF31cGaK+/E1KC3E6mWdiR1a+xwSpxzYuzwCOHwPrR2+8SNlksARN7LJFB0q723Qx1k8ePd0A==
X-Received: by 2002:a05:690c:62c2:b0:6e3:6a76:ce45 with SMTP id 00721157ae682-6e5a3d808femr37096327b3.13.1729191005955;
        Thu, 17 Oct 2024 11:50:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5b875b5sm12512797b3.72.2024.10.17.11.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:50:05 -0700 (PDT)
Date: Thu, 17 Oct 2024 14:50:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Bence Ferdinandy <bence@ferdinandy.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/6] doc: =?utf-8?Q?update-ref?=
 =?utf-8?B?OiBkcm9wIOKAnGZsYWfigJ0=?=
Message-ID: <ZxFcWy7clKQyw1xq@nand.local>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
 <ad9ee00a2a971522968f95dd413deae24839ef71.1729017728.git.code@khaugsbakk.name>
 <ZxAmBsZzwBuEGN3N@nand.local>
 <CAPig+cSuQwu4YeZ5cs-g0oAnhCf1LMS1SSywyPc_vBExh85ahw@mail.gmail.com>
 <ZxA5ni7McD1c1yuf@nand.local>
 <24297144-c08f-4bc4-89dc-c3d8c12523de@app.fastmail.com>
 <CAPig+cTPyFXYxm-YO7xTqmeL1KZKT0vApvaD633Y4=q8=k-2rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTPyFXYxm-YO7xTqmeL1KZKT0vApvaD633Y4=q8=k-2rQ@mail.gmail.com>

On Thu, Oct 17, 2024 at 12:31:26PM -0400, Eric Sunshine wrote:
> On Thu, Oct 17, 2024 at 11:30 AM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
> > On Thu, Oct 17, 2024, at 00:09, Taylor Blau wrote:
> > > On Wed, Oct 16, 2024 at 06:08:05PM -0400, Eric Sunshine wrote:
> > >> I think we typically avoid rewrapping after minor edits like this
> > >> since rewrapping introduces unnecessary noise which makes it more
> > >> difficult for reviewers to identify the important (actual) change.
> >
> > I was skeptical at first.  But I saw that this line is only 55
> > characters long.  So I think (like Taylor) that rewrap is in order.
> >
> > What if I make a commit with just that word drop and then an immediate
> > fixup! commit which wraps the paragraph?  That way the review is still
> > straightforward.  And hopefully the integration part is not complicated
> > further.
>
> Don't bother. That's even more work for yourself, for reviewers, and
> for the integrator, and it increases the cognitive load for everyone.
>
> There are far fewer reviewers than there are people submitting patches
> to this project, so it is helpful for submitters to do what they can
> to make life easier for reviewers, and foregoing re-wrapping of lines,
> in general, is one such way to do so. However, this is such a minor
> change that it isn't going to matter one way or the other, especially
> if Taylor, as interim maintainer, is willing to accept the extra noise
> caused by re-wrapping.

I agree with everything Eric wrote here. If you want to send a new round
that re-wraps the text, please do so in this patch (that is, make patch
1/6 in your new round apply the changes from this version *and* rewrap
the containing paragraph). Please do not send fixup! patches or other
such things.

Thanks,
Taylor
