Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7857B202A5
	for <e@80x24.org>; Wed, 20 Sep 2017 08:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdITIJw (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 04:09:52 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:45427 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdITIJt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 04:09:49 -0400
Received: by mail-it0-f41.google.com with SMTP id v19so1814380ite.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 01:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=C/My6I0ukbBB0VCkT8orK1D/I4SgHLcqHywz0I52OI0=;
        b=M88mMCu3lSdE9EzQAbPk/H6n5OlZycq/boHua7E2sV/sb4/x9q5krRjhzwtNk2Qjhb
         ZEQt9/sNnbZ+9D8mbR08IjEWCX7e+JuRYx5Gj3ymf7Rw/sGwOyOGFzIKoug3ZxkAyPxo
         N84fiILNJf2AKOp72Q/KEMx7fW2QUHwLMrvGLLOPkHhP/FqMvjVbIskLCLDJ42iPqA+x
         mrE31v36VK49l7qTk6UtiCwKq8m0FitJ1h0ew2nAqhpTDB3p8Hcpq+q0NezSb4d16hVO
         lBf110bH45uS/JQepIHYmzeeyXKITTlFy3353xFOVhdb08PIu+Jqsv5OSqq1s7RLum16
         vjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C/My6I0ukbBB0VCkT8orK1D/I4SgHLcqHywz0I52OI0=;
        b=VILN0D+d/lwQdj5v8/k5B8TFiuxW7xrh+GDzqzhzMn7JbVzfBlHcfwDvY2PV+fbGFX
         pcqFyQNN18h94HSHZZRY6HzDFMBCpYC6SXphHTEVWUN+vTcUTCJGotd+a9LE4+8R6ctp
         +CrpltZ3++ihJLT66iv277tBSIYCn5p7n5BzaRQekFFzkE59/CSd7s/703ZjwpuV+rLh
         4vBtYmA8a112Zg3hZJ/d/oKzZQQ3/7iLD6U2GNzf3yZDBjVOlx8GGlu8PtK962TGGPmB
         v6HoyrlC//lzjWdhT/wbdRME6X0zOnpYCZuRjIy+7ZwiEugmu/YklCkyjGlhK8dpfY9N
         XQ4w==
X-Gm-Message-State: AHPjjUgMVSpdIZdU8kR1KHyKurOCyU/CvAYHPZIS7ciFO0J1eE/vGHLs
        RJOoWRqsFBnITFkcuDV5aaxHoci6
X-Google-Smtp-Source: AOwi7QA96Z38GePzBs9cEP7zF17UABSVDhvR+PxyZeOZK+wzm7xgx0iFe/OG6FMMuoa51BV67PxJDw==
X-Received: by 10.36.46.20 with SMTP id i20mr1690635ita.7.1505894988264;
        Wed, 20 Sep 2017 01:09:48 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id o135sm2020589ith.30.2017.09.20.01.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 01:09:47 -0700 (PDT)
Subject: Re: [RFC PATCH 1/5] builtin/checkout: avoid usage of '!!'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170919071525.9404-2-kaarticsivaraam91196@gmail.com>
 <xmqq8thaow8f.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <e07a613e-8b69-e382-777b-b5797270ecaf@gmail.com>
Date:   Wed, 20 Sep 2017 13:39:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8thaow8f.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 20 September 2017 09:30 AM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>
>> There was a usage for which there's no compelling reason.So, replace
>> such a usage as with something else that expresses the intent more
>> clearly.
> I actually think this is a good example of the exception-rule.  The
> function wants to take true or false in "int", and the caller has a
> pointer.  And !!ptr is a shorter and more established way than ptr
> != NULL to turn non-NULL ness into an int boolean, without having to
> either repeat or introducing an otherwise unnecessary temporary.

Though !!ptr might might be a shorter way to turn a pointer into an
int boolean I think the documentation says pretty well why we
shouldn't be using it,

         "..  can be extremely confusing to others".

Should I drop this treating is an exception rule (or) should I keep this
back?

Thanks,
Kaartic
