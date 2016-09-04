Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4D31FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 10:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbcIDKu6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 06:50:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34173 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752502AbcIDKu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 06:50:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id v143so9023165wmv.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 03:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=E1TaO2evNMUscMgrjA6WZfcQZoUP97jmlM5KKzRpvrc=;
        b=pQhrP1f/a0/GKVGsjBxRLI8vbV98SsJs9DiFqdOctBDg9vbK1jhsQXKrAunSuHQ3/R
         MCrJh7VCRuAVNhmn7AnNnnDhO3IBYcGuXP7I4bhsp+0SYq//LcI+P7M7pPvrHyXezy8u
         KjRPSVwqCPRD19q2uLqsxYTju9SR8tpOwa1ufCDIcQ5RehMftWp3DuzHOHY/9wfUbOI9
         yFNfqyR/Z30c9w4sjsroWVXW7Z2spO+TsBt80fqxZsCE6wwpaWx2VP6zdf8Gtslw8H4R
         HLAP+tjBUo6vYvs0cL+KgbxJzNIpAVwPcctxue9yJ991qGo69kdye5HSYorNFetrDVdS
         LBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=E1TaO2evNMUscMgrjA6WZfcQZoUP97jmlM5KKzRpvrc=;
        b=iJ51RgR3OfjTUKUIiRxTtoT4EgynJGXOTvmtphdMXddUe17wJokmeSEKVEuFQ6lTsf
         jUuii9lcoqKqIDYlxJq6IpmcmkZcE+px3L+/hEKPufP3wCBhBuD4WWe8fntR2hoQv6FL
         hqMMHRrrMg7Doe1kz4p7QNMAQQP58KTKicnAp3wrjGPwcMoSzOXwwDYsZHkMFRwX5T9m
         tmxkzQF9/BLBMUJlwFJjpAjlU65vBgv/pz0vhwoXoXHWBO7l44ABqyAKotv8iy44udS2
         Zbgc6VHKejT919jxE3AjSXvVa42hZbyWN+SXUZhUsEIiNUIx+hO8ZzeYhnznWOXAPuEx
         u8ew==
X-Gm-Message-State: AE9vXwO3dcy28SGxoW6DP1RbScA2mw6WBHGKMOBhQ4MmcHrOKXGimjdn+UttOZsEjTadzg==
X-Received: by 10.194.107.163 with SMTP id hd3mr6118170wjb.60.1472985324407;
        Sun, 04 Sep 2016 03:35:24 -0700 (PDT)
Received: from [192.168.1.26] (elm244.neoplus.adsl.tpnet.pl. [83.21.206.244])
        by smtp.googlemail.com with ESMTPSA id vh6sm20492214wjb.0.2016.09.04.03.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Sep 2016 03:35:23 -0700 (PDT)
Subject: Re: [RFC/PATCH 2/2] WIP xdiff: markup duplicates differently
To:     Stefan Beller <sbeller@google.com>
References: <20160903033120.20511-1-sbeller@google.com>
 <20160903033120.20511-3-sbeller@google.com>
 <eb88af2c-d7b1-295e-5f23-a85045bde753@gmail.com>
 <CAGZ79kYEieYGFAgORc8yaF3=8-L1E7K4afNGxDH5AgM5nHFgFw@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2001e1f2-7ba5-6084-292b-aa97f9b99c90@gmail.com>
Date:   Sun, 4 Sep 2016 12:35:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYEieYGFAgORc8yaF3=8-L1E7K4afNGxDH5AgM5nHFgFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 04.09.2016 o 07:31, Stefan Beller pisze:
> On Sat, Sep 3, 2016 at 5:25 AM, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 03.09.2016 o 05:31, Stefan Beller pisze:
>>
>>> When moving code (e.g. a function is moved to another part of the file or
>>> to a different file), the review process is different than reviewing new
>>> code. When reviewing moved code we are only interested in the diff as
>>> where there are differences in the moved code, e.g. namespace changes.
>>>
>>> However the inner part of these moved texts should not change.
>>> To aid a developer reviewing such code, emit it with a different prefix
>>> than the usual +,- to indicate it is overlapping code.
>>
>> What would be this different prefix?
> 
> I will discard the part of the different prefix as the design of 2/2
> will change.

It would be nice to have at least an option of using different prefix
(or pair of prefixes), as not always it is possible to use color to
markup duplicates.

P.S. BTW. does this work with word-diff?

Best regards,
-- 
Jakub Narębski

