Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA7B1F462
	for <e@80x24.org>; Tue, 28 May 2019 19:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfE1TFR (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 15:05:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32885 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1TFR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 15:05:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id g21so8741833plq.0
        for <git@vger.kernel.org>; Tue, 28 May 2019 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OehierHcnpZ+7gWjZfsLwcPcK6h2HzIQn+Y4taDiKhs=;
        b=fg7DCK0vDQdlLZWLbTaX/CHQtudpRDwUknq04kS93uRci82RmW/7Q9PK6VYApN7yuM
         KiDv+t8WOV6er+Wg/yIq4P1n+cTFRRvKH1SXBpbHqyxDkuWYspZO3ZMKKUCQhsZ8kysZ
         sS3AOrOcGVsmzQ8NBDR/QJZHkrQimDpAYrAYf/kss+6es3cRplnaEEO8B085InrCL4c5
         ygIPwTGbi+L5AYraatzS0aGpfgzW2iEn0K1xkTHsh3IpyHee4v3wFyvr0dPpNTtbk5Cq
         8BoQXCmBKGzYAc4g5V6WdGsr0kBM1iYMCYjq8ykf4ToEPUCjLkhEyRGeywMV6YXLuhMx
         BNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OehierHcnpZ+7gWjZfsLwcPcK6h2HzIQn+Y4taDiKhs=;
        b=fokyRC5wCmU2x0/Pu/GL0RFtDNmvEjD+/gY9N/dLLYHprH4sHAdk3R0ffcHqX/TVqv
         TDX9vfeAhjq0RdjUzNkxoOidZr6jWfnhB6Qzg5gBUncmAx7a49OzMRBlc3MTF/h6+FiN
         p9yvOn6qcBRR9UXc8QbdKiIEDXUNtTGgfwqtLLQhDpQsIe/ZYSOiMLibFgVQNSP7+1zj
         CFNzA/csjHTnA4BBIs9kAEdRMyhI2UBg2rezzMePGQI5fePOuZcRBN1SOWK13/mYVg5y
         O2hhVSvkVFh4jcFxtpzk3Q4k1VSis+p5gJQY2W+zkP7Utb+/lxUX3zMhKqFPP64efgcc
         xJsA==
X-Gm-Message-State: APjAAAWUp7PzQmWKom+5MUQRRur7kriardY0zeZZzSSXWizIH1Y3fQiG
        wXwXaQWsyIDySv1WdBA+/WZW6A==
X-Google-Smtp-Source: APXvYqzgHCA41886H4+YmgUiZQ9k9v4nxARp+qB9LiY+ks3wblNokPTEG6PTo/PJTGXBC4H9YKUSTQ==
X-Received: by 2002:a17:902:4181:: with SMTP id f1mr113099873pld.22.1559070316169;
        Tue, 28 May 2019 12:05:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id d4sm3174933pju.19.2019.05.28.12.05.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 12:05:14 -0700 (PDT)
Date:   Tue, 28 May 2019 12:05:10 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] doc: hint about GIT_DEBUGGER in CodingGuidelines
Message-ID: <20190528190510.GA133078@google.com>
References: <20190521010036.70378-1-emilyshaffer@google.com>
 <20190523005533.260611-1-emilyshaffer@google.com>
 <CAPig+cQSp2pY9_fYhDPO+YwEmVXiqB+wjhL9NTcA+Mc_TQbWHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQSp2pY9_fYhDPO+YwEmVXiqB+wjhL9NTcA+Mc_TQbWHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 06:09:17AM -0400, Eric Sunshine wrote:
> On Wed, May 22, 2019 at 8:56 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > We check for a handy environment variable GIT_DEBUGGER when running via
> > bin-wrappers/, but this feature is undocumented. Add a hint to how to
> > use it into the CodingGuidelines (which is where other useful
> > environment settings like DEVELOPER are documented).
> >
> > You can use GIT_DEBUGGER to pick gdb by default, or you can hand it your
> > own debugger if you like to use something else (or if you want custom
> > flags for gdb). This commit documents that intent within
> > CodingGuidelines.
> 
> This last sentence is repeating what is already stated in the first
> paragraph, thus doesn't seem to add value. In fact, the remainder of
> the second paragraph seems to be repeating what is in the patch
> proper, thus could likely be dropped.

Yes, you're right. Dropped.

> 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > @@ -412,6 +412,12 @@ For C programs:
> > + - You can launch gdb around your program using the shorthand GIT_DEBUGGER.
> > +   Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
> > +   run `GIT_DEBUGGER=my-debugger-binary my-args ./bin-wrappers/git foo` to
> 
> Don't you need to bind my-debugger-binary and my-args together with
> shell quotes? Also, placeholders like these are often ensconced in
> angle brackets, so perhaps:
> 
>     ... `GIT_DEBUGGER="<debugger> <debugger-args>" ./bin-wrappers/git ...

Fixed. I did get the dq in the example but missed it with the
placeholders. :) Thanks, good catch.

> > +   use your own debugger and arguments. Example: `GIT_DEBUGGER="ddd --gdb"
> > +   ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)

Patch update to follow. Thanks.

 - Emily
