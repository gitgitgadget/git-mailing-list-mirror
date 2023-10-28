Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71174422
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="d9M+ovVG"
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03926DE
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 10:35:28 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58686e94ad7so1872618eaf.3
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698514527; x=1699119327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Stu1Ab6CnvKhgCgYFToE+kALT5CfWFro3CJxDsLKVKs=;
        b=d9M+ovVGkYe85ztVjAwXnNhbFijDkpGVyJSWsbWDWMUx25u1l9whcOWGYJhwU5rMnG
         T9EXsUhGrdB/ntw/1MFbNkymXNa5ebFNHPdEtLhFLSN+71YQjf2mYTiuqsPplCBWaZIg
         2SEcH1/LLXTS6j8tX04P5aiaCbt8VsDgzWefOTtTBFHZq4SzbQq4XdptZIWrYE/Qzomq
         dxiAlFzWL6CpgxQf+Mbc7Rtn4PaPFOV/tYTMxczAarLrAkUrtxiTwmugmTEd6inELaEy
         h0LLi+1OlpzG9QtJ5IptjK6OIwoHKjxgc+CXXupnlGA3XqLgcTuyMHedcRvVXkxSlkon
         fxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698514527; x=1699119327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Stu1Ab6CnvKhgCgYFToE+kALT5CfWFro3CJxDsLKVKs=;
        b=Zdvnh7KDCBVn3ocOrvWfe1oxVUHXVLDS3Q79qQWQq4LgjgjG4xMPT/ehe69BydGFfv
         3HPjjGWn4B6DaLc1SletFBtIAydMqbLBl9Tcuvre3/YKry3gTwuZzkW4IpfqDm81cw9e
         ry6Qak1z4nd6OXSo8nRRcDgKcmg2uMfa7caZFOkszZahew78t5Qz6ckNMHQVEec9rJ0M
         97fNbzfdXoPkbGesNILCvzEHNxoaol9QSq/T8PR2CGgqiK2BwEU3YvNdyGk1XDhVQBAr
         so2cCitCqQmOxpM7L27sTg/iWkGm5YVXUvvweuLuU5vNl+GArIDfl+UIXMIgwh/ZfXR3
         wvBw==
X-Gm-Message-State: AOJu0YzQpqg0dhHyskLMaEg+VXPaZe1QNr0MAmGTO7Eumc/h+pIGa9qP
	yDbkh5P0X9J09SsjaI2EoGXd3g==
X-Google-Smtp-Source: AGHT+IE3Iiuwx3qcu+VgWNupHNkEFvTHA1m3bK7O/ZxLFNCQjZYBqGISZZ5yv7/qS4Ugu4H/J45xBw==
X-Received: by 2002:a05:6358:9186:b0:168:e467:1ab2 with SMTP id j6-20020a056358918600b00168e4671ab2mr7526603rwa.3.1698514527094;
        Sat, 28 Oct 2023 10:35:27 -0700 (PDT)
Received: from initialcommit.io (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id h15-20020a63384f000000b0056c2f1a2f6bsm2573732pgn.41.2023.10.28.10.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 10:35:26 -0700 (PDT)
Date: Sat, 28 Oct 2023 10:35:23 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH v2 0/6] Noobify format for status, add, restore
Message-ID: <ZT1GWw886XuXwqlw.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
 <ca47d328c280e4b4c13bfa6dd9958a57@manjaro.org>
 <ZTvvz6/GFdwagVa+.jacob@initialcommit.io>
 <9b93115810ca269c87ec08f72fdc9c12@manjaro.org>
 <ZTx3fIGpdGl4JpaV.jacob@initialcommit.io>
 <2a0ba4c8e96cb7d2ea66dd1e78cdd39c@manjaro.org>
 <ZT0m68HWZS/tDGtH.jacob@initialcommit.io>
 <37e7bd8f6f4b75aa3b31dc98804b1334@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37e7bd8f6f4b75aa3b31dc98804b1334@manjaro.org>

On Sat, Oct 28, 2023 at 06:20:41PM +0200, Dragan Simic wrote:
> > Hehe ok, maybe there is room in some hints to notify users of the
> > extended option...
> 
> I agree, there should be a well-placed hint, but we'd need to think really
> well where to place it, so we don't annoy experienced git users too much,
> while we also inform the less experienced users.

Yes, hmm, I wonder if maybe we could add the hint for the extended option
only in the case that the user uses the --verbose option either on the
command line or via the config setting. Since using the verbose option
tells us the user is asking for more details, that might be a good time
to inform them of the _even more detailed_ option, but of course that
hint could be disabled easily if they preferred the "basic" verbosity.

> > > > Any thoughts on what the section in the config for a more general
> > > > setting like this might be named?
> > > 
> > > Maybe "core.verbose"?  We already have "core.pager", which kind of
> > > affects the way all command outputs look like.
> > 
> > Ok! The idea of using "core" came to mind but I wasn't sure if that was
> > more for lower-level settings or more general things.
> 
> I also considered the "core" section to be reserved for the very low-level
> internal things, but having "core.pager" clearly allows other appropriate
> configuration options to be placed here.

Ok awesome!

> > Great. Thanks a lot for all the feedback. Let me doctor up the patch
> > series to take these things into account and submit an RFC v3 :D
> 
> Sounds good, thank you.  If you agree, I'll go ahead and implement support
> for a few "<command>.verbose" configuration options during the next week or
> so, and submit the patches.  I'll most probably come to some more important
> conclusions while implementing that, which I'll relay over, of course.

Yes I agree, that sounds great! Maybe I'll just wait then until seeing
your implementation of that before I poke around on mine more. Then I'll
apply your patches locally to add my extended option.
