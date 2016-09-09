Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 857511F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 21:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755019AbcIIVIB (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 17:08:01 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35646 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754739AbcIIVIA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 17:08:00 -0400
Received: by mail-pf0-f178.google.com with SMTP id w87so32840953pfk.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qk0/asBUEE0AGUVGZZHT8U5vtofxP+5JacYldlBdA+Y=;
        b=HIsMcpkc8zR4Sg9297thsrER77bBq0hKw9qoAaLEWgVoML7Xvj4PquhBpE5B+K9AYd
         UdoJR8AD4nKqf0EGDuOgHU1T+VLvO3HvcQ5vaFP5C2wbyk+Wdt2QmZbmBW+vQB6UeG/E
         XcopQ36zgz+gr87OLnJImFHanMoujJ9YvJI9eVCqmvdZcDpR3KyYIRV3gbwsCOthznYU
         ogvv9HFeegUODUyEIoxxDMxQLoXUlPqCI86xUwXNYtOFHFcNO6kmuBF7vD06nYK5bEjt
         /1zhVRqGrTzmKHq3doc3ivRl6Kh2E+aMlqyvzlx1vR4VQeOEzhklGAn0qhQyeiM57If7
         yMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qk0/asBUEE0AGUVGZZHT8U5vtofxP+5JacYldlBdA+Y=;
        b=duHPxq9kKk6zx6+4Qpd7ZxRt9wlXi72EDN5FHQxpe89DNqoR0cQ90wpeHVXQI1nVz3
         tDUdJ8UdCg2Kb/UsWv9R1xRW2JkdNAFDJO5nnVo31gqbp8M5AQZNwbTZ751BcW55TRlB
         0cqQPZYA+xEPH6G6mPno+GJj/Z8sJz6jp4as9yP/SrNGjMkOzFnPJNeXPXxtOjRHVCIT
         K5Ye1p4Vq2HfGFaZZ1/cmP1JZXNAspNlRmZQ4v750nb/pSbc7ecLFZrbLAui6R7wD+S1
         SvrsA6CLKxxrCyJswo564HpahxcXzU/Irs1yqa5gs30byD7NT/3qcf5S83jUG743aHtm
         GWBw==
X-Gm-Message-State: AE9vXwMZJyupxKUabew3wYJieodlMU+dmHAWr12WCJNNdPCzjTshSAUsxPjYBM5cCFMpFw==
X-Received: by 10.98.16.75 with SMTP id y72mr10091524pfi.50.1473455280035;
        Fri, 09 Sep 2016 14:08:00 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:2c45:4dc:f98f:e9ed])
        by smtp.gmail.com with ESMTPSA id m5sm7331591paw.40.2016.09.09.14.07.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 14:07:58 -0700 (PDT)
Date:   Fri, 9 Sep 2016 14:07:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 0/3] handle empty spec-compliant remote repos correctly
Message-ID: <20160909210757.GH25016@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1473452153.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1473452153.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

>  connect.c               | 32 ++++++++++++++++++++++++++------
>  t/t5310-pack-bitmaps.sh |  4 ----
>  t/t5512-ls-remote.sh    | 40 ++++++++++++++++++++++++++++++++++++++++
>  t/test-lib.sh           |  4 ++++
>  4 files changed, 70 insertions(+), 10 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thank you,
Jonathan
