Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D161F453
	for <e@80x24.org>; Tue, 18 Sep 2018 17:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeIRXQw (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 19:16:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33960 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbeIRXQv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 19:16:51 -0400
Received: by mail-io1-f67.google.com with SMTP id c22-v6so2290461iob.1
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iAj7220gtyL/AjjGxpAHIE1d9JrXtaX4HM1PcCtbH80=;
        b=zBjjvDFCgyru8KJ414GsVWn71MTrCsyByxeXTAoaPr2pVQiFRz0xyaPUawP98WuA8h
         usDjkUS24sQhjg9CrcywxRFONoULY82p8lmLhzK4qYBiieNCZWSo/aImDgElB68+fNm7
         4AspRtyuh58vTZdx83wQKLWToZNzw4JiYNMvX3MG6JdU1d8HlbP00P+w+KkaoHuSWl1Z
         DQWV4os0gzYJ1I6n9+0/omyRXG6UOf3OFXxqkN47K+2yegi+F4d0J7ejDA/1CHDSQbo9
         9PDosRDxbpx3ml42UWAeC//89GqQwE0bDJMgNL/ZS/sIpuAMn0NEcXhvkEwyM3hZJgR1
         zdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iAj7220gtyL/AjjGxpAHIE1d9JrXtaX4HM1PcCtbH80=;
        b=kLG4m38sNNPpi7wqfRJXlRgj8DvyFGIyH+Bjej0TbDpC93oHcnIkJfL8ozgKEvfmux
         +nygiSIW4SmIHGXqvioNXjD73Wmhx45KLh8iuOT2KiRBVOSaVZ4q79+kh64aX2ExRVCr
         dBWbzP3zjanAzK+ftAwvW1PU8146EhnHycdPUkqHKIy+neDLx7oqeDlbWNGzvrdlvvh5
         3TikrCH4xKYh2aGH4qVgbeiOTcIhTYf8mIZBwDNQE3noxNVlFd3OQjLYMph6nbwu/CzK
         jD8WRXycTR/4KEG8vn5B/oB/OztnYtqsPT8qG4jEYw6Cg5t+OnT5Jtfebd8rcWRQQaqa
         OyQw==
X-Gm-Message-State: APzg51DSDo24N7J36nIEg9WJHZs0rkgy6ZEJaq9KILV4VdmHqNsBLaEt
        GvLc444Ec+EWoeiOL4DbrwXDlQ==
X-Google-Smtp-Source: ANB0VdajmmeCMyPbkZ6SBs+SOfya+bofhOYPYzEXkk1NBamxEnr9lKnsg70QPQcPn//FekDgVPaWWA==
X-Received: by 2002:a6b:950f:: with SMTP id x15-v6mr26772251iod.240.1537292591617;
        Tue, 18 Sep 2018 10:43:11 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id t134-v6sm5135092itb.41.2018.09.18.10.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 10:43:09 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 18 Sep 2018 13:43:07 -0400
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3701-add-interactive: tighten the check of trace output
Message-ID: <20180918174307.GA87396@syl>
References: <20180910140714.19617-1-szeder.dev@gmail.com>
 <20180910141834.GJ86006@syl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910141834.GJ86006@syl>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 10:18:34AM -0400, Taylor Blau wrote:
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

Oops, this should be:

  Reviewed-by: Taylor Blau <me@ttaylorr>

Thanks,
Taylor
