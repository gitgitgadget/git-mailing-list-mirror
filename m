Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9204C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A56613CF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhFKJei (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 05:34:38 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:37380 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhFKJed (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 05:34:33 -0400
Received: by mail-ej1-f53.google.com with SMTP id ce15so3601174ejb.4
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0RdVNORXVHzoC0+5DTrH906KScbaMiiQzE8zbHLGhMs=;
        b=sxSaXOb5TSyLYCvngWU28krXWK1TKziPfGbrPP4vXskj1Gjhtcjy/Xno3KNfDPWZiD
         4qkUBvEuN1tfx11UlG79h5ms9zK9xWf+qp6EB66fdLvOi7LaG1PR8IR6lsiAAIqa8lNC
         KnQmu9LTeDnGHxeH9SWz/1AE7sr52IyEXwZrbMf1BuAsCC9A/xuNUVRJnK8z1tr1OVXb
         X07hm9ykCzcqKRqZ+QTN62wLT7QftKiA7FYZtsAXmh2KSh35aqdN7bqMMoWNRoZclJ7j
         yeBQFg6+6efJg1DsT8wUOV5KdkKlSJ90XgQ2VSvUDp/692sn4jVAJNQBafzJmrOf9P7T
         MCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0RdVNORXVHzoC0+5DTrH906KScbaMiiQzE8zbHLGhMs=;
        b=aN4cT/l+MGP5hG9p97hLYMzVGxWzhepn8oeW04xdU15dyBpVM46XaOHa9FkGJkboIJ
         XbdaYkbT23M6xJCK2r+vQnMHqNHM5Bc5xFpARmoeFZUmGr6UHzw3hkoWB7k7qNYbp/6Y
         2YoSYYyiyIj+hMD5Pw8QqLdIB9f/5igkFHAdy4AkZdlYO1GZUjNem+ZRUhVgdS/gUe/H
         Bjj7/ZowD+U4rmBpJn02JGdlYMnvnSX+WrFhq2M8KZCBhz8kUWR3Y+J+uIukWICSWm80
         D79EyINDOLzAvqyfTFtmlwA+cS1SuNj973qBIlZ06znHYF1z0Xitu11wD4gQZ2lKP1ig
         ZXog==
X-Gm-Message-State: AOAM5303dS5+oFWEiQP8T/kocc6LxnNWozv5OPiR9eM00o0CgAdHvZR9
        gg9tv4ytttocFuAyZ8U25Zl9h1wV/cVOpYBL
X-Google-Smtp-Source: ABdhPJxrBfqxDVkSJ1ScJD7+SCcX7MmSm8G8zQVhddgwQoCMYSIzTPqcsmuj1ClWhM0GvGLfEBsBlQ==
X-Received: by 2002:a17:906:9706:: with SMTP id k6mr2798623ejx.456.1623403881219;
        Fri, 11 Jun 2021 02:31:21 -0700 (PDT)
Received: from [10.4.18.4] ([138.199.18.64])
        by smtp.gmail.com with ESMTPSA id r29sm2473133edc.52.2021.06.11.02.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:31:20 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2] *: fix typos which duplicate a word
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20210609102641.3531183-1-rybak.a.v@gmail.com>
 <20210610072406.10203-1-rybak.a.v@gmail.com> <xmqq1r99e0ff.fsf@gitster.g>
Message-ID: <beb55a5a-2507-e194-7e3b-92a028210e43@gmail.com>
Date:   Fri, 11 Jun 2021 11:31:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqq1r99e0ff.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/06/2021 01:59, Junio C Hamano wrote:
> Andrei Rybak <rybak.a.v@gmail.com> writes:
> 
>> Fix typos in documentation and code comments which repeat various words.
> 
> Thanks.
> 
>> These typos were found by searching using scripts like this:
>>
>> 	for w in $(grep '^....$' /usr/share/dict/words)
>> 	do
>> 		git grep -P "\b$w $w\b"
>> 	done
> 
> This is clarifying and somewhat puzzling at the same time.
> 
> It says that doubled words that span across line folding, and
> doubled words that do not have exactly a single space in between,
> have gone undetected (which is fine and may be useful information)
> by showing that it grepped for lines that has doubled words.  But it
> also says that you only looked for four-letter words, which I do not
> believe is the case (you fixed "the the", for example), which is
> misleading.  The "like this" part can be an excuse for that

Indeed. Basically, it was several scripts with different lists
of words.  I considered writing:

  	for w in <list of words>
  	do
  		git grep -P "\b$w $w\b"
  	done

but opted for an explicit example of a script used, which may
be reused later.

> inaccuracy, but then the whole thing pretty much has already been
> summarized nicely with your first line already, i.e. "which repeate
> various words".  If you update it the end part of the sentence to
> "which repeat various words on the same line",

Since v2, I've written a script to also check sentences which span
several lines.  I'll send out a v3 with a bunch more fixes.

> then the entire
> paragaph can go without losing clarity.
> Not a huge deal, though.
> 
> The changes themselves all look good to me.  Thanks.  Will apply.
