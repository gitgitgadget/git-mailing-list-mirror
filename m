Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XO684cTi"
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB59EE
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 11:25:04 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d87a8228e0so80472a34.1
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 11:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701890703; x=1702495503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MwxhpLAWTMf+nCelrIgjV1D6YCK4b8yHLq8HK4hUI38=;
        b=XO684cTi6tLHzWjFVy8Z/SQGdmZZ56I4OT7SMZoQhfxNG12ornc+Xkb6pm+txPVL0v
         s/rDOzIkzGkLi22VyQzQhkw6Ri+nSRfTanwingtnHRVVYPCtIr5xOIPSmXxfpjebT4Vi
         bUFVb/rrEBQP7ppo3KHpr51fHAvP5Tt36s1o/8JzttN9DF/Z4ahOXqjX3uVKf3MOL4zP
         h8CepevJe1sDc98mUuoExBj4TcbnX5c3ys6lPV4DK4VDTkFsgp2n+adAawaIYBhThSOB
         YX7GbtIjtxu7pEG9/nGy5poOFG22Bw04Cf1Ho6nYiMveGz2VcMfgw99bfRGzQSCB7UBm
         Rhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701890703; x=1702495503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MwxhpLAWTMf+nCelrIgjV1D6YCK4b8yHLq8HK4hUI38=;
        b=WIuFeDw8Xzc0qGc1AnnGis/A/XQNvPGSkfYf0j0ZUbAp0n1K9HjfNWhLvpX4Ybatv9
         HLOUmJzt8R3sFuuUPHODGcmY/rRy0+/DlsqOJ8gff3LFcDXsL3Lm1S1n49N5yqKpaGO2
         c4LwRo4WG2c03go4BfnXVaadL2sk/ScB0p46u6/TOZnyXvanPL7pNeazwJOuDtvQYTkw
         PMDqnoL8ZpumuKWYMMSFfCfe7QSNgoCZmanIMSxjD/kCJMd/+RzLZ/UkAZUw5SaDLnap
         rZnUHNaueNbnGFJ/ct+IF5PUR7qHQ7n0lG2hDrRhX2O327Sr447udJKA4bpZA3VdUA3K
         ZO2A==
X-Gm-Message-State: AOJu0YyVhOUuc6mXF4wJ+uj8bcQIOs+IRJKvgEKEGESWzNRAO4kxB64T
	nJq5yYdQENo7is94PkVWuAT1xBPY1TJYWQj0gzo=
X-Google-Smtp-Source: AGHT+IGQzE+oPKHYnC6xbSlsJIoOHbdNLSuzfzPfCVWmK78cproNe48IoFn90vUSnKM8E+88pcHwJQ==
X-Received: by 2002:a05:6870:2312:b0:1fa:fb70:63c5 with SMTP id w18-20020a056870231200b001fafb7063c5mr1334773oao.25.1701890703371;
        Wed, 06 Dec 2023 11:25:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q5-20020a0ce9c5000000b0067835abc38bsm204126qvo.129.2023.12.06.11.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 11:25:02 -0800 (PST)
Date: Wed, 6 Dec 2023 14:25:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 4/7] revision, rev-parse: factorize incompatibility
 messages about --exclude-hidden
Message-ID: <ZXDKjdOiIdHipaKy@nand.local>
References: <20231206115215.94467-1-l.s.r@web.de>
 <20231206115215.94467-5-l.s.r@web.de>
 <ZXByOXWo6cIy71s2@tanuki>
 <389cd7b3-2350-4dc6-b282-e9d6e25fa68c@web.de>
 <ZXCHj3hIpQb900WX@tanuki>
 <4954cf77-63f6-4225-833f-3c28d642ed11@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4954cf77-63f6-4225-833f-3c28d642ed11@web.de>

On Wed, Dec 06, 2023 at 06:07:29PM +0100, René Scharfe wrote:
> > It's not perfect
> > of course, but would at least ensure that we can easily convert things
> > over time without having to duplicate the exact message everywhere.
>
> Maybe the simplest option would be to use a macro, e.g.
>
>    #define INCOMPATIBLE_OPTIONS_MESSAGE \
>            _("options '%s' and '%s' cannot be used together")
>
> It could be used with both error() and die(), and the compiler would
> still ensure that two strings are passed along with it, but I don't know
> how to encode that requirement in the macro name somehow to make it
> self-documenting.  Perhaps by getting the number two in there?

I think that this is a great idea. It nicely solves Patrick's concern
that we have to duplicate this message ID everywhere, and equally solves
yours by calling error() inline instead of having to pass down the
option values.

I think that including a number in the macro name would be helpful here.

> > I don't think it's a problem to not convert everything in one go. The
> > current series is a good step in the right direction, and any additional
> > instances that were missed can be fixed in follow-ups.
>
> Right; whatever we do, we can (and should) do it step by step.

I agree :-).

Thanks,
Taylor
