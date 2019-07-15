Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8FAC1F461
	for <e@80x24.org>; Mon, 15 Jul 2019 22:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfGOWCz (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 18:02:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37681 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfGOWCz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 18:02:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so8057549pfa.4
        for <git@vger.kernel.org>; Mon, 15 Jul 2019 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dh7vfy27S+m8RdlsksdF7gIXda82rUS9Vbd1t3B/xYs=;
        b=VAOu0SwXmc8EyLvsk9N2UBH5x6r8Wr+ymZ61EFZsEmikx1xRLtfU40eK35l9L/NbUa
         P+wnQ+8dJiqzm9IsPTMR2v84nbMh4a3Ke0Q0uAILDj5phbfkkOXJx6tVMjXBz17YtgEN
         ApHCM9Aamg7rcLgpsw5SULJyMz1cmNhFynpys+zyDcgHfGNhujVey/GdEepRexR9MDkV
         3WNwnlXSkcAFxKI2bQZ23L8yxtwwuy7eV+XI2GYfyu2tigMKo0ZfbJpc24F5Jm+Z7lF1
         blBOojta0lNWa0Si2joGeE6HonI+R2Z5RRyb/qD7QCqPisi0h0XtXgb1fkopXucYxnWa
         IN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dh7vfy27S+m8RdlsksdF7gIXda82rUS9Vbd1t3B/xYs=;
        b=Y9f8FoaXUjU+kLCV75f7c0Y1+GXrUnx6LzJKW41WPFsX0eV+/6B+AIg548NXQ4ZGuA
         w6ewGZdTQaKGI7zQ5SZpqIvd0hqr3E0CXocG28tZfQLwQBIA8ZbK4L+CypAz2z5Q+GRi
         yGNgVkJH0MRUvLe8j36UtaTNXAM2vb56W/+/C3vnh+aV9vFtD7k3L21vBULQ0cc/1y1d
         dla+5lhPDU7/6CpUmyvSp+V9YQg1NpNBZgGrKceNX0FsKiJEfgNopuT2mrHj9fI02orj
         UEUGk8TUV/hvuUQfgMbIwkkW7Tln5AIEnqDYpqRozLgFshP7FBwPL5K4PPxCiBBPEjR5
         3cxw==
X-Gm-Message-State: APjAAAXHUdUaLpG8ZeZFtg2CqPqMVySATVUvNhjDxdP7R8VysBeCtdoZ
        Bh47QQPBykWguiDumjO5K4U=
X-Google-Smtp-Source: APXvYqzsfc8qb9aLuCjHr3sWacYtZ2Ys9eicg0fTrGCIVREbxbPXwMGo/SdKYFiXQ1nbuhN13WK7vQ==
X-Received: by 2002:a63:5823:: with SMTP id m35mr29655888pgb.329.1563228173946;
        Mon, 15 Jul 2019 15:02:53 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.215])
        by smtp.gmail.com with ESMTPSA id n19sm18958195pfa.11.2019.07.15.15.02.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 15:02:52 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, phillip.wood123@gmail.com,
        rohit.ashiwal265@gmail.com
Subject: Re: [GSoC][PATCH 1/1] rebase -i: add --ignore-whitespace flag
Date:   Tue, 16 Jul 2019 03:30:10 +0530
Message-Id: <20190715220010.8146-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqlfwz41vl.fsf@gitster-ct.c.googlers.com>
References: <xmqqlfwz41vl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Mon, 15 Jul 2019 10:57:18 -0700 Junio C Hamano <gitster@pobox.com> wrote:
> 
> Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:
> 
> > +	if (opts->ignore_whitespace) {
> > +		struct strbuf buf = STRBUF_INIT;
> > +
> > +		if (opts->strategy_opts)
> > +			strbuf_addstr(&buf, opts->strategy_opts);
> > +
> > +		strbuf_addstr(&buf, " --ignore-space-change");
> > +		free(opts->strategy_opts);
> 
> Is this call to free() safe?

Yes, as far as I can tell. Since up till now, `strategy_opts` is
either "NULL" or xstrdup()'d string. There is no double free involved.

> > +		opts->strategy_opts = strbuf_detach(&buf, NULL);
> > +	}
> > +
> > @@ -1821,6 +1836,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  	}
> >
> >  	if (options.rebase_merges) {
> > +		if (options.ignore_whitespace)
> > +			die(_("cannot combine '--rebase-merges' with "
> > +			      "'--ignore-whitespace'"));
> 
> Hmph, this is unfortunate.  The patch is not making things worse, though.

Actually, there is no need for --rebase-merges and --ignore-whitespace
to be "incompatible". My mentors also agree on this one. Making them
work in harmony will be handled in another patch series.

Best
Rohit

