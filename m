Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E385B1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 14:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfIKO1l (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 10:27:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32856 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfIKO1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 10:27:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id x134so21008793qkb.0
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4wyQvV8ZSWNWm2Dbq3L/40buSWLfnLuXo71YifEHt5w=;
        b=IkqPL49FjykIYhuOKyqQ4qxz9hnSEXDTIIeRqtJJgGDvO9Zxk9n1LCGeKXVeBXqkR6
         AjBzB+gSg2OZerGg3wGkgE60Ots+MVWTunYjNBF5kul/fIAuUWWfSnaSF6g+HA+5EB4o
         RODSNYQm9yFICVsrYacpdIu5Gn0YUW4iF3Rw11zq6EXwxEjVtmvArvwSMRM4cy/qsCv3
         vgjoceWpUSURrOhoAWbYBcPzm/Y2RFCvNim039jN7yU8yYiRF+GQSTYliFLEesptOWKa
         HoHCcYNZwA2Y78eUG7B5Q4znGTa+mSrpn1dcKUU8uuabZ8ifjDC1Pq3FEUPr/M+rAUIa
         8Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wyQvV8ZSWNWm2Dbq3L/40buSWLfnLuXo71YifEHt5w=;
        b=AYKeqFeIXSA09DrLQTiUoTgfKr2+QgKOKfzLMbp2LUW4TJtC3w/P4uXX5AZk5Q3D/J
         0433c+EZzjrrWaImiFR4Nd8h6RDOCFBUbc1k9QRS5FF1ej80zXXZ2VSr2uiazXnIUAmm
         hG4OLbHMJ6iLn4lY2OkGISodZpcA+hR+/4Mow126wHUrh4Ri2JPk2k3XQvRP6P6mzbBm
         4/Ed9dL/CtYiW7YYeZZa/eo9q+MGuciVoQEVAs4UUfBJNkhw09gIZAw2h5qnyG5QskIW
         SjWAuJj5yJogA+zyhLNNTCuc9X4akioeuQ1qIG2dSHZVxERI0wTCmdqq/PwDSeNL3YQy
         R3yg==
X-Gm-Message-State: APjAAAWGVxfBAv890W3D081FW6yIiz4jTc7FCAHkFvS8/Tv1xggAGIcN
        x/Aa+bfEebPF/7bfQDQK9YA=
X-Google-Smtp-Source: APXvYqx5GySSqaLK91/Mo/aPS/bWiMFOaPOVNMFbU1hhivwhOhLFWQez6WOZiXPzNC2o5SMYGrQfSg==
X-Received: by 2002:a37:a612:: with SMTP id p18mr33702867qke.56.1568212059663;
        Wed, 11 Sep 2019 07:27:39 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4d96:7f18:9479:c2b0? ([2001:4898:a800:1010:fecb:7f18:9479:c2b0])
        by smtp.gmail.com with ESMTPSA id l48sm7208474qtb.50.2019.09.11.07.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 07:27:38 -0700 (PDT)
Subject: Re: [PATCH 2/9] sparse-checkout: create 'init' subcommand
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <e6e982e5a6e4517d97a7a404384057110f3a151d.1566313865.git.gitgitgadget@gmail.com>
 <CABPp-BEmwSwg4tgJg6nVG8a3Hpn_g-=ZjApZF4EiJO+qVgu4uw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7949295b-cda3-fe86-967d-4c070dbd2d5c@gmail.com>
Date:   Wed, 11 Sep 2019 10:27:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEmwSwg4tgJg6nVG8a3Hpn_g-=ZjApZF4EiJO+qVgu4uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2019 7:02 PM, Elijah Newren wrote:
> On Tue, Aug 20, 2019 at 8:13 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Getting started with a sparse-checkout file can be daunting. Help
>> users start their sparse enlistment using 'git sparse-checkout init'.
>> This will set 'core.sparseCheckout=true' in their config, write
>> an initial set of patterns to the sparse-checkout file, and update
>> their working directory.
>>
>> Using 'git read-tree' to clear directories does not work cleanly
>> on Windows, so manually delete directories that are tracked by Git
>> before running read-tree.
> 
> Is that a bug in read-tree that needs to be fixed?

Just to follow up on this: it turns out that this is NOT a bug in
read-tree, but rather a side-effect of our custom "core.gvfs" config
setting. In the virtualized world, we didn't want Git to hard-delete
a folder just because we marked everything sparse.

By removing that option from my environment, the deletions work as
expected.

Thanks,
-Stolee

