Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412D820281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032702AbdIZXwD (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:52:03 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:51705 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967961AbdIZXwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:52:02 -0400
Received: by mail-pg0-f52.google.com with SMTP id k193so6772947pgc.8
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=suhrqIeW/2nhVhHw1IFhF9Nxlo8/r9KRXbfW7xdD9oo=;
        b=j7yutGZc2jOzfUmPw87W8yMWENK4mY/aihYAOhaInhFUViWIWuRunrhzGzzM66a4Aj
         R7c6A+mA2jEqsEH3bxf/yHjrJK/4wTg/8RXe03uTMwQZViXV1P9DcYA3ero42Tor22o4
         +TPAgTfPEnnso68ztiJBUYGx6+E1ChW+e3MIyvyzyYdfR8gm2gYKSHFkKJ6kl+bT8QFQ
         HBk6B9o8mpPKflNDplCBkwT5uoa2QvEMBfvYJrAk91rRJc/4xgEFCGHrBpUigVGNALRh
         feMM9EJtIhXe/TM+JbDTrBEOqViMa+w3JlW9bnVA2pDPNf49ntHEP4EV7WohJqWCdKSm
         y6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=suhrqIeW/2nhVhHw1IFhF9Nxlo8/r9KRXbfW7xdD9oo=;
        b=KAwC+uxE9XTsVura6ja/y2vqAyrDe1gG3M4tJK54UzI3zKxmrcN7XGzk2O5SCYKXh+
         1yiHjyKx8YTAuTyAuRQWBpM+1F9vNbMGM3Tx4MeL572Xd7OauuvMCyT50tmINeu1zs4+
         YQTxLagtfoS4DV4vAiDQeUcjVMs9RZ+yZ65bEEotTIqJmPAKtJGf1fiUMj9pFF9GYKpT
         ZVMtmc9soUh80AEg3zZQD70eYTwLZsSCTVvIIEU2s1mJosRmRNW8WTeKvPq0JeFtNglv
         Xb35Lb30cyUq4yWtzY4kekTUKE2zo/kfSTPPtfytX9iApxSN7Cwnr+3T8fr69H8u3zSz
         xsug==
X-Gm-Message-State: AHPjjUgekwPP01vZSpjK0jPpS9TbJPbpe0+2/PCrfOlpDQWQyEcPqFbd
        E2P+DzLlo891qTII6aGd1Co=
X-Google-Smtp-Source: AOwi7QCR1/Uhk4qm488O0IqKOW6/1IPztBNJ2gTT+fRNNgIVTs5neQZuILP7XEIGmV/+WAt6ieZC9w==
X-Received: by 10.101.66.70 with SMTP id d6mr12294119pgq.169.1506469921356;
        Tue, 26 Sep 2017 16:52:01 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:adf2:1b4a:4806:c4b1])
        by smtp.gmail.com with ESMTPSA id q28sm17573598pfj.77.2017.09.26.16.52.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:52:00 -0700 (PDT)
Date:   Tue, 26 Sep 2017 16:51:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170926235158.GD19555@aiede.mtv.corp.google.com>
References: <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
 <20170926170502.GY31762@io.lakedaemon.net>
 <alpine.DEB.2.21.1.1709262356360.40514@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709262356360.40514@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> Sorry, you are asking cryptography experts to spend their time on the Git
> mailing list. I tried to get them to speak out on the Git mailing list.
> They respectfully declined.
>
> I can't fault them, they have real jobs to do, and none of their managers
> would be happy for them to educate the Git mailing list on matters of
> cryptography, not after what happened in 2005.

Fortunately we have had a few public comments from crypto specialists:

https://public-inbox.org/git/91a34c5b-7844-3db2-cf29-411df5bcf886@noekeon.org/
https://public-inbox.org/git/CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com/
https://public-inbox.org/git/CAL9PXLxMHG1nP5_GQaK_WSJTNKs=_qbaL6V5v2GzVG=9VU2+gA@mail.gmail.com/
https://public-inbox.org/git/59BFB95D.1030903@st.com/
https://public-inbox.org/git/59C149A3.6080506@st.com/

[...]
> Let's be realistic. Git is pretty important to us, but it is not important
> enough to sway, say, Intel into announcing hardware support for SHA3.

Yes, I agree with this.  (Adoption by Git could lead to adoption by
some other projects, leading to more work on high quality software
implementations in projects like OpenSSL, but I am not convinced that
that would be a good thing for the world anyway.  There are downsides
to a proliferation of too many crypto primitives.  This is the basic
argument described in more detail at [1].)

[...]
> On Tue, 26 Sep 2017, Jason Cooper wrote:

>> For my use cases, as a user of git, I have a plan to maintain provable
>> integrity of existing objects stored in git under sha1 while migrating
>> away from sha1.  The same plan works for migrating away from SHA2 or
>> SHA3 when the time comes.
>
> Please do not make the mistake of taking your use case to be a template
> for everybody's use case.

That said, I'm curious at what plan you are alluding to.  Is it
something that could benefit others on the list?

Thanks,
Jonathan

[1] https://www.imperialviolet.org/2017/05/31/skipsha3.html
