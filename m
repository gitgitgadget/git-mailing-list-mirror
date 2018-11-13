Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3869D1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbeKNBrB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:47:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44747 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbeKNBrB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:47:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id j17-v6so13832663wrq.11
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ILVid8z8RNeiLtspyFbym29nrPSA2aF/88NUglkEf8M=;
        b=LK2X8B3alM4of4KxFphhz6WqZPjoyBHHCEBcgr+lYP7vasvWjoiR8+5qItrk2ucPPp
         c+7YSl01lnfbIkGCpWtGHvcFZbtrkP7ET5+zHrds3kXuDYBCTYv2SVUyGoewM/EIsEY2
         dVt89fnV/OS7g7LBMHOYT1nHOPyCIUO0QRcuDHHR3Bq1R39ZFbHrVw1abv9E2Aw3cYCJ
         2gPYGFQ3sEFXim+AwuowzCiiTS3T3MgKylOqBp4jx6XIkHM2jx328NCBhHl25rhKJH7T
         VG2AVEEhhIpQs5vDWjHNFcrSkLQGc+24rhVXZwlGjUZv71zLzYjgt/iBnHk1wvzkUTEQ
         cnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ILVid8z8RNeiLtspyFbym29nrPSA2aF/88NUglkEf8M=;
        b=qcvr3hWtG6kQvN5adSBInZ/pkXAsLnOGJ0pxEowkBcodv5Rtq0LneYQBilqSVOmlwI
         2ls7Cfhi9j6wbHupXURDY/9tnwAqf60zN0WuC+xH1YMAHY8yFlZunuE+eElDMYs8a0/R
         ER0j8rzex0/+YKXqxzqcrZIJfRnlgL+Pgcc+77YO12lpRpHCZLjf4GH4G7VwlqzYpURL
         0Lw7RR+idg5m4EEXL5udhPknmnjrzRxrQNXk4mJiJPgWo04de2y8EShmeBzQbA6TWQKE
         /Q/LpAckslxau7jsY4Ia9SRRggtzRIYNXgfvWrAj4kXHe18EmuQ5rqTT00K5QQW8y1TO
         DMtw==
X-Gm-Message-State: AGRZ1gKvawSE4Er2rDmfB71kU7DgPh38PnFa8r8GTxylig3SmdvqH8wj
        mHEPuurHq15UpeNnQQrQ5pY=
X-Google-Smtp-Source: AJdET5fNGj5GzvS8gsTY5MNNbm17WxN2yhakZRf+ZDlYk0agV1Lx56gYPW+/84dZEHy5jQwETZV0jg==
X-Received: by 2002:a5d:4a91:: with SMTP id o17-v6mr5909226wrq.132.1542124101330;
        Tue, 13 Nov 2018 07:48:21 -0800 (PST)
Received: from szeder.dev (x4db2a36c.dyn.telefonica.de. [77.178.163.108])
        by smtp.gmail.com with ESMTPSA id m7sm1402410wml.32.2018.11.13.07.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:48:20 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:48:18 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] Makefile: add pending semantic patches
Message-ID: <20181113154818.GE30222@szeder.dev>
References: <20181030220817.61691-2-sbeller@google.com>
 <20181108205255.193402-1-sbeller@google.com>
 <xmqqzhui4ymh.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbdewnxe=uC4GScvjJTgsru75O2FzSckjWoin2g1yXyPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbdewnxe=uC4GScvjJTgsru75O2FzSckjWoin2g1yXyPw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 09, 2018 at 01:58:01PM -0800, Stefan Beller wrote:
> On Thu, Nov 8, 2018 at 9:18 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Are they wrong changes (e.g. a carelessly written read_cache() to
> > read_index(&the_index) conversion may munge the implementation of
> > read_cache(...) { return read_index(&the_index, ...); } and make
> > inifinite recursion)?  Or are they "correct but not immediately
> > necessary" (e.g. because calling read_cache() does not hurt until
> > that function gets removed, so rewriting the callers to call
> > read_index() with &the_index may be correct but not immediately
> > necessary)?
> 
> the latter. I assume correctness (of the semantic patch) to be a given,

I'm afraid we can't assume that.  As far as correctness is concerned,
I think semantic patches are not different from any other code we
write, i.e. they are potentially buggy.  Perhaps even more so than the
"usual" Git code, because we have long experience writing C and shell
code (with all their quirks and error-proneness), but none of us is
really an expert in writing semantic patches.

Cases in point:

  - 6afedba8c9 (object_id.cocci: match only expressions of type
    'struct object_id', 2018-10-15)
  - 279ffad17d (coccinelle: avoid wrong transformation suggestions
    from commit.cocci, 2018-04-30)
  - cd9a4b6d93 (cocci: use format keyword instead of a literal string,
    2018-01-19); though this one is probably a bug in Coccinelle
    itself
  - c2bb0c1d1e (cocci: avoid self-references in object_id
    transformations, 2016-11-01)

