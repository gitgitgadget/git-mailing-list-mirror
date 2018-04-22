Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F631F424
	for <e@80x24.org>; Sun, 22 Apr 2018 23:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbeDVX0k (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 19:26:40 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:37559 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753443AbeDVX0j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 19:26:39 -0400
Received: by mail-pg0-f53.google.com with SMTP id a13so2615056pgu.4
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 16:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NVij1scMADEK2dgMOpQbFtxIXZbV3Iy1XQn6mZJ6pXo=;
        b=R2e6DmLZqvsyYkVTYu0yNfF3n82ov7EWKk9c78K/XZLy9I6aPa0sgcPowepPzxrbZr
         WPZ+02bQ/SeLPc8jW1IlwPVMY0dFjbVrPKc8DHnonNS5LKutyjYSOTVNvsanjrWChqvd
         dWKCPsFlPmJVWsaJHt0ho3nIAv2ySr7OJt1KIu/sVILDz/uZZR115S5Eto0S/2ge3441
         FNJEymlNDp32V+xYQwp2NJdEOc3+FFiCuZ1VWJ7MtSLwxssNmr5m1UYV6pvY0GZgdhrL
         2evjoTemFdne0OSwIPAsH0Pd4WTV3vUEqPrQ7KwLKKdPosyMA9ZVG0RtRAqLoRxHpdA7
         gTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NVij1scMADEK2dgMOpQbFtxIXZbV3Iy1XQn6mZJ6pXo=;
        b=AUEAVoTd/qcAlqG8CrulStdPC7Ep0S7lUFh10JWuiA58HAa8w+P5qy31vYhrOLJG2y
         ikWKPQGiqr9L/02jvIN5QgpwQnX1AhDREV6rltC2mrm1AWra9E4gWVxFi/3th5ZjNlJy
         Gu9MDc5eA7pAnSidbUFVUTFw+KG0UZ8IXXvmc4zbqr1xKhx0sYSzIymhLqXnUROhFr0n
         9ZjwxfLew7q3069e5aGeuzeypkPriaaB9UBdPy9ZAzKW0BQzRM1rRpkb3sW1T4+OI68w
         OBSLeA2FypbO+FfuTy5PvWXckwn3ecr8aTKh6RwbqSCMGsaAdPELwcsGK79BGdzA26Ge
         M9yg==
X-Gm-Message-State: ALQs6tBVBr0yENm/k+K2vG02dUEMLkWdhL1C51+BbAMGhyvIESZnXAmp
        WMrBeIS83TKhFHh0hiC2pne4Lw==
X-Google-Smtp-Source: AIpwx48R9jMIjdtWXU48lnC0NAiVDyZfKZffPl69l67Jw7Ryo8YDsLL8+JW0r2wAlJ1ybmDy++MfVA==
X-Received: by 10.98.155.141 with SMTP id e13mr8395567pfk.157.1524439599264;
        Sun, 22 Apr 2018 16:26:39 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id b72sm13918135pfm.69.2018.04.22.16.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 16:26:38 -0700 (PDT)
Date:   Sun, 22 Apr 2018 16:26:37 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 5/6] builtin/grep.c: show column numbers via
 --column-number
Message-ID: <20180422232637.GB48072@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <6dd73ad84cad5a749bf05c500295955970577e04.1524429778.git.me@ttaylorr.com>
 <878t9eewu2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t9eewu2.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 11:48:53PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Sun, Apr 22 2018, Taylor Blau wrote:
>
> I think this part though...
>
> > While we're at it, change color.grep.linenumber to color.grep.lineNumber
> > to match the casing of nearby variables.
> > [...]
> > -`linenumber`;;
> > +`lineNumber`;;
>
> Makes sense as its own patch at the beginning of the series, since it's
> just related cleanup.

Thanks, I have adjusted this change in my copy and will attach it in a
subsequent re-roll.

> > +`columnNumber`;;
> > +	column number prefix (when using `--column-number`)
>
> Here you're using --column-number...
>
> > +grep.columnNumber::
> > +	If set to true, enable `-m` option by default.
>
> ...But not here. This needs to be updated
>
> > +grep.columnNumber::
> > +	If set to true, enable `-m` option by default.
> > +
>
> ...ditto.

Fixed all of these, thanks for pointing them out :-).

> > +--column-number::
> > +	Prefix the 1-indexed column number of the first match on non-context lines.
> > +
> > [...]
> >  		OPT_GROUP(""),
> >  		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
> > +		OPT_BOOL(0, "column-number", &opt.columnnum, N_("show column numbers")),
>
> Maybe "show first matching column"? I.e. the main docs say "just shows
> the first", but this seems to give a different impression.

I settled on "show column number of first match", and have noted its use
for callers like git-jump in the documentation.

Thanks,
Taylor
