Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B400C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 22:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiIVWKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiIVWJz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 18:09:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867195EDE5
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 15:09:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d24so10098471pls.4
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yyEQMarzqbs7EjvmM2T7UHCRda/cwMmIi+tI7QX70R4=;
        b=IYujysb9gJxOtJ0PMKoVHhB9+bJnvOLxVNNEl0o+I4b3UqoUWsksP4ciwzKAKO+hV4
         sJkrm+5ptJqIKQlsWzOaqwyWmkJCblGtYVXNrMLUuOjoJK33UhpsAl5lzwczKso9N44m
         mQuTf3gH45RvliuNHtYV+Rq0397hPDHpaTJkYG6gWaN1CJ/q2J5zLt3bEhAGJ3ox1roL
         oO9RbUR8csOU1buGS76xjcsI1SBN7RMgwkK0YzcNOly4zNzOu+nie8xrouucrmShgXrS
         T0FEc0DKn5+MbSNpsdSnFF2vu0RSW34qkPbpiSeZESA/nLYpswSSsB9WVriHrN5zzX1Z
         gg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yyEQMarzqbs7EjvmM2T7UHCRda/cwMmIi+tI7QX70R4=;
        b=dym7XG+PeNO4dAn/WApRjfhZxd+BfOS08dEqLWsCcEy1tVVJSweJYCTmOTebwd7H2O
         OBKGVfSafkqbitLMPzDLtQsBlKzQwOBsBvXZ6gZt+ZKs2wDcm23M/KhhxWWfKgjMydtJ
         xzFAQYrNxtbqVgYF+cuWu2KrhKarNdAgAzRtFTpcWXARQQGUCEG3GWBqNvKvVe7qpHWT
         a8NrWNdRiVUxT/CA0XPZB3J5uN69FJRAoPDwJ7KtVYgqkdUiVuGPEJWLffgaykzRZxc2
         MdKSmJHR/JPKOafKiNGGHFhu06vRr4T1QT87yvXu8MtGPI4+0pQkFmkb5CDkXtAO7cow
         n40Q==
X-Gm-Message-State: ACrzQf01TYUNqpSLOUS0qcqZiyNPplt/taAGxD4EQT7MZRfPh7qgFKug
        GqIMY/Zgdy7Kly2xjjUsRxe9RE/AH/Dg
X-Google-Smtp-Source: AMsMyM4ocUX42cKxvEPIF5SsSozXmBwZf5pt+GgO7IRFLJmW3Uk+1vs07miXPBqp1KIn6bU1oQhUpQ==
X-Received: by 2002:a17:902:f0d4:b0:176:988a:77fd with SMTP id v20-20020a170902f0d400b00176988a77fdmr5419069pla.25.1663884593991;
        Thu, 22 Sep 2022 15:09:53 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id b14-20020a63340e000000b0043ba3d6ea3fsm4342567pga.54.2022.09.22.15.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 15:09:53 -0700 (PDT)
Message-ID: <50c57a60-8346-6952-93d9-432a70ef74c5@github.com>
Date:   Thu, 22 Sep 2022 15:09:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: t9210-scalar.sh fails with SANITIZE=undefined
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
References: <YywzNTzd72tox8Z+@coredump.intra.peff.net>
 <ff921c34-139a-9e2b-ca1f-d6f9f7213d1b@github.com>
 <Yyyzk3FVjmms7dkO@coredump.intra.peff.net>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <Yyyzk3FVjmms7dkO@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Sep 22, 2022 at 08:35:22AM -0400, Derrick Stolee wrote:
> 
>>> I didn't dig further. It's obviously new in v2.38.0-rc1, but I'm not
>>> sure it's a show-stopper. It _might_ have been there all along, and is
>>> just now surfacing. Or it might be in an existing experimental feature
>>> that just wasn't exercised enough in the tests. Or if it really is new
>>> in scalar, then it will only hurt people using scalar, which didn't
>>> exist before. So I don't think it's a regression in the strictest sense,
>>> but it might be nice to get a more accurate understanding of the problem
>>> before the release.
>>
>> Interesting find!
>>
>> Here are the index-related settings that Scalar sets as of -rc1:
>>
>> * core.preloadIndex=true
>> * index.threads=true
>> * index.version=4
>>
>> My gut feeling is that index.version=4 might be the culprit. I thought
>> we tested GIT_TEST_INDEX_VERSION=4 in some CI modes, but apparently we
>> do not. Do you get the same error in other tests with that environment
>> variable?
> 
> Yeah, that seems by far the most likely of those three. And indeed,
> running with GIT_TEST_INDEX_VERSION=4 causes even t0000 to fail with the
> same problem. A minimal reproduction in git.git is just:
> 
>   make SANITIZE=undefined
>   git clone . tmp
>   cd tmp
>   rm .git/index
>   export GIT_INDEX_VERSION=4
>   ../git reset --hard ;# ok, writes v4 index
>   ../git reset --hard ;# fails reading unaligned v4 index
> 
> So it seems like a problem with the v4 format in general. Which...yikes.

Other than allowing us to use a (non-packed) 'struct ondisk_cache_entry' to
parse the index entries, is there any reason why the on-disk index entries
should (or need to be) 4-byte aligned? If not, we could update how we read
the 'ondisk' index entry in 'create_from_disk()' to avoid the misalignment.
E.g.:

------------------8<------------------8<------------------8<------------------
diff --git a/read-cache.c b/read-cache.c
index b09128b188..f132a3f256 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1875,7 +1875,7 @@ static int read_index_extension(struct index_state *istate,
 
 static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 					    unsigned int version,
-					    struct ondisk_cache_entry *ondisk,
+					    const char *ondisk,
 					    unsigned long *ent_size,
 					    const struct cache_entry *previous_ce)
 {
@@ -1883,7 +1883,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	size_t len;
 	const char *name;
 	const unsigned hashsz = the_hash_algo->rawsz;
-	const uint16_t *flagsp = (const uint16_t *)(ondisk->data + hashsz);
+	const char *flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;
 	unsigned int flags;
 	size_t copy_len = 0;
 	/*
------------------>8------------------>8------------------>8------------------

the do the same sort of conversion with the rest of the function. It's
certainly uglier than just using the 'struct ondisk_index_entry *' pointer,
but it should avoid the misaligned addressing error.

> 
> -Peff

