Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49222469F
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YKQetxE6"
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A624B3C14
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 11:26:13 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cd1fe4645so7085461cf.0
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 11:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699557973; x=1700162773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZV3Jy8exDC4da1w4JSvuuJXQu87KerqtBcfG1d4VDbQ=;
        b=YKQetxE63wYDPJrVetEPLouCbaMyhCWw0OU2X8MNoori047rziwoeoivEjKqmNUto7
         j/yO1GnWgCHyYFM6pbuTTdJzC0npDIbOQKYt46rFgzvK0Cmvxt+Gf/L23nXbA5ORDXPF
         zXVV/K+XKvOKQNEydaHJPw1FGj2OZaAfm20dkEvt6upVbYli4a2KgNDpO7EW8ycK14a9
         oT3Lk+5hQk3wI+jQtuPWgkMmGk9o8xjeZGqT/6HRv7mSt4neYPWrbiaeF7i/gM1pPXHN
         4Y1fqg8iOub0IFuDCS9XMqxRY02d9VTgwWV5h78H3W7+CaTgXOrkzQi7/dIYVUWHr50m
         xqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699557973; x=1700162773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV3Jy8exDC4da1w4JSvuuJXQu87KerqtBcfG1d4VDbQ=;
        b=DERajVCq9Vehnotk6mMOkYhlVVJHgIWihuXIyhTJbpbTH9oPYS02z3YbVFVfUceVJs
         Ey1JR58p1Nz6nRQ7zFLRkuGEKaWyysPTXK+rpxkS7pgn6gp2I35RjhhhBVv7XmDVrLRM
         bT2r/IG5iR99dWzyUHKhRRob5scyMKYBX/WR1dS5foVhCAd9sIdnF/5nUgB4HUFd7+/s
         RSq9uaa8XkNufeX0+iCCJJIanAHucSkXiolyaDN3/IfoddWxcIG+55uqahpf8A26yYOU
         kud8laHBrLo+4JaO2kNTQIVb71gsvVn3jygnBpu5i8l+lCDXnmZo1idv0uNIAQSI1hmm
         u3uA==
X-Gm-Message-State: AOJu0YzvcPQ3ieakJAo88sD5f2IiMXitWYipB3Jgc/Wog9rVJaj1RRSi
	73AXFoF5PzPGo9IiSlh6NRtxLA==
X-Google-Smtp-Source: AGHT+IEWRHi5ZTr6PbxFdHojlMzj7tqkbII4Fkyxp+A13vLx4YKIbB8PyBLFjqJxLFU13YtQth0kyw==
X-Received: by 2002:ac8:5e53:0:b0:41c:c27a:2927 with SMTP id i19-20020ac85e53000000b0041cc27a2927mr6838176qtx.44.1699557972799;
        Thu, 09 Nov 2023 11:26:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y17-20020ac87091000000b00419c40a0d70sm2206567qto.54.2023.11.09.11.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 11:26:11 -0800 (PST)
Date: Thu, 9 Nov 2023 14:26:07 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 2/3] tmp-objdir: introduce `tmp_objdir_repack()`
Message-ID: <ZU0yT9karPxHrGuM@nand.local>
References: <ZUpepnSCSxL8i96b@nand.local>
 <cover.1699381371.git.me@ttaylorr.com>
 <0f19c139ba9bb5105747f545038825d0c89f2e42.1699381371.git.me@ttaylorr.com>
 <ZUszSs0CYoFV9YJ0@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUszSs0CYoFV9YJ0@tanuki>

On Wed, Nov 08, 2023 at 08:05:46AM +0100, Patrick Steinhardt wrote:
> > @@ -277,6 +278,18 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
> >  	return ret;
> >  }
> >
> > +int tmp_objdir_repack(struct tmp_objdir *t)
> > +{
> > +	struct child_process cmd = CHILD_PROCESS_INIT;
> > +
> > +	cmd.git_cmd = 1;
> > +
> > +	strvec_pushl(&cmd.args, "repack", "-a", "-d", "-k", "-l", NULL);
> > +	strvec_pushv(&cmd.env, tmp_objdir_env(t));
>
> I wonder what performance of this repack would be like in a large
> repository with many refs. Ideally, I would expect that the repacking
> performance should scale with the number of objects we have written into
> the temporary object directory. But in practice, the repack will need to
> compute reachability and thus also scales with the size of the repo
> itself, doesn't it?

Good question. We definitely do not want to be doing an all-into-one
repack as a consequence of running 'git replay' in a large repository
with lots of refs, objects, or both.

But since we push the result of calling `tmp_objdir_env(t)` into the
environment of the child process, we are only repacking the objects in
the temporary directory, not the main object store.

I have a test that verifies this is the case by making sure that in a
repository with some arbitrary set of pre-existing packs, that only one
pack is added to that set after running 'replay', and that the
pre-existing packs remain in place.

Thanks,
Taylor
