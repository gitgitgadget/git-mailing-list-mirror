Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315991F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfKDUgE (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:36:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46204 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDUgE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:36:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id 193so11926452pfc.13
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FIi+8yj5nBtFV49T2mVmlAqRN65XmcizN0oIygNZ+UA=;
        b=lMr9Q5RFGf+9ez9JrZdVo6ia11XPpr/H99KCcGt9M59ZeOMZ9aOu7PGATBD46mBrBP
         GWXvsM8adlvKKFTN5zTEdhMZyAecym6ZdAXnja6l1z9KmE02EkjkQPZklILQyQiISo3b
         2mnfuhidHgmV+sod/cDI2gjY9eGOIfDJQhUOlTc2Xx4ei+ke7k8rkNE7gLj9qhU8UkAv
         0+Ohfjmyy4CvyPn9FiVgFEqpVt33r5sG8NKgGLl7EzytW9/zwjGMVLwpYXBVaWXhezaH
         KxYgeLLgxEUkTOqP3br7WhXNV8K++ZFDSbeLV35j+lfHOoqnnXrZ+3/VjcMKVflKSlhX
         0bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FIi+8yj5nBtFV49T2mVmlAqRN65XmcizN0oIygNZ+UA=;
        b=nUicZ6PG0qkF5Nl1z4l/mH4efmL1knD/P0rSRapbgfgOFWIVOBLucX/ligSTIX0jfs
         wNlF6MiONvxStIh/2cQGYsoEgaELvA5QXQXdJY4J762/qvK9U++8aGIwxLA/u6cJ46s3
         pDzB6Rrk2laVbHFI/tw5Rd07IuIVhNjQVttImJER9OpJJdcmo0IM07fhKHvnZ95iMNw0
         ODZzrAsAjWNho7sROC43unM/Aj953HIwNy43VffBgKzFPj/sheeH/JXWoftqL7J+797+
         KLw7tbqq0z/PyCxsRSiWdBDLvBtSeRAoZVYkoxalS/drHQOppg8EeAHs3BuR6jYVBx0p
         bhsg==
X-Gm-Message-State: APjAAAU/6npUatBzTTyu+hqWBmVmmopWUvPBTYuXyA5RGFBn5gdV088N
        jLmHtTr7wcCedHUkn1VPFO40U+Ct
X-Google-Smtp-Source: APXvYqzqYmTOaKtBq20Y+lyse0CCyRhS90Gt0kSQGurhd5SILfqswsKHPZuOWLq6sD5+gJb8SYTAvQ==
X-Received: by 2002:a63:ed43:: with SMTP id m3mr5009028pgk.261.1572899762464;
        Mon, 04 Nov 2019 12:36:02 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id y4sm10694907pfn.97.2019.11.04.12.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:36:01 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:35:58 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 7/8] pretty: implement 'summary' format
Message-ID: <20191104203558.GA8004@generichostname>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <64b6f7c9d7434ba39929220c1aebcd9a1fd0ad6e.1572897736.git.liu.denton@gmail.com>
 <CAPig+cRVgf3q6-mHeMgOThCrhseTGtYt+S6x1ikUSEKGbUTz4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRVgf3q6-mHeMgOThCrhseTGtYt+S6x1ikUSEKGbUTz4g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, Nov 04, 2019 at 03:16:56PM -0500, Eric Sunshine wrote:
> On Mon, Nov 4, 2019 at 3:04 PM Denton Liu <liu.denton@gmail.com> wrote:
> > diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> > @@ -63,6 +63,15 @@ This is designed to be as compact as possible.
> > +* 'summary'
> > +
> > +         <abbrev hash> ("<title line>", <short author date>)
> > ++
> > +This format is useful for referring to other commits when writing a new
> > +commit message. Although by default, '<abbrev sha1>' is used, this can
> 
> Why does this talk about "sha1" when patch 1/8 removed references to
> SHA-1 in favor of generic "hashes"?

Good catch. 1/8 modified pretty-formats.txt but this message references
the content in SubmittingPatches.

In a future reroll, I'll submit a similar patch as 1/8 but targeting
SubmittingPatches instead.

Thanks,

Denton

> 
> > +be overridden with '--no-abbrev'. In addition, '<short author date>' can
> > +be overridden by with '--date='.
