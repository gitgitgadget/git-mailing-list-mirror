Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A250225D3
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Hcxlo5vf"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53F8CF
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:30:54 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778940531dbso112416585a.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697729454; x=1698334254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4D1RmNJD5qtrbRTqlwQDefnBkRfnGBvsVhbWb12+Bh0=;
        b=Hcxlo5vfK3AqfbjQFYfVXNI82sxq4LxusLJAKsNbkqVZrUGUV9jp0by3nf2lOS5F5b
         Z8wl83KV982ttb4tjCBwAAAVG2J9OO0ExFRCwHF+SQlxHf1IW8BEiLymaGgCkJijKeQn
         AfMGjIHL9DbVWZ8PV8Px1ScXdr9xJCAB7kHrbEVs39H1GvfD4DjuCjZNKoIfAP/SNyp9
         5lFs889rxjj4BwDLwA9CwNspoJe5tWoiLMXyJOUq89cVGu8Z/+0K+3w6+V90N1qRceF8
         4gYviBH3weVD6icWc1T0pxiSbaeDovY5SN/Yk+5lio0M5OCofi/AkipZX8Lt4xvGeQgo
         gOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729454; x=1698334254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D1RmNJD5qtrbRTqlwQDefnBkRfnGBvsVhbWb12+Bh0=;
        b=jlqrP078JCaTPzN+yCaqCAjrNWd/QWOE5P7k3U39cxK/ht5vcdC1dYPwF33uF+l3Zd
         /CZF5uFA8KY4e4oij7bA3/BdCDMeC+VP4t/OgJoOgMzc9x8n15uvpTREIW319s9t3Mcg
         t0QMQgVO15+0wbG8uzQEUNAkEEVFaKEO1MikWgo2cToMLkVF4WGiS1XICi7uSfBUA7hb
         rTdtcRwY3+q1YKSJppuS7uFIU+JRFD2N6h1CWgzAGjva2itW4L8SmiD3ltHgj2Ou/40c
         ChCspHX+D8beCCkPI9G4jcCJhG4QBoUX9D1fFx4A44UQYhbO8iUCJx9jIuj2vyC8WDRZ
         HH7Q==
X-Gm-Message-State: AOJu0YxYjVLFsPL16Le3d0NncQDzZkZHK8wF4u3j2zr9NQJiA8jP/G40
	ETaOVOrWOK1SACkxS8wED56tyQ==
X-Google-Smtp-Source: AGHT+IGgv+VgFTwhEHCzAPIWNfJyKUUKwzyCsm+hPepCA1c0Vv3MWZqFPZ+oGI1QnvStfhNlfhhuGg==
X-Received: by 2002:a05:620a:11b6:b0:767:e993:5702 with SMTP id c22-20020a05620a11b600b00767e9935702mr2282025qkk.35.1697729453914;
        Thu, 19 Oct 2023 08:30:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d29-20020a05620a205d00b0076cda7eab11sm802226qka.133.2023.10.19.08.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:30:53 -0700 (PDT)
Date: Thu, 19 Oct 2023 11:30:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 08/10] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
Message-ID: <ZTFLrOpGaTQHEGcT@nand.local>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697648864.git.me@ttaylorr.com>
 <8667b763652ffa71b52b7bd78821e46a6e5fe5a9.1697648864.git.me@ttaylorr.com>
 <xmqq34y7plj4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34y7plj4.fsf@gitster.g>

On Wed, Oct 18, 2023 at 04:18:23PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Now that we have factored out many of the common routines necessary to
> > index a new object into a pack created by the bulk-checkin machinery, we
> > can introduce a variant of `index_blob_bulk_checkin()` that acts on
> > blobs whose contents we can fit in memory.
>
> Hmph.
>
> Doesn't the duplication between the main loop of the new
> deflate_obj_contents_to_pack() with existing deflate_blob_to_pack()
> bother you?

Yeah, I am not sure how I missed seeing the opportunity to clean that
up. Another (hopefully final...) reroll incoming.

Thanks,
Taylor
