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
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9231F463
	for <e@80x24.org>; Fri, 20 Sep 2019 20:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfITUdv (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 16:33:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46075 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbfITUdu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 16:33:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so5241568pfb.12
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NKmod4E3DWEXvUYdXGNGWR4E2ggmY3HECHDdTJ5FQ0Q=;
        b=t/93CJJO5git8aHfmFUGElhhkFXCHL5Sxhr+U7ayastY9tbtTGXO4BApNFBMdTWw+c
         VZ5UwXNZCXKkmgEwZxxLvgaxDa+QWy0LHe2Hfo5Ue2rmiVXf6r5CehPb9zp1eOviTs+h
         pUiF4UxHWHaENYtXJFizjkWXeD45Yj3xQT2ZWyrOLeqvyrD5a2fJ0+BBUXU9lUYXxUg4
         y7JQv1ZGGikRpauSOpqjT/OSj9mbYN1b6LbhkrzhGGPPZVzP7LGRpHr9JKOvhW8FtU+g
         aia2YyQ5yYuMZNqv24SRRQul2s2aa2FjUAQIOL8jR1pm/mPY0/G9D/ze/H2nDTE0dgcA
         KCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NKmod4E3DWEXvUYdXGNGWR4E2ggmY3HECHDdTJ5FQ0Q=;
        b=sJlUMXU+gbFPwoF4aaE+MUj6HWtX7W7Gr2wYReGxGddmGXXiWLdf/RPnqUO0LVsDjF
         qI4kJcmfvB8s28jRosyRdy9G31SkfqDapQpkLsyneHKStU8YOQduA/phVwsywqwaACud
         zOkh4ciMHzxZIOeGYpe/uoYLQzlacoe+qG8xMNURwoAFbdTZjz8Lm1IF4kuxh1tBdfgV
         SlOraMxDiPheNe9lY43bR+txl/BrvDwevXj1nIVkan/7+6DqzeaL82w14LWDh46S7w0R
         cmUtDQ4B7J9l76KWDnxtASlrieZvmSuQ3C9kg0iouTuIJ3U6aakwCRKGatFJdFPl1MYc
         2gUw==
X-Gm-Message-State: APjAAAVK5FDdjOFdExiOIF9IMlbwEZNOUOoH8X9QwRULYhu5cLyn81tz
        1+NuKXWQ6SI0mEECfMzTT+s=
X-Google-Smtp-Source: APXvYqy66lSNIsnxlQ6zZx8QKwy2XQjuCBYH3yg3zwp07iTXkx97jXhJUm25RzIJzbJuwLMRjyhqGw==
X-Received: by 2002:a17:90a:cd01:: with SMTP id d1mr6561808pju.99.1569011630357;
        Fri, 20 Sep 2019 13:33:50 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:b:3de5:4d83:552b:26ce])
        by smtp.gmail.com with ESMTPSA id j1sm2673756pgl.12.2019.09.20.13.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 13:33:49 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] multi-pack-index: add --no-progress
To:     Junio C Hamano <gitster@pobox.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <xmqqv9tmu4jz.fsf@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <6b33f29b-d211-1548-05ec-c0863685b8a0@gmail.com>
Date:   Fri, 20 Sep 2019 13:33:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9tmu4jz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/19 12:54 PM, Junio C Hamano wrote:
> 
> Do all of these commits have overly long title with no body recorded
> in the commit objects, or is this just a mail sending program
> screwing up?
> 

Sorry about that!  With some help from Stolee I found the issue was that
I was missing a second line break before the body of the commit.

-William 
