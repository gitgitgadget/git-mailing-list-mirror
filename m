Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6EE1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJQG0I (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:26:08 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:45180 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJQG0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 02:26:08 -0400
Received: by mail-ed1-f46.google.com with SMTP id v18-v6so22942818edq.12
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 15:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s/rvNy3xFwMSaJD3WJOdPjq70eYY2rrQGiMW1x8iUBc=;
        b=C/fe5ERDxvW/HQowiQcPOtKHqzC9W2z9fW/sMF3S5EfpSWoXrmy3JZY2FZDFmsg8/Q
         2XyGa+J+El+rFv8XbG0hUE7v2FRIRFRmTuuZc2mR8/x1UKhIH9jqbX2lwWV0V+pdWl9W
         RqcIQjaqwdh/jy8luwMe/fwMlA/osvVIA3pte/IpHMt9S/h7yBvJPL1IJxc5DeM96blp
         21LIzpFGqnnFR3pcMMrNLPRWboNwt9jqqnfnnseiGX/kfzSt9eSNiEU46PHUH8lBHPql
         HN2USsK8W8q/bWeai0TkPbwTWFqkybCBZ31yKJWFCYkX5WWvr85MdilhgdIoCqZwH6LX
         SSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s/rvNy3xFwMSaJD3WJOdPjq70eYY2rrQGiMW1x8iUBc=;
        b=ecMWKP7EXi95FnZ2sWCSNuN+ZPCqV5mRS2i7cm3TgHfPnb6OFwVMV3nFyzNZEnySND
         sAUYfDQ5oRlUNozRCjH3SKbi6MO62ADFyPIriI/oPq7gA6c8xtK1IdCFLo4PtLvjZN0+
         B4KB68Utoah3uJcnXLBWVeYJl3KpMgixZXsu+zQqIGCzxmEQ6je1pxVzRgPh7l7soXc6
         xEQXiKLMAmBANogae2u7oZx5ZzrP0AwRg+AWxIolXM37P/hBWdT+gwYRBCU+Jj4Q/BCh
         xWVdA/jtTu6IlHBN5h5np8q6VM96EvGApWOBPUgjecS1s7tv4hCY9YAyVVDlfxRAp4/P
         8Gqw==
X-Gm-Message-State: ABuFfohHn8MJfhsxJEkKZQFgl5B4aUtJIjNdPLI6x/uH8NoaYI9pXjSq
        7ldO4rMc1mZXm5ZX/6mWsujcYgeS
X-Google-Smtp-Source: ACcGV60g6w9dUZNKA11iv1GEGPva4FNCLwD3luc4WHvlBz3lkTIZxPyy8g/my9r6/pF/N4MpoQp7nA==
X-Received: by 2002:a50:af61:: with SMTP id g88-v6mr33604909edd.220.1539729214326;
        Tue, 16 Oct 2018 15:33:34 -0700 (PDT)
Received: from szeder.dev (x4d0caaf1.dyn.telefonica.de. [77.12.170.241])
        by smtp.gmail.com with ESMTPSA id a27-v6sm6470779edc.46.2018.10.16.15.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:33:33 -0700 (PDT)
Date:   Wed, 17 Oct 2018 00:33:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: On overriding make variables from the environment...
Message-ID: <20181016223330.GP19800@szeder.dev>
References: <20181016184537.GN19800@szeder.dev>
 <20181016215456.GB96853@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016215456.GB96853@aiede.svl.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 02:54:56PM -0700, Jonathan Nieder wrote:
> SZEDER Gábor wrote:
> > Our Makefile has lines like these:
> >
> >   CFLAGS = -g -O2 -Wall
> >   CC = cc
> >   AR = ar
> >   SPATCH = spatch
> >
> > Note the use of '=', not '?='.
> [...]
> > I'm not sure what to do.  I'm fine with updating our 'ci/' scripts to
> > explicitly respect CC in the environment (either by running 'make
> > CC=$CC' or by writing $CC into 'config.mak').  Or I could update our
> > Makefile to use '?=' for specific variables, but:
> 
> That's a good question.  I don't have a strong opinion myself, so I
> tend to trust larger projects like Linux to have thought this through
> more, and they use 'CC = cc' as well.

I don't think Linux is a good example to follow in this case, see e.g.
6d62c983f7 (Makefile: Change the default compiler from "gcc" to "cc",
2011-12-20) (in short: Git is supposed to be buildable with compilers
other than GCC as well, while Linux not really, so they can hardcode
'CC = gcc').

Also, the projects I have on hand usually have 'CC = gcc' hardcoded in
their Makefiles, too, but those Makefiles were generated by their
./configure script (which in turn by ./autogen.sh...), and those tend
to write CC from the environment into the generated Makefiles.

