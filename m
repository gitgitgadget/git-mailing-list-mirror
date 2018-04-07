Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56EC31F404
	for <e@80x24.org>; Sat,  7 Apr 2018 00:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeDGA6l (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 20:58:41 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:44122 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbeDGA6k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 20:58:40 -0400
Received: by mail-pf0-f177.google.com with SMTP id p15so1898132pff.11
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 17:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NH5VO+p7r+rnHVqzP7qV3boqkamVxWzbF0Rv+Zc1Zao=;
        b=MqesyyOt4x8NcL5TmX6dVRva6grNKii9lin8p1R3HIlkC0Pn6UDRQrFQmeF28DxBqZ
         dVGrC9Ff2Myj7AdNPa2jrXBceFFRn9Flxp4zo4s87jRbGmdrFFaVe9IIFvPO6DYubFgP
         32kwdjpPuONfVMmEGtbQtYUHXnXXEK4I6m6c/UwRg/ovQDK2alqa61zqW1DP/d51erb1
         GFs1KBCSFjGAZkH35Y7L6+WcVoJ4syBSYhF1AX4cx54h0XRw2n1aMpxLp+9fBs8sHgUj
         PfGpoQaW+Z2OMtXvANwc8v5cgSVHtAhOoO3wvtPXEhY/YJJeI60kJV0tqXAz1NLbEMkA
         CI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NH5VO+p7r+rnHVqzP7qV3boqkamVxWzbF0Rv+Zc1Zao=;
        b=UdktXBMaECbVVP+GHg2pBr/0lyzRwNF476XMiAM43SNIaXxNzcW9mBy6B/Z8dOD6x5
         MsQMziDk9w9ufsiTM2cn6rm8O1hGcwtP/i+5krGzlc9sA0sBbP7h4UuvXrWR4fAMlUIO
         Knvpz0wsS0T/Ue6WQbpWda9RNPAZJuKZ7BekqOHg3c37A3CWkjAdv4P3hvvPG9gjxCNX
         PQv02DHNDVOV75jWa6D3H4QCAbh3g5YWZafH6m2L+FYYpjUUba3Mx24l9lpGlvs8Imz4
         Z5X1wwXQm5VEcfFmuxAtEMAaBUVy5ktsBBtqKg8a441qwC2plIS5yigICbP8Bc8ZUmDi
         9kCg==
X-Gm-Message-State: AElRT7FwDAiqs4oluXe8qeknFJbmyzMKYFwZ0C3VYtzJvGJwD/xo7XGs
        ibUA+3p8cNL5dX+ebomNFXG9oQ==
X-Google-Smtp-Source: AIpwx4/YzjqLra0TdnkqcnwOH5XjqVQUl9rLQLcCmz8yCW+/EM+FRJyNwbU2GBnaeXM0xNQtJPRh5A==
X-Received: by 10.101.90.203 with SMTP id d11mr18862170pgt.20.1523062719646;
        Fri, 06 Apr 2018 17:58:39 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec81:e7e6:a4ca:eef6])
        by smtp.gmail.com with ESMTPSA id w12sm21653603pfi.180.2018.04.06.17.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 17:58:38 -0700 (PDT)
Date:   Fri, 6 Apr 2018 17:58:37 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/3] builtin/config: introduce `--default` 
Message-ID: <20180407005837.GD78042@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <cover.1522996150.git.me@ttaylorr.com>
 <20180406063013.GB662@syl.local>
 <CAPig+cRKaxECLHb1id6Mcd0O3uOiDzdGB4ZxPt1UpwUDi9Xb+g@mail.gmail.com>
 <CAPig+cRrz_Reb1CJN0u1LSQ38LjED+tuBAT=RT5rESfJ05absg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRrz_Reb1CJN0u1LSQ38LjED+tuBAT=RT5rESfJ05absg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 03:40:56AM -0400, Eric Sunshine wrote:
> On Fri, Apr 6, 2018 at 2:53 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Fri, Apr 6, 2018 at 2:30 AM, Taylor Blau <me@ttaylorr.com> wrote:
> >> +test_expect_success 'uses entry when available' '
> >> +       echo bar >expect &&
> >> +       git config --add core.foo bar &&
> >> +       git config --default baz core.foo >actual &&
> >> +       git config --unset core.foo &&
> >> +       test_cmp expect actual
> >> +'
> >
> > If you happen to re-roll, can we move this test so it immediately
> > follows the "uses --default when missing entry" test?
>
> One other issue. If "git config --default ..." fails, the --unset line
> will never be invoked, thus cleanup won't happen.
>
> To ensure cleanup, either use:
>
>     test_when_finished "git config --unset core.foo" &&
>
> earlier in the test (just after the --add line) or use the
> test_config() function to both set the value and ensure its cleanup.

Neat. I wasn't aware of 'test_when_finished'. I think that I prefer the
explicitness of 'test_when_finished "git config ..."' over
'test_config()', but I am happy to use whichever is preferred. Since
t1310 is new, there's no historical precedent to follow. Please let me
know if you have a preference one way or another.

Thanks,
Taylor
