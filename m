Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E44F1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 16:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfA3Qui (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 11:50:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39861 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfA3Quh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 11:50:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so215696wra.6
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E9tFtcB9/qR5FkIsGBGlQnt3OI/cBOdWepa5pFjcB6U=;
        b=VDtmhZNq9yLBeCAkrTsb2mkyOvWXguM0GJKTvLnGd8OPUbfKKLwFkSOD3ahxXhaTJE
         Qdmek9h+9dYaiw4W2lIBh06IfDjSjN3BlXkEkqM+D0zyTHVrz+vPKWJyOpepMaBxIddZ
         /JhVKXtxIwyzo/M6RVMLGvrZmhbuLfxcq/uZnpYYKYGzZAtR4Gf1HbE3GnXKCBk/rSnD
         zlIIgL1pyLUeiu3nxn4Oj1XIfUv8VZO9I4sHduufyFwXuJklSkNG/zY5MfRUux/Xpu1x
         Y6Oc/d0vavn/5tYZqT1Lg2kPueJrMjqtnlhyoVYMW4Z45W2OJW4KnmdJ1bNx9tX3vT/p
         QbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E9tFtcB9/qR5FkIsGBGlQnt3OI/cBOdWepa5pFjcB6U=;
        b=NNNfMpZPLRoeEUFD/gdImpFcE3zk3CQPwi9dw1Q2jqv3fufyGbqK1nP+gIE4KNbR0D
         7y43zsNC4k9OiVcX+xM5Unq2U9ZuWvXzmOeiJTXtQ6eYHaD4uGZuAXnjkcRwyGgzVUZJ
         9r8sToRoHWKfNh0E2odKY3opKD2DKqCnTL582JGfULpjE9nBO3k83fA5Vrummm8e0Xfp
         +GtgrmotyhZNHLmZ+OR30AQgmGQOWDCXKizRgWjXM179dTQklcp1vLs2pDnzQzwWGze3
         jsBi55N1Cq1+MFbzWzWfuHoogQrkDDVoawnZ9/3yMAG+Mfs4Mr6YJmbN7XBVFZwcIenc
         itkQ==
X-Gm-Message-State: AJcUukehCdJa7Ir59aSZzb+5eO4So8jRqvL3m18DhJU2puH0U87NIcwC
        /h/Vv7Ta/kNgiTy2Vb6VRN0=
X-Google-Smtp-Source: ALg8bN5nhodJKvn3tmw5IrvMhOq/RDsAwVEznI+ludyTWpsVDF3+RLJomH9IM189zgssHZVillgM/g==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr32552635wrw.113.1548867035005;
        Wed, 30 Jan 2019 08:50:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l20sm3439031wrb.93.2019.01.30.08.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:50:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 07/13] HTML documentation is not provided with Apple's git. Make the error message more on point.
References: <20190129193818.8645-1-jeremyhu@apple.com>
        <20190129193818.8645-8-jeremyhu@apple.com>
        <xmqqsgxb5ard.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901301444220.41@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Jan 2019 08:50:33 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901301444220.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 30 Jan 2019 14:45:12 +0100 (STD)")
Message-ID: <xmqqtvhq3x9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 29 Jan 2019, Junio C Hamano wrote:
>
>> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
>> 
>> > Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>> > ---
>> >  builtin/help.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/builtin/help.c b/builtin/help.c
>> > index 7739a5c155..e001b6157c 100644
>> > --- a/builtin/help.c
>> > +++ b/builtin/help.c
>> > @@ -383,7 +383,7 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
>> >  	if (!strstr(html_path, "://")) {
>> >  		if (stat(mkpath("%s/git.html", html_path), &st)
>> >  		    || !S_ISREG(st.st_mode))
>> > -			die("'%s': not a documentation directory.", html_path);
>> > +			die("HTML documentation is not provided by this distribution of git.");
>> 
>> Mentioning HTML in the message may be a good idea, but I feel that
>> "distribution of git" is not something we should say in the source
>> for those who are building from the source.  Distributors are free
>> to munge before they generate their binary distribution, of course
>> ;-).
>
> So maybe something like
>
> #ifdef MISSING_HTML_MESSAGE
> 			die(_(MISSING_HTML_MESSAGE));
> #else
> 			die("'%s': not a documentation directory.", html_path);
> #endif
>
> ?

No, distributors can fork and build from patched source.  What I
meant was along these lines:

    die(_("HTML documentation not installed in '%s'."), html_path));
    die(_("The installer chose to omit HTML docs from '%s''.", html_path));

