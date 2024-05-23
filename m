Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4A2628D
	for <git@vger.kernel.org>; Thu, 23 May 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487008; cv=none; b=I/RFdrLZUmkK5AnRMld+Oimz94oPdZ6PAWoG9xqDjLAqkPav4peWb+QMITMu0VJfMbfKAosdH1bBn/UKeLXQTGgN+4JtQy3m3By5QVJKZv7Ek761Arb9ICvBEang2yKNOZsc5z+7gSF5lRzoXjOCIFyjnCqFYp+A2Q804Clzr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487008; c=relaxed/simple;
	bh=Y1GjVns2uWBXmIqAjGqqGdn8RXWVX6oScj5rPzy6vAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8y4/4A0cSoaYuw+J9WCkPFPQDsZNZrUN4kGUfTunqD7WRw9SVfSGDOXTR8I91OERHf4S7iGOol+Y2mI/VbuaXxnHrKpauDmK+A8LMJeJVGwEELXQqDEzJH/+fiIp6zsPErXC3UWUfAT6wfqr+tTOxqqSwL1U87d35Y5C3mEDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GkXwLjN4; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GkXwLjN4"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43e385a7589so11247961cf.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716487005; x=1717091805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1GjVns2uWBXmIqAjGqqGdn8RXWVX6oScj5rPzy6vAQ=;
        b=GkXwLjN45SFAskMSJX1NzLGBq5g8gEK/YPvNezJm6kqAvZJXwjt1dUb+e0C2wIopep
         rfBmpdTgLKNs41SsjN7TiYWpOXUpV0QBmflrYbhQOg1UwaEodV/hdSLLFdxkIZMUOtWe
         yBSBpu2qDMEnUbAiPCCCoTcenc6pQnsmy/68F5uuXYU4Myfbkh1F0wckrTubCWrWUVZX
         fkb/RSjQGL68RKQuN8KXgF8VOzcxON4j0ZhO46gp7QOe/BpFI6gft3RIAGI54busV4v/
         YiOgy7uxLxnd/9C7wLhXk70L3pqcPg33pbHV4f2M9tnXMEt8pzG0KQiHioFvp3jTclSm
         kHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716487005; x=1717091805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1GjVns2uWBXmIqAjGqqGdn8RXWVX6oScj5rPzy6vAQ=;
        b=QC60TR2nado9LHb0DO6zZBTiv/p6OPtbgzJU9wvBANNGC2bS1uvTi8zR3iP7VxiH7j
         9QKLQ1ao/5TtxVjdag/OQdQMRpnZI8pT8f55GzxJrt3eD5ICI4X6aawoBaGRQR68v3As
         prpEW6HaC7Hrp8HVUeY10Lm++/1+1Sh/oN/wISSFsfnsS8X7Sgbbsa63d2eHyXgi/uS7
         dZtAj2Tg1wzacR/ddaIwSwqJ7WX1ysY2oeCjuxL/DJiaWPphX+TPH4ZHupcZUJTJ9CEY
         fW21fZ61pehsZiH9MkAH29cCJFNheFwS1erJLrZRUVJgKPo3EX8KSGL4u0Q00Mq6yQwq
         ZnCQ==
X-Gm-Message-State: AOJu0Yz6zn3vD7SMCVWXiu+76ez7ls22nZA/UAtgPkmsCLQMCfrNTqDK
	adOpX00Gmvw7O8ZriihbdeQd3sEisdIjhVVgMJHs+ckpJaSUrUR6hSU7dwMIGok=
X-Google-Smtp-Source: AGHT+IFEKFcIxW2SyLnM8+W5Z17R+KRgmB8Y0+SKXu78/dHFiJSExjGdWZoe/g8e2e2naXjO/8mgdg==
X-Received: by 2002:ac8:5a04:0:b0:43e:40bb:a0db with SMTP id d75a77b69052e-43f9e0f084amr55888851cf.54.1716487005018;
        Thu, 23 May 2024 10:56:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43dfd760ca8sm176559761cf.14.2024.05.23.10.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:56:44 -0700 (PDT)
Date: Thu, 23 May 2024 13:56:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/30] pseudo-merge: implement support for selecting
 pseudo-merge commits
Message-ID: <Zk+DW4uBXDSd5xAf@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <3029473c094b3edf51828b7a1d1acfc8e959ece6.1716318089.git.me@ttaylorr.com>
 <20240523101248.GB1308330@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523101248.GB1308330@coredump.intra.peff.net>

On Thu, May 23, 2024 at 06:12:48AM -0400, Jeff King wrote:
> On Tue, May 21, 2024 at 03:02:32PM -0400, Taylor Blau wrote:
>
> > diff --git a/Documentation/config/bitmap-pseudo-merge.txt b/Documentation/config/bitmap-pseudo-merge.txt
> > new file mode 100644
> > index 00000000000..d4a2023b84a
> > --- /dev/null
> > +++ b/Documentation/config/bitmap-pseudo-merge.txt
> > @@ -0,0 +1,90 @@
> > +NOTE: The configuration options in `bitmapPseudoMerge.*` are considered
> > +EXPERIMENTAL and may be subject to change or be removed entirely in the
> > +future.
>
> I'm happy to see this all marked as experimental. We really don't know
> what selection approach will be best yet, and it's good not to lock
> ourselves in.
>
> I wasn't sure how this would format via asciidoc, since we're in the
> middle of a list of variables. It...kind of looks like the note goes
> under the previous entry (for attr.tree) in the text manpage. Though
> looking at the docbook, I _think_ it's actually outside of that, and
> it's just how the roff ends up indenting it?

I think that you're right that this is a roff indentation thing. Looking
at the html version rendered by asciidoc, it places the NOTE in an
admonition block [1] that is separate from the previous attr.tree entry.

> I don't know if it's worth spending too much time on, but maybe there's
> an easy way to do it differently (I couldn't think of one).
>
> This paragraph might also be a good place to refer to gitpacking(7).

Great idea, thanks.

> > diff --git a/Documentation/gitpacking.txt b/Documentation/gitpacking.txt
> > index ff18077129b..1ed645ff910 100644
> > --- a/Documentation/gitpacking.txt
> > +++ b/Documentation/gitpacking.txt
>
> Thanks, I think this new file and the content you added address all of
> my documentation complaints.

Good :-).

> I think it will also be a good place to discuss bitmaps in general, but
> you were IMHO wise to not do that in this series, which is already quite
> big. :)

Thanks. Yeah, I would like to add more about bitmaps and other advanced
packing concepts in general to gitpacking(7), but let's do so outside of
this already-gigantic series ;-).

Thanks,
Taylor

[1]: https://docs.asciidoctor.org/asciidoc/latest/blocks/admonitions/
