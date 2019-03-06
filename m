Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C5720248
	for <e@80x24.org>; Wed,  6 Mar 2019 23:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbfCFXov (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 18:44:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43636 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFXov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 18:44:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so9878273pfh.10
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3nAGycRmweI5vAhYczBVscAVxia0aMt34pSeUb6P0hM=;
        b=lGXPpYlB6uQqSdIg55SG/Wz6trFreYW+bmR0C7mu6hXjx3PrZzedT7EVm+uZyIaYNb
         wZaJ1Fj7WKbLvstn+trjv/5/QlUBx1hlEGCCR80VmDnwpYYVUf5g/KlDo16Y8Z9AuFtP
         I7qP/Pj8iPvXPwwUFWqHc515SVYuPS02TOHiDu2U6Nqf2IpYHHLidp9BOg6HCtVUiXAm
         kuMq1mPusJoxQXsYO78FSV6sFLLFa+yky2UOqwg9KtEy6TTI4r5Lv5pmDpN/PWmqNPmf
         aW90MtloYa15ips8y3LqQPYsn9nW9EDqcU6eDRPQgn+EXBd+Xqopqd2/dVihwZY42vP4
         Hw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nAGycRmweI5vAhYczBVscAVxia0aMt34pSeUb6P0hM=;
        b=Zde4r9CqYenr5E4UtFPZOyy/bHiPg93QbA8jtFQmLclAQ6EeVkrhxf+cm+nDQjV9p4
         H2+mek7OoBBWCgooENsLARWpa8sqvYmh+te7ouHPZt4/SJ4T5x5EEi2Mux4tli9bNrrK
         KXZrfuutd56DuxeXqt+bXKDXOyTH25fdmMfMUB4KM5PmIiTYWh1BIfBDJZO+nD48RC6o
         xozbEXIy8qHpJmuHgXiYx7TokS44O5k6CEOGlvLNDcORQEA9MaDvLoKFKyN+PMtlPBvH
         H1tx0OFGUocaV8mk8ToaYM2K5WLpv6J7MZdMrH+hmZy5hPBFI8HoIJBqWmM9RmJTHWZS
         pyqA==
X-Gm-Message-State: APjAAAUsKb5aKLGTFYeiVuXgxxBF5EFNduiMAzo0QawQr+jssE47e1mH
        fHcLw3ltjEkCrcqs/9L30J6Zfw==
X-Google-Smtp-Source: APXvYqwUy3REud4n+qU/bASrP2phNHrQQcKONhFVQLKx0LPztIY3Vj/8+AUCYS0Tf5PK+VWeKI8slQ==
X-Received: by 2002:aa7:8508:: with SMTP id v8mr9799722pfn.14.1551915890292;
        Wed, 06 Mar 2019 15:44:50 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:44e5:978c:280e:8d47])
        by smtp.gmail.com with ESMTPSA id n15sm3930952pgc.92.2019.03.06.15.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 15:44:49 -0800 (PST)
Date:   Wed, 6 Mar 2019 15:44:49 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
Message-ID: <20190306234449.GF27082@Taylors-MBP.hsd1.wa.comcast.net>
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
 <nycvar.QRO.7.76.6.1903022123160.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903022123160.45@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Sat, Mar 02, 2019 at 09:25:28PM +0100, Johannes Schindelin wrote:
> Hi Taylor,
>
> On Fri, 1 Mar 2019, Taylor Blau wrote:
>
> > [ ... ]
>
> This should do the right thing if you write
>
> 	printf "<RED>" >expect
>
> instead?
>
> Ciao,
> Dscho
>
> > +	printf "\\033[31m" >expect &&
> > +	git config --get --type=color foo.color >actual &&
> >  	test_cmp expect actual
> >  '
> >
> > --
> > 2.20.1

Thank you for your suggestion. It occurred to me that this might be a
preferable way to do things[1] after I sent the patch, but I am glad
that you suggested it here explicitly.

That said, I think that this patch has moved on from the code change,
after some discussion between Junio and Peff, so I think that I will
leave this (and the rest of the code changes) behind.

Thanks,
Taylor

[1] ... preferable in the way that we don't have to write "\\033[31m" in
    the test.
