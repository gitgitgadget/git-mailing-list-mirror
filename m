Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6BB3F8E0
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978038; cv=none; b=eNiLF1F3cHunf1WtR+SLqpXRtRKPy6dQ2RJTeyNmDOHVLgFVmFlEq87Bzv9kxLWqBZnMBp/imsKOiVEaWqNs2xzLlWigzSXLHGHgwiOtbeZvAFarE5/8g7rK07JK3UaFZeQailUOWFWLQrepRvozNT6P5XaGtJx4fv+SaQYwXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978038; c=relaxed/simple;
	bh=uHBWPMQydQEzk19/JDRO95oWrIt6kC2MTklGK2fubt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7w6CEhyuoFmH0alUJSLoU2ft381uZ1bxor/AYFadorST671Mr0NlKR8wjs+quAgir9URuAzHWHkLXNaiPhBHtvxKc2Bq9Esplit+g08pJreLc/SbUsKqdJwc7qnZQBDwhXf4ULdhbdrhJTvgKX7F5a3WWiezrYcNdIOYGQS9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojy2CWSp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojy2CWSp"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6eac64f2205so3279676b3a.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711978036; x=1712582836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8MARPPMfsqO2qhxomZVHkvP5UI2JL8hPhCIbbV/CC38=;
        b=Ojy2CWSpZ9Ya22Xkjo+o6D7qSlIPm2wLoIaInlgfYI4kRR6RtTg4H13HfbheYYvUvi
         nJbl5mjrei/h2gBQK1rK/DHlUTYuyL+a0wQNRN2HKeujhT/o/X2nGBBt5DkH4zhQDbaF
         a/3R4+IThZyWSk1OSVgQR3zfYKt69rUMlBgflLX5TEce9Tf7Kup6Fq8fv+Gq9QAXpnVY
         Nhi3aBSMhYTUl/AydZx06cUQWLaHM/xTBPOSzH24obzKl9k1/AocgQ7gykDQxHAniNex
         RGC2kXiOoH1hFBkeTzbTS5KjKDQgh2c8o+fc5Ma93gFsvZhOmmGJgj1Krd/lWvhYRGbu
         A/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711978036; x=1712582836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MARPPMfsqO2qhxomZVHkvP5UI2JL8hPhCIbbV/CC38=;
        b=BpCzmfH18sKdYsFvH8A8XXIcVLqp/xUWR3GpT9p8zqoPRlQJm+lEzYnPgMOQkFnEkS
         h9GcIgtG8WRvvWhUZyUyVDgqvWRbHla/+qRlBWVgj3L224mZLBaYgfm4HCcArzKcmHIs
         6k5zPLGv5M2KquNVuaSPVPP94gZm1T0l0OfTo98Gcc5nuoghp9a0KRzkHZ/F/AESfHw6
         RhSKjTs3QscAYvSezD+/l4w5AdGFtL8PvU9j9JHL1frcu4oA9IWBUcVQR7Vi1wmYXyyv
         9/XjrjLlnbpSbYBbtlryV/Fjs/LPjBlY1KnoJad3mq4Lk//KMhXjz8oBKEyyuq6UBG37
         rvqw==
X-Gm-Message-State: AOJu0Yy/y2OpglbYp8FmAXKtFlU9vERxbpNhaeJO9F3N/fMhthQutVgJ
	P+03Zb2231vuQazN3TfVIeBLI8KP09gwK7LgyA8BpOYri19pJu+GmC+eskSeaGs=
X-Google-Smtp-Source: AGHT+IG+GXvnVSi4XF/+qo36+FO+MnNjNLl3M/+vJqVciYdR7MKmbUlWOf7A+ZBX7GmFvqmqbzTAVw==
X-Received: by 2002:a05:6a20:72a2:b0:1a7:e98:96e0 with SMTP id o34-20020a056a2072a200b001a70e9896e0mr5011800pzk.5.1711978035940;
        Mon, 01 Apr 2024 06:27:15 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id t28-20020a056a00139c00b006eac9eb84besm7787958pfg.204.2024.04.01.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 06:27:15 -0700 (PDT)
Date: Mon, 1 Apr 2024 18:57:12 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] builtin/add: error out when passing untracked
 path with -u
Message-ID: <h7yk7nk7cwyv35reqzfy7brpbn3xoaarhudteyvxfpkodvltt2@eggaahzrjryq>
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
 <20240329205649.1483032-5-shyamthakkar001@gmail.com>
 <xmqqzfugvhnf.fsf@gitster.g>
 <b3j7l2ncstdiaxojtollxddmxvkbbeciou25yptguttr5qugmx@y3bzqbdxkyaw>
 <xmqqh6gnmzqs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh6gnmzqs.fsf@gitster.g>

On Sat, 30 Mar 2024, Junio C Hamano <gitster@pobox.com> wrote:
> So, it was a fairly pointless thing that I was wondering about.  The
> current behaviour, and the new behaviour with the new check, are
> fine as-is.

Well I think we should be going 'all-or-none' way as I can't think of
any major user-facing command that does partial changes incase of
error (besides two testcase below).

> If we wanted to make it "all-or-none", I think the way to do so is
> to tweak the final part of the cmd_add() function to skip committing
> the updated index, e.g.,
> 
>          finish:
>         -	if (write_locked_index(&the_index, &lock_file,
>         +	if (exit_status)
>         +		fputs(_("not updating the index due to failure(s)\n"), stderr);
>         +	else if (write_locked_index(&the_index, &lock_file,
>                                        COMMIT_LOCK | SKIP_IF_UNCHANGED))
>                         die(_("unable to write new index file"));
>  
> And if/when we do so, the existing code (with or without the updates
> made by the topic under discussion) needs no change.  We can do all
> steps regardless of the errors we notice along the way with earlier
> steps, and discard the in-core index if we saw any errors.

Doing this, we would need to take care of atleast 4 tests breaking in
t3700-add:
 error out when attempting to add ignored ones but add others
 git add --ignore-errors
 git add (add.ignore-errors)
 git add --chmod fails with non regular files (but updates the other paths)

while ignore-errors ones would be trivial to fix, fixing other 2 would
probably require some more than trivial code changes, as from the title,
their behavior seems pretty much set in stone. That's why I did the
'goto cleanup' approach to not break these.

Thanks.

> The renormalize() thing is not noticing unused pathspec elements,
> which we might want to fix, but I suspect it is far less commonly
> used mode of operation, so it may be OK to leave it to future
> follow-up series.
> 
> Thanks.
