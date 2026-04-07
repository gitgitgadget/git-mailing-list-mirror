Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9122083
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589758; cv=none; b=JX9xjRHWk2/jqDwRdPQmO0zU7THZeqMNVzOQ4W1Q2jdQtLj8dhq58Gi+/mOVXvnB+3hTNvpjVtHjmHzIWsYxRqfADLP0rADOWh4BzOmKzzzLdJokUSYznigA+vawVZMsB2VAxjBBCwG6w6+XGA7eD/7SAK+s5XO7pQuzmrEDCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589758; c=relaxed/simple;
	bh=CXBZ2lCVtpx/YO1JCwlbCOpRlErUQkh4Itq6jKobmJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6OGeG1X0NmzWAvbiNtU6qKWoZrTmFI6BMYM6k8aT9hu+L7Hr3ICPCzTgmlbvitn4V19j8LNjhZ0iYeCCriilOjYal9T2My4kRD76RFWEem0GkLUoy7Mpo2oNgb30itCdtv95uURVQpOtUh7lOg43OywF8TvQbG6+3Yuw3A58Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDoKlj9s; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDoKlj9s"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so2691078b3a.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589757; x=1776194557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAmSKrDatj8MRdpsclwniw3n2H/MQSB+Ckk0AzZBnsQ=;
        b=gDoKlj9sMbYpmW7aZvfR9eqUadysQSnrKk3/5uyyJ4w1/7LDZl88czW5rX+KfLXWNL
         EXHyUhXATw5Dz4zIQfG1czty0Ak/Gjkz3FZdIkaezGihhg39vOAR/Rb9iUWIIcJ9kre3
         fARXmqCa8HBMAVu8TTM2ae+tULh0HdLnYILGbTm/v4xpKJ/luzdhtLdYkLaLG+I943x8
         A8186aRCA5Iwi14XOXziO5FYXCSIXQ2OQdAX3tj99GaztVknCgwY5lu3PARsGQgQLHQY
         76jK/bqm+NZ+prmKcyshyyH/SFC9fmXytWmdtxdXr2DztIOy8Oq/F1lJNpbCF2iHD7kS
         11VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589757; x=1776194557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAmSKrDatj8MRdpsclwniw3n2H/MQSB+Ckk0AzZBnsQ=;
        b=Ovk2ZwbxuQH7cobP5yya9NQBROpqkCJ7d3JQuAVnFDPABoRNm9LRtHJ6gCyEn6qnoc
         b+nHAnVsc8NzGxXqPQTw3qHpC+xSTdEXb09jp1TXYuuIG3Gmp7inf1ZXgNAc3nYqXqbm
         jOaUB2M07vL7kFkXxvhRizHNJ2V3WAc9PSi2JmYlQgsvexBtmAVuhE5h602MOqVB6S2W
         ChajFSXEN3MuFGe6KmtieYcfsCnvVgwaRZnqmzeZpCFmyW3J48+LBEZpo4hyph5OVE4R
         BYROS0UiA6CDjRTUBOHRpJAlRlLcaL9gkagMUNZphziml+3Yum9zksVKKTTLHxU0SLyp
         R80Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMhaNovgRrj9YGFtgX5k7NWAUkJbdeZwuMaUEnwe74J4Mz5/dl0VDrW6gyjBGVwlQ+8I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJAwg66Nabeo22m8XHGBJQwD/CA7YHjb3AvtIg7j4C7CoK7SJ9
	JJr8v3NyMvOb9AWnh/MqXsVzGMCSqd6meGAEJlUzllcGdkMfaEV60mBZ
X-Gm-Gg: AeBDiesBIs5A4KRi/uYwscz5HsngMM2Cvvm00mjX7K5CsY0Lal0UpfuXQluz1Ik1uoY
	BWv9yDBng9GqC4oboDHtkGzu9393IJUGqlb9/yavXzMDPNrz1q6u43Gnr0IavaMzkHqzc34/UUt
	jgMw1DF2w4vM4JLl59xSY87eadVGyAnmRMQSn/QV78gkxI+Ir9nS6TgtQD5WAnDuxv6OBEfepGJ
	224ZmOPBrcIbnweOM4dkTnzEJrvTpm1EiBZGxsm3rpB495CvUHE4pMB7XS9MY/CteLxxQ8Cb7+L
	gx3tgIC5TEOLjzbMu1dHdMvto2Au5EcyMiAfBymZxY6NRaRTu1NDEsxvHTlqyDIJF3ca9NsbhZj
	rgeWk894y44yISktGIinCVNn9acI9C1Xv73R1TkBxAIo9aKbRqED1q/EpUND6u8sDsxP1nIxVGO
	4tjxS3HKafD1tMb/z+K7Lll524RuCtQrs=
X-Received: by 2002:a05:6a00:84e:b0:824:188b:c173 with SMTP id d2e1a72fcca58-82d0da3de79mr17564729b3a.5.1775589756845;
        Tue, 07 Apr 2026 12:22:36 -0700 (PDT)
Received: from localhost ([42.118.191.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm19142853b3a.38.2026.04.07.12.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:22:36 -0700 (PDT)
Date: Wed, 8 Apr 2026 02:22:33 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC PATCH] backfill: add --[no-]progress option
Message-ID: <ktjgf2gyf5wkktiquy4cfzdcifd2yhqk3mngckaih4bwca6fda@nkcju65ku7hf>
References: <20260329152443.525493-1-vikingtc4@gmail.com>
 <8db10441-2fce-43ad-bcdc-331d26ec38ed@gmail.com>
 <xmqqh5poat4x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5poat4x.fsf@gitster.g>

On Mon, Apr 06, 2026 at 10:35:58AM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> > On 3/29/2026 11:24 AM, Trieu Huynh wrote:
> >> 'git backfill' is silent when downloading missing objects, giving
> >> no feedback during potentially long-running operations on large
> >> repositories. By contrast, 'git fetch', 'git gc', and
> >> 'git index-pack' all support --[no-]progress.
> >
> > I wouldn't use the word "silent" because the output is actually
> > quite verbose by default.
> 
> ;-)
> 
> > With your patch, I think there would be some extra progress
> > indicators between these batched fetch requests.
> 
> >>  static void backfill_context_clear(struct backfill_context *ctx)
> >> @@ -54,6 +57,7 @@ static void download_batch(struct backfill_context *ctx)
> >>  	 * avoid possible duplicate downloads of the same objects.
> >>  	 */
> >>  	odb_reprepare(ctx->repo->objects);
> >> +	display_progress(ctx->progress, ++ctx->batches_requested);
> >
> > This looks correct. My preference is to not use prefix operators
> > like this on struct members (it reads like you are incrementing
> > 'ctx' and not 'batches_requested', even though it is correct).
> 
> Thanks for paying extra attention to such details.  In general,
> post-increment and pre-decrement are the norm when evaluated in a
> void context, so the use of pre-increment above violates that norm
> too.
> 
Thanks for pointing it out. Will update, eg:
++counter;
foo(counter);
> > However, I'm not sure that we want the progress to indicate the
> > number of _batches_ but instead should be the number of _objects_.
> 
> True, too.
> 
Make sense to me, worth checking if we can feasibly track the total
object count instead of just batches to make the progress more
meaningful.
> Thanks.
Thank you for all your kind review.
I'll update v2 as per your comments. Hopefully, it can address
these concerns. 

BRs,
Trieu Huynh
