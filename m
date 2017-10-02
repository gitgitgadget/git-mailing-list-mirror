Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8543920365
	for <e@80x24.org>; Mon,  2 Oct 2017 05:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbdJBFNj (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:13:39 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:45842 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbdJBFNi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:13:38 -0400
Received: by mail-pg0-f52.google.com with SMTP id 188so2443191pgb.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nb6c21y9jTddxCuYnGxwtzfXjJdeUKH5f1sDXccHNtE=;
        b=epfDIEkAaJf/ks55S9wYZmVkoNDnEl/5b3yIQGCh8QzQYZlTLGnL3XoIDYnG2mskP4
         lZOV8TBNH8y0nTEjUK5o2/6Dsht4mXnF6hRd7ltHBeiBCYOruLQETdYBbavKmgP/Ton2
         xYwf/PrGDCVwvuosu356nVFHJ49nb1+biyKn8mBRNqd4XqfvJcph9lE5WFydYP3wyZvP
         +fCGEw1h9WDJyfw61y8bVuXY5jTbXNfTNvfLPOFqV/zaAv/Hd2+j8NNs/RHs4iyZ5PrT
         NzERLPer6TBstsyjgKLIlvnnuS4mVXfQZhSroyfrwQORkX92D8hG3O9Hlnn91Vy6UBXY
         nVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nb6c21y9jTddxCuYnGxwtzfXjJdeUKH5f1sDXccHNtE=;
        b=VJw+nn5ghjO5j3OLcSIIVzmZa2gy8AKQC27UX9nfgOFZbPdHS83qIv7s0VM/9hrf2D
         B8RyChi/ytBIbCTJ8FR7ougpyoXwgEsY7ChHJXEsTg68GvEWan/I8+b9CFohfXlLkdP5
         O5+L3kkwyKR7YnqzEVn8zRB5LXjC28uwtiwRujI20ILHOv2VbeuA2GXr1qHaviRr6iUs
         ogBgjChrB9p96BGgQKmXVKWFX+Waj2kvuSVF/STQOy0EYYOgGlHoThLD25aRPQAEKyvI
         0GtvIFYRV5Se+hX+iIrQG3n0nOmKwku5h9zykPObKeRbj9qHShJy1O490xy0Rr07rdD9
         npkw==
X-Gm-Message-State: AMCzsaUcQSfXk4C8PSYxE4UFIy90URB9eOcSivsY/3636AiwnU4xGaFr
        s9NAAE9Wh9POB4UME/quz6lCfw==
X-Google-Smtp-Source: AOwi7QAqQiPg9DMYP4KbDSWLykky0d6dVw+DgxGWPJYtsEtorK5TO50EH5EnV5i4LE84vBC8bmIGBg==
X-Received: by 10.98.7.204 with SMTP id 73mr4267310pfh.210.1506921218378;
        Sun, 01 Oct 2017 22:13:38 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id e66sm14137687pfb.48.2017.10.01.22.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:13:37 -0700 (PDT)
Date:   Sun, 1 Oct 2017 22:13:36 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v5 6/6] ref-filter.c: parse trailers arguments with
 %(contents) atom
Message-ID: <20171002051336.GA7266@D-10-157-251-166.dhcp4.washington.edu>
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003304.77514-1-me@ttaylorr.com>
 <20171002003304.77514-6-me@ttaylorr.com>
 <xmqqk20ep2yo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk20ep2yo.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 01:51:11PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -212,9 +212,10 @@ static void contents_atom_parser(const struct ref_format *format, struct used_at
> >  		atom->u.contents.option = C_SIG;
> >  	else if (!strcmp(arg, "subject"))
> >  		atom->u.contents.option = C_SUB;
> > -	else if (!strcmp(arg, "trailers"))
> > -		atom->u.contents.option = C_TRAILERS;
> > -	else if (skip_prefix(arg, "lines=", &arg)) {
> > +	else if (skip_prefix(arg, "trailers", &arg)) {
> > +		skip_prefix(arg, ":", &arg);
> > +		trailers_atom_parser(atom, *arg ? NULL : arg);
>
> A parameter for the call is missing.  I think you want 'format'
> there.

Thanks for pointing this out. I have fixed this in v6, which I am
sending out shortly. I think that this revision should be ready for
queueing.

--
- Taylor
