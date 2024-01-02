Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1331171C6
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="3Wu+BWim"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dc1fe0889fso2827195a34.3
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 14:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704234679; x=1704839479; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OvUBVjhcqbkouovW6qKbdG7eQPxN0tiCriPE/JiHQ54=;
        b=3Wu+BWimX4PsXp/MChh830KIP05F/P+fXoqsgiT4j0WGaLKpa8qbzZVNhyOkJPH3p6
         JDJkFh4cnLQosXj+3zdGPPN5/9oqdrqraG7zqpkTMuj/cW+Qek7XDIedEg/OEof3hsuE
         LthhRnZh/+sNypsjk7/FZ5PAWSzYZdsRLxfKpws7ouIZQYTGtaH165xZiJWUprs2wAGr
         HFDMZZI+jmBHoN6bKYVkOWQBIsdQMCRjlAyDumS6Lhqyj9dcp2oKHpaqcCtz5qfCEUXx
         +MEzLF7qN7F1UuRGKTAXIxIFfkSDAh8IQxrWjz+VlSvqjVMHO75TSiUcIRAwjcZtQsnf
         8I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234679; x=1704839479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvUBVjhcqbkouovW6qKbdG7eQPxN0tiCriPE/JiHQ54=;
        b=oOBaoOyO8vvvoJI46yL2voS4U3jgdrTCa0QA/Ol/p2jeKvyCK+VKtw43ryDfRxRNWM
         CnmhFi063C7OSW/xMH0m3ohQZCBHr2eLPYE+AKM1nwavs0C8Y511yWgA7povYyyF2yoK
         G4mE/bF5vAmRCrg97QDmlTPlKN19nWnTx0aCNkQLD8e13E1NQu4hHXhG1jcK6NjFtJro
         6hni20bAyfnChicAjAnLeoK99lY6370mSfOnULjvLy5pRI/kG+dX6pqWfdNA4Qzb3yU4
         zUEM9Eg/wCl1q9W6PhsS+rjstmy9Z4Wh9b+xBgWWdqeJ+7E/Bm0QpZbavWR1dylYy5YD
         Xflg==
X-Gm-Message-State: AOJu0Yx+WGQj5KwkBtZtsh051+Tv4NmV5tSgpg2FUO/e5Z7xa7MEMjR5
	agXFEKWBC+DrOv3EEfEKzWPAwHRBOn6hPg==
X-Google-Smtp-Source: AGHT+IHOxk3n4plU6HeHeHWGW85KyZ7+qJM8sfI+EwAgdtQxm0XTD4JDWUaiBsIrjMtILOgdxziG6Q==
X-Received: by 2002:a05:6830:1105:b0:6dc:3798:6aba with SMTP id w5-20020a056830110500b006dc37986abamr4409971otq.41.1704234679056;
        Tue, 02 Jan 2024 14:31:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q65-20020a4a4b44000000b005944c7f6bb6sm4604736ooa.29.2024.01.02.14.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:31:18 -0800 (PST)
Date: Tue, 2 Jan 2024 17:31:18 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] sideband.c: replace int with size_t for clarity
Message-ID: <ZZSOtiZSPSthcDgp@nand.local>
References: <pull.1625.git.1703264469238.gitgitgadget@gmail.com>
 <20231222175747.GA2880@tb-raspi4>
 <xmqqedfejc32.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqedfejc32.fsf@gitster.g>

On Fri, Dec 22, 2023 at 11:01:37AM -0800, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
>
> Just this part.
>
> > Further down, we read
> > 	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
> >
> > However, a size of an array can never be negative, so that
> > an unsigned data type is a better choice than a signed.
> > And, arrays can have more elements than an int can address,
> > at least in theory.
> > For a reader it makes more sense, to replace
> > int i;
> > with
> > size_t i;
>
> It is a very good discipline to use size_t to index into an array
> whose size is externally controled (e.g., we slurp what the end user
> or the server on the other end of the connection gave us into a
> piece of memory we allocate) to avoid integer overflows as "int" is
> often narrower than "size_t".  But this particular one is a Meh; the
> keywords[] is a small hardcoded array whose size and contents are
> totally under our control.

I certainly agree in theory, though I've always erred on the side of
always using size_t for indexing into arrays, even if they're small. It
removes a potential pitfall if you are working with an
externally-controlled array and happen to forget to use size_t.

But if there is an existing index variable with type "int", and we can
easily validate that it's small, I probably wouldn't bother changing it
if I was editing nearby code.

Thanks,
Taylor
