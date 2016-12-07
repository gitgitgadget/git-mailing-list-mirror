Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A5E1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbcLGWl7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:41:59 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35431 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbcLGWl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:41:58 -0500
Received: by mail-pf0-f177.google.com with SMTP id i88so79153747pfk.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xVU1pSL34+YwhL/u4JHorsys3oLrcV9clY9mR1nz1Mo=;
        b=aezB2Vfw5uoq+0YZgDgLLHhp/qvhKLIdX3gBr+x36tYKm6k/tZVviob0otpihMgOnV
         neest57uLGBKL5FtdLk5OWMAZYLpJk3hTTGGB4Y/8bVXK1ED95yICRxaA2lgw9x1LDry
         rS4Bv8x8az3jSCpC8IDzOXmP2Qln9ReXCnTaHP34drSJswn+ruuJdGNKpCclSNOtMgny
         ZDPE8Ls2mfz3Nzu7oCT3+v5G1IXZtujhnw4H5hTQ13tVX/+gvECXOjo5RRBARNPLeY5w
         tTdfLzicsHqKYvnFZyTiDJriVTBSdKtwikcp3NDe+Poa9Nugc+AEsrqZNqUa2+mwz5wr
         jq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xVU1pSL34+YwhL/u4JHorsys3oLrcV9clY9mR1nz1Mo=;
        b=IjzEowUzP0i5bSO+3vMQkzHHX8nSyB1SM/3wTvowBmcgsNHS/aFrdek/8LUjdhcGjk
         myWLy5oqg3iA7J7C1e8qAJUrxhOSHk+gSlycz4NjmCGjPMzyOLUqgZfagM0LzzPezZ+S
         fi/ww7ZJaAENuNfFDFENuiRNEBpBkuEuGM+vHLqyzxrOIIgRQlkteAWWbfq77Dpemt6J
         DZCKjKRUYBF5eHtZ6Zgp4GM0rCQSPDguDToNYHMVLUA72WwKJ61W8pfzesc6VrPJjn1p
         a7P5/3BuNyZIGmD9miHH68NZB0N+PIC1pLkOo8C7v5+sjIiUMkUj3fbrs+yfQ6AM1Aye
         vzHw==
X-Gm-Message-State: AKaTC00KFMRjQsBL05nrXzPLJ6rJEAunWeo0v0MgCG5njh2xjrJT/amgAKZbfW5pGezDh7Wi
X-Received: by 10.84.196.164 with SMTP id l33mr152337886pld.150.1481150517796;
        Wed, 07 Dec 2016 14:41:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id 16sm44887612pfk.54.2016.12.07.14.41.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 14:41:56 -0800 (PST)
Date:   Wed, 7 Dec 2016 14:41:55 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/17] pathspec: always show mnemonic and name in
 unsupported_magic
Message-ID: <20161207224155.GF116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-10-git-send-email-bmwill@google.com>
 <CACsJy8CKY5wb+0KzpincHLiYwC0za9Wexo9QvNedcQTGc+ZRDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CKY5wb+0KzpincHLiYwC0za9Wexo9QvNedcQTGc+ZRDw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Duy Nguyen wrote:
> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> > @@ -413,10 +411,9 @@ void parse_pathspec(struct pathspec *pathspec,
> >         prefixlen = prefix ? strlen(prefix) : 0;
> >
> >         for (i = 0; i < n; i++) {
> > -               unsigned short_magic;
> >                 entry = argv[i];
> >
> > -               item[i].magic = prefix_pathspec(item + i, &short_magic,
> > +               item[i].magic = prefix_pathspec(item + i,
> >                                                 flags,
> >                                                 prefix, prefixlen, entry);
> 
> The final output looks a bit ...um.. strangely tall, with the first
> two lines that have one argument each, then the last line comes with
> three arguments. Maybe put 'flags' in the same line as 'item + i'?

Yep you're right, it does look a bit funny.

-- 
Brandon Williams
