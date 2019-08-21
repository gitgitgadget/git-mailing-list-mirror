Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0AB1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 14:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfHUOwT (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 10:52:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35621 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfHUOwS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 10:52:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id k2so2352105wrq.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PzGYxAtCIl1sy/qq7+uAc/reQaMulJFQHx2q1anXsZ8=;
        b=uQGyIj4lDW/lvxP+JLEI/iGGpAjQMRQiuV/h2AYj29R8dXXhrdcic4ibxk/7m9ndmu
         oMC7NzBfOvcOvU7QFjnmsCvydezdtKXP8cI73bwhN1VKG0x485SAoFGW5xb4ZC9HpWMg
         hZdQr+DhMyAVrEcxtmQieLy+uI25/tvzOw35ZpM+M7Lo5PEtpAJnEzOIpmGl9QOr/NQk
         tpEv72omjEh7JvRMWoUicujcI7BtT4j/YbInmtBbjmJSNUHMZBz6euCDcyqyPtU0T5Gf
         XatKOwPq2LxYnz4VCIEpfS2DJeHs2oWFC+9mFwyB3Jottt6+41Sblyf1kjtgoQmzlsP0
         3OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PzGYxAtCIl1sy/qq7+uAc/reQaMulJFQHx2q1anXsZ8=;
        b=KW76PiPSJMsDGvYTcu9kQnz50eW8xoaYqBnOGaPclR9eleIWzyxRHm2FLm9SA42hB2
         EtrG/k+s6onjZEVPWRPhsMUgfiEkXutuqwpVxCwEU5xE12GnrdUyhf9zLG0K9w/Ic8J4
         LXvUg/LufISSJiZtLVIy2wZnvmal3IuCJfaFExNkP8pK8MDp1xbd04voPsy3y0sjeLwr
         Xv6YQAC6BJDshaEDnmaEeIcFsJ2y8w9eRZraBzfqghNTeqwkQbO/tlp+47azm56dw3kE
         tVuezeY2/eFwpPF7G6nEYSaJ0BBEYJ95ODuVlyVdPpETkHYMXMD13DMgMKRlPN0CkY46
         pHBw==
X-Gm-Message-State: APjAAAUwy9Ew6FdFVHTJXCSTVhk1jpNNzNTLl7/SIvJNe0ROFL4mUzWs
        dn+xeA8wHxzWt7sjSiA7CzQ=
X-Google-Smtp-Source: APXvYqxip9QVCdRbX1Z/MugLtdx8jLwrT4kz2TDJTgM/imdW67sStcU8+//7BOf5/lJuxgH1OMKCIA==
X-Received: by 2002:a5d:4b83:: with SMTP id b3mr41385283wrt.104.1566399136704;
        Wed, 21 Aug 2019 07:52:16 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id p10sm317383wma.8.2019.08.21.07.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 07:52:15 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:52:15 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        johannes.schindelin@gmx.de, larsxschneider@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH] t0021: make sure clean filter runs
Message-ID: <20190821145215.GA2679@cat>
References: <20190820065625.128130-1-t.gummerer@gmail.com>
 <xmqqlfvnvhpl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfvnvhpl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/20, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Fix the test by updating the mtime of test.r, so git is forced to
> > check the contents of the file, and the clean filter is run as the
> > test expects.
> 
> Hmph, depending on the timestamp granularity, with this patch,
> test.r would have mtime that is the same or a bit later than that of
> the index file.  Is it sufficient to really "force" Git to check the
> contents, or does it just make the likelyhood that it would choose
> to check a bit bigger (in other words, are we solving the race, or
> merely making the race window smaller)?

This test only worked until now because git checks the contents if the
mtime of the file and the index are the same.  This is because of
racy-git.  I tried to describe this in the commit message, but looks
like it wasn't clear enough.  Do you have any suggestions on how to
make it clearer?

It will also check the contents if the mtime is greater than the
timestamp of the index, so the 'touch' here would also cover that.

So the changes here do solve the race completely.

> Thanks.
> 
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  t/t0021-conversion.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> > index e10f5f787f..66f75005d5 100755
> > --- a/t/t0021-conversion.sh
> > +++ b/t/t0021-conversion.sh
> > @@ -390,6 +390,7 @@ test_expect_success PERL 'required process filter should filter data' '
> >  		EOF
> >  		test_cmp_exclude_clean expected.log debug.log &&
> >  
> > +		touch test.r &&
> >  		filter_git checkout --quiet --no-progress empty-branch &&
> >  		cat >expected.log <<-EOF &&
> >  			START
