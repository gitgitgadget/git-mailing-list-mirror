Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5472A1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 01:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753825AbeDWBLi (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 21:11:38 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:43088 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeDWBLi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 21:11:38 -0400
Received: by mail-pf0-f171.google.com with SMTP id j11so7820206pff.10
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 18:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e09KcrFB3j/UGy4B202Yv6N76rBmbVLNmckvvOALejw=;
        b=Sw1CV2CRgrT5Vy9GiBTD8c9yPdING/lbowazmzN4kasYOkEWMXCFkrtLbKqrQO0k/z
         53O0OicKujN7Vt9+bBqRR+hUhnkV4jzVbRWVVPBZZ+RtF1N8HUaB5/kO9UcDpWkuEW3z
         CXwYHd2yRvZ8B2rdiy0tLHTnOVnbTec2B6h05jb8Et18eDBcs1cYNjCvhW1l4YcXLa/t
         398IrzW0NWd9eKuwUiBS8UsMOAyTk8bB92DNm3cSr1ycjBYQyjY+6yk1/9QQ+2KY44Ec
         l6uooGpDQvg1tCYQyXj66DOrDBCCAvptQYDcGBc3GcWJDyE6A9x4q7En8TzZ6dyp1pQp
         usYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e09KcrFB3j/UGy4B202Yv6N76rBmbVLNmckvvOALejw=;
        b=tU9MU4T07IeS2MnysOYD8wmZe65AzbENgmOR5iqURAYmVx8/nMZMSzbRQ1aqrBmiTM
         6O4J/2AiXHj2eRljartnndVTIG8OJZiBwzwpYfsZT3gQrM15f/Q137Ht00P4gjlBJYPJ
         g6qiEfTtGYUpj5hj/kBokopN+VFEduAWmFEf+QUIVczetTE3djhibOGs+bf+lYKcv9qc
         5/wHILr0yz9/luYsX99aYplV1pR0fDrsTO1DXuNYf5PxvdAHQ3MPS3U/vzsydbgAvFVF
         fUIrBo1rusFlsmyeZHEFMEQ3JffMa8DED1bk9X5AGG4XBZzSF2zfQQMqJRJQLu5ndnsQ
         htZQ==
X-Gm-Message-State: ALQs6tCUird1F4mNthPzizqrjHrDzIHUdLPMVemyGJ/exsFETmVWh1dY
        OODR90AA8ClBBf0tI0IGB50ylw==
X-Google-Smtp-Source: AIpwx4+R7uuW2e7bSLhQuQa8BRHXJG3KhNlckC59DRQpkoRjO1FAAPlfxB+znvIKNcG0ApEXrGIZjw==
X-Received: by 10.99.114.14 with SMTP id n14mr15163093pgc.384.1524445897313;
        Sun, 22 Apr 2018 18:11:37 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id s20sm13636814pgv.14.2018.04.22.18.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 18:11:36 -0700 (PDT)
Date:   Sun, 22 Apr 2018 18:11:35 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/6] grep.[ch]: teach columnnum, color_columnno to
 grep_opt
Message-ID: <20180423011135.GA78148@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <47f06ae36ce6af48fca06b140bdb5af2582116e1.1524429778.git.me@ttaylorr.com>
 <87a7tuex47.fsf@evledraar.gmail.com>
 <20180422232447.GA48072@syl.local>
 <CAPig+cQXsU4cXLtZPA-C84DH+PzrgN7C8_A-NZE+6e5HoJEFCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQXsU4cXLtZPA-C84DH+PzrgN7C8_A-NZE+6e5HoJEFCA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 08:21:33PM -0400, Eric Sunshine wrote:
> On Sun, Apr 22, 2018 at 7:24 PM, Taylor Blau <me@ttaylorr.com> wrote:
> > On Sun, Apr 22, 2018 at 11:42:48PM +0200, Ęvar Arnfjörš Bjarmason wrote:
> >> On Sun, Apr 22 2018, Taylor Blau wrote:
> >> > In preparation of adding --column-number to 'git-grep(1)', we extend
> >> > grep_opt to take in the requisite new members.
> >>
> >> Just a nit: Makes sense to refer to these camel-cased in docs & commit
> >> messages.
> >
> > Could you clarify which? I am not sure if you mean --column-number,
> > 'git-grep(1)', or grep_opt.
>
> I think Ævar was referring to this bit from the commit message (which
> unfortunately got snipped in his review):
>
>     We additionally teach the 'grep.columnnumber' and
>     'color.grep.columnnumber' configuration variables to configure
>     showing and coloring the column number, respectively. (These
>     options remain undocumented until 'git-grep(1)' learns the
>     --column option in a forthcoming commit.)
>
> He was suggesting camel-casing 'grep.columnNumber' and
> 'color.grep.columNumber' even in the commit message.

Thanks for the clarification, Eric. I have amended my copy of this
patch to correctly case those variables.

Thanks,
Taylor
