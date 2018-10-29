Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454FB1F456
	for <e@80x24.org>; Mon, 29 Oct 2018 14:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeJ2Xmj (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 19:42:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34350 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJ2Xmi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 19:42:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so9733538wmg.1
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rh8cdy87GKdJlNjO80di454+XxRHnJy2bfW/EkVVfJA=;
        b=Cw4XcVyfdhMwzu4PPufcb7LxAXjnwJoY+zCRqieOxCijx5DHGTFpnj8yzy6o6Vb2+A
         ggdljLINmoLo1pGedjBBzTn/4f3akYc08W92YoT1Eu3LEYpgTOKfq7buqKePI3Ngm1PX
         Q8ZqAVUdyNy0mT6eF0dws2HvXS925VUfOCeM7Wo1s36iQ49cg3OngSQX2i8QLTp56H6N
         ws/1vPTDPokZNL5m8c9lEsEsvC2aiJMEM1SMRhQEHvMfoUSeiZGqjcMBIsuAVi5OVa+R
         QXu8tC+a5KJPAwp5TAotb3mQoJOOBF+gf4ajcHnjKkrMxAYel659JmZAvU+L03mDbKR3
         2fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rh8cdy87GKdJlNjO80di454+XxRHnJy2bfW/EkVVfJA=;
        b=Lo8/91h0jxLXIyLgzW1QzT/o/8XxgRLU0668xdPIAk0wO6v43VcnIoIqBQVTDcVGZT
         VKGKe+TN/MbaHTMYxYv6qIM2zdqT/yvrYVZIol9wRPLBI8NlDE0YZVoJzomdF+SRXOM/
         vFH/pIfvCdBIJb70PIEAV/WP5ratXbqn9yxrhQdEzy6OS2Wpzyuao68ubyepBX2TZ4h4
         6ekxfk8OpnF4S2tq0SQ51M+aWhkl0iAtHGBmBPnAxlUjIGRDzUifuekrVyMPDxAAr9AJ
         cbN6lm9oXp0hw71TP5alGtluXZvFDrEsi+x8uPkxcSfwP/WR5gxyIMhxM2Lkqee0CgtZ
         0x1g==
X-Gm-Message-State: AGRZ1gIoUUYdaHAwi1HsE8WtnSSvcrRo3pdz1FIIFdHggZsQVvS7ax/j
        +CXNB98MbIEdAN2nc4pK24M=
X-Google-Smtp-Source: AJdET5cojo+yT1KdEuEv8mQBEjefqn7nUfjLUlTa17SfAuJX02rRhjiu1hbreCJudYr/gWr/k6PgtA==
X-Received: by 2002:a1c:e102:: with SMTP id y2-v6mr13800734wmg.141.1540824818613;
        Mon, 29 Oct 2018 07:53:38 -0700 (PDT)
Received: from szeder.dev (x4d0c66d6.dyn.telefonica.de. [77.12.102.214])
        by smtp.gmail.com with ESMTPSA id j13sm11876470wrx.5.2018.10.29.07.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 07:53:37 -0700 (PDT)
Date:   Mon, 29 Oct 2018 14:53:35 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: introduce the '-V' short option for
 '--verbose-log'
Message-ID: <20181029135335.GS30222@szeder.dev>
References: <20181029121359.7323-1-szeder.dev@gmail.com>
 <20181029142108.GD17668@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181029142108.GD17668@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 10:21:08AM -0400, Jeff King wrote:
> On Mon, Oct 29, 2018 at 01:13:59PM +0100, SZEDER Gábor wrote:
> 
> > '--verbose-log' is one of the most useful and thus most frequently
> > used test options, but due to its length it's a pain to type on the
> > command line.
> > 
> > Let's introduce the corresponding short option '-V' to save some
> > keystrokes.
> 
> Interesting. I'm not opposed to something like this, but I added
> "--verbose-log" specifically for scripted cases, like running an
> unattended "prove" that needs to preserve stdout. When running
> individual tests, I'd just use "-v" itself, and possibly redirect the
> output.
> 
> For my curiosity, can you describe your use case a bit more?

Even when I run individual test scripts by hand, I prefer to have a
file catching all output of the test, because I don't like it when the
test output floods my terminal (especially with '-x'), and because the
file is searchable but the terminal isn't.  And that's exactly what
'--verbose-log' does.

Redirecting the '-v' output (i.e. stdout) alone is insufficient,
because any error messages within the tests and the '-x' trace go to
stderr, so they still end up on the terminal.  Therefore I would have
to remember to redirect stderr every time as well.

I find it's much easier to just always use '--verbose-log'... except
for the length of the option, that is, hence this patch.


