Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E233FB2F
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bf9HKebC"
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835DE9F
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:47:42 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so48013496d6.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697651261; x=1698256061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7EsKWaaiIGAZbFsWWpN8glxVhwnaqaCRXoUcGdge/s=;
        b=bf9HKebC70Z+fnmRAijKZwS+uzmOnY7+ML5WRGh0m5wQcWp59w0gGhJLmKpHXWAXOM
         KPmKh28H4V3ZAn6YnRzb/46ZeuFGHGZqTxlABUwfiiNNLmYEFJNm0brw61HnsksI2sEz
         jfz9p3MDrbMlI8SOLen0iF+ufZn5hI82rrZPLjCqWjYMLp3PtcDtlMJElfe5iY6NACcA
         3s5YCqxn6cAXf1uUt/D4aWRT7jlBYtFWbXwhLAsLSDTkt9XO2p1Cu1bpkAEEMMNWrWOQ
         vZO4ZOm6MiXTtXnfzslp2VZ4UwtEqHI2nWe2wA4cfznPbKiGYOKh2kZo9fWjIPVhutO1
         76Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697651261; x=1698256061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7EsKWaaiIGAZbFsWWpN8glxVhwnaqaCRXoUcGdge/s=;
        b=mRtFKJ8tpRyba0Qf6L/G2tfra+acd/Un9rcOFj9EV2GY9tR+iGRw+WU4FlbEZ1l/Kj
         FSxZQqUT5aKVncww7Pib1EAbf2hAFZfZ53LqGyfDnxEXi9LVXHA93OityquLk/GL6FRD
         T1TZScEfDzB8lysDdxVgvQFe+bJYzR6O2gsaO0B2xWrON+8F1XURm4/nlHjZWgmc2YYp
         LiV3PkmMDzVrT2WojvjvAa4AYVpVngWZDqR4lWAsyfK8p+/YMsLEU1Kf24GRaiPbQEY/
         IL9HyAFYx+tSDPCi2gF0XcKJ2SSZQUiwiwAUOSgGC/9ol9zN12SbGSuraIrnMVqdO/uZ
         hRwQ==
X-Gm-Message-State: AOJu0YyQxjptb8bGXHk1FDk8CCsFlEqnmT5Yct1VwOb90eIrk/ejNUzh
	cprki35oGvJlHD9mfYY39+GoHQ==
X-Google-Smtp-Source: AGHT+IH0nhQ2f1+nBaHcfmVzOk03n3j5FyZPtjiwbA54FdcOxy91nIwOhZ3M7NdmQL6CTqMzrW3kxg==
X-Received: by 2002:ad4:5ccb:0:b0:66d:670:d425 with SMTP id iu11-20020ad45ccb000000b0066d0670d425mr9159193qvb.31.1697651261620;
        Wed, 18 Oct 2023 10:47:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id lg12-20020a056214548c00b0063c71b62239sm123323qvb.42.2023.10.18.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:47:40 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:47:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 00/17] bloom: changed-path Bloom filters v2 (&
 sundries)
Message-ID: <ZTAaO5Jg8CGr/pJL@nand.local>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
 <ZS5JsDKk8RioQfOA@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZS5JsDKk8RioQfOA@tanuki>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 10:45:36AM +0200, Patrick Steinhardt wrote:
> > Thanks to Jonathan, Peff, and SZEDER who have helped a great deal in
> > assembling these patches. As usual, a range-diff is included below.
> > Thanks in advance for your
> > review!
>
> As this patch series has been sitting around without reviews for a week
> I've tried my best to give it a go. Note though that this area is mostly
> outside of my own comfort zone, so some of the questions and suggestions
> might ultimately not apply.

Thanks for giving it a look! I generated a few small tweaks on top of
what I already had here based on your review, so I'll send a reroll
shortly.

Thanks,
Taylor
