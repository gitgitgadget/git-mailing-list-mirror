Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4018C2A
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMEfme/4"
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF84C1
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 10:55:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5b8f68ba4e5so25311a12.1
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861304; x=1699466104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd701X2Uk3e9Fo7WlJ0IQ4Vk2Gd4wYBmJ2Tl/H5W4bc=;
        b=UMEfme/4LAiWOyoDwM/Yx1bVhL+Ad4dD/T4ObBYjtbo72UP/FkgT1xA1dJHPY16A2a
         uCRDGcdNOZIpzQ4vRjm/bEXCPkN56lmGeS8JIxu4aPxO3iZjhKwq9pkvxJNJx38sddDp
         68vwQtB4D4yF4Q7Q1CrgpsQjloek8mICJKj9YFOVemNlGJX1w7U7ZCfVawlimAVCrBJT
         7oZhFFMUt7ouH38TV2fNHiYbFbIm46Tpma/ZISmfu10COmKKQXzWmjwz7d0lLXNitX41
         v4vMAMJbxCjYn+UfU5Lv+jRUFFwikEgp2PR3SbPWEShRaEy8zY7maSwoNsdQDR24i6hO
         Om8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861304; x=1699466104;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bd701X2Uk3e9Fo7WlJ0IQ4Vk2Gd4wYBmJ2Tl/H5W4bc=;
        b=IgJtS3xw3DeRqeNZ4zBjF5gFSB59XXjml5Ek3XWzupdotbdqwtHH4beK+moI35ZHrb
         ZquMOiWJp452UV0YAbqkW5g0+4LPT5OsSZcfNs5Sf0BFZQjwMnicOU2o441RsXL4nniZ
         pIB8MzVDYFC5sUPFdifE23nGT2+XfmMnE9BmJKXfD57qXaOxZgudFuyoVbzDJgv9wxs5
         1qlx1XRJ7R3sfweDYXs8Ei+xvha3TZUySBTDLCqk2fvNyyEKn+YgApac3kpRVESy/dPm
         dLUCA8dAABiuPl2Z1RuNoMBCu9EI9/dsRTujeO+tuPBIijsqjlrrmngr224ZgNGB0RZI
         fB6A==
X-Gm-Message-State: AOJu0Yx+vDjutLqfxjxtNGNtOjD0cRsavQ52SquM5MOT1fZOz97IExrZ
	uL+9Qe2ayGKsmpuARyb7D+XJpg==
X-Google-Smtp-Source: AGHT+IHAHvlkyIYNFvjNvhFvRi1axes/gohMtOaGSr7LyeXGQnIrFb5prLV/yXrUjv2l95gXzVQkqg==
X-Received: by 2002:a17:902:e803:b0:1cc:482c:bc4d with SMTP id u3-20020a170902e80300b001cc482cbc4dmr9649715plg.5.1698861304334;
        Wed, 01 Nov 2023 10:55:04 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:22ea:81ca:f3ec:8bce])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f7d400b001b86dd825e7sm1610597plw.108.2023.11.01.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:55:03 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:54:59 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, calvinwan@google.com,
	git@vger.kernel.org, linusa@google.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 2.5/3] fixup! unit tests: add TAP unit test framework
Message-ID: <ZUKQ8xtFSYbSBPXb@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>, calvinwan@google.com,
	git@vger.kernel.org, linusa@google.com, rsbecker@nexbridge.com
References: <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
 <20231016134421.21659-1-phillip.wood123@gmail.com>
 <xmqq1qduo6yr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1qduo6yr.fsf@gitster.g>

On 2023.10.16 09:41, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > Here are a couple of cleanups for the unit test framework that I
> > noticed.
> 
> Thanks.  I trust that this will be squashed into the next update,
> but in the meantime, I'll include it in the copy of the series I
> have (without squashing).  Here is another one I noticed.
> 
> ----- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] fixup! ci: run unit tests in CI
> 
> A CI job failed due to contrib/coccinelle/equals-null.cocci
> and suggested this change, which seems sensible.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/unit-tests/t-strbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in v9, thanks!
