Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2451F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeDRVP1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:15:27 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39672 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeDRVP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:15:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id q6-v6so8465674wrd.6
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:importance:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=V/fjg2BLrmmi3DOE++flKZDChPbu3E2rO33G++BK6YQ=;
        b=DhYZS/csGKQ3ViNEe0s5Xh8WpC0r91QBMHLFswHP+BpnLljObQSA/jjevizvuLx7Tz
         0N5Uq9PMfpqxGVjPbugpxVC80BqHaxfIH6/ROCpXIliEg/nyFtpajXYJ88fRo7OGdlfS
         nbc7MewCez7BAkT46bf2+ykF2dIpa/CtO+ZhO/qzropnh1R26GEh3Tow0yxZvwN6JcSI
         5PWI+xR0q4kXOsLgO4jdkqqT2teJOLefw7Nm0AHkx5OJ2GJb11Ts5D8YSlrlYXKjV0Tg
         yUxZyH5wiF6mKFUg+ygOqz8sHlRqcIYHL7jMlsvgrBkZhfKQk7RpagNLNukFLBahkI4p
         vKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:importance
         :date:in-reply-to:message-id:user-agent:mime-version;
        bh=V/fjg2BLrmmi3DOE++flKZDChPbu3E2rO33G++BK6YQ=;
        b=qmTUGTbOcneMoqVrMlolOOqCORUFzSRdHZrYw1ksLsjR1iZYmLCYlSBFGs7iurbpnW
         ZsVv2W5nWSXYpAUc6zTqrz9G8iGy0l2DSSWYyT5iocoFoi+halmmBHJXnLtwRAHTZXtN
         MYGHnnAsT9IgiFXVOuHFjb14ADqoL42EhmFe4w/rgux4JY2L3P+AII9kwWvBYVOYSsaO
         Us5kjIl/XDnSFkBsiZXYllia7MaKkdi4UFdo+KkkZDJBaEWMRFrG75sZm4agg3K4IbYx
         I1amxuZxvU48Tu34n4uVc+ttcrIYFHaLSEk8Bl7c/BYUkdUDCav8k8g4x226cQrTw3dC
         kiCQ==
X-Gm-Message-State: ALQs6tB+IAtxaIYe7YFnteDGsS/AAhDm/bvK4m8iUBIlWkwKES4NFw/E
        tKvUY8xbVIe+i5Thk4gjRJ8vLa6O
X-Google-Smtp-Source: AIpwx4+jJadKYWmQq+MdAdW5yqhHe7gaP3j+Po901M95bzanuaZ9FQxElZaZOiYp8cAZLg5Tlprcdw==
X-Received: by 2002:adf:c301:: with SMTP id n1-v6mr2776438wrf.76.1524086124604;
        Wed, 18 Apr 2018 14:15:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 14sm3487191wmo.27.2018.04.18.14.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 14:15:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] ident: don't cache default date
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
        <20180418102236.7183-1-phillip.wood@talktalk.net>
        <87vacoeovh.fsf@evledraar.gmail.com>
        <85ecb584-77a7-f818-14c9-1019873d87f9@talktalk.net>
        <d4aee85d-956f-ac93-b909-6dfeb5ea8fd7@kdbg.org>
Importance: high
Date:   Thu, 19 Apr 2018 06:15:23 +0900
In-Reply-To: <d4aee85d-956f-ac93-b909-6dfeb5ea8fd7@kdbg.org> (Johannes Sixt's
        message of "Wed, 18 Apr 2018 20:15:04 +0200")
Message-ID: <xmqqvacogqs4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> While I like the basic theme of your patch, I think we should fix this
> case in a much simpler way, namely, use the infrastructure that was
> introduced for git-am.

Yup.  reset_ident_date() was introduced by 4d9c7e6f ("am: reset
cached ident date for each patch", 2016-08-01) and the commit
explains very well why it is a good idea to have both the caching
and also the strategic resetting it introduces.

Thanks, all.

> I've shamelessly lifted the commit message from your patch.
>
> ---- 8< ----
> Subject: [PATCH] sequencer: reset the committer date before commits
>
> Now that the sequencer commits without forking when the commit message
> isn't edited all the commits that are picked have the same committer
> date. If a commit is reworded it's committer date will be a later time
> as it is created by running an separate instance of 'git commit'.  If
> the reworded commit is follow by further picks, those later commits
> will have an earlier committer date than the reworded one. This is
> caused by git caching the default date used when GIT_COMMITTER_DATE is
> not set. Reset the cached date before a commit is generated
> in-process.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  sequencer.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index f9d1001dee..f0bac903a0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1148,6 +1148,8 @@ static int try_to_commit(struct strbuf *msg, const char *author,
>  		goto out;
>  	}
>  
> +	reset_ident_date();
> +
>  	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
>  				 oid, author, opts->gpg_sign, extra)) {
>  		res = error(_("failed to write commit object"));
