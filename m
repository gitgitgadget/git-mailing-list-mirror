Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 275F72095D
	for <e@80x24.org>; Mon, 20 Mar 2017 10:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754414AbdCTKut (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 06:50:49 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36603 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754391AbdCTKuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 06:50:39 -0400
Received: by mail-wr0-f193.google.com with SMTP id l37so17437638wrc.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pY1VSKMp6TfxQRs6Px8cKIeSFvVDNVXx9DRoXu3NlDY=;
        b=LWi6QLV225IdqbNq8+9ObicQYIKf4FtiiszwQKn0gcJzFDZJoeYCEtqG3g+Fph7NBj
         ndBl7vrnaGkEK3Qb7f4J8U330u6YhNxtAG6ydgdVSnxyfa/9+/aZAGZHJeBE8GfZRkuh
         Pjj9rAU0JX8aTF2RzFSRcr3XtyH94iMAZHN9AH4ZORkRyRtYIB8IuKf01WJoAHH8gZo2
         AcbDehbf7HuNF04f7x9grD5Ix8jxMbN/QLsspP1FnUxeofxq72Jilpi1o4Ipme00Hv2O
         33Qm8TXWek9hTG3vWKlwaoGqPUwjSQAycDc/w6og0Hhv7GcjyIKtHsrzfkGDcaQiYSKx
         1tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pY1VSKMp6TfxQRs6Px8cKIeSFvVDNVXx9DRoXu3NlDY=;
        b=O/10Vo5mjTzVqL+qON6+4XRho/XuwcYVCgNY1sRxwt+fwInP2aBg/jicMXQ5cYTrad
         Y3VnLnDrwiEuvKPdUSSj+OSvaQtKi2qM8d5Vv3hnIQdHudV2CX4a5LSc8twEORiccLim
         Iy1b1JyDFdih8EROU6qpx6buxFC9ju8l1yCJi/pc0zA2IvGS06yVBa9mvPAAduCbmBCp
         wME2uOiVBoPIS7C1VXvTovTIDmymHAghhJFtYzGKf8JmQfumIwOj5vX/6nB1Fcat+v2j
         dAZuXcqJoHKd+cxMTKeBUIYdYVp4950k7uRFGGq1oR0RNEGpTCzEpAsd21mdYXxmCXKU
         Tglg==
X-Gm-Message-State: AFeK/H2PSGjbsRAkZd4GZHFj/XsdN81xsaViMwiKbX0H1SRmbXISXjkS6bhaSz72ltPfGA==
X-Received: by 10.223.135.47 with SMTP id a44mr26972584wra.197.1490007037112;
        Mon, 20 Mar 2017 03:50:37 -0700 (PDT)
Received: from seahawk (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id x23sm20468944wrb.49.2017.03.20.03.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Mar 2017 03:50:36 -0700 (PDT)
Message-ID: <1490007035.15470.14.camel@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] diff --no-index: optionally follow symlinks
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Mon, 20 Mar 2017 11:50:35 +0100
In-Reply-To: <xmqqk27kzzfm.fsf@gitster.mtv.corp.google.com>
References: <20170318210038.22638-1-dennis@kaarsemaker.net>
         <20170318210038.22638-2-dennis@kaarsemaker.net>
         <xmqqk27kzzfm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-03-19 at 15:14 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > diff --git a/diff.c b/diff.c
> > index be11e4ef2b..2afecfb939 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -2815,7 +2815,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
> >  		s->size = xsize_t(st.st_size);
> >  		if (!s->size)
> >  			goto empty;
> > -		if (S_ISLNK(st.st_mode)) {
> > +		if (S_ISLNK(s->mode)) {
> >  			struct strbuf sb = STRBUF_INIT;
> >  
> >  			if (strbuf_readlink(&sb, s->path, s->size))
> > @@ -2825,6 +2825,10 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
> >  			s->should_free = 1;
> >  			return 0;
> >  		}
> > +		if (S_ISLNK(st.st_mode)) {
> > +			stat(s->path, &st);
> > +			s->size = xsize_t(st.st_size);
> 
> Doesn't this affect --no-index mode?  We never need to do a wasteful
> stat() after lstat() and we are penalizing the normal codepath with
> this change, no?

the S_ISLNK(s->mode) conditional above is for the normal codepath,
which returns early. So the stat I added is only done for symlinks in
no_index mode.

> > @@ -3884,7 +3888,11 @@ int diff_opt_parse(struct diff_options *options,
> >  	else if (!strcmp(arg, "--no-follow")) {
> >  		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
> >  		DIFF_OPT_CLR(options, DEFAULT_FOLLOW_RENAMES);
> > -	} else if (!strcmp(arg, "--color"))
> > +	} else if (!strcmp(arg, "--dereference"))
> > +		DIFF_OPT_SET(options, DEREFERENCE);
> > +	else if (!strcmp(arg, "--no-dereference"))
> > +		DIFF_OPT_CLR(options, DEREFERENCE);
> > +	else if (!strcmp(arg, "--color"))
> >  		options->use_color = 1;
> 
> Also shouldn't be some code to detect --[no-]dereference options
> given when --no-index is not in effect and error out?  As the patch
> title says, this change should be a no-op for normal codepath and
> only affect the no-index hack.

But erroring out isn't a no-op. With the current patch you can do 
--dereference without --no-index and it simply wouldn't affect
anything. 

I don't mind either way, so I'll make it error out.
-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
