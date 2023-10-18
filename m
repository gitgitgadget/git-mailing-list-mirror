Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF53D39D
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="K0MO2kkj"
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB15111
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 09:34:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7789aed0e46so6904485a.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 09:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697646871; x=1698251671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/+tXC22cuJfSv48MR64M4rKjsfhVx2JLkU1grbILyY=;
        b=K0MO2kkjctAHwaYTigeYE0YAxwmuGhb3ZFkCEhCZBcNLqGVoMi4dsJh/2Te3Asw5OK
         V6y0TnX4Fn28vVMRw0F15vU4Aj2V9/NM7G4wfyrUvAvllrCr3o02z7DkVkGMBYlnH6Lh
         6q0LIcADiCUQpY36RLmedgwuPpWFm8k/5r1uSljZ/ZVlJTob+SHoY/4Kt7hEj3m+xZvC
         T6emtV6mr7MxosOOSCSAcSyilXwN2zyvjq/6Ef0XZXGOABcUQVAtcG2hxdi8wwQcpyYE
         f50rUWT6YpUlp5AAYlfX41NYLTZvVrNqAOAVBnfjbxwdkVqVNTQMizMX086JLhVb//JQ
         iiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646871; x=1698251671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/+tXC22cuJfSv48MR64M4rKjsfhVx2JLkU1grbILyY=;
        b=fb31ZK8VZfe91eMYTgaK4rGIKTGXFvNZtW4E8tOoF4esi5n3Omf3j2/Cte2HDNPoXw
         M7AD8y6Fk6Ffb8Xre7OhEdfyO7Nf88JfmKys6YC7DYf+XVVBEZPP6pJDyaM1EdUP5fOR
         jYkXGbMAbtMqptxVB4c5soqStq6MRVr0fusShrvkBXoQfxBCG7t/98/dig2KAKIg1C7Y
         KUmnAIZqOJ3XaTJE4dSWn1rZDYQCeuFB5POTLmyEg/FVmhliGLe4yL36yZNFk0vxUdpv
         Iu7YIOMCcsP6r9KMCRhXRxTYR9eTGftWVp1Qn9+cWzIrWfhKwopf4rSr0vt+Kb7KdfR/
         biyw==
X-Gm-Message-State: AOJu0YyeEs22sUe3aQRfPkgUTsUBMbcytlilBf1MekZfX+600J8kg2c0
	kCjipVF3SGuMoQwV5RcjZmlORw==
X-Google-Smtp-Source: AGHT+IHI3ts1M9fCbFmoLfOeTcylx2pjOthyO+T9insiLl/oGfVVbfBKh8C2blY4yR334RRjqEZkGw==
X-Received: by 2002:a05:620a:1929:b0:774:33ce:cfb6 with SMTP id bj41-20020a05620a192900b0077433cecfb6mr7173503qkb.30.1697646870862;
        Wed, 18 Oct 2023 09:34:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d22-20020a05620a159600b0076dae4753efsm81092qkk.14.2023.10.18.09.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:34:30 -0700 (PDT)
Date: Wed, 18 Oct 2023 12:34:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 5/7] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
Message-ID: <ZTAJFK8BLFEb9FFq@nand.local>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697560266.git.me@ttaylorr.com>
 <239bf39bfb21ef621a15839bade34446dcbc3103.1697560266.git.me@ttaylorr.com>
 <xmqq5y34wu5f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5y34wu5f.fsf@gitster.g>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 07:18:04PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >  bulk-checkin.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  bulk-checkin.h |   4 ++
> >  2 files changed, 122 insertions(+)
>
> Unlike the previous four, which were very clear refactoring to
> create reusable helper functions, this step leaves a bad aftertaste
> after reading twice, and I think what is disturbing is that many new
> lines are pretty much literally copied from stream_blob_to_pack().
>
> I wonder if we can introduce an "input" source abstraction, that
> replaces "fd" and "size" (and "path" for error reporting) parameters
> to the stream_blob_to_pack(), so that the bulk of the implementation
> of stream_blob_to_pack() can call its .read() method to read bytes
> up to "size" from such an abstracted interface?  That would be a
> good sized first half of this change.  Then in the second half, you
> can add another "input" source that works with in-core "buf" and
> "size", whose .read() method will merely be a memcpy().

Thanks, I like this idea. I had initially avoided it in the first couple
of rounds, because the abstraction felt clunky and involved an
unnecessary extra memcpy().

But having applied your suggestion here, I think that the price is well
worth the result, which is that `stream_blob_to_pack()` does not have to
be implemented twice with very subtle differences.

Thanks again for the suggestion, I'm really pleased with how it came
out. Reroll coming shortly...

Thanks,
Taylor
