Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43621F45F
	for <e@80x24.org>; Tue,  7 May 2019 14:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEGOTq (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 10:19:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38988 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfEGOTq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 10:19:46 -0400
Received: by mail-it1-f194.google.com with SMTP id m186so1225683itd.4
        for <git@vger.kernel.org>; Tue, 07 May 2019 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vxHpSfD1S7JtnYPpj4saw+iL6jSfv0H1I3Srvu27tUs=;
        b=Bsgq468Ozo8yLQlyFuE1Hb70q4F4fM1ncR1WHXLe2mHEy7GEvgUSAyJaZvj7cu3M2d
         1HAaZv2j8LlbF+kAqPMbWAWUmwASa77kJHogDEVQ+7yTQCkNAKtoZPj+tx6viPthUu/h
         t9SbY8rwB96ylGF710O4TcAcRjSBQTLy09+eNiXRXzPzgbzvVSA8XCkyIlAdYpFXGkLS
         AtgbdD5QJXKVZaBLcU6fqeC19UgLh8c1hYqZzviFij0O4Zybjusk5y74jMgI0g0cSrWU
         tWxuVyiLsP2iDAGlCdBGHgxsqTB5Ij8+PLgplPuzDHGaJ13QzUWnzlOYPdVWneNWS8CX
         Wwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxHpSfD1S7JtnYPpj4saw+iL6jSfv0H1I3Srvu27tUs=;
        b=J0Mfvmjk/s7o2Exz9S5qQ1JRnvt2dBRDTtapjT0BsxcgEyMUkhrIszW3Jcnvum9Zp8
         aGRtn1JQtEMA7ZNqZhgwlxu4iGySi3ry99HVLiLiSrtc6mHpGZjxQSOKayTFktdgiRY6
         jzeixvB2OyNuKtp/z4P0I2xDASSeECxg/fYXNcxcKIG25sXBndoD1M5yGU3JLYdiv3pg
         4vKP6VSD20pSHMp1HiCguTl44VTkNgW0ZH923CaPOoN8K13SvdsUDJTx9rK3YdrJbb9o
         EkHCoLoCyCmdt/eLI9mEQnU6793QBOXdtcO6i5PRHrN5S1Z7YXhibdj7I+1Vh5LIx+gf
         U+Ag==
X-Gm-Message-State: APjAAAUOBWjiu1QECkV5RZ5K2hmP4QBLLRAYMQ3DSF72iuJYctiK6YO2
        xnK+Nc9xEAJi+SpA6eMtouE=
X-Google-Smtp-Source: APXvYqxdW66QlmfXRamFV9mkrKkKJAeeXPrYrYXpFwxDaE36N69R0m4sJgbJY73Z7PYld5vNOr57DQ==
X-Received: by 2002:a24:8583:: with SMTP id r125mr21879330itd.69.1557238785475;
        Tue, 07 May 2019 07:19:45 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:780:ed13:bfd5:1bea:adb7])
        by smtp.gmail.com with ESMTPSA id j16sm4811076iok.64.2019.05.07.07.19.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 07:19:44 -0700 (PDT)
Date:   Tue, 7 May 2019 10:19:42 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/7] teach branch-specific options for format-patch
Message-ID: <20190507141942.GA359@archbookpro.localdomain>
References: <cover.1557072929.git.liu.denton@gmail.com>
 <xmqq4l66myn3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4l66myn3.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, May 07, 2019 at 05:56:00PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
>
> > Currently, format-patch only accepts branch.<name>.description as a
> > branch-specific configuration variable. However, there are many other
> > options which would be useful to have on a branch-by-branch basis,
> > namely cover letter subject and To: and Cc: headers.
> >
> > Teach format-patch to recognise these branch-specific configuration
> > options.
> >
> > Note that this patchset[1] was created using these new configuration
> > options:
> >
> > 	[branch "submitted/fix-revisions-txt"]
> > 		coverSubject = "cleanup revisions.txt"
> > 		cc = "Andreas Heiduk <asheiduk@gmail.com>"
> > 		cc = "Duy Nguyen <pclouds@gmail.com>"
> > 		cc = "Junio C Hamano <gitster@pobox.com>"
>
> Do we have format.<something> configuration for these things?

Currently, we have format.{to,cc} but not format.coverSubject. The
reason why is that for the cover-subject, I didn't think that it would
make a lot of sense to have a general configuration for this since it
varies between branches, just like how branch.<name>.description does
not have a matching format.description.

>
> What I am trying to get at is if these are better structured similar
> to http options where http.<something> supplies the overall default
> for <something>, while http.<destination>.<something> gives a more
> destination site specific override of that default.  I.e. format.cc
> is used as fallback, while format.<branch>.cc is used to override.

The reason why I chose to use branch.<name>.* is because format-patch
currently reads from branch.<name>.description and I wanted to build on
top of that. In addition, I didn't want to scatter branch-specific
configs in two different place (i.e. have a branch.<branchName>.description
alongside a format.<branchName>.coverSubject).

>
> In any case, it smells to me that branch.<branch>.cc does not hint
> strongly enough that they are meant to affect format-patch.
>
>

Would you suggest moving to a format.<branchname>.* approach or would it
make sense to rename the configs to something like
branch.<name>.{emailCoverSubject,emailTo,emailCc}?

Thanks,

Denton
