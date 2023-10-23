Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5E1C284
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="S1LOdRVq"
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A77A94
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:40:05 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so2430057a34.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698082804; x=1698687604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CmA0zKmpeW2qgDLH+xbhqthR3v5uS2+ViSF69hAY3Zc=;
        b=S1LOdRVqDwTTaK61UPpiE29Gu68omVt9z8KtwxI8zmqqLoo93g0DjHBtTfDN8mPBMz
         cu7Ep4gpv2GeFG63nssq8s1LrePkw9IHyBgDRm5loS/fM0nQIOU8n0NHlVd4y+ZJjxcx
         STrvz9rvVjttCNKQAGSgDpZijPcmCNQDbTyqEZTTWR0pOBTxr+hdSUED/AXtJYVecE5p
         9rCfxHz/dkCuMWJ3fafvO7hAlpia3s9PAGHqRsAm62wSoMAns1/y5dpTNIkW6ma0Q5QL
         IPzuLzSLPkOizDt1jQdfKyAL0Rq2WYCfsercHNCncUkOnUovSzHufj6fJ/F+NAKS4x07
         +WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082804; x=1698687604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmA0zKmpeW2qgDLH+xbhqthR3v5uS2+ViSF69hAY3Zc=;
        b=RkYyPl6CMnh4tJcvHYKbnUaCyU5NmzGbZ2zyGdAZBgpQ5a1XWTdwHpzrUb3ar1ThSw
         JpY/N0tNg41h9+hRmcW+Lp5dFTQYCCX9lpEbxIGyyXeFD38bWzF+ADB39Ytwz+2m1Ag3
         iIdYBN2++bSegdvgCFaX3jwOsAUbJPUjxJdgF+5+MUs4zDlnJFkoSrAfzS7OdiFY+5Uk
         l4fEARPnXl6BxAFVQawZasppVsj7GCWm4Pmc0oo7/6OjyrpyFzzlScmdycsL5KJwgJm0
         gLKvIGbi2kgBqvpabpTt5MP/abwnPCAU6lDij+Vck4p8nsHKYvZhXaKpbDT7YjGVauEB
         pFXA==
X-Gm-Message-State: AOJu0Yzo43xYxpqkbsWmyluAGpm6yEEtWJxtNSCF/XY6YOKlIKvAHTeN
	hTnMxoYx/vUc1KWo66XyuTK2wg==
X-Google-Smtp-Source: AGHT+IFCMBaGp/S+EEmvkv5eVV0B+zEatdaSqxmGlBOgacQd1AoXzSMXY2F+iLvRG8Tpzzak/pDNzw==
X-Received: by 2002:a05:6830:118a:b0:6c4:da36:f949 with SMTP id u10-20020a056830118a00b006c4da36f949mr10981815otq.8.1698082804390;
        Mon, 23 Oct 2023 10:40:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g10-20020a0cf84a000000b0066d0621bb67sm3019915qvo.114.2023.10.23.10.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:40:04 -0700 (PDT)
Date: Mon, 23 Oct 2023 13:40:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
	stolee@gmail.com
Subject: Re: [PATCH v1 3/4] config: factor out global config file
 retrievalync-mailbox>
Message-ID: <ZTav2u1JWmLexEHL@nand.local>
References: <cover.1697660181.git.code@khaugsbakk.name>
 <147c767443c35b3b4a5516bf40557f41bb201078.1697660181.git.code@khaugsbakk.name>
 <ZTZDqToqcsDiS5AP@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTZDqToqcsDiS5AP@tanuki>

On Mon, Oct 23, 2023 at 11:58:01AM +0200, Patrick Steinhardt wrote:
> On Wed, Oct 18, 2023 at 10:28:40PM +0200, Kristoffer Haugsbakk wrote:
> >
> > Factor out code that retrieves the global config file so that we can use
> > it in `gc.c` as well.
> >
> > Use the old name from the previous commit since this function acts
> > functionally the same as `git_system_config` but for “global”.
> >
> > Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> > ---
> >  builtin/config.c | 25 ++-----------------------
> >  config.c         | 24 ++++++++++++++++++++++++
> >  config.h         |  1 +
> >  3 files changed, 27 insertions(+), 23 deletions(-)
> >
> > diff --git a/builtin/config.c b/builtin/config.c
> > index 6fff2655816..df06b766fad 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -708,30 +708,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> >  	}
> >
> >  	if (use_global_config) {
> > -		char *user_config, *xdg_config;
> > -
> > -		git_global_config_paths(&user_config, &xdg_config);
> > -		if (!user_config)
> > -			/*
> > -			 * It is unknown if HOME/.gitconfig exists, so
> > -			 * we do not know if we should write to XDG
> > -			 * location; error out even if XDG_CONFIG_HOME
> > -			 * is set and points at a sane location.
> > -			 */
> > -			die(_("$HOME not set"));
> > -
> > +		given_config_source.file = git_global_config();
> >  		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
> > -
> > -		if (access_or_warn(user_config, R_OK, 0) &&
> > -		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
> > -			given_config_source.file = xdg_config;
> > -			free(user_config);
> > -		} else {
> > -			given_config_source.file = user_config;
> > -			free(xdg_config);
> > -		}
> > -	}
> > -	else if (use_system_config) {
> > +	} else if (use_system_config) {
> >  		given_config_source.file = git_system_config();
> >  		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
> >  	} else if (use_local_config) {
> > diff --git a/config.c b/config.c
> > index d2cdda96edd..2ff766c56ff 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -2111,6 +2111,30 @@ char *git_system_config(void)
> >  	return system_config;
> >  }
> >
> > +char *git_global_config(void)
> > +{
> > +	char *user_config, *xdg_config;
> > +
> > +	git_global_config_paths(&user_config, &xdg_config);
> > +	if (!user_config)
> > +		/*
> > +		 * It is unknown if HOME/.gitconfig exists, so
> > +		 * we do not know if we should write to XDG
>
> Nit: we don't know about the intent of the caller, so they may not want
> to write to the file but only read it.

I was going to suggest that we allow the caller to pass in the flags
that they wish for git_global_config() to pass down to access(2), but
was surprised to see that we always use R_OK.

But thinking on it for a moment longer, I realized that we don't care
about write-level permissions for the config, since we want to instead
open $GIT_DIR/config.lock for writing, and then rename() it into place,
meaning we only care about whether or not we have write permissions on
$GIT_DIR itself.

I think in the existing location of this code, the "if we should write"
portion of the comment is premature, since we don't know for sure
whether or not we are writing. So I'd be fine with leaving it as-is, but
changing the comment seems easy enough to do...

> > +		 * location; error out even if XDG_CONFIG_HOME
> > +		 * is set and points at a sane location.
> > +		 */
> > +		die(_("$HOME not set"));
>
> Is it sensible to `die()` here in this new function that behaves more
> like a library function? I imagine it would be more sensible to indicate
> the error to the user and let them handle it accordingly.

Agreed.

Thanks,
Taylor
