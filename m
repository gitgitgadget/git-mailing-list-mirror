Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33497FC
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zG/M1xmA"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ba2e4ff6e1so147372b6e.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 17:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702603537; x=1703208337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jilDVfBluOeSTXrH9lLRQOoeU/99fZqpCMV/K69eX9I=;
        b=zG/M1xmAWierVnmYy8zf13eGjZfMGlRpw37ILXRtAxv/V9CgDFcCx3mFgL/gqn0wbt
         aqSDVA4e55s3jmg1mjFxVqmWblDcjvzhcIy62/VnRpedHfic8U1XpNYSlxqsCunmpxCM
         0UoPEv9xt7XIZNHOuPPTY/VQrAxJ1L3MP8nVwTk2KCbg/W5d85WySa0mFU8YH77snKFj
         km/LRiqeZ/wkRFiRzH+st2s+ht3gP/qCi3+cgdi/qolDS6KjCQHjFl4f6L1PrRgTdkcs
         ws03AdD3mZ0A9CdAzGlL9P59tzSiGl9rhp+UpiqHs6bwjp4cWbgeyvAqUNV3wCCW4cdL
         x4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702603537; x=1703208337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jilDVfBluOeSTXrH9lLRQOoeU/99fZqpCMV/K69eX9I=;
        b=EHFqmCNG/b57E47dPfQWwspUWBXG5Anh0/gLz+etxWs7Hwyj1f0z7z24mfMSUaCJZ9
         zWUMeoB4GPdrMWHKqX5JzdZaIbrkiAfJ2sIKE/qDbNOaAedF1I1Xd05hKMD2SFreJIp5
         JD3v7T3oegUmpcpMRl+mF8RsrRKWyRR+gDjcVVAbH1NJU7TSiNvwUdkxnyZ0/iSAAwsb
         mpqQDa2pNDFIetulTwxzpY+RVPs98YD54l69THxa+MXic5eKP1WbqDf8Qpr/KZWUjaOR
         PTaK/x/UYYyxEkJtmVjb/rkehCAJm60MRvjREDJy2KKkNMVxjeZTOBFEkN9ce5WUfnUQ
         BgCA==
X-Gm-Message-State: AOJu0Yy8Yo3yAY+PpgMGG0T/ra1MAaegVWlKNp93MSZhL6f9cTGDhJC4
	xMi+lFUaPOacyELE01GgvG8MkPZ7FTl/+jzOYCK6Jw==
X-Google-Smtp-Source: AGHT+IENRLRhfqCgQHV/8cIBAalTWViUk0+Cfg7bIPKCEwr51EsL1x4qJCPmVmnrveQQirpEtVqEog==
X-Received: by 2002:a05:6808:1686:b0:3b2:c242:aaee with SMTP id bb6-20020a056808168600b003b2c242aaeemr13064564oib.42.1702603536936;
        Thu, 14 Dec 2023 17:25:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u12-20020a056808114c00b003af6eeed9b6sm3570948oiu.27.2023.12.14.17.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 17:25:36 -0800 (PST)
Date: Thu, 14 Dec 2023 20:25:35 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 00/26] pack-objects: multi-pack verbatim reuse
Message-ID: <ZXurD1NTZ4TAs7WZ@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
 <xmqqbkasnxba.fsf@gitster.g>
 <xmqq7clgnvqv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7clgnvqv.fsf@gitster.g>

On Thu, Dec 14, 2023 at 04:40:40PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I haven't looked into the details yet, but it seems that
> > t5309-pack-delta-cycles.sh fails under
> >
> >     $ SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true make -j16 test
>
> Hmph, this seems to be elusive.  I tried it again and then it did
> not fail this time.

Indeed, but I was able to reproduce the failure both on my branch and on
'master' under --stress, yielding the following failure in t5309.6:

    + git index-pack --fix-thin --stdin
    fatal: REF_DELTA at offset 46 already resolved (duplicate base 01d7713666f4de822776c7622c10f1b07de280dc?)

    =================================================================
    ==3904583==ERROR: LeakSanitizer: detected memory leaks

    Direct leak of 32 byte(s) in 1 object(s) allocated from:
        #0 0x7fa790d01986 in __interceptor_realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
        #1 0x7fa790add769 in __pthread_getattr_np nptl/pthread_getattr_np.c:180
        #2 0x7fa790d117c5 in __sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:150
        #3 0x7fa790d11957 in __sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:598
        #4 0x7fa790d03fe8 in __lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType) ../../../../src/libsanitizer/lsan/lsan_posix.cpp:51
        #5 0x7fa790d013fd in __lsan_thread_start_func ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:440
        #6 0x7fa790adc3eb in start_thread nptl/pthread_create.c:444
        #7 0x7fa790b5ca5b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

    SUMMARY: LeakSanitizer: 32 byte(s) leaked in 1 allocation(s).
    Aborted

The duplicate base thing is a red-herring, and is an expected result of
the test. But the leak is definitely not, and I'm not sure what's going
on here since the frames listed above are in the LSan runtime, not Git.

I'll try to dig into this a bit more, but I'm not quite sure what's
going on yet.

Thanks,
Taylor
