Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B6D1FBB0
	for <e@80x24.org>; Tue, 29 Nov 2016 01:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754801AbcK2BFm (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 20:05:42 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35369 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbcK2BFl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 20:05:41 -0500
Received: by mail-pf0-f176.google.com with SMTP id i88so27848787pfk.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 17:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wa63fdNjaMUw3uTCXlq1iotGpyIq7xgiLph8yXMO8xw=;
        b=eZ7YcYSLlf4TZyBseEnrJqhnVFR67ogsxvacAKZHGlaXP2SQ+rIrNgdCXIzCtvwhtk
         NnGGZcMGL2vj1yfHaFxEoj5HkLUANMxTxDyMDGwFkS+E08+YoOoQR5UZWOAQ1bp55G0v
         Qh51/NmeN99bAPrXYqx8/wrK8NrIJ8kSn2zCrhWSJ+C3T74vB9e9M+VGPQQ05TGL9qK/
         Kmhzb131usg2yPqUgolNnUVnCuBVpHVnEVYKIQjKoa1oIN0OjScEuh8+xIYHQ4ciXuKi
         h6Vvmk4UhnwprJZfV7mA63N4w5JadeyLjgRPXHjyadQssmtkJirzCT6KLu1ZAm5Kzano
         b/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wa63fdNjaMUw3uTCXlq1iotGpyIq7xgiLph8yXMO8xw=;
        b=jD0lvij5XuJn2EB3bctcqwUmewx8eA0tJjOmxaxK+UJv+kSyWT/gnGWSeNYVXdXxPs
         l7C3nbUwjXJ3iGju4RdOXoQEbG5yuitw+7FM7L0L9HW9n6GtAaVyn9hkpXoHkEHuL4cx
         ppLnmnTFpfLrM7MRB4hSof2DoDBytC75qvLpWIbWD1B7q+y4w4/67QHP4MjnuDIup/wR
         K5JRQeEmQGCqjsTSUwcvp0fCoEwwzITNrpS/Ea6RufNAQlKPoeh7nqd2kbTMqJAQ+kqr
         ZdUTrenscMztmRfDyZOmINiMgLqrVuxEPSelaankMcQS79LRIkbYU6X3P1scnj6Mgku9
         1NWw==
X-Gm-Message-State: AKaTC00XXVWotuyfOrXY5mlpYcru3L6uflbSElJyGrp4KLWtPyuzNg5/agPpWt2TpFRGNsqH
X-Received: by 10.84.210.233 with SMTP id a96mr55832319pli.118.1480381540552;
        Mon, 28 Nov 2016 17:05:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:6409:b611:8934:17a0])
        by smtp.gmail.com with ESMTPSA id g63sm89925524pfd.60.2016.11.28.17.05.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Nov 2016 17:05:39 -0800 (PST)
Date:   Mon, 28 Nov 2016 17:05:38 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161129010538.GA121643@google.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28, Junio C Hamano wrote:
> * bw/grep-recurse-submodules (2016-11-22) 6 commits
>  - grep: search history of moved submodules
>  - grep: enable recurse-submodules to work on <tree> objects
>  - grep: optionally recurse into submodules
>  - grep: add submodules as a grep source type
>  - submodules: load gitmodules file from commit sha1
>  - submodules: add helper functions to determine presence of submodules
> 
>  "git grep" learns to optionally recurse into submodules
> 
>  Has anybody else seen t7814 being flakey with this series?

Which tests in particular are you seeing issues with?  I can't see any
issues running it locally.

-- 
Brandon Williams
