Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C46F1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 21:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbeDBVG0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 17:06:26 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:42289 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753218AbeDBVGY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 17:06:24 -0400
Received: by mail-wr0-f179.google.com with SMTP id s18so15621198wrg.9
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ElxWtW7t6bYTDDvRuwZt+8TB5yJwIYrJGig0xRBCpxI=;
        b=uDc+e/are4X2U7kiQSrmywHZpiBmI98IFiVo3IupkmJmBC9hZl0jXyC7yzIJdkFYxF
         to5N8PsI7DXWYBKdwYXAFpdXzh88ivQDXSi2iD5Pllgv84MHfb7oy8EGjlnQgvqMT27x
         uZExcCF0BnFdAQuc49Pis6Sa+eJyWYbhWnkX2krWy9PoMdPoC9YOusSadinYI4bCv+qo
         tWauuYf9dyLKgrTc/3FMGc1ITcKCmnXGq7lcRwjIy2XheJaCfLDQ3Fa1yYzlisWS2tki
         GCnkxxnLvEPJILVK6UxL6g8amIRIwp4s4dwM47E6NsQbpoCudZTmWNwS/66wfUCisvQu
         jkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ElxWtW7t6bYTDDvRuwZt+8TB5yJwIYrJGig0xRBCpxI=;
        b=dAThExFAnJ4jBbGGwTUIRxffnACavRs6H4B6xFPjx5FtJaC1jx09kbd6vtY0qucDka
         Yxh0jbwLiJlIGNepxgOkaTJ0C/mA9D3Exdwg+fuwIsqe8mNGje6i2SZWZ4CUltXQWPlT
         csPRDytGPYPLvy7hXsVyZW7yuij/q/9JnzXvQtvWs4hGd7rBTbUSKWW55mdbj7zWEHuj
         JtuNfrQT+Sqg9g4yDzJ+ulf2kG77SA4/pqWNSoNiwFNRp3bxG1yHZeIH8+iWos9CdVhM
         5EbAwJ8JrftbGS8C7Y7b7+1RmVjtuGFN0VAJBi8psXdM/3moKAvtPtnAMq1NtulEXIa1
         qYKg==
X-Gm-Message-State: AElRT7HThgcU1chhZuGfFWUUt9icrHVNf/d8vSEg6clc+Bhh2HdueNHi
        5plKLV7a5zo9KUVXeso6iO0=
X-Google-Smtp-Source: AIpwx4/GsPgiaMdPxaYYe0iyHMTdeshsnRvJGH4eGYYDCqEm8/oXLpXgkh59V1Q1QwsCzxReIRUo5g==
X-Received: by 10.223.208.146 with SMTP id y18mr7083832wrh.54.1522703183122;
        Mon, 02 Apr 2018 14:06:23 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id b34sm2773151wra.21.2018.04.02.14.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 14:06:22 -0700 (PDT)
Date:   Mon, 2 Apr 2018 23:09:52 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v6 2/6] reset: introduce show-new-head-line option
Message-ID: <20180402220952.GH2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180331151804.30380-3-t.gummerer@gmail.com>
 <xmqqsh8dxs86.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh8dxs86.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/02, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > +test_expect_success 'reset --no-show-new-head-line suppresses "HEAD is now at" output' '
> > +	git reset --hard --no-show-new-head-line HEAD >actual &&
> > +	! grep "HEAD is now at" <actual
> > +'
> 
> As builtin/reset.c::print_new_head_line() does this:
> 
> 	printf(_("HEAD is now at %s"), hex);
> 
> this needs to use "test_i18ngrep !" instead, no?

Ah yes you're right.  Thanks for catching this.
