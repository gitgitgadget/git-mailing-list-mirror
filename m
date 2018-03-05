Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD5A1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeCESsw (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:48:52 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:43803 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCESsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:48:51 -0500
Received: by mail-pl0-f46.google.com with SMTP id f23-v6so10198881plr.10
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A/GaFYG49hHaghru9DrBD5Tkbi6IhE42EqwHmoGbwCk=;
        b=QJrsm70mKQcLIIpXv2upRAttcBDdBA5snnYfMxLG05cVOrixhisLzGlasvVm1Wz8cD
         xPnGDr+quDLoQpAAivQp4Lt/8Z8PLX5rCi0hIjXkYckO9WP7ZfB9GPu+64C/EG7LNYq5
         4DXCDoZ3WDApJIbtiFB6ZaJy/v0Mfnm1JF22dmHBnSuYjvocFoeEYutZxd4qqNP7D4dQ
         KIboFQLlClT9fv4bq08GzfNAPI490d/1nr46zASfhr9YIV+LAvZQOjYqcBi4473vCg4q
         Laoiug5b+xN5ahYGX5sdDw3vQgFH80/X0Lwn/H4Zr2lDW9Hljz1WgILczG2gTWkHLg8M
         fLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A/GaFYG49hHaghru9DrBD5Tkbi6IhE42EqwHmoGbwCk=;
        b=Fw0gHdnJ1Xeu4KPdRMOcgu5ThajA1W9bjOEcVCx4yqxLE1EuNZ0aODGDj1MOgnYUR3
         AX4CTh3wJAQQR7qUy7zkE2UiZoKtZRbGHUT07z9WNd7FYLGZ14aR9fsZBZ4En3feYgpz
         1WV57WC3NFjzVdrknjyCYViLT7yUSrhsA+LHYdfPy+lJiQRyIqdDAAzHOucJV1f4yEoT
         LgOvnpsJzk+ydZeea7T7W8LOicXUrCwIyIu8cAGvBDMBkTi5GPq0u911W+MUvlAtkWJG
         BkOiZEPYej7siOJrMctqGhEgEPkRPQ5rRYP/ojyzoyBjxLCtBgYq776JqdyAA0kI3S5m
         +aSQ==
X-Gm-Message-State: APf1xPAJQmySogui1cmDfN4Qf4audyQ8iWfItEVgwmVMZ7kocHVqAvi+
        DYrRzfhbcOhtRMWAHz/jItIKAw==
X-Google-Smtp-Source: AG47ELtboiUC6IO3xxDTp2fjYXXu+2cmsevp5hmTRYh31pUjUZQRiJdBlYdaZlfZnc5xSJ6X+TeHfA==
X-Received: by 2002:a17:902:4001:: with SMTP id b1-v6mr13409256pld.28.1520275730794;
        Mon, 05 Mar 2018 10:48:50 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id m1sm3039277pfi.80.2018.03.05.10.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 10:48:49 -0800 (PST)
Date:   Mon, 5 Mar 2018 10:48:48 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 11/35] test-pkt-line: introduce a packet-line test
 helper
Message-ID: <20180305184848.GA162172@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-12-bmwill@google.com>
 <CAGZ79kbrm2Ei=spoDbjrwVFoF+mi0AAsXNLDBgCozFVoXM6+1w@mail.gmail.com>
 <20180223212231.GC234838@google.com>
 <20180303042558.GB27689@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180303042558.GB27689@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02, Jeff King wrote:
> On Fri, Feb 23, 2018 at 01:22:31PM -0800, Brandon Williams wrote:
> 
> > On 02/22, Stefan Beller wrote:
> > > On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:
> > > 
> > > > +static void pack_line(const char *line)
> > > > +{
> > > > +       if (!strcmp(line, "0000") || !strcmp(line, "0000\n"))
> > > 
> > > From our in-office discussion:
> > > v1/v0 packs pktlines twice in http, which is not possible to
> > > construct using this test helper when using the same string
> > > for the packed and unpacked representation of flush and delim packets,
> > > i.e. test-pkt-line --pack $(test-pkt-line --pack 0000) would produce
> > > '0000' instead of '00090000\n'.
> > > To fix it we'd have to replace the unpacked versions of these pkts to
> > > something else such as "FLUSH" "DELIM".
> > > 
> > > However as we do not anticipate the test helper to be used in further
> > > tests for v0, this ought to be no big issue.
> > > Maybe someone else cares though?
> > 
> > I'm going to punt and say, if someone cares enough they can update this
> > test-helper when they want to use it for v1/v0 stuff.
> 
> I recently add packetize and depacketize helpers for testing v0 streams;
> see 4414a15002 (t/lib-git-daemon: add network-protocol helpers,
> 2018-01-24). Is it worth folding these together?

I didn't know something like that existed! (of course if it was just
added this year then it didn't exist when I started working on this
stuff).  Yeah its probably a good idea to fold these together, I can
take a look at how your packetize and depacketize helpers work and add
the small amount of functionality that I'd need to replace the helper I
made.

> 
> -Peff

-- 
Brandon Williams
