Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E948E1CFA6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Gel82msx"
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489ECE8
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:58:44 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d190a8f87so33204616d6.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698703123; x=1699307923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGiA7Q0U2rR7JLSISanRHktFTitlVe/RLxP97BcAKNI=;
        b=Gel82msx8BMdxn8xGhX3P0d2hKDWGC+0opwdApzxp1BeHUMyghl/CutbD+CrqTdpuR
         a7dn86LzVzROu431JkCLSey+qQmBXwhdkOdoujsKb+opu/Qbo06VYgsQODj2qLlhxzQM
         lsirSFCLcit0r4Z4OCVONGm8QzJ28SoDTkxuYYal7Gi/qmaA04vvdhS09BHIY11bGLUd
         V7tW22/gocYPR+r7xWKWi5Bo20Fq34pqtNkfgC5406H56S8hRvxsK080AXKmkmYUTdw6
         Om7v109NE7yLn9FO5t6I8QVMZA4xfTeDuQQBdsYi2F4wQGJRcb/VzmJfQKTIJYKfBlpb
         e6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698703123; x=1699307923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGiA7Q0U2rR7JLSISanRHktFTitlVe/RLxP97BcAKNI=;
        b=Of+ZnCgEdOZo45W8qQejTK9KtopLPQRza7T0QNbrJBBtlek66KW2INsgcAMQXh2DaJ
         TmDWXbjkm5XkqBw/3tO8e/oDQOp2gbeOC5/2nWERTljWBGzqjK91W9iSGbapHIVz6QJq
         7n+mbxTY+RSQ/3LnclYn0vXUWYYJWMlFEohIHHaU+fSs45AZ3FeCNqMGxVcXCZAFxQky
         hfa8RrcRuqeDaAVN8JYLK2Rl58dg3//yrFaDraYK7dp184KUtgsCGigjC0NxmcovCUnY
         Ms8CKIAHZM9/lHx4SXnhDt3cg3gfQUdkc23NlilGDPGE4S/sWgjqxseIj4AGYldtopuW
         p7Wg==
X-Gm-Message-State: AOJu0YyHhafq3SP8KS50sjBYXg4WeXkfNEjoZBDVZpKL8QKFNL7GJ69r
	BOQ4ac+P9MLs6LY7Ct+d5uyfbZ5Ea9L4nA1VkLXY8w==
X-Google-Smtp-Source: AGHT+IHe/6ORewnr5HVCsUCEhEEPW4+/bPUxFVdXbOZgP2Ab7PGmmtaeyNDz9APSeVEt5ZSG3TRgSw==
X-Received: by 2002:ad4:5d44:0:b0:671:1d0:d75c with SMTP id jk4-20020ad45d44000000b0067101d0d75cmr11006180qvb.25.1698703123166;
        Mon, 30 Oct 2023 14:58:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id eo15-20020a05622a544f00b0041e28dc9e6fsm3780209qtb.70.2023.10.30.14.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:58:42 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:58:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Erik Cervin Edin <erik@cervined.in>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: Git grep -f reads the filename relative to the repository
 root
Message-ID: <ZUAnEVk65VQQE263@nand.local>
References: <CA+JQ7M_htKUv5=GRQEUqWmJrQmFQNfZkPjr8n12CU6x0Khr4dw@mail.gmail.com>
 <xmqqedhzg37z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedhzg37z.fsf@gitster.g>

On Thu, Oct 12, 2023 at 10:28:16AM -0700, Junio C Hamano wrote:
> Erik Cervin Edin <erik@cervined.in> writes:
>
> > In the Git repository, I ran
> >
> >     echo tig > pattern-file &&
> >         echo git > xdiff/pattern-file &&
> >         cd xdfiff &&
> >         git grep -f pattern-file
> >
> > What did you expect to happen? (Expected behavior)
> >
> > Git grep -f to read the pattern-file, in the xdiff directory and
> > search for lines matching `git` in the xdiff directory.
>
> That does sound like a bug.  It should use the original directory as
> the base of the relative path computation, similar to the way how
> OPT_FILENAME() options are handled.
>
> Perhaps something along this line, but this is not even compile
> tested yet.

Just going through old mail that I didn't have a chance to respond to,
the proposed patch that you included here does compile and pass t7810
for me, and the fix looks reasonable as-is. I don't think I see this
patch on master, but would have no objections to you merging it down.

Thanks,
Taylor
