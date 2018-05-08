Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88255200B9
	for <e@80x24.org>; Tue,  8 May 2018 00:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753665AbeEHAYm (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 20:24:42 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:41775 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbeEHAYl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 20:24:41 -0400
Received: by mail-pl0-f46.google.com with SMTP id az12-v6so1110157plb.8
        for <git@vger.kernel.org>; Mon, 07 May 2018 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TJyCFSOu5uKmOeoJQkjG4bcb515U9F0SytBbEJ+d4m0=;
        b=eQJHI2UyRbOaYdxNKT+CCg/FtUzzZh03ImXIsaa79CYrSkvnvXAoCPPp8mcqUcnE6s
         dPQ31WXig17Nqs0DB0JCtZTks39xLfloGB5ggVEaPaZtXrY9qPmmZvAtJzgS2IdUdeN1
         FNxiUmCfo5rLx4raO0ylp1ehTedhsxu9A7dHMNC15zxtuabW/Ecn+wJSF1R0g5vprW3w
         xbImN7gdyGieehjnTNrPj/jQbtxeyaMWDsx7kDYlD4yj1vC70NYbFm2kMClBrhDLwOD6
         3ZP7U314LWWzz3NvQVG75J+qdkXWOZXiRXY72gUybHCVhlior1sXMHXWk+ioNnXvhHk1
         lcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TJyCFSOu5uKmOeoJQkjG4bcb515U9F0SytBbEJ+d4m0=;
        b=dtUhygqzoWqP9M667TJkjdv+btE9DaAnORWXiuUnt5UgPsI3aUahHJa0ZWsELx1Yte
         r+3l0kwEsiZbeyBMB4gDUSCX3fCWGHwFYABzNvaskVIRDkCFOulfEUdvHF3SV9S3JpiG
         4iRxDNbe5j+wcd0kEM9iT18OEWFR8/fHLTbNZb/7L7AuvQG4ztXXENE1CGkaTbnqk0Eo
         J7HNeOx5QEoVbYDXS4evL9JtP9zDCior2olML9aZ1OIxTAO2QLw4awY71CLLDxnyU5oF
         +JqNV2Coeeq2I5ICUNyIW0F1uXqPfoVy+Ty/+hQkTWViGc9/IIdvQnl3dhay9iKvXvSs
         0jOw==
X-Gm-Message-State: ALQs6tD48mR2RDqPjo5dk3OgkAAxhilHJo7x0dEsOEr8lSs3whLnozCN
        lb0EhB0bnyxbz2cuRR8j0mA70A==
X-Google-Smtp-Source: AB8JxZrLAyIkdVcAxC6jkV+ZGWdBwLX6kZgq1YT58rum+Crjyfld7PiW6qfIr5/xi29e1VciXP5uJA==
X-Received: by 2002:a17:902:22cc:: with SMTP id o12-v6mr40443271plg.38.1525739081050;
        Mon, 07 May 2018 17:24:41 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e0dd:ed95:919f:45e6])
        by smtp.gmail.com with ESMTPSA id a77sm13481432pfe.70.2018.05.07.17.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 17:24:39 -0700 (PDT)
Date:   Mon, 7 May 2018 17:24:38 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] grep.c: extract show_line_header()
Message-ID: <20180508002438.GA6763@syl.local>
References: <cover.1525492696.git.me@ttaylorr.com>
 <9dc758e3517681691e0809d9e9bcca03fbdad1cc.1525492696.git.me@ttaylorr.com>
 <CAPig+cRbBZ+QTqGiW_wQ9E-gROA-Wtevp1vcRqmJ5YQJ8tYEVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRbBZ+QTqGiW_wQ9E-gROA-Wtevp1vcRqmJ5YQJ8tYEVQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 05, 2018 at 03:30:51AM -0400, Eric Sunshine wrote:
> On Sat, May 5, 2018 at 12:03 AM, Taylor Blau <me@ttaylorr.com> wrote:
> > Teach 'git-grep(1)' how to print a line header multiple times from
> > show_line() in preparation for it learning '--only-matching'.
> >
> > show_line_header() comprises of the code in show_line() executed in
>
> s/of//

Ack -- thanks for pointing that out :-).

> > order to produce a line header. It is a one-for-one extraction of the
> > existing implementation.
> >
> > For now, show_line_header() provides no benefit over the change before
> > this patch. The following patch will call conditionally call
>
> s/call conditionally call/conditionally call/

Double ack. Thanks again :-).


Thanks,
Taylor
