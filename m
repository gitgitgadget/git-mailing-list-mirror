Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066F18B13
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KdqIiJ0w"
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADF110D
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 06:42:11 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b6c31e604cso3418356b6e.2
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 06:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699972930; x=1700577730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+gSIUUTiqqx+RzbH2sW4l6BxVcaWKZ7SY5AezVYzi4g=;
        b=KdqIiJ0ww5JllfGepDL5k8Dl777Ny6rsr+j9t6fpNBGIC8msGufphpGS1JZWsFcK73
         +LiU2VYnbCv5Ro/1ORZHupTtfTILX/SmeXkdKVmMOnNk8JqYr63R20ON90qPHpe5I5A/
         2Lvm0RtSms/Q419ltn3g7ps4cYdV9zrXvldW1MD/C/HStc6gD3mR67cwOZyS/p5CKA9/
         pPGS+NxzW1LE+NKzSHpPQD9ucuyL9Jpjn3gzx0cV5H/iBMfgv2msLGzvJada45FbNG/+
         ItYd0YifFSxQ9OoX3foJfijXS8f+jG8W/KKfGa8IZPQ6cxho3MT4QFNz7rvuyeZm2Fqt
         nxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699972930; x=1700577730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gSIUUTiqqx+RzbH2sW4l6BxVcaWKZ7SY5AezVYzi4g=;
        b=hSr2eZVTN5s0ZLIvnP/eLrdUe3S6XCsHyH8erIehdwMXatQQb6pFnFtc/8EqqiqizP
         0C1Zb4pqyoh1h7wO0asPEua+QtsaDtdn2WZ14xh0lSISBKE2QrfEzTOqyFciBWALr/wR
         fcRR8vTRTt23UUIvlTQBxTn7FFleZYjPqAe5Bwce970WPatda6Rv3r7Z5LsB39Vdhw7/
         z6ws6hYjscKJMs+KnaCxskczGUu+LIQFQoT94x+liicEZTNalsRyL1dpjlvLeUh6Vdqd
         mtwpUmDMsryBGKN7XXyUtwGssuQP7JmhvlUGdbv7+YnBVcgF8mIXR+/g3vCX5rC0th6f
         50hA==
X-Gm-Message-State: AOJu0YwRuGT3Bn9/H3Xs6z3GMAZEbQpKP0nfgMpglR7yGV/y0haAphSH
	KH031aOlnV9UXhW9m2sfJZavuO4orvgdqxdY2Qaerw==
X-Google-Smtp-Source: AGHT+IFPt61xeMG3NEYuf8IPHGQpJ4ILnKnzMoNRGPJqNqpU3vlRTyl7hEkWSATnxirp9ozghRmFrQ==
X-Received: by 2002:a05:6808:14c:b0:3b6:c4dd:be83 with SMTP id h12-20020a056808014c00b003b6c4ddbe83mr11337811oie.52.1699972930437;
        Tue, 14 Nov 2023 06:42:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id tp9-20020a05620a3c8900b007757eddae8bsm2710513qkn.62.2023.11.14.06.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:42:10 -0800 (PST)
Date: Tue, 14 Nov 2023 09:42:08 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by
 default
Message-ID: <ZVOHQJaXcV6A7588@nand.local>
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
 <ZVNNXNRfrwc_0Sj3@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVNNXNRfrwc_0Sj3@tanuki>

On Tue, Nov 14, 2023 at 11:35:08AM +0100, Patrick Steinhardt wrote:
> Gah, I forgot to run this with GIT_TEST_COMMIT_GRAPH=1 before sending
> this patch. There are two test failures that this change introduces:
>
>   - t6022-rev-list-missing.sh, where we test for the `--missing=` option
>     of git-rev-list(1).
>
>   - t7700-repack.sh, where we also manually delete objects.
>
> Both of these are expected failures: we knowingly corrupt the repository
> and circumvent git-gc(1)/git-maintenance(1), thus no commit-graphs are
> updated. If we stick with the new stance that repository corruption
> should not require us to pessimize the common case, then we'd have to
> squash in something like the below.

Good catch. Thanks for investigating and providing a thoughtful analysis
of why we should turn off GIT_COMMIT_GRAPH_PARANOIA by default. I agree
with your conclusion (with this follow-up patch squashed in, of course).

My hunch is that it would be easier for the maintainer to have a single
patch to queue instead of squashing this in themself. You may want to
send a "v2" to that effect.

Thanks,
Taylor
