Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEDC54656
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572726; cv=none; b=DGOvmgTk8vteswH/sufEAS/icqRyKbYIdqzOiN3gOL29Eexf3tXeK4bcdXGLqgk6OXlM5ZI3ySqbWEoZbSM2w6V/CnbY/pPJRVDo1ttiLCNFFVOfn3SDfHge2OQtKd3iEDsVtlScBpAVSI9+RUjLkJhMGZJzQdBMNB+CPWR4Zt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572726; c=relaxed/simple;
	bh=fqdrcxS1yc8norHRtORpvJn4+OPAvjIbtDzKZVsnMMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyK0VGCxnKgoIoV0UGn178Rff5urMEqBA1qSnTie5YT7dmpK/iUHO1U0o8YGYLmvKjogjg5wXEo4KtbMCyAMNJDSa6HGuQe9avG6oej+sNjLuxilref+yHW6FCv323uWasBGRgTpJfHPG0pLg2Zvasw2NoVfQyIFwJtrAuV+16c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=spYgVwlk; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="spYgVwlk"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6818a9fe380so26166756d6.2
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 15:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706572723; x=1707177523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F/E6kW0WuIj3ODp1XnQ2lYO5zLc5L7Fy+ZMQq/TBzbU=;
        b=spYgVwlk9msiOAyAFLo+9ecFMBe56IZOSZle7j6IopRqZ9qUIhOfecpEK+7eQCgi+X
         nwxVcR3LbSTvR6rxK0uUwsm+jkAZBLvs6ZS/84W698vDRXSuJFvZEFxUrB9uuG9eFylS
         Bq00pwxMGvgnWV7IRfDTZM49e0E9wtdCiDnmZyh3vn6U9H3znShiABcYaxWpHpQJv+6T
         45OV/tIjsAlK4opH655QWpBfrAkVDcHFqdFUnH3bssUXOMqYdJ9R+QXdWdDR3h96yTc5
         u4q71jm51jDzLtTonO5CzhvGqp0DAtr0zM4XvvcvzQz48xbNYjjBbAOVdexb+HtOyEJO
         93dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572723; x=1707177523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/E6kW0WuIj3ODp1XnQ2lYO5zLc5L7Fy+ZMQq/TBzbU=;
        b=GNrrZKnOTqg0Y5wXNxX9nG32CGAGeI1kJId2GSUT/FG0Tm7U1iljr9MHZRYM3TyM0e
         V2El7JkUUcEJptmsBwWDv86XO+jMBwPlgyqkw1WsNM8yas5uJfJO/vjGAibL5FKalxd0
         S5DywT/eZ8wOZBXusAjAPiFjvm6l51Foh52hIJTJd1r9/kJtxQNigmsNLP9vLUsfG/37
         USyuo94iTOh55BP9GlyVz559kxEiEM6BGuUArTGyQWSCSb/968fMdoaG1b2nN7Fve9TD
         OUmufY2lthTJfbM69DHI7D23omImvPhX8t9Ru0lflGujfu32p4L2v6+bT8RaY5xCA2YA
         HRaw==
X-Gm-Message-State: AOJu0YzT0MYgU0AkzpR2h/ciK7RzC/Fkn4AIutHzu44FvBpPKEDlhAee
	j4V1PJ3Pr2h8J3yEJ0ZI5wymc0J5FGInjsAwxrPXWP4pxP0/ss/N8WilS8AHaHI=
X-Google-Smtp-Source: AGHT+IFgarSvu2pETVV1R2/1CoPQc5ZPrpfAkjzDe3MYmS1Zub+tKjr3M7ux99OZPQC9cA9BQcC0uA==
X-Received: by 2002:a05:6214:4104:b0:68c:5f08:9c46 with SMTP id kc4-20020a056214410400b0068c5f089c46mr317475qvb.110.1706572723358;
        Mon, 29 Jan 2024 15:58:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ph15-20020a0562144a4f00b0068c50dec857sm1203339qvb.128.2024.01.29.15.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:58:43 -0800 (PST)
Date: Mon, 29 Jan 2024 18:58:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v5 09/17] repo-settings: introduce
 commitgraph.changedPathsVersion
Message-ID: <Zbg7so2b4puSEWNK@nand.local>
References: <cover.1697653929.git.me@ttaylorr.com>
 <cover.1705442923.git.me@ttaylorr.com>
 <a77dcc99b4eb0a19dc6c09a40a84785413502126.1705442923.git.me@ttaylorr.com>
 <20240129212614.GB9612@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129212614.GB9612@szeder.dev>

On Mon, Jan 29, 2024 at 10:26:14PM +0100, SZEDER Gábor wrote:
> At this point in the series this test fails with:
>
>   + test_cmp expect.err err
>   + test 2 -ne 2
>   + eval diff -u "$@"
>   + diff -u expect.err err
>   --- expect.err  2024-01-29 21:02:57.927462620 +0000
>   +++ err 2024-01-29 21:02:57.923462642 +0000
>   @@ -1 +0,0 @@
>   -warning: disabling Bloom filters for commit-graph layer 'e338a7a1b4cfa5f6bcd31aea3e027df67d06442a' due to incompatible settings
>   error: last command exited with $?=1

Very good catch, thanks, I'm not sure how this one slipped through.

The fix should be mostly trivial, but I'll have to reroll the series
since it has some minor fallout outside of just this patch.

Junio, please hold off on merging this to 'next' until I've had a chance
to send out a new round.

Thanks,
Taylor
