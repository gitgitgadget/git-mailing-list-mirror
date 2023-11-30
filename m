Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jZ8IY1s8"
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2F710E3
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:11:30 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-423d9d508d1so7596331cf.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701371490; x=1701976290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bIJsoK8SGbhUGz1N0TH6lhRD5WkL5wqhVsut8cTOYs=;
        b=jZ8IY1s857/gY1mf/zjnKOrMl4aUsHZIExUoUXQbhz3T18wpL6aJNlQKpim+LTinoX
         mB5ReSnSmc/1Cfc8G3N15V+WvLQDMHrYs4nCqED89Z64Ou4j96DtJyXz+mMKyuIN6r/g
         EqMdEGZtW00gqfe4eGgpp9wKLzSXr/gzqAq397gPA8zs5pOF/UYcUhGrXozq61097lz8
         ASKPFtDHpNG3X1snoEGNdDsUEw1qluDSzc9mG9hC+hz+P6v1EDCnU/LcdPHLHNItk+5B
         sxNS4vS0I8czdTevoyaRSkwqp7/Qo38c2txD/hyGXrYfhpcokS05rFpim7s74HMBSvfC
         AxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371490; x=1701976290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bIJsoK8SGbhUGz1N0TH6lhRD5WkL5wqhVsut8cTOYs=;
        b=g1BIkmE2xPM3Vs2+FZVZauVuWpQIZhi6vf7fPQjLQ6aPY2VIZGUt3R5TQWjg27JG+J
         nA4+ih2gKIVq/leVCDNOc2CVQ9Y2hGI9ljRfp0lGhYlOBv4Ec22gmlPLAb0hdE7JRiZo
         kNYrsHh5NQ+jZmMH9RWwKgflhYrVSrc4ThSUuaICFhu0kbulfHnSosb8UVotSOgYqejw
         MIHjQBKddrlHfeEJ3NPpRB32vqV+R7y2Vka/CFEscDt7/YP1n+4ZwXn/abNo5T4+3osz
         WdCf4KbCHo11CkHtgOWOboFGh/QPs3BZaCMtmOYM0MhDKW5zPhBfSsHiy1F5Mk2cJw5h
         epKA==
X-Gm-Message-State: AOJu0Yz54y5OBYltrxD+v3ZyI1IqYMRFZplUqVD0ussuKJTwWsx4HcIS
	NfqPd8fQgor1U9V6mYdrONCJCQ==
X-Google-Smtp-Source: AGHT+IFGeGEIdkUOFVthyhcRjTJx0RM6fsoLexSRW7UOhe/JF6G0UIDDM39f6wiZQsipdoRzG5PTZw==
X-Received: by 2002:a05:622a:10c:b0:423:6f05:33da with SMTP id u12-20020a05622a010c00b004236f0533damr27697573qtw.18.1701371489811;
        Thu, 30 Nov 2023 11:11:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fx3-20020a05622a4ac300b00424030566b5sm148076qtb.17.2023.11.30.11.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:11:29 -0800 (PST)
Date: Thu, 30 Nov 2023 14:11:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/24] pack-bitmap-write: deep-clear the `bb_commit` slab
Message-ID: <ZWjeYP2vGTyAuQo+@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <6f5ff96998946f3f49da56fd05c096b949521339.1701198172.git.me@ttaylorr.com>
 <ZWhhd5gLzYwPEgBl@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWhhd5gLzYwPEgBl@tanuki>

On Thu, Nov 30, 2023 at 11:18:31AM +0100, Patrick Steinhardt wrote:
> > diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> > index f4ecdf8b0e..dd3a415b9d 100644
> > --- a/pack-bitmap-write.c
> > +++ b/pack-bitmap-write.c
> > @@ -198,6 +198,13 @@ struct bb_commit {
> >  	unsigned idx; /* within selected array */
> >  };
> >
> > +static void clear_bb_commit(struct bb_commit *commit)
> > +{
> > +	free(commit->reverse_edges);
>
> I'd have expected to see `free_commit_list()` here instead of a simple
> free. Is there any reason why we don't use it?

Thanks for spotting an oversight on my part. We should definitely be
using free_commit_list() here instead of a bare free() to avoid leaking
the tail.

Thanks,
Taylor
