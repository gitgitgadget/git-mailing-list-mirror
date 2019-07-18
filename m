Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 010701F461
	for <e@80x24.org>; Thu, 18 Jul 2019 23:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfGRXqx (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 19:46:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50508 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGRXqw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 19:46:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so27122635wml.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 16:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dlUyXALN/cQqH0V+onTwWwKhFtBie9vf1h2L0huy2ro=;
        b=Q5J3QBpEiKPjBnc0Ya7d1QggE+kMjaO5tFw7wymYBOa1jeo/gmQFRJB6n92+5E9tLQ
         0pBYSWhIw1j0PQTx5WFdb/s3EfeganRVKPnO0eqtx04p7UX8IcSZpvUxATEZ4HeqRJy9
         AWgBzxKLi10OVCf/5hZPulQngz2uAZj0u/Xgjxp58vxmsv/btmrhy1n/kkdUiSg3D/pa
         aHJZgE+ARd4blmXWQW05ZJNSkuIINJk9V4swc8+9EAXwkvKVgUOWiHrGoFtA214dVefX
         0iK/WsFf0D90Da1CWPl3yR0O+eNtO0wo1XvLhf2RMZyFSOAMQg2dFbWZn3Mbz518Jb17
         /3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dlUyXALN/cQqH0V+onTwWwKhFtBie9vf1h2L0huy2ro=;
        b=DQFDOLzcSYBniKkvpsq+siI4UPfWi/cGsv9fH320VNlSC01EJ6pLfzHJM6H5kZF9HW
         9IQ/5oALMtsseq6Xs3DzWY6vJkKE9+PMvUK4K2JtTPZDZKRoJoBkzaNLSxqpzgiq6WWK
         87YP31kFoqf5eKZ4FndN3JYRCEqx7ei1uFG3PNQK0bsAQ5mvX6d+dS3tMiYnzeLnRSQS
         xHZR+nD2unnD0Ry1Zg8XiZ7nAYs2yvA0+vDgWfTvivP47IYl5/j2292MIt3v/7TULXsP
         92hKeC60t+CXeCvRCFMxax8VKsmmmH9yhe55Q83Tgm78d+g3p2tssypJJyvTBcbVyoVU
         7L6g==
X-Gm-Message-State: APjAAAW5lg7ARym+q15Jn6xGiu8joHvIKd0LpbMOxClVWpa+KAYYIgGl
        jiH58ysjFGocu2S3sWl4xZs=
X-Google-Smtp-Source: APXvYqyI6PZFfgyS1z/BA/VX+2FkoQU4fWS3A7ouu/pOzcgyy1lr0Xoew6fyPQiBx3sCOskghp+Z0Q==
X-Received: by 2002:a1c:7d08:: with SMTP id y8mr22933448wmc.50.1563493611089;
        Thu, 18 Jul 2019 16:46:51 -0700 (PDT)
Received: from szeder.dev (x4db919f4.dyn.telefonica.de. [77.185.25.244])
        by smtp.gmail.com with ESMTPSA id a84sm32115849wmf.29.2019.07.18.16.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 16:46:50 -0700 (PDT)
Date:   Fri, 19 Jul 2019 01:46:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in
 push_refs_with_push
Message-ID: <20190718234647.GJ20404@szeder.dev>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <20190709211043.48597-1-emilyshaffer@google.com>
 <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
 <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
 <20190718152234.GI20404@szeder.dev>
 <xmqqa7dbz5h7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa7dbz5h7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 18, 2019 at 09:12:52AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > With that patch issues like this could be caught earlier, while they
> > are only in 'pu' but not yet in 'next'.  But do we really want to do
> > that, is that the right tradeoff?
> 
> I am sort of in favor of having at least one build with an older
> compiler without "-std=c99", like the set-up you are proposing.

Alternatively, we could sort-of restore the old state of the
GETTEXT_POISON job, i.e. build Git with GCC 4.8 in that job.
"Sort-of", because we don't necessarily have to go back to the Ubuntu
14.04 based Linux image, because GCC 4.8 is packaged in 16.04 as well,
so it's just an 'apt-get install gcc-4.8' away.

