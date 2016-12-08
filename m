Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5650D1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbcLHSEw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:04:52 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36805 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbcLHSEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:04:51 -0500
Received: by mail-wj0-f195.google.com with SMTP id j10so28245183wjb.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=oytlCULHy5X83VPFlFD8JthXsY1l0GfSVZ+TH1sQ/KE=;
        b=UxEiQTX5WgpRqAn3OtuoWfPE99/Gx+bmyYS6R/gCrXWty4LGXDjCBjI0Fk/wbhElx/
         0NtGA2i400kj1KsEhjvmaAjrGH+6e5q0/BZpnjb5P8vszUqQGY7qB41g/vp3C3AUSRCJ
         X/wc3UZ9q0sq46sABnO1+CtB3Dgw+cvcZ3LIlVZPYPc4VlqQ8b+y2SBDY9rrWxhsSFwY
         /GTxrjzpN4e1sjYfiviz5NfmMm2HLDFS5nvQ1PXpND7EMoIekc0T+5k3zB9GlY4FMNkk
         8+heI0KeOlwsMsZ2CuySt1QwCgt6x3D7+a7Eptxf84cfETW1Q8nwwMUK7dIdiTcdCH78
         w+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=oytlCULHy5X83VPFlFD8JthXsY1l0GfSVZ+TH1sQ/KE=;
        b=jvZpHkCcjTj46HZ8wSpbSx2zN/WLjKVF+/cWg0CSr8jtOCuFq+wQskD6Z0LXGGRVZx
         z5eRkRX1Fjf0NBcUTIygZ64v20Mn+vK/9VEK39MWGpJQDlxjCzOCQ4WGjTpA9J1Gxb/H
         D9DA4NX2K/c+K+yUBLt/JfNOiSzGMbOJkKfhFUNYbyFS+/DTGxM9tzBv6+o8zsebiNiy
         2TM/1o/DdrjTuuEq5nf63oc2tdxxM9dEZc+cmskZgQYFt0SrGZKWS3Cl3J6jaONEyzaV
         K6M7gHZrU6KiLezUGyZMnjwW3GoQ4aO+pose5sFANqTBOcAYu29wegVnR/STFMOYaqc/
         /sUw==
X-Gm-Message-State: AKaTC01p950o6415SzQb3XzpSWkyU5YqXaC9bjGLcyX3wW/SOUPL/AML1TwG+YJaig9/zg==
X-Received: by 10.194.72.100 with SMTP id c4mr64033519wjv.188.1481220290097;
        Thu, 08 Dec 2016 10:04:50 -0800 (PST)
Received: from ?IPv6:2001:470:7bd6:1000::2? ([2001:470:7bd6:1000::2])
        by smtp.gmail.com with ESMTPSA id d184sm16520317wmd.8.2016.12.08.10.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2016 10:04:49 -0800 (PST)
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned
 submodules
To:     Jeff King <peff@peff.net>
References: <20161208003940.28794-1-vi0oss@gmail.com>
 <CAGZ79kZU401JRp4EtwTGHzk3Zq+snQhX3GArDfF6SpKxsSwtWg@mail.gmail.com>
 <20161208174633.bsktiflql6jpn5t3@sigill.intra.peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
From:   vi0oss <vi0oss@gmail.com>
Message-ID: <d445a6c3-5375-22cf-4f03-1717559f1157@gmail.com>
Date:   Thu, 8 Dec 2016 21:04:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161208174633.bsktiflql6jpn5t3@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08/2016 08:46 PM, Jeff King wrote:
> On Wed, Dec 07, 2016 at 05:22:30PM -0800, Stefan Beller wrote:
>
>> On Wed, Dec 7, 2016 at 4:39 PM,  <vi0oss@gmail.com> wrote:
>>
>>>      Previously test contained errorneous
>>>      test_must_fail, which was masked by
>>>      missing &&.
>> I wonder if we could make either
>> the test_must_fail intelligent to detect such a broken && call chain
>> or the test_expect_success macro to see for those broken chains.
>>
>>
>> I wish we could improve that, but I spend a lot of brain cycles on it at
>> one point and couldn't come up with a workable solution.
>>
>> -Peff
>>
Why Git test use &&-chains instead of proper "set -e"?

