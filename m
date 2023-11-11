Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19E28F3
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 01:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2HkJCGy8"
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C42422D
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 17:34:04 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-45da601e6f9so1175274137.0
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 17:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699666443; x=1700271243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgUmLoQ30YxbACnJaMgyOKDFPqaNuqL4tQgghgld4b8=;
        b=2HkJCGy8NUI1MTkVQZ306eUfWRQ43dVOBx5GcbUWkD6gndm6kOdnSpeme8Yykuql8u
         vC7tVzlOY1+s2bEYYppc2dDuOwSKfgnIntF/dyaMBFFuVYNK3Z0i2miiOWOB0Zl7DZ9u
         8hpXts+j6KylLA+Q2jRW/HuQLfJqbNbVwl0as9KjY/M3CK/CgYxxcE1/KGbwlquJnKcY
         DDuJOcca5TQlpyB/OOOK70kTw0yVlrJwFhrqGiUbFOrGmu+LFtW3fv4xdqye/8mFHTJG
         A7wfI/7MG+iLEyAZolXORuCpbXeY2PmWiAAlOic4l1rwJzMsBKBRGW0DmRvkaCLT7dju
         5WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699666443; x=1700271243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgUmLoQ30YxbACnJaMgyOKDFPqaNuqL4tQgghgld4b8=;
        b=PQ6adwrJPuhphgxzsidWYFHMsgdAxdlVU/loA1R+8uK1J5Nbh8orV2niP8/OXAiRjO
         2V8T7D206V7ZBCL6iWbhbgOQOH7uOn0LQVdgKo5/uSI+rrpfxtWzA9/KaQJQqRVNu4O8
         CzNIzXLArlMI4seIUrQ2grSceeBtgJdwNx3kRBPQKfcJlbLwI0qfq+98UdbCgSUE8EfS
         ACvUc+1LWprrq5aQzU9VFGzDYJS3+AQPMp7y/nhjY0g/Az7rHswtxqVX1YpyjDTG9NUZ
         7njO2gAB3/byDv/s/rMbRgMtyaS1UrUyOgdpnjWJ82GkShf6jgZsGx9pxVF1e4VtE5JM
         ZPCQ==
X-Gm-Message-State: AOJu0Ywv4W5d3uIrJyNfrgOYXMnMjKKlP9scs5xm/yxOTydXA4X2NjVf
	kQ2HK9Px6/f/T299lDkvhxopsjDoZmWUJQGhCixyTA==
X-Google-Smtp-Source: AGHT+IEc0AnznCmyRR52rW9fpwcNKns/zvT6Dq+dpff4bG3UrJKzsnM8VbzWIpZ+jFKsaB0/XD3f3g==
X-Received: by 2002:a67:c305:0:b0:45d:9abe:b33f with SMTP id r5-20020a67c305000000b0045d9abeb33fmr1078146vsj.31.1699666443602;
        Fri, 10 Nov 2023 17:34:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z6-20020a0ce606000000b0067101efa98asm250248qvm.69.2023.11.10.17.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 17:34:03 -0800 (PST)
Date: Fri, 10 Nov 2023 20:34:02 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <ZU7aClZCAtzkt55w@nand.local>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 <xmqqmsvlrv5t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsvlrv5t.fsf@gitster.g>

On Sat, Nov 11, 2023 at 09:27:42AM +0900, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> > I believe the above is built on an assumption that any objects written
> > will not need to be read until after the merge is completed.  And we
> > might have a nesting issue too...
> > ...
> > This is unsafe; the object may need to be read later within the same
> > merge.
>
> Thanks for a good analysis.  I agree.

Ditto. I responded to Elijah more in-depth elsewhere in the thread, but
I think for your purposes it is OK to discard this series.

Thanks,
Taylor
