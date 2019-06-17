Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4093C1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 15:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfFQPHh (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 11:07:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:47096 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfFQPHh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 11:07:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so11035543qtn.13
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GQRMc+15CnthhNigTQUvNuTXPVSVriL10G7wlDmBZOI=;
        b=WYOLny1roIjxIPcBf6RDmuFmOsVCetXWte/G/4+Q7e9+4ZmvFNoyCVQccnd6VvvxTe
         Dkc6FUvahY7Rue6Qio/awLCA5EF5dTI8Cu6LCCbhRKfAyCzLy06FKPhIJoDUgaAOldZD
         u/Tt/4k0fe7hbrUDyCiWKk7qCsBYNiQ5FwIKiYpe1bPYVXhbiW3siIyJywzXz+MjlHep
         xKMl1Lu2tX7HfJ/SGrXDhBgSWz/jo3tE7WkYRzNRzvDCvOHd/ZXmdgYg/zCj6vL83VAO
         5qnuwnoTKqeGGkptakBltnH3jdETA/nrcgfjhqk5TpkLQQ7ppUC7mE7ns051oxzmCRgg
         /zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GQRMc+15CnthhNigTQUvNuTXPVSVriL10G7wlDmBZOI=;
        b=QyhwPvjwmIO95nPjpL6PKR4t3g2YuxqQeHE4VKOsEQy3WGlLLLH3xMUYr6+JVecZiK
         ewux/nS8SLSUfX11JB9EWxk/DkckY1/jubpELV9oUVF8lzyDgnjMHop8QfsslUgwlmO3
         O1XIyINYl3aKMVmNsboJQ2FDupjizkIlNvRCTd85VqtVXyPsahBHfy8RQZSnACBAWJjn
         iCd9x1iy1x0iz/m1gNsqAA300KUR2JJaoVfKBlz51HfZzavCIPn7pOB6yk+fe2HFj93g
         vkS2gwek+qF5Ud08g1rimsJrRNLfCVkuyzGY5trugQvAD7dRBSx2FCv1DTLRN3psrTwb
         BzSg==
X-Gm-Message-State: APjAAAXo6tJC9vlfYLttVtCYu1PRPLNI1+fnDFCQa8V4UlT6yus3+ZlT
        W0m9HKDY4Bbj0WGgvj+XYPInXwGW
X-Google-Smtp-Source: APXvYqxGoMhqc3fle1d5H2RPkcUPSxPdUZpwcM23QBYgx+akpHHH/8WTJMobqJpuwVfYKMmS6PaZtA==
X-Received: by 2002:a0c:b036:: with SMTP id k51mr22474129qvc.103.1560784056171;
        Mon, 17 Jun 2019 08:07:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:90f5:c7b6:191f:f00? ([2001:4898:a800:1012:4229:c7b6:191f:f00])
        by smtp.gmail.com with ESMTPSA id j26sm7994907qtj.70.2019.06.17.08.07.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:07:35 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: normalize commit-graph filenames
From:   Derrick Stolee <stolee@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
 <20190617150207.16849-1-dstolee@microsoft.com>
Message-ID: <8251cbca-cbac-ef7f-57fa-a3671fbd6704@gmail.com>
Date:   Mon, 17 Jun 2019 11:07:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190617150207.16849-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/17/2019 11:02 AM, Derrick Stolee wrote:
> -		strbuf_setlen(&path, dirnamelen);
> -		strbuf_addstr(&path, de->d_name);
> +		char *filename = get_split_graph_filename(path.buf, de->d_name);

Please ignore this patch for now, as this line is incredibly stupid and
breaks the tests that I somehow forgot to run before submitting.

Thanks,
-Stolee


