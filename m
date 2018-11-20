Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7911F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 15:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeKUBgg (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 20:36:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34506 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUBgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 20:36:35 -0500
Received: by mail-qk1-f193.google.com with SMTP id a132so3059026qkg.1
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 07:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9rufB7sVHZ9Io+04YkVwfBccuXA5ZMPf5njXIs2kDCs=;
        b=fp/Kdc6qWMsuxstC/86AM/l8JXR9jdWRp44YBCdJ2EK6cXKWOQQgx7pEiXnTOAc1TQ
         Os+oMe6jApVpomcIkiMfS67/drF2Du2F1UplM8kT3A4xAdvCYN7R812LKOC90ZWBkAk8
         OKckO226q2W4YcGbYVUG8CKTZGIEPmh2fB14vmBZJ5LSnLmC3lucVV3uH2uX336LBV48
         HMVad0slYOVptEOBVgt01SG3/CBbffkPHx41ti2TyJ6YI6YJm05TvMdZzgWXcATtJouO
         qMcbZ2xhDeDlipDsdwGor2m+RnCsPwIIxoO78z0VFKJA3FHG6z6wXpUfsIwAuyH/x03Y
         eDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9rufB7sVHZ9Io+04YkVwfBccuXA5ZMPf5njXIs2kDCs=;
        b=V0Nfij9ntOoW6rbHE5sIhmPGX5h3wdYDWEGVHtwKmQU1qd5hYWoUUWTGBAjOfx0TRi
         a6NhriZvnsaPJdZzrNlVpOMFiVf/3Z9n3v/uczp2NJ1OG5U5UnWcaMne4/4hG1FppcZ4
         9KSSufhp+3EctvgsS80yuRaZAsef3e4EquqSFHCjii/viXKguSmk5f3nOuodbAa8rvHv
         AFv1tQWlaVyg4QfhXOYDrmEwl5gUVPAVDvcVHizg1YfgA/K9XlK3qg5F/1hablHU6c2+
         mqqNT4rifJBR8kD4gjhhVKk5HxV1d6qhPTv6P4VkePdcCOgYzVXfsj8U7DsOwVEjZNo9
         JxJw==
X-Gm-Message-State: AA+aEWY91Ik5nI0ZNSnajb9SzRwdhl0wNAvluEWb7GrSEO19tCI9TGwX
        zeeMW3Cu6H5aHRyzJZ9WeiM=
X-Google-Smtp-Source: AFSGD/WOeY8ETsrSwwb/EWI2GzpqLPqNNvGTdhUboi0H331Vib1mBQh5/eRSSBEPYVPZjuiIBqABag==
X-Received: by 2002:a37:d994:: with SMTP id q20mr2069757qkl.116.1542726419727;
        Tue, 20 Nov 2018 07:06:59 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9842:9c91:9414:a691? ([2001:4898:8010:0:8178:9c91:9414:a691])
        by smtp.gmail.com with ESMTPSA id r24sm29403292qtr.2.2018.11.20.07.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:06:58 -0800 (PST)
Subject: Re: [PATCH 0/3] delta-island fixes
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20181120094451.GA21725@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <778f1fcb-8988-de42-8264-d4394ede8540@gmail.com>
Date:   Tue, 20 Nov 2018 10:06:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181120094451.GA21725@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2018 4:44 AM, Jeff King wrote:
> In cases like this I think it's often a good idea to have a perf test.
> Those are expensive anyway, and we'd have the double benefit of
> exercising the code and showing off the performance improvement. But the
> delta-island code only makes sense on a very specialized repo: one where
> you have multiple related but diverging histories.  You could simulate
> that by picking two branches in a repository, but the effect is going to
> be miniscule.

The changes in this series look correct. Too bad it is difficult to test.

Perhaps we should add a performance test for the --delta-islands check 
that would trigger the failure (and maybe a clone afterwards). There are 
lots of freely available forks of git.git that present interesting fork 
structure. Here are three that would suffice to make this interesting:

     https://github.com/git/git
     https://github.com/git-for-windows/git
     https://github.com/microsoft/git

Of course, running it on a specific repo is up to the person running the 
perf suite.

Thanks,
-Stolee
