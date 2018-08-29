Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8D331F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeH3BAN (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:00:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35604 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH3BAN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:00:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so2831158pfh.2
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 14:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ApGISWSDLp3mm1DpBGVLHfsN/UmYXRgTxqQ4lRRLPEI=;
        b=FeV1y+DsVZKqcnAQYvIhiViTO3sAeU9qSbk0uSijWbLPFy25bhU2FXrq/9TA8Y+5Lh
         NemctIqR78dEa/5g7OYOf+7sdxlfoClxfLt/vek1VgxMHxMe/BXkitXajNyM815oxj8F
         c4WTv+AkHJUutmZqj+S2KMUXgPZYiwBYfSL/7M06VIXhJi+32DdXPDNmhM/7+/rPXs+J
         x1VXq/MLKgZqpvjT4JAUZX15Sbt5NW1JG6bjVYFOKJpQrGlX34kCJiRZsDcYaZ+y4kI0
         pdxl3TrTB12SBuuUnbeAQp1/O/x7JwoWmnHB3qT7EjugcCeoSwYyg1yBorjU/jjzA3+Y
         fcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ApGISWSDLp3mm1DpBGVLHfsN/UmYXRgTxqQ4lRRLPEI=;
        b=rdgNwi9SGUEvj4bOjIXQ27VyChBl94nnAA7S2PT5osZxygG9iwsuRjNTlc8azHWrK4
         7IunwOAu7hGu/BLVE+Vq0Zy0AkaNwBejfLIigX8mRrX5iBW8CX8+QGS7/1ph0IF3AwMk
         ei1I3M3LBpq+aGy4JbKqaHcj0SxfRMJjg8ELbFuaoW/MSZseuRGqTZF4un31u3CXSlze
         eU59K1ojB1xOyeVoP4PcURwWouLfHlLkErQakjLMguTIuAx42bEFXByxT1RbE3EfFeZX
         s/FYBgJf5jLu888oJZFS/iW5RTCk/QNg/pFm+rJKD8r6qCEbzO8zHccoCzJsUfHdYzSI
         xtFw==
X-Gm-Message-State: APzg51CaU9MKSxPcSZGkp3VM8P+Pb5r0SG+vwj6GcH6xe75fA3oXLOky
        WEqFywpqcX5SXuSk8kEhU6Y=
X-Google-Smtp-Source: ANB0VdZkljupnljdU8uyw29yrrlbcHcg62QgGhmh9Y57n0lIVTQVoxrigZyEePo1FUmM2EPz0MXZ2g==
X-Received: by 2002:a62:1089:: with SMTP id 9-v6mr7507130pfq.30.1535576492418;
        Wed, 29 Aug 2018 14:01:32 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v72-v6sm11918175pfj.22.2018.08.29.14.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 14:01:31 -0700 (PDT)
Date:   Wed, 29 Aug 2018 14:01:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: How is the ^{sha256} peel syntax supposed to work?
Message-ID: <20180829210129.GE7547@aiede.svl.corp.google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014703.GE99542@aiede.svl.corp.google.com>
 <877ek9edsa.fsf@evledraar.gmail.com>
 <CAGZ79kaGb_TL7SiR4CFGFzrfy2Lotioy76o6sUK4=vZK5qwqNA@mail.gmail.com>
 <20180829175950.GB7547@aiede.svl.corp.google.com>
 <87zhx5c8wo.fsf@evledraar.gmail.com>
 <20180829191232.GC7547@aiede.svl.corp.google.com>
 <xmqq36uwc2s8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36uwc2s8.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> In other words, I want the input format and output format completely
>> decoupled.
>
> I thought that the original suggestion was to use "hashname:" as a
> prefix to specify input format.  In other words
>
> 	sha1:abababab
> 	sha256:abababab

That's fine with me too, and it's probably easier to understand than
^{sha1}.  The disadvantage is that it clashes with existing meaning of
"path abababab in branch sha1".  If we're okay with that change, then
it's a good syntax.

If we have a collection of proposed syntaxes, I can get some help from
a UI designer here, too, to help find any ramifications we've missed.

[...]
> I do not think ^{hashname} mixes well with ^{objecttype} syntax at
> all as an output specifier, either.  It would make sense to be more
> explicit, I would think, e.g.
>
> 	git rev-parse --output=sha1 sha256:abababab

Agreed.  I don't think it makes sense to put output specifiers in
revision names.  It would create a lot of unnecessary complexity and
ambiguity.

Thanks,
Jonathan
