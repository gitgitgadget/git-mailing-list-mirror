Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3989199A9
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xN0qjXtd"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01741D7
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:27:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7788ebea620so61203785a.3
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697822822; x=1698427622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UR/M7H8zgLBG0FuN2/gItpzW59L8Fk5S9we1btR0UJM=;
        b=xN0qjXtdoThXngz4kuDE3b61/NusqX8BkIqkbm4pcTYQ+W9mxfRel2qZGTWGAadwjB
         ygIDTnNets+93e0zv0Ies6+ffJR2DDLKBCIOUWrRWOlXhgZxcMAR/Aduhh2J6lemVYsz
         fUTRD0vU8Fd12lp1q07u6lBTkz+ntKXuv7Y7EUxxjjwd1N9n+GIiOSJ4WkHv3tWV28dO
         GAFLYUcAkb4Ht3ddxJfvkhmWCd8p24IG/D3R7F7yBzZyG9Ndc2PfbOo8udDRAsXZAt3i
         BziC21CXAJtqvAtMwLasqpLl4x0z+F7HPXsPT0XyU/YUkqUB0SJrpFHnK5lQxilbG7PJ
         KZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822822; x=1698427622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UR/M7H8zgLBG0FuN2/gItpzW59L8Fk5S9we1btR0UJM=;
        b=QuC71y1stXZWKa+K/0wM+z/00V534c0WyoPhPBrE7unZE4tTFpxh22dlBYLM6w3F3F
         EWriTNeL/5S99i7J98ZmgzMdUYDjaE19M+w67oD4QuK+jnhgm12xZFRvp7OnPK/rYLOx
         ZsqHGcM5XwOlU8wCsHQxesCTh0+4iwQTwgBbJWs2O93/CQrSm8O7yOi3k4uNonE/Z3Vb
         Kqng8aWcFfJfx39dmfOwHjHWN6eNE4ROMh8OJ9Xbu3RJfFFm7pvEKC/AdQzvqrs4oSvN
         auGz32kzuWcApCnMuu5XNUNwFwGLLepU4k4EbmZ73k8ioTb8s2k98ESbjVAElxXYJrnT
         3Rcg==
X-Gm-Message-State: AOJu0YyvfoFeGNEP+3i/WMf0qDj1pzQoFR0DzOw6oiO2mJvPskO74RY6
	30T5ZLitHIHhzL6rBbva3QJC3A==
X-Google-Smtp-Source: AGHT+IEECik2rNvg9g5X/1ZyVYb5KjShWXSZtDz0JLlJfotuqmOkcHu2tT5Tli21VDDo/u4FtGfE1g==
X-Received: by 2002:a05:620a:27cc:b0:76f:f11:7d1 with SMTP id i12-20020a05620a27cc00b0076f0f1107d1mr2563433qkp.77.1697822822061;
        Fri, 20 Oct 2023 10:27:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t27-20020a05620a0b1b00b00773f008da40sm757316qkg.125.2023.10.20.10.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 10:27:01 -0700 (PDT)
Date: Fri, 20 Oct 2023 13:27:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 00/17] bloom: changed-path Bloom filters v2 (&
 sundries)
Message-ID: <ZTK4ZKESDVghzSH8@nand.local>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
 <xmqq34y71phj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34y71phj.fsf@gitster.g>

On Wed, Oct 18, 2023 at 04:26:48PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > (Rebased onto the tip of 'master', which is 3a06386e31 (The fifteenth
> > batch, 2023-10-04), at the time of writing).
>
> Judging from 17/17 that has a free_commit_graph() call in
> close_commit_graph(), that was merged in the eighteenth batch,
> the above is probably untrue.  I'll apply to the current master and
> see how it goes instead.

Worse than that, I sent this `--in-reply-to` the wrong thread :-<.

Sorry about that, and indeed you are right that the correct base for
this round should be a9ecda2788 (The eighteenth batch, 2023-10-13).

I'm optimistic that with the amount of careful review that this topic
has already received, that this round should do the trick. But if there
are more comments and we end up re-rolling it, I'll break this thread
and split out the v5 into it's thread to avoid further confusion.

> > Thanks to Jonathan, Peff, and SZEDER who have helped a great deal in
> > assembling these patches. As usual, a range-diff is included below.
> > Thanks in advance for your
> > review!
>
> Thanks.

Thank you, and sorry for the mistake on my end.

Thanks,
Taylor
