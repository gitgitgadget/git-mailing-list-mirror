Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2C339B4
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur6NVuhJ"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBC4A3
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:52:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-407da05f05aso13231145e9.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697633535; x=1698238335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgoViXm3iNJfnChE6yS83O+dK+Jd6rJXZthLSPJWDbc=;
        b=Ur6NVuhJvdl6ORTGrZtJRcF5Zm40IUJtS74uz235a7Ol3e3/aq9YnXXHj3GOF5hT6p
         3XK3x5Xwy0FlcDFcUgau6dS+GE7vGoQZj7P/QfPYiwVo/h1UNkkeL9GpK5L59gD17+6k
         1zDpKmFumKKqbMZLILyZ9Xozx3ZMID+HnMgqmDgjOvfDaKg43gdAWIo6Dt1bfj2Nl0o7
         e2Kcn8iwBEgC6tyUjlLLKGklmV9NwQiUcHTDjokpr5hA6Di69hWYEGLIm4UqHezJ7lxB
         bfd6BCF9hFvSf4UXwj3/5eKC4whrIFU3e4S/Jsh6OBOVAyc8BbfOkv769+u0cmFUoPkP
         LkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697633535; x=1698238335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgoViXm3iNJfnChE6yS83O+dK+Jd6rJXZthLSPJWDbc=;
        b=TcPofUBpKY6ejuAWysLambLz06DUIBN7u+7JfDNHQBKjiNDSbc1JYvLjFasq8gJRe9
         Mm+vnll/RRzFZbwcFvQ81c6VI2XNN7mQgBgVBeU1rFS+YdVBlrp3wDu16sKysotKSPXp
         m5AhAS1D9XGDNPBC2aZ0m3RBBRt+la1CqVqijBmPTElQkO3+nkdYUQWJvPmvdAkRH61t
         zfSJwfU4mop/rjqfxzI6gFqYO22nEcZJVhKzVHnz0dY0AeOccGVh6MHHn9PEulUd2/Rs
         2+re3tyLB/HalIPBqtvw37eXFA59L3rT+i7JO/t1XxnFlGs9vXMwj2FSOCA67ujqH1YU
         uzIg==
X-Gm-Message-State: AOJu0YzaIWnuddRA6tKjPIfb7jELDFONRUkqwxbrAEQN+shWXIWZhiLB
	EyofBFtZYoQPY4UaeP2mETo39lzhhbU0qws=
X-Google-Smtp-Source: AGHT+IHLBUK8ziZPZ9hbAxGQi1Imk8I9Ym2wmGuNllJex0JF4lu0AlXOYdWON45/Q3qAX2wtGF4srA==
X-Received: by 2002:adf:cf03:0:b0:32d:a405:b6b7 with SMTP id o3-20020adfcf03000000b0032da405b6b7mr4094520wrj.32.1697633535284;
        Wed, 18 Oct 2023 05:52:15 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.0.137])
        by smtp.gmail.com with ESMTPSA id l16-20020a5d6750000000b0032dc1fc84f2sm2065854wrw.46.2023.10.18.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:52:15 -0700 (PDT)
Date: Wed, 18 Oct 2023 15:52:10 +0300
From: Dorcas Litunya <anonolitunya@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] t/t7601: Modernize test scripts using functions
Message-ID: <ZS/U+rPzVCpzGMww@dorcaslitunya-virtual-machine>
References: <ZS2ESFGP2H3CTJSK@dorcaslitunya-virtual-machine>
 <xmqqjzrlgftp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzrlgftp.fsf@gitster.g>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 01:21:54PM -0700, Junio C Hamano wrote:
> Dorcas Litunya <anonolitunya@gmail.com> writes:
> 
> > Bcc: 
> > Subject: Re: [PATCH] t/t7601: Modernize test scripts using functions
> > Reply-To: 
> > In-Reply-To: <xmqq1qdumrto.fsf@gitster.g>
> 
> What are these lines doing here?
> 
Sorry, I formatted the email wrongly.
> > So should I replace this in the next version or leave this as is?
> 
> Perhaps I was not clear enough, but I found the commit title and
> description need to be updated to clearly record the intent of the
> change with a handful of points, so I will not be accepting the
> patch as-is.
> 
> These two sections may be of help.
> 
> Documentation/MyFirstContribution.txt::now-what
> Documentation/MyFirstContribution.txt::reviewing
> 
Thanks for the resources and feedback. Ihave edited the patch based on
it and sent v2.
> Thanks.
