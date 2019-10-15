Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273FB1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 03:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfJODpv (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 23:45:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45921 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfJODpu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 23:45:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so11532275pfb.12
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 20:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FxNnuaHn1FJ5s3/i6xS7aV0o3YxDMaVEEtw0MSoeqEY=;
        b=aHR0htCJV3NtfX0cq4JVEjq17EQlDh46L6xfmAt8BQnmMD7pqu8XhpWYs+rDLRq14s
         RpfzP6zRCMpaiG0MTsuqdWLbu4MywGoQubWh9XRSqkx4UHpm3CfWKsbRELktjTKdhfbQ
         27A8rHoPA6sxe2xBSK7HhfmjUyqJ3sew14IbCDs0rOhhzr9AOYWrmJ5aaF5bMi+6Hew4
         TisGrlklB+1QFCVbJZC8aChEK/EfZSoUPEl4Mc3mNhd4p4RkTphLd69n6xge1urRsIVe
         YPC6XCfKmd77IKui97CZMfA4eXFFkSW6axrUymUGw655sGV06KVEHv9oFSi48uxpB2gj
         kNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FxNnuaHn1FJ5s3/i6xS7aV0o3YxDMaVEEtw0MSoeqEY=;
        b=rLq0iE9N6oKtwOFNUgWW4HzLwZd2zrsi+i6bOU/oWvX/YGGNtbjESwR2l9MSLxPeEe
         pIQzT+E+GWm0SdOnbsWaVY2gLoj32GNwwMEVtUBPFgoostlRtS9dISNDIcHMUg8WdbeS
         g0KU206TdpM0KH1Z+mDwmjn6OlrMsICbuAGC7LDFYc1DLmfa2v2gYn4Zw3d5uVh4V2nz
         ZhEzo4T7nstcPxOG/0xM4z8RYUoMtJLfofJ3HNPINBrc6Oxl629p6bx12kPYDZxvMAM6
         adVVd9q6oE7gbEttQXX8WGMknEvlTjd8dYbd9aue7pipYR70q2n9lzf+2LSimWryN613
         JxSg==
X-Gm-Message-State: APjAAAVuvrM4r88Sl/xocbGssH1f/XUWVtR8wuW1TmkmZbq48bsLNKs9
        PaqxMwbYAXoOPC9rXViGQ9jEEsZ3
X-Google-Smtp-Source: APXvYqxI+L/WROgymyjQS1w+oIsmsQkbbAyY3fcPf6VMv+fBCM4DeJR7no7322tPGrYlqfrw/AFpng==
X-Received: by 2002:a17:90a:db4a:: with SMTP id u10mr40017982pjx.30.1571111149993;
        Mon, 14 Oct 2019 20:45:49 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id 71sm28468110pfw.147.2019.10.14.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 20:45:48 -0700 (PDT)
Date:   Mon, 14 Oct 2019 20:45:46 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v5 1/3] format-patch: change erroneous and condition
Message-ID: <20191015034546.GA61505@generichostname>
References: <cover.1570821015.git.liu.denton@gmail.com>
 <cover.1571085952.git.liu.denton@gmail.com>
 <56fb230ad271dc9aa91c0f43ac8e4e7085c15775.1571085952.git.liu.denton@gmail.com>
 <xmqqeezeda7w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeezeda7w.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thanks for the feedback.

On Tue, Oct 15, 2019 at 11:16:35AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > .... Since this
> > seems to be a Python-ism that's mistakenly leaked into our code, convert
> 
> The conclusion is OK, but as the inventor of format-patch and a
> non-pythonista, I do not think the above claim is correct, and even
> if Thomas thought it was a good idea to follow Python style in
> 30984ed2 ("format-patch: support deep threading", 2009-02-19), which
> I doubt he did, I do not think there is much point in speculating.

I agree, I probably shouldn't be putting speculation in the log
messages. I'll change this for the next reroll.

> 
> Both the log message and the patch text in the previous round were
> better than this round, I would have to say.

I'll probably keep the patch text, however. In the previous version, we
were implicitly relying on the value of THREAD_SHALLOW to be 1. This
seems a little bit flimsy to me since it's possible that the enum can be
changed in the future and it may invalidate that assumption.

I'll keep it explicit so that it's a little bit more robust and also, so
that it's more obvious to future readers what's going on.

Thanks,

Denton

> 
> Thanks.
> 
> 
> 
> > diff --git a/builtin/log.c b/builtin/log.c
> > index 44b10b3415..351f4ffcfd 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -835,7 +835,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
> >  			thread = THREAD_SHALLOW;
> >  			return 0;
> >  		}
> > -		thread = git_config_bool(var, value) && THREAD_SHALLOW;
> > +		thread = git_config_bool(var, value) ? THREAD_SHALLOW : THREAD_UNSET;
> >  		return 0;
> >  	}
> >  	if (!strcmp(var, "format.signoff")) {
