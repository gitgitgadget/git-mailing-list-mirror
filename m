Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8FCC43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 20:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbiFTUAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 16:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiFTUAG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 16:00:06 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AE61CB07
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:00:05 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id p31so17387915qvp.5
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ju8FRWdGKUzhrdRwLPq8kGpYPRRZuml53/cIjXmgWZc=;
        b=BP/B+fWNqDiHKGxokP+EVxgej+Khy0O4q36kvjDz0s4mWTCI8GabtqznC4tWobbpOl
         bT377GJPee863vpDbCYPfxyjLAA/5vqGQP2E77xdDkZWvuMZnnSgrZ1dlc1lHGOrBCBg
         VlEqWAa4QFvjm6QuensXRTIj8mh6CA+3nTzRwzvoaMhrzZWcy+hOgydFnZq2ARHlbYPX
         8Wbm/v5jpbEFNeIW7P2wX0mBrxNphC/ML6EcK5idqRNH16WdPMDrlIGRcyBUPUaAC67H
         oypfTYWWKVw/3O65AmVP2Gl4H7DxWaH3Q1MfJC+mXIdV+AgW9Py1Te72+iHCN3xWSGqA
         Gs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ju8FRWdGKUzhrdRwLPq8kGpYPRRZuml53/cIjXmgWZc=;
        b=DRP6PhVUay+iylUy/EaYU161vrTgIOKzZoxXdtbWRB2lIilwaFEURcU3dYxst/Y08u
         YgNZpxKvoVBerDn5DVSbEU4LAKEdjfzqr6wyuunt9J8jBlwgMnhPY7fQDQUmhKKOjYWi
         coWvITTO1qgXPUqSl61Qgx3mFEktyElnFGmNFHI2r/iG088Rr4e6Gbk9S6AbM5dGvSxP
         kArMoN4wypzCvBkJmRnro5ed+U+bOIVe/EJ10BloihrFQumt46VGZrtZx75iBsnNAozJ
         5BmLUAXflSGbkYo8nDHLeSJbahaTSTl973z+H8FQue/QlpRk7dQncJmbhqTn6XksxRPQ
         7guQ==
X-Gm-Message-State: AJIora8V21WJLY5XPoievc4fBYPaD1rrs/bxd3UQSsg3oUGEIx69WzWo
        LnQaN2ATYWJRlkfkOFoN6VQz
X-Google-Smtp-Source: AGRyM1sKb+uxFboQg0XCP+y1ENXbtzd/ou2hty2IIMfrD01NgYHn5qvXaYnFtP+ceELK8lIUXtn+Kg==
X-Received: by 2002:ad4:5bc1:0:b0:42c:3700:a6df with SMTP id t1-20020ad45bc1000000b0042c3700a6dfmr20768341qvt.94.1655755204786;
        Mon, 20 Jun 2022 13:00:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e19f:4ebb:4dfb:e710? ([2600:1700:e72:80a0:e19f:4ebb:4dfb:e710])
        by smtp.gmail.com with ESMTPSA id m22-20020a05620a291600b006a370031c3esm12959655qkp.106.2022.06.20.13.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 13:00:04 -0700 (PDT)
Message-ID: <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
Date:   Mon, 20 Jun 2022 16:00:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1
Content-Language: en-US
To:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
 <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
 <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/22 2:59 PM, rsbecker@nexbridge.com wrote:
> On June 20, 2022 2:46 PM, Derrick Stolee wrote:

>> The issue is this line (some tabs removed):
>>
>>  new_cmdline=$(printf "%s" "$cmdline" | perl -pe
>> 's[origin(?!/)]["'"$remote_url"'"]g')
>>
>> At this point, $remote_url contains the file path including the @ symbol. However,
>> this perl invocation is dropping everything starting at the @ to the next slash.
>>
>> I'm not sure of a better way to accomplish what is trying to be done here (replace
>> 'origin' with that specific url) without maybe causing other issues.
>>
>> This line was introduced by e1790f9245f (fetch tests: fetch <url> <spec> as well as
>> fetch [<remote>], 2018-02-09).
> 
> How about using sed instead of perl for this?

I wasn't sure if using sed would create a different kind of replacement
problem, but using single-quotes seems to get around that kind of issue.

Please see the patch below. I'm currently running CI in a GGG PR [1]

[1] https://github.com/gitgitgadget/git/pull/1267

Thanks,
-Stolee


--- >8 ---

From 1df4fc66d4a62adc7087d7d22c8d78842b4e9b4d Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Mon, 20 Jun 2022 15:52:09 -0400
Subject: [PATCH] t5510: replace 'origin' with URL more carefully

The many test_configured_prune tests in t5510-fetch.sh test many
combinations of --prune, --prune-tags, and using 'origin' or an explicit
URL. Some machinery was introduced in e1790f9245f (fetch tests: fetch
<url> <spec> as well as fetch [<remote>], 2018-02-09) to replace
'origin' with this explicit URL. This URL is a "file:///" URL for the
root of the $TRASH_DIRECTORY.

However, if the current build tree has an '@' symbol, the replacement
using perl fails. It drops the '@' as well as anything else in that
directory name.

You can verify this locally by cloning git.git into a "victim@03"
directory and running the test script.

To resolve this issue, replace the perl invocation with two sed
commands. These two are used to ensure that we match exactly on the
whole word 'origin'. We can guarantee that the word boundaries are
spaces in our tests. The reason to use exact words is that sometimes a
refspec is supplied, such as "+refs/heads/*:refs/remotes/origin/*" which
would cause an incorrect replacement. The two commands are used because
there is not a clear POSIX way to match on word boundaries without
getting extremely pedantic about what possible characters we could have
at the boundaries.

Reported-by: Randall Becker <rsbecker@nexbridge.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5510-fetch.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4620f0ca7fa..8ca3aa5e931 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -853,7 +853,9 @@ test_configured_prune_type () {
 		then
 			new_cmdline=$cmdline_setup
 		else
-			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
+			new_cmdline=$(printf "%s" "$cmdline" | \
+					sed "s~origin ~'$remote_url' ~g" | \
+					sed "s~ origin~ '$remote_url'~g")
 		fi
 
 		if test "$fetch_prune_tags" = 'true' ||
-- 
2.36.1.vfs.0.0


 
