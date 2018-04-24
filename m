Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1F361F424
	for <e@80x24.org>; Tue, 24 Apr 2018 22:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDXWhj (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 18:37:39 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:44714 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeDXWhi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 18:37:38 -0400
Received: by mail-pf0-f169.google.com with SMTP id p15so13451893pff.11
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 15:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzingdOJuTjv9HtXJ4CdAeKMkRpqZfqwEh0j10NfadU=;
        b=I2vKlGeLK4NxFsgRIwfMq1lx1UYRsufpy62oFoMnItrKW3BKzL3LQjWCE9DrnDtCAJ
         9ecr+Rz6w0mIHJUWr1XLHlX8kdp6jigmaLP+KjrQd5xPraM4o73YbQcw9Whh5ENuSEGb
         fs9L7sI+Rqpc1aWrkwK4Cfim7KowxUIBmNDl8GLrKt6YaAb0iR4Sr3T8WJIRd1zsPr4w
         7HtALKzpKg3cHcHhpnr/yDyOG4uAlpQIP2LCSGDcjmH/tVqk7gpqGhkj8a41/m0SEOyY
         x/LFhrFv3zzYcnvqzM9YMEBGodFY0zmF8PyEJwlAgX+mgMzs5iB/yEVTbC43EOCsZDXN
         xE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzingdOJuTjv9HtXJ4CdAeKMkRpqZfqwEh0j10NfadU=;
        b=YvslLlKvX0krrGgVsbl1WkyGVgqRdKhdnXdWnSlbm6cs7SvOzKfFmJLy/d76I9Tyhh
         kV1pLDi1kfw30CYyR17+BVY8aSqJrdCVaN4Aw/2Yivh8YxMt7cdA63So66VT+nOOqL4z
         Pz/Zo69fjBsTyY+8bFz68VPvx4REuT04blUJUHhnaUpaVnEJttgZ24Oor4VGMW06R4Kv
         jcQMFQFJogOjVJMjua/Ba7eMm56ZOZWOm25iQemG/6TpXdWewj/qFJ/06YVRsEzz7xxJ
         A/SUH9mS4R1sQyA64jBZ24PDDCXvbuXtPOkcwdhArMo8wPNfZpnuhtPUOSDoH0V4s/aA
         vroA==
X-Gm-Message-State: ALQs6tCMgvZ1JWR0EiUO8EbGmvkFe1YMucCa2d5RrQweSNgH8XLpryRR
        CSMSF1bCNPnCbgw9L+8eA/30ig==
X-Google-Smtp-Source: AIpwx48DPCr8vrTInK6BuDhxsyzxmAa6EX4F3YV5OV2ZERwrDHI32tdrKnF4hNWI1gMVRLAjAtek8Q==
X-Received: by 2002:a17:902:9a90:: with SMTP id w16-v6mr26489101plp.390.1524609458182;
        Tue, 24 Apr 2018 15:37:38 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id s4sm13140849pgp.35.2018.04.24.15.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 15:37:37 -0700 (PDT)
Date:   Tue, 24 Apr 2018 15:37:36 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com
Subject: Re: [PATCHv2 0/7] Moved code detection: ignore space on uniform
 indentation
Message-Id: <20180424153736.480b609d0af412ec46311eb6@google.com>
In-Reply-To: <20180424210330.87861-1-sbeller@google.com>
References: <20180424210330.87861-1-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Apr 2018 14:03:23 -0700
Stefan Beller <sbeller@google.com> wrote:

> v2:
> I think I have addressed Jonathans feedback
> * by using a string instead of counting the first character only.
> * refined tests slightly (easier to read)
> * moved white space handling for moved blocks into its own flag field,
>   keeping the enum for the actual mode of move detection.

For reference, v1 is here:
https://public-inbox.org/git/20180402224854.86922-1-sbeller@google.com/

> Stefan Beller (7):
>   xdiff/xdiff.h: remove unused flags
>   xdiff/xdiffi.c: remove unneeded function declarations
>   diff.c: do not pass diff options as keydata to hashmap
>   diff.c: adjust hash function signature to match hashmap expectation
>   diff.c: add a blocks mode for moved code detection
>   diff.c: decouple white space treatment from move detection algorithm
>   diff.c: add --color-moved-ignore-space-delta option

I'm not sure if we should add a new "blocks" mode, or if we should
modify the existing plain mode to have the minimum block length instead.
I reviewed the code as if we want the new "blocks" mode.
