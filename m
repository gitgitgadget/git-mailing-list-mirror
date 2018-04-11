Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2155B1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 03:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeDKDtq (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 23:49:46 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:39479 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeDKDtp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 23:49:45 -0400
Received: by mail-pg0-f45.google.com with SMTP id b9so165216pgf.6
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 20:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9vPoHJ4oblld9kfRlPNT7kZQhb9na+spCmNQo2YbAR4=;
        b=Y+taXiI0yp+bla4is0BGCniX3hBwviUnYz1+tgMrx0IcJMKlZBlMcPENu1QlkB3s7l
         tKCQCR1kDIyp63ROY80iY3+U5y33l4oSdFsavr6rj0UCD8r9xyqHpoLkD8c1ZUHAQwbw
         M52fzYz79rji/74WOONYrVU0tVqQQRB+X052dP2nmG+qzvG6JNchozWmbB+W41hFEMQo
         ZcijhGRrKk0AeU62pp2C6cUW3BATPR5M6kSFUQS6oZOz+RnMgAGLfkIl9gtQU8umJoRf
         nFNq2VJK/MAXTm7HQaCbQH5/Bnhqk3wBJboDNnPpSm+xBAceGC4HYNBhow3ru4PTFunr
         TsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9vPoHJ4oblld9kfRlPNT7kZQhb9na+spCmNQo2YbAR4=;
        b=ESXYlMwPFgp1Oj3cvFaJymXTk8xAoe6cYm5yn3R8YAy847QYhVVJzQdZpNY5EeYG2c
         ToISBKdhuBiSvtH1t+CnNu3BvnjnP4GEg9M6XTcz084zBRwLrs52OMcowhk8Kd+PZrmM
         czKki92XE7VLizIi/hPUiOnDzYTdD7DOut/nlsKqWnVdtzHbL1z0EapKwvpb/2QvMmRn
         W7VKnSt09BljTYaXmulU3rljSGAWJEVnTXMD8TPxJSUCDUYAkHcir7g8L5T3WCLPWnLd
         n/lJenK84rAWzRX5tvtiRs/maXpktOidoOapFJ9VAMufC+fTUpebV4gP97VuaZDnpTyx
         6/tQ==
X-Gm-Message-State: ALQs6tBYEBFUIXZSM3D5EGPTCPdzdG8We0Vs567fhIR8T+nATawG4w9f
        sgmJtGYefCd4g82CFr+Eq8srHHv9MTI0xg==
X-Google-Smtp-Source: AIpwx48L10zQCEu3dZSLdoLArXIyYtGdONOprOl/4bZZXfCyqIO4+of927oQoJBpn1E3Ren4pmTLEg==
X-Received: by 10.98.242.80 with SMTP id y16mr2580112pfl.200.1523418584175;
        Tue, 10 Apr 2018 20:49:44 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d0e:5efd:b490:f1b1])
        by smtp.gmail.com with ESMTPSA id p6sm360089pfk.104.2018.04.10.20.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 20:49:42 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 10 Apr 2018 20:49:41 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, peff@peff.net
Subject: Re: [PATCH v8 0/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180411034941.GA63158@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180411010654.GA28561@syl.local>
 <xmqqtvsizg9u.fsf@gitster-ct.c.googlers.com>
 <20180411013309.GA36066@syl.local>
 <xmqq1sfmzbbg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sfmzbbg.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 12:11:47PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> > +#define OPT_CALLBACK_VALUE(s, l, h, f, i) \
> >> > +	{ OPTION_CALLBACK, (s), (l), NULL, NULL, (h), PARSE_OPT_NOARG | \
> >> > +	PARSE_OPT_NONEG, (f), (i) }
> >> > +
> >> > +static struct option builtin_config_options[];
> >>
> >> OK.  I am not sure if OPT_CALLBACK_VALUE() needs to take 'f', as you
> >> always pass the option_parse_type function to it.
> >
> > That's fair. I left this in as an indication that something like this
> > _might_ want to make its way into parse-options.h as a general-purpose
> > utility, but was not yet ready to do so. Thus, I defined it inside
> > builtin/config.c.
>
> I understood the reasoning, but as your current verdict is that this
> is not yet ready for parse-options.[ch], I think it is probably
> preferrable to reduce repeated passing of the same function to the
> macro, at least while it is in this builgin/config.c file.

Ah, that seems fair to me. I have removed the duplicate 'f' parameter
and all of the option_parse_type()'s in builtin/config.c within my local
copy, and will happily include these changes in the subsequent re-roll.

I'll wait for more feedback before sending this, however.


Thanks,
Taylor
