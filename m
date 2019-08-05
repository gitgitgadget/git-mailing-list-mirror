Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA531F731
	for <e@80x24.org>; Mon,  5 Aug 2019 10:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfHEKMn (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 06:12:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32900 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHEKMn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 06:12:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so83919819wru.0
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c789easnAnhbsXMNiitkDa9LTxBmYvlT7K7jukvi6qY=;
        b=RAigVBt+vZaTTgGz32Ja2iX25n+sa3sMpqGoJqs0FFzWrF7r6dc9g+M6KycnEf/9nT
         DOlQZNUwIiJoMeXKfjy/FJ2sv6gq1ELELGy3Ku9plWFPAbuapvo0L+UhF1NqkzYBYLps
         YmS7+KHsG6DBxk0mH0D6q4O/Ibtxrt6N8JKoiBEGbJAAvXnFaZkhnuPmKwDLYdFWuDJ1
         2zHSxph0FPdN4bPEneClKmSBYmoIEoQcPsR7wiPldzk6MXjudnGL/Yba2XNSyzSD6yVm
         F042cJuGRGE8sZcZUodURE1IhzR41ymMvqnXIWm+tryqDGeUdkxBwMaFG0osYJydSR5W
         r+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c789easnAnhbsXMNiitkDa9LTxBmYvlT7K7jukvi6qY=;
        b=mJAn5j258NGYnvQApX04Dw6DqBxDheSoOVhbT+FTKN+4i8R7HFcHpX18NiBBVsbgze
         v4KrhVSWtaDyUU2mIKmRj+sd8/tsquJy15YvnveQEhq0xFnqiJehY8U5NtZvdW7MWnyw
         2ZSe6sSzVvKLwuSTJGCYcl6iNThS41w5MmZ7ZiDppPG60+WgkPI8/SNtzuYYtsfdXrLt
         Y/JGZcvwQBz3N580DZQBGMYiOl236woqZuxgpqqeL530ZgovOGncB8a/ep0A+I907Ohu
         ZJ/YlZL9jwgN3XaaOG9j7qiwguWZV/2Y56E4+4pOJMpqxu/yiS0vRR3hnH8xyKlWcSWn
         m0kA==
X-Gm-Message-State: APjAAAV+dg3EQtGBKkdl21TBczX5M6TgkAMkIyc/ZDl1F3vkeaBACGFT
        eKYnyi9JV7o6tcg+PcksCzA=
X-Google-Smtp-Source: APXvYqwipsjXtcGapa2CPwlPAT8sjWKLvWJsrR+f9QVCagd5fEmuTKd2InDlOXCNwo1UOH3Evh2aPg==
X-Received: by 2002:a05:6000:112:: with SMTP id o18mr83330478wrx.153.1564999961243;
        Mon, 05 Aug 2019 03:12:41 -0700 (PDT)
Received: from szeder.dev (x4db4a28a.dyn.telefonica.de. [77.180.162.138])
        by smtp.gmail.com with ESMTPSA id y16sm88337987wrw.33.2019.08.05.03.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 03:12:40 -0700 (PDT)
Date:   Mon, 5 Aug 2019 12:12:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib-functions: show the test name at the start of
 verbose output
Message-ID: <20190805101237.GA20404@szeder.dev>
References: <20190803080126.29488-1-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.1908042113300.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1908042113300.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 04, 2019 at 09:14:46PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 3 Aug 2019, SZEDER Gábor wrote:
> 
> > So the dummy test above would start like this:
> >
> >   expecting success of 'commit works':
> >           echo content >file &&
> >   [...]
> 
> Maybe it would make sense to also mention the test and test case number,
> like so?
> 
> 	expecting success of t9876.54 'it works':

It's easy enough to do so, but I don't readily see any benefits.

The '--verbose-log' of each test script is written to a separate
file, whose name already contains the test number, so there is no use
including it for each test case in there.  When running a test script
and looking at its '--verbose' output, then surely all test numbers
must be from that particular test script, so there is no use, either.

As for the test case number, since the test cases are not numbered in
the test scripts, I just ignore them right away, and look for test
names anyway.

Could you give an example?

