Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840A320966
	for <e@80x24.org>; Sat, 25 Mar 2017 21:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbdCYVa0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 17:30:26 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34228 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdCYVa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 17:30:26 -0400
Received: by mail-wr0-f181.google.com with SMTP id l43so12551771wre.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2v4dk0m8hN9JmKQ18Z3shwOukB1yWFvXQIlD9npzeOE=;
        b=ujWAG5Mm8PlBGcVor0Z/tBuECVcsNmdw80/xfWE4ozNaqNm/xGrFBJcfr4+/YsNLxk
         s0zjmhNVqlu2QcEXeSaTbrgoUNClBUFjlPvl4osP6mn3+Y+QJbFmoGWSPt5JFqzjqG3Z
         7Ox0b1SkE4Qf5m69fJSCYJbu8WTEU/E7H2hY10V4GC0jSkPLCEVzcW2GBwxo9DoJVGOt
         Lfa7itsmI5lWbVmvyyrKPf4O9q4d3OXoMpu+QZ6JcHrhWyqnz6UIKWcGmOwNTEZAgiHD
         WP0DmNVl38g/J5gcM419gPP50//qfXS6dKi4rmCrCK/mOAYq1rWyRWVGPYLtpOF0fTRN
         GBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2v4dk0m8hN9JmKQ18Z3shwOukB1yWFvXQIlD9npzeOE=;
        b=G+3B4Te3gh41fts/HAl1pNvAAhJc4WE9slFxI655N29Z+JS0ELYGYenwPP6f6x6L+D
         0eSqBZl59X7wgb/ZOSSsI0CIH8JUKOkszlwyrrolyJCi1eC6J43eVSsIESWgXpecRhgU
         eYCEPXooFYbrOjmz/cQ6JzCp7/1VRCI1ajp3cMt/4/f9G1/L8m4gSsox4vNqa2D+OSm3
         lQaDcK8fv+s0ydeVPeuSrMphUl8r+qQdJtIX7fFgi7pr8RTBMtCG8Pz/vAxNzSMNfqBY
         wb7ah3S8zIr/s4jU2wIednhgUqYFH8AGDDO+EyoGGPfs1NOYTU4aWS3O4eo51Ezm2XG6
         zj8w==
X-Gm-Message-State: AFeK/H2RpRh7R98aHAONbMANaWTNVmMnFXvbp9ZdxFnNsMgE7RaINb1hWQXzNYst2EavIA==
X-Received: by 10.223.139.152 with SMTP id o24mr13551895wra.61.1490477423600;
        Sat, 25 Mar 2017 14:30:23 -0700 (PDT)
Received: from hurricane.home ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id h3sm8415552wrb.6.2017.03.25.14.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Mar 2017 14:30:22 -0700 (PDT)
Message-ID: <1490477422.29662.3.camel@kaarsemaker.net>
Subject: Re: [PATCH v4 1/2] diff --no-index: optionally follow symlinks
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sat, 25 Mar 2017 22:30:22 +0100
In-Reply-To: <xmqqziga5lnn.fsf@gitster.mtv.corp.google.com>
References: <20170324213110.4331-1-dennis@kaarsemaker.net>
         <20170324213110.4331-2-dennis@kaarsemaker.net>
         <xmqqziga5lnn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-03-24 at 15:56 -0700, Junio C Hamano wrote:

> diff --git a/diff.c b/diff.c
> > index be11e4ef2b..2afecfb939 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -2815,7 +2815,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
> >  		s->size = xsize_t(st.st_size);
> >  		if (!s->size)
> >  			goto empty;
> > -		if (S_ISLNK(st.st_mode)) {
> > +		if (S_ISLNK(s->mode)) {
> 
> This change is conceptually wrong.  s->mode (often) comes from the
> index but in this codepath, after finding that s->oid is not valid
> or we want to read from the working tree instead (several lines
> before this part), we are committed to read from the working tree
> and check things with st.st_* fields, not s->mode, when we decide
> what to do with the thing we find on the filesystem, no?

Hmm, true. It just accidentally does the right thing because s->mode
happens to always match the expectations of this code. I will pass on
more information into diff_populate_filespec so an explicit check can
be done here.

> > @@ -2825,6 +2825,10 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
> >  			s->should_free = 1;
> >  			return 0;
> >  		}
> > +		if (S_ISLNK(st.st_mode)) {
> > +			stat(s->path, &st);
> > +			s->size = xsize_t(st.st_size);
> > +		}
> >  		if (size_only)
> >  			return 0;
> >  		if ((flags & CHECK_BINARY) &&
> 
> I suspect that this would conflict with a recent topic.  

Possibly. I used the same base commit for the newer versions as that
seems to be your preference. If there is a merge conflict, do you want
me to rebase against current master?

> But more importantly, this inserted code feels doubly wrong.
> 
>  - what allows us to unconditionally do "ah, symbolic link on the
>    disk--find the target of the link, not the symbolic link itself"?
>    We do not seem to be checking '--dereference' around here.

The implicit check above (which you already noted is faulty) allows us
to do this. So fixing the check above will also involve fixing this.

>  - does this code do a reasonable thing when the path is a symbolic
>    link that points at a directory?  what does it mean to grab
>    st.st_size for such a thing (and then go on to open() and xmmap()
>    it)?

No, it does something entirely unreasonable. I hadn't even thought of
testing with symlinks to directories, as my ulterior motive was the
next commit that makes it work with pipes. This will be fixed.

Thanks very much for the thoroughness of your review!

D.
