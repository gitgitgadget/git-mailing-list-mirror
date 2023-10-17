Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C701E5666
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="BrWiXPm5"
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AC893
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 20:17:34 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b811a6ce8so2920242eaf.3
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 20:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697512654; x=1698117454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/+3jfluIwTgC81QEV2MAZYypOMXnOS1DWuiwi8Y8Zc=;
        b=BrWiXPm5a5a+Vom9yS+rbsa//3Tlupdgkk61hsVpsnPnBEWpXkf5GInpsZ4KJ6bYE3
         E4NvC7W4cB/21I/YNskWOtQ3m/v78JzHDEDuVJuTHJtU3E91sqvLO4OnkfHtNI+UqsWB
         udc0f9AOQdNG0Gl8wgqnxdtPWIl05szC82+0cg3rDgZmihZbUGOwymkE+tsU3U0DHN9u
         6L/5TsTuEPbQGOJ9JW/aGjtYtwjt5k49j5jXVufbK0Fj+3N0BjqzraLm9K9FpNNAi019
         +QQ/AQB9VsSCg/NZZD7MWWiZAZfvM9sVirJZPlP5nSwuBoYxQs7I3+Rdg2622i7Iyhyn
         s5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697512654; x=1698117454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/+3jfluIwTgC81QEV2MAZYypOMXnOS1DWuiwi8Y8Zc=;
        b=ZtJ2LMtOzOLvW2ClOfvBzsz006r2YIEWS7GFWAVRVM3tlYcQqS8vIhzW67uVWLFIds
         28CqCme+J+ciqkHT1cOxuxSsriL/gLwxO0a1X8+e6yeb4xE/MlsbXaRXvmc9yJebnJp7
         UzSNROgyzhEaW55Z0svcQh8bDAycgXUd92B+RP0kq8OdzjmmDE+jt9f/bGYGSNOd0AfJ
         4VcpYSpBdPeWDQ/ESGLLUIwNPbx51KrlA9FFRyA1+C9IwF3hDDMtOc46EChvBVZb6cX0
         Jg+OJ3nxyZKbvbJP3aq051Ege2giPZ0gwxf4ThaIFLz0N56K/1pgTQBYflNjvProNEXl
         U4+w==
X-Gm-Message-State: AOJu0Yy5Le87jLQd4bxz5ednKTz23mrebbtrcUnpd/2AUn3nPEhNqnv5
	MixrBERdF18plr83AZ97arvBq1f+bTiE+kPK6AlBAHhsd6w=
X-Google-Smtp-Source: AGHT+IFtzwEw05KGe/I5EIW9NNnwcBg51/REp/88yJGM6IcNxl9Xm2hpBCNHJNvnEziqoCs5pOCsHQ==
X-Received: by 2002:a05:6358:8807:b0:134:de8b:17f0 with SMTP id hv7-20020a056358880700b00134de8b17f0mr1227940rwb.19.1697512654093;
        Mon, 16 Oct 2023 20:17:34 -0700 (PDT)
Received: from initialcommit.io (mobile-166-170-47-49.mycingular.net. [166.170.47.49])
        by smtp.gmail.com with ESMTPSA id w123-20020a626281000000b0068ff6d21563sm315603pfb.148.2023.10.16.20.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 20:17:33 -0700 (PDT)
Date: Mon, 16 Oct 2023 20:17:30 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] bugreport: include +i in outfile suffix as needed
Message-ID: <ZS38ykTuqHXYnU57.jacob@initialcommit.io>
References: <20231015034238.100675-2-jacob@initialcommit.io>
 <20231016214045.146862-1-jacob@initialcommit.io>
 <20231016214045.146862-2-jacob@initialcommit.io>
 <xmqq4jiqkwi1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4jiqkwi1.fsf@gitster.g>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 03:55:50PM -0700, Junio C Hamano wrote:
> Jacob Stopak <jacob@initialcommit.io> writes:
> 
> >  builtin/bugreport.c | 83 +++++++++++++++++++++++++++++++--------------
> >  1 file changed, 57 insertions(+), 26 deletions(-)
> 
> Looking good.  It is not easy to do an automated and reliable test
> for this one for obvious reasons ;-), so let's queue it as-is.
> 
> Thanks.
> 

Awesome! Thank you!

> > -	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
> > -	report = xopen(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
> > +	again:
> > +		/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
> > +		report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
> > +		if (report < 0 && errno == EEXIST && !option_suffix_is_from_user) {
> > +			build_path(&report_path, prefixed_filename,
> > +				   "git-bugreport-", option_suffix, now, &i,
> > +				   ".txt");
> > +			goto again;
> > +		} else if (report < 0) {
> > +			die_errno(_("unable to open '%s'"), report_path.buf);
> > +		}
> 
> I didn't expect a rewrite to add an extra level of indentation like
> this, though ;-).

Whoops... I looked in another file to check the indentation around a
goto label and misread how it should be. Let me know if I should submit
v4 with that corrected.
