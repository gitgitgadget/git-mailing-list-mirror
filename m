Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF84310A3A
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mA8K2JUX"
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DCCA6
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 16:09:49 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-586abec2c8cso157358eaf.3
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 16:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698880188; x=1699484988; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qbB5zLlYTe1kh8rYbH9PEd1U/az1LQZRiCR9BTx6Yc=;
        b=mA8K2JUX16JC2EXLVs2y6S6lz3CUbjsN5PjbGIlalZFf5KIHessHe3hQLY3Bx9j4cf
         Fjnr7vo0q89POsesBaFRCqWO21Ei166paeKFARhLgr8rXGW/DZ6SV/LRKhN1C5cMyMFI
         qScbXIlDDOByRde3WtHJZuHZmSM1yfC8EmeQVmgs6BtnWkTmSioPxXEV43/GdwxErSpK
         4UMCeG+JWjjIeYqB2vuJKHY8vARQHN1XqlEzS90IUb5/OazCe2isngE7S+7wuFFRGgxs
         AFHreFvaO3Qj+A3QLybzwXH0d91Efzxw5NpDvQCbSNDDh5uc9PEWxJ6W//AzlDKWFdSs
         6n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698880188; x=1699484988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qbB5zLlYTe1kh8rYbH9PEd1U/az1LQZRiCR9BTx6Yc=;
        b=RVHNG4tD7bpRg5QY7v/DZZiop8pdP6PjjVdzLHuPHbz9ZLBty8JRnDhMRh6ept9VK0
         G7FHcfUwtrQmIfxwMI7MCpt1dqgHNA3SgYCuSRWpiM5uP1JNqiy9tYB1vDyOl8ZWWf70
         vNV2VmcD7gvh2fVaMA79jhuXF21WAbg2yjpqg114QeSLrJqUhKxaaH5vFVgWV7GX8Rfy
         2vY4x/CAlWKTMiqFPn/Eyb3PJl5RZUaePlKk2qyPD5Vqj8/AWvanBYeLwFlc3vZMJR/Z
         ya+OGhx4W+N15r3Rsa9wp03NcXuvN75+4w4Z9a2hg400yDVYYNG0rI6YPIPxbHeLvdk2
         rrBA==
X-Gm-Message-State: AOJu0YwgQmh/7jy/aUKAUelY8G4NpLtrSx9CiYPCLmTUD7yACOAcDVwe
	VRB7HplO9oskpo4JWRaJB7K/Fj+i+t5ybkJhZ+vV/Q==
X-Google-Smtp-Source: AGHT+IFd7ikJY0ytHxNiSzkk34tP/PENsdpdw253uDMqjUjOqWR92eVGacbfw6P7/jpUWMsXDWibCA==
X-Received: by 2002:a05:6358:5e09:b0:169:a54e:eb26 with SMTP id q9-20020a0563585e0900b00169a54eeb26mr3060189rwn.19.1698880188316;
        Wed, 01 Nov 2023 16:09:48 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:fc30:220:f2fb:969])
        by smtp.gmail.com with ESMTPSA id d4-20020a63a704000000b005b8ebef9fa0sm339941pgf.83.2023.11.01.16.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 16:09:47 -0700 (PDT)
Date: Wed, 1 Nov 2023 16:09:43 -0700
From: Josh Steadmon <steadmon@google.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, linusa@google.com, calvinwan@google.com,
	gitster@pobox.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 0/3] Add unit test framework and project plan
Message-ID: <ZULaty2ce5rUy8vz@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org, linusa@google.com,
	calvinwan@google.com, gitster@pobox.com, rsbecker@nexbridge.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com>
 <93a18989-bf05-4318-8d85-cf23c0f32170@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93a18989-bf05-4318-8d85-cf23c0f32170@gmail.com>

On 2023.10.16 11:07, phillip.wood123@gmail.com wrote:
> Hi Josh
> 
> Thanks for the update
> 
> On 09/10/2023 23:21, Josh Steadmon wrote:
> > In addition to reviewing the patches in this series, reviewers can help
> > this series progress by chiming in on these remaining TODOs:
> > - Figure out if we should split t-basic.c into multiple meta-tests, to
> >    avoid merge conflicts and changes to expected text in
> >    t0080-unit-test-output.sh.
> 
> I think it depends on how many new tests we think we're going to want to add
> here. I can see us adding a few more check_* macros (comparing object ids
> and arrays of bytes spring to mind) and wanting to test them here, but
> (perhaps naïvely) I don't expect huge amounts of churn here.

This is my feeling as well.


> > - Figure out if we should de-duplicate assertions in t-strbuf.c at the
> >    cost of making tests less self-contained and diagnostic output less
> >    helpful.
> 
> In principle we could pass the location information along to any helper
> function, I'm not sure how easy that is at the moment. We can get reasonable
> error messages by using the check*() macros in the helper and wrapping the
> call to the helper with check() as well. For example
> 
> static int assert_sane_strbuf(struct strbuf *buf)
> {
> 	/* Initialized strbufs should always have a non-NULL buffer */
> 	if (!check(!!buf->buf))
> 		return 0;
> 	/* Buffers should always be NUL-terminated */
> 	if (!check_char(buf->buf[buf->len], ==, '\0'))
> 		return 0;
> 	/*
> 	 * Freshly-initialized strbufs may not have a dynamically allocated
> 	 * buffer
> 	 */
> 	if (buf->len == 0 && buf->alloc == 0)
> 		return 1;
> 	/* alloc must be at least one byte larger than len */
> 	return check_uint(buf->len, <, buf->alloc);
> }
> 
> and in the test function call it as
> 
> 	check(assert_sane_strbuf(buf));
> 
> which gives error messages like
> 
> # check "buf->len < buf->alloc" failed at t/unit-tests/t-strbuf.c:43
> #    left: 5
> #   right: 0
> # check "assert_sane_strbuf(&buf)" failed at t/unit-tests/t-strbuf.c:60
> 
> So we can see where assert_sane_strbuf() was called and which assertion in
> assert_sane_strbuf() failed.

I like this approach. We'll need to document unit-test best practices,
but I think now that I'll want to do that in a separate series after
this one lands.


> > - Figure out if we should collect unit tests statistics similar to the
> >    "counts" files for shell tests
> 
> Unless someone has an immediate need for that I'd be tempted to leave it
> wait until someone requests that data.
> 
> > - Decide if it's OK to wait on sharding unit tests across "sliced" CI
> >    instances
> 
> Hopefully the unit tests will run fast enough that we don't need to worry
> about that in the early stages.
> 
> > - Provide guidelines for writing new unit tests
> 
> This is not a comprehensive list but we should recommend that
> 
> - tests avoid leaking resources so the leak sanitizer see if the code
>   being tested has a resource leak.
> 
> - tests check that pointers are not NULL before deferencing them to
>   avoid the whole program being taken down with SIGSEGV.
> 
> - tests are written with easy debugging in mind - i.e. good diagnostic
>   messages. Hopefully the check* macros make that easy to do.

Thanks for the suggestions! I will make sure these make it into the best
practices doc.


> > Changes in v8:
> > - Flipped return values for TEST, TEST_TODO, and check_* macros &
> >    functions. This makes it easier to reason about control flow for
> >    patterns like:
> >      if (check(some_condition)) { ... } > - Moved unit test binaries to t/unit-tests/bin to simplify .gitignore
> >    patterns.
> 
> Thanks for the updates to the test library, the range diff looks good to me.
> 
> > - Removed testing of some strbuf implementation details in t-strbuf.c
> 
> I agree that makes sense. I think it would be good to update
> assert_sane_strbuf() to use the check* macros as suggest above.

Fixed in v9.

> Best Wishes
> 
> Phillip
