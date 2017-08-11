Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DE8320899
	for <e@80x24.org>; Fri, 11 Aug 2017 19:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753671AbdHKTla (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 15:41:30 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35863 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbdHKTl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 15:41:29 -0400
Received: by mail-qt0-f195.google.com with SMTP id c15so4596331qta.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 12:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NPkd6+VgvoZoUcnvjZan4BEr6BOPy9NgqtFPvu8KD1Q=;
        b=Y5l8IUboEjUO5f953LD1DVqF53HiLnMUYgAuBOd6vZIKpuKpH6YSvSiTvxV2MGX2a6
         iYUZXrsrdyNhaCh2LTRxm6DIEKrklYcHkKAHcxmvBylz8+CRNCmXiyXU5Q71qv67bDcZ
         c2Mx1/7kluCC26dJtUROZCwPlYTkqARZPH1mVb1B0LmV2zYsKQ6BHF1LZ4z9/wCyuUi4
         BslNfUn9eBs4ky6qGVVfVPclJA2g5h2ss3KqzmECIT5zW+0/7ySq2NFgjS8ccYhorHXg
         lnuNCDudMO4U4Fi30KTZuMjR6bHm8TG9PtgH1BoctNZyz/pNQkPNK6n84ORGHFkD7Dfq
         yMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NPkd6+VgvoZoUcnvjZan4BEr6BOPy9NgqtFPvu8KD1Q=;
        b=HiL5xdKzRrzSCIpSMkF/5H3od//Kt8AwMrpksSwEEtee9Hv1a1vMRiMWuEK5zcyFL/
         WQqChlz7vHjdwxZOls0FBLxAjzIyvv8E0zEHX0ge1K0F+91l9RZpfy9zGCzeWll6mQKw
         IfIhpS+7ns1/XWZ5Vh4ct6vcWPBKwVyBpJF8uhFRNRVQRS/uCsBzK+VxyfgyoNogziyQ
         5JYOjDInm/uiTjm/7dEQuA9O5t6LsJkus31neCGLAH/HgLBVeVwMCZNMyWAJm96vmMMv
         eU0O8hHfSnQOzRbfbj14Gy4TE7q00pX7aF66+BP4nBqefSduym5AIm7Tm2eHICahXLQY
         zMRg==
X-Gm-Message-State: AHYfb5heoq0QJnSF+/aKSfHkFTBV5XdAYJvM/cPDQ5Xjqd+jonn6VgGk
        fGpkM5E5NaCVlw==
X-Received: by 10.237.62.156 with SMTP id n28mr24091427qtf.203.1502480489104;
        Fri, 11 Aug 2017 12:41:29 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id v55sm1036787qtc.90.2017.08.11.12.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Aug 2017 12:41:28 -0700 (PDT)
Subject: Re: [PATCH v2 00/25] Move exported packfile funcs to its own file
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com
References: <cover.1502220307.git.jonathantanmy@google.com>
 <cover.1502241234.git.jonathantanmy@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <588e6770-58f8-0320-014b-0ce195d498ac@gmail.com>
Date:   Fri, 11 Aug 2017 15:41:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/8/2017 9:22 PM, Jonathan Tan wrote:
> Here is the complete patch set. I have only moved the exported functions
> that operate with packfiles and their static helpers - for example,
> static functions like freshen_packed_object() that are used only by
> non-pack-specific functions are not moved.
> 
> In the end, 3 functions needed to be made global. They are
> find_pack_entry(), mark_bad_packed_object(), and has_packed_and_bad().
> 
> Of the 3, find_pack_entry() is probably legitimately promoted. But I
> think that the latter two functions needing to be accessed from
> sha1_file.c points to a design that could be improved - they are only
> used when packed_object_info() detects corruption, and used for marking
> as bad and printing messages to the user respectively, which
> packed_object_info() should probably do itself. But I have not made this
> change in this patch set.
> 
> (Other than the 3 functions above, there are some variables and
> functions that are temporarily made global, but reduced back to static
> when the wide scope is no longer needed.)
> 

Nice to see the pack file functions being refactored out.  I looked at 
the end result and it looked good to me.

Do you have the energy to do a similar refactoring for the remaining 
public functions residing in sha1_file.c?  Perhaps a new sha1_file.h? It 
would be nice to get more things out of cache.h. :)
