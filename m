Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26DC2D024
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaZjG11X"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D7094
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:47:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4083740f92dso3782645e9.3
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697561270; x=1698166070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+4odlNagvFp+G19qe3Iov5aiTx8npQX0fLQlCn+Q/8=;
        b=MaZjG11X9hKaMYZhFGiCpZDOtyM+pB+ecfnG/mntmh87VWm92y7k1NIJycYRJ16w3y
         GH84XwgNSlulwbOTrBnOh9xEM3tWnlqQdvugdXvvwgbBjKQt6SJZFw+obsAAZzgtl+6d
         k+MY1EYWX5OWd1qqpupvMABirVFOCbHzbJPjitARUDI36mBI4Up0nPVwBA16NquH5asX
         9l3gRZa2iMF1yHvDb9sspnDEpv+tgjuagnRhny4mmJHTxPgZ+am4wy5gLicctRe+4WeQ
         rLHSyvmT7sFTuO4iUzHpk3O+47olWiFja+En1wx7zNRJtwzEoS34cUbv+3je59PlYnJf
         zAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561270; x=1698166070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+4odlNagvFp+G19qe3Iov5aiTx8npQX0fLQlCn+Q/8=;
        b=d38Z+I23QvKSjnw/83z5MUVugDNtf6qvuA+LLh8IfzVXU/z+g7TUGuJ1DKGTE70C8O
         OY4epN20FJiB50L9C3CeioNMzc9JDxKr39wRWSSuukdiaYqbgY11aSjCgi5qt7ILSbi+
         FOrGLNlja+JglaqlvHVzSDwwyeYI0v42AGQgkJW2O9TsyfSZj6+sdKbfEmD/vjiq63P1
         5lZqt5IK8uadIexAsuZav89IeM+gzTkXwgXjDg2itHplJ8eKUkG2UkSSmC+1Iux0U9go
         ZVOIzJV7btxnUOiRLWP15myR8333TKR1Hg2pjzFtXZeyVI0CRLnjD/cHO0M57xxsO5Zp
         eAUg==
X-Gm-Message-State: AOJu0YyhySrrLAJcTp+wPdiVA/NanSz5Bc3JJWCBFjBa6IREIfPQtAN/
	YwaLiFhzbwMJpODcp3ALFw==
X-Google-Smtp-Source: AGHT+IFhHUkaeWO1YdJnWgsX7HWaoyI83dKvrVHfrH+D2sjAiRo56dnW5uD+TsqHdb08hOmzVVl8LQ==
X-Received: by 2002:a05:600c:1d13:b0:407:90aa:8224 with SMTP id l19-20020a05600c1d1300b0040790aa8224mr2019386wms.16.1697561269198;
        Tue, 17 Oct 2023 09:47:49 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.158.206])
        by smtp.gmail.com with ESMTPSA id l7-20020adfe587000000b0032da87e32e2sm171846wrm.4.2023.10.17.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:47:48 -0700 (PDT)
Date: Tue, 17 Oct 2023 19:47:44 +0300
From: Dorcas Litunya <anonolitunya@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: anonolitunya@gmail.com, git@vger.kernel.org, christian.couder@gmail.com
Subject: Re:[PATCH] t/t7601: Modernize test scripts using functions
Message-ID: <ZS66sBosc55Q0lLp@dorcaslitunya-virtual-machine>
References: <ZS2ESFGP2H3CTJSK@dorcaslitunya-virtual-machine>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS2ESFGP2H3CTJSK@dorcaslitunya-virtual-machine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 09:43:24PM +0300, Dorcas Litunya wrote:
> Bcc: 
> Subject: Re: [PATCH] t/t7601: Modernize test scripts using functions
> Reply-To: 
> In-Reply-To: <xmqq1qdumrto.fsf@gitster.g>
> 
> On Mon, Oct 16, 2023 at 09:53:55AM -0700, Junio C Hamano wrote:
> > Dorcas AnonoLitunya <anonolitunya@gmail.com> writes:
> > 
> > > Subject: Re: [PATCH] t/t7601: Modernize test scripts using functions
> > 
> > Let's try if we can pack a bit more information.  For example
> > 
> > Subject: [PATCH] t7601: use "test_path_is_file" etc. instead of "test -f"
> > 
> > would clarify what kind of modernization is done by this patch.
> > 
> > > The test script is currently using the command format 'test -f' to
> > > check for existence or absence of files.
> > 
> > "is currently using" -> "uses".
> > 
> > > Replace it with new helper functions following the format
> > > 'test_path_is_file'.
> > 
> > I am not sure what role "the format" plays in this picture.
> > test_path_is_file is not new---it has been around for quite a while.
> > 
> > > Consequently, the patch also replaces the inverse command '! test -f' or
> > > 'test ! -f' with new helper function following the format
> > > 'test_path_is_missing'
> > 
> > A bit more on this later.
> >
> So should I replace this in the next version or leave this as is?
Hello Junio,

Following up on this? What are your thoughts on it?

Thanks!

Dorcas
> > > This adjustment using helper functions makes the code more readable and
> > > easier to understand.
> > 
> > Looking good.  If I were writing this, I'll make the whole thing
> > more like this, though:
> > 
> >     t7601: use "test_path_is_file" etc. instead of "test -f"
> > 
> >     Some tests in t7601 use "test -f" and "test ! -f" to see if a
> >     path exists or is missing.  Use test_path_is_file and
> >     test_path_is_missing helper functions to clarify these tests a
> >     bit better.  This especially matters for the "missing" case,
> >     because "test ! -f F" will be happy if "F" exists as a
> >     directory, but the intent of the test is that "F" should not
> >     exist, even as a directory.
> > 
> > 
> > > diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> > > index bd238d89b0..e08767df66 100755
> > > --- a/t/t7601-merge-pull-config.sh
> > > +++ b/t/t7601-merge-pull-config.sh
> > > @@ -349,13 +349,13 @@ test_expect_success 'Cannot rebase with multiple heads' '
> > >  
> > >  test_expect_success 'merge c1 with c2' '
> > >  	git reset --hard c1 &&
> > > -	test -f c0.c &&
> > > -	test -f c1.c &&
> > > -	test ! -f c2.c &&
> > > -	test ! -f c3.c &&
> > > +	test_path_is_file c0.c &&
> > > +	test_path_is_file c1.c &&
> > > +	test_path_is_missing c2.c &&
> > > +	test_path_is_missing c3.c &&
> > 
> > The original says "We are happy if c2.c is not a file", so it would
> > have been happy if by some mistake "git reset" created a directory
> > there.  But the _intent_ of the test is that we do not have anything
> > at c2.c, and the updated code expresses it better.
